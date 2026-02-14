
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using VRC.SDK3.Components;
using System;
using VRC.SDK3.UdonNetworkCalling;
using VRC.Udon.Common.Interfaces;
using TMPro;

namespace enfutu.UdonScript
{
        /// <summary>
        /// 時計機能の他、同期変数もここで抱える
        /// </summary>
        [UdonBehaviourSyncMode(BehaviourSyncMode.Manual)]
    public class DropClock : UdonSharpBehaviour
    {
        string[] tempNames = new string[100]
        {
            "Alice","Bob","Charlie","David","Eve","Frank","Grace","Hannah","Ian","Jack",
            "Karen","Leo","Mia","Noah","Olivia","Paul","Quinn","Rachel","Sam","Tina",
            "Victor","Wendy","Xander","Yuki","Zack","Aaron","Bella","Caleb","Diana","Ethan",

            "太郎","花子","ゆき","さくら","春人","あおい","蓮","ひな","海斗","芽依",
            "陸","結衣","颯太","未来","匠","彩香","大地","かな","翔太","真央",
            "健","美咲","直樹","あかり","悠斗","里奈","和也","奈々","優","千夏",
            "誠","陽菜","航","結菜","拓海",

            "민준","서연","지우","현우","지수","태양","혜진","동현","수민","윤서",
            "지원","민서","준호","채원","상우","은지","경민","아라","호진","나연",
            "도윤","하은","시우","유진","지민","예린","건우","다은","성훈","보라",
            "주원","소영","태훈","하린","선우"
        };

        string[] lucks = new string[5]
        {
            "Wonderful Day", "Lucky Day", "Normal Day", "Unlucky Day", "Bad Day"
        };

        [Header("一度に更新出来る上限数(少ないほど軽い)")]
        public int UpdateLimit = 6;
        [Header("触れた水滴が落ちていく速度")]
        public float LeaveSpeed = .02f;
        [Header("新しい水滴が落ちてくる速度")]
        public float ArriveSpeed = .01f;

        [SerializeField] Material _mat;

        //blit
        [SerializeField] RenderTexture rt;
        [SerializeField] Material _blitMat;

        //textに関する
        [SerializeField] GameObject[] _namePlates;
        [SerializeField] GameObject _decorationPlate;
        [SerializeField] string[] _decolationPattern;

        TMP_Text _decorationText;
        Vector3 _plateSizeMin = Vector3.one * .1f;  //非アクティブ時
        Vector3 _plateSizeMax = Vector3.one * .5f;  //アクティブ時
        [SerializeField] private Material[] materialPresets;

        [SerializeField] AudioSource[] _se;

        //xy:position, z:joinTime(=scale),
        //w:0==n→nonActive / -1==n→isActive / 0<n→leftTime　(最悪だ…)
        [UdonSynced(UdonSyncMode.None)] Vector4[] sync_value = new Vector4[100];
        [UdonSynced(UdonSyncMode.None)] string[] _plateText = new string[100];
        [UdonSynced(UdonSyncMode.None)] int[] _todaysLuck = new int[100];
        [UdonSynced(UdonSyncMode.None)] double _baseTime = 0;
        [UdonSynced(UdonSyncMode.None)] int _playerCount = 0;

        int _srcid = -1;
        int _valueid = -1;
        int _selectid = -1;
        int _handid = -1;
        void Start()
        {
            _baseTime = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
            _decorationText = _decorationPlate.GetComponentInChildren<TMP_Text>();
            _mat.SetFloat("_Exactly", 0);   //定刻の演出を必ずリセットする

            generateShaderId();
            initializeArray();

            //値が確実に同期するまで待つ
            SendCustomEventDelayedSeconds("Boot", 3);
        }

        public void Boot() { boot = true; }

        private void generateShaderId()
        {
            _srcid = VRCShader.PropertyToID("_Src");
            _valueid = VRCShader.PropertyToID("_UdonPlateValue");
            _selectid = VRCShader.PropertyToID("_UdonSelectValue");
            _handid = VRCShader.PropertyToID("_HandRot");
        }

        Vector4[] initialize_value = new Vector4[100];  //リセット用
        float circleRange = .4f; //配置はuv座標指定なので0～.5で指定
        private void initializeArray()
        {
            //仮の値を代入
            Array.Copy(tempNames, _plateText, tempNames.Length);
            Array.Copy(tempNames, temp_plateText, tempNames.Length);

            for(int i = 0; i < 100; i++)
            {
                Vector2 rand = UnityEngine.Random.insideUnitCircle * circleRange;
                float randScale = UnityEngine.Random.Range(.4f, .6f);
                sync_value[i] = new Vector4(rand.x, rand.y, randScale, 0f);
                temp_value[i] = sync_value[i];
                send_value[i] = temp_value[i];
                initialize_value[i] = send_value[i];

                _todaysLuck[i] = -1;

                GameObject plate = _namePlates[i];
                plate.GetComponent<nameplate>().MyNum = i;
                Vector3 pos = new Vector3(rand.x, rand.y, 0f);
                plate.GetComponent<RectTransform>().localPosition = pos;

                plate.GetComponentInChildren<TMP_Text>().enabled = false;
            }
        }

        bool boot = false;
        void Update()
        {
            if (!boot) return;

            _closeBlit = false;
            _clicked = false;

            platesHideControl();
            updateClock();
            SelfOnDeserialization();
            redy();

            if (!onClick) return;

            _dragTime++;
        }


        /// <summary>
        /// 時計機能
        /// </summary>
        Vector4 handrot = Vector3.zero;
        float exactly = 0;
        bool _exactlyMotion = false;
        private void updateClock()
        {
            DateTime now = DateTime.Now;

            float seconds = now.Second + now.Millisecond / 1000f;
            float minutes = now.Minute + seconds / 60f;
            float hours = (now.Hour % 12) + minutes / 60f;

            float secondAngle = seconds * 6f;
            float minuteAngle = minutes * 6f;
            float hourAngle = hours * 30f;

            handrot.x = secondAngle * Mathf.Deg2Rad;
            handrot.y = minuteAngle * Mathf.Deg2Rad;
            handrot.z = hourAngle * Mathf.Deg2Rad;
            handrot.w = 1f;     //PlayModeFlag

            _mat.SetVector(_handid, handrot);

            //定時の演出
            if(minutes <= .1f) { exactly = 1f; _exactlyMotion = true; }

            if (!_exactlyMotion) return;

            if(0 < exactly) 
            {
                _mat.SetFloat("_Exactly", exactly);
                exactly -= .005f;
            }
            else
            {
                _mat.SetFloat("_Exactly", 0);
                _exactlyMotion = false;
            }
        }

        public void TestMinute0()
        {
            exactly = 1f;
            _exactlyMotion = true;
        }



        float _durationTime = 0;
        private void calcDurationTime()
        {
            double nowUtcUnix = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
            _durationTime = (float)(nowUtcUnix - _baseTime);
        }

        /// <summary>
        /// OnEnter
        /// </summary>
        public void TestPlayEnter(int testPlayerCount)
        {
            if (100 <= testPlayerCount + _playerCount) return;

            if (Networking.LocalPlayer.IsOwner(this.gameObject))
            {
                int a = testPlayerCount + _playerCount;
                updatePlateValue(_plateText[a - 1], a);
            }
        }

        public override void OnPlayerJoined(VRCPlayerApi player)
        {
            if (100 <= player.playerId) return;

            if (Networking.LocalPlayer.IsOwner(this.gameObject))
            {
                _playerCount++;
                updatePlateValue(player.displayName, player.playerId);
            }
        }
                
        private void updatePlateValue(string name, int pid)
        {
            calcDurationTime();

            int id = pid - 1;
            _plateText[id] = name;

            //_plateText[id] = _plateText[id] + "[" + pid + "]";
            _plateText[id] = _plateText[id] + " ";
            GameObject plate = _namePlates[id];

            Vector2 rand = UnityEngine.Random.insideUnitCircle * circleRange;
            sync_value[id].x = rand.x;
            sync_value[id].y = rand.y;
            sync_value[id].z = _durationTime;
            sync_value[id].w = -1f;

            //オーナーから同期命令
            RequestSerialization();
        }

        /// <summary>
        /// OnLeft
        /// </summary>
        public void TestPlayLeft()
        {
            if (Networking.LocalPlayer.IsOwner(this.gameObject))
            {
                //テスト用なのでひとまず5番だけLeftさせる機能
                double nowUtcUnix = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
                float dt = (float)(nowUtcUnix - _baseTime);
                SendCustomNetworkEvent(NetworkEventTarget.All, "WriteLeftTime", dt, 5);
            }
        }

        public override void OnPlayerLeft(VRCPlayerApi player)
        {
            if (Networking.LocalPlayer.IsOwner(this.gameObject))
            {
                double nowUtcUnix = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
                float dt = (float)(nowUtcUnix - _baseTime);
                SendCustomNetworkEvent(NetworkEventTarget.All, "WriteLeftTime", dt, player.playerId);
            }
        }

        //sync_value[n].wの変更のみで回数も少ないので、引数付きのSendCustomで全員に直接書き込ませる
        [NetworkCallable]
        public void WriteLeftTime(float dulation, int playerId)
        {
            //全てactiveなplateなのでsync処理には関わらない。直接書き込みでok
            //playerIDは1からはじまる。
            sync_value[playerId - 1].w = dulation;
            temp_value[playerId - 1].w = dulation;
            send_value[playerId - 1].w = dulation;
        }

        /// <summary>
        /// 同期処理
        /// </summary>
        private void syncPlate(int n, bool isActive)
        {
            //Debug.Log("SyncPlate");

            GameObject plate = _namePlates[n];

            TMP_Text _name = plate.GetComponentInChildren<TMP_Text>();
            int threeOrMin = (int)Mathf.Min(3f, _plateText[n].Length);
            _name.text = _plateText[n].Substring(0, threeOrMin);
            _name.alpha = 1f;

            //ここは共通
            Vector3 pos = new Vector3(sync_value[n].x, sync_value[n].y, 0f);
            RectTransform rect = plate.GetComponent<RectTransform>();
            rect.localPosition = pos;

            //ここはactive要素
            if (isActive)
            {
                _name.enabled = true;
                rect.localScale = _plateSizeMax;
                plate.GetComponent<nameplate>().Active = true;
            }
        }


        //sync_valueとtemp_valueの比較。temp_valueとsend_valueの比較は可。
        //sync_valueとsend_valueの比較は不可とする。
        Vector4[] temp_value = new Vector4[100];
        string[] temp_plateText = new string[100];

        int timeLeft = 0;
        int checkCount = 0;

        float[] lerpPower = new float[100];
        bool[] processing = new bool[100];
        bool[] sync_x = new bool[100];
        public void SelfOnDeserialization()
        {
            checkCount++;

            //bool値で変更すべき配列を取得しておく
            for (int i = 0; i < _plateText.Length; i++)
            {
                if (processing[i]) continue;
                if (temp_value[i].x == sync_value[i].x && temp_value[i].y == sync_value[i].y) continue;

                temp_value[i] = sync_value[i];          //一致させる
                processing[i] = true;
                timeLeft = 100;
            }

            int loopCount = 0;

            //plateを動かす処理をスキップ
            for (int j = 0; j < sync_value.Length; j++)
            {
                if (!processing[j]) { continue; }
                
                loopCount++;
                if(UpdateLimit < loopCount) { break; }   //更新の上限数に達したなら一旦止める

                //x座標を揃えるまでのループ
                if (!sync_x[j])
                {
                    float extend = .5f;

                    //落とす    
                    if (-extend < send_value[j].y)
                    {
                        send_value[j].y -= LeaveSpeed;
                        _namePlates[j].SetActive(false);    //落ち始めたらplateには触れないようにする
                        continue;
                    }

                    //落ち切っていた場合はターゲット直上へ
                    if (send_value[j].x != temp_value[j].x)
                    {
                        send_value[j].x = temp_value[j].x;
                        send_value[j].y = 1f + extend;
                        send_value[j].z = temp_value[j].z;  //ローカル処理の場合はここで0から復帰する。詳しくはListeningEnter_NonActiveMode()辺りに
                        sync_x[j] = true;
                    }
                }

                //完了処理
                if (1f <= lerpPower[j])
                {
                    //完了時にsyncPlate(Active/NonActiveの判定を名前の違いで取ってるのはちょっと良くない気がする)
                    if (temp_plateText[j] != _plateText[j])
                    {
                        temp_plateText[j] = _plateText[j];  //一致させる
                        syncPlate(j, true);
                    }
                    else
                    {
                        syncPlate(j, false);
                    }

                    _namePlates[j].SetActive(true);         //落ち切ったらplateに触れるようにする
                    lerpPower[j] = 0f;
                    timeLeft = 100;
                    processing[j] = false;
                    sync_x[j] = false;
                    continue;
                }

                //更新処理。zは処理が分かれるので更新しない。詳しくはListeningEnter_NonActiveMode()辺りに
                lerpPower[j] = Mathf.Clamp01(lerpPower[j] + ArriveSpeed);
                send_value[j].y = Mathf.Lerp(send_value[j].y, temp_value[j].y, lerpPower[j]);
                send_value[j].w = temp_value[j].w;
            }
        }

        /// <summary>
        /// ActiveなPlateが触れられた場合の処理(ローカル)
        /// </summary>
        /// 
        int _selectNum = 0;
        bool _modeChange = false;
        bool isEnter = false;
        public void ListeningEnter_ActiveMode(int mynum)
        {
            //hideを停止
            forcePlateEnable();

            _modeChange = true;
            isEnter = true;
            _selectNum = mynum;

            _se[3].PlayOneShot(_se[3].clip);

            double nowUtcUnix = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
            double j = nowUtcUnix - (_baseTime + send_value[_selectNum].z);

            DateTimeOffset join = DateTimeOffset.Now - TimeSpan.FromSeconds(j);

            TMP_Text _name = _namePlates[_selectNum].GetComponentInChildren<TMP_Text>();
            _name.text = "<#FF0000>" + _plateText[_selectNum];
            _name.text += "</color><br><#00FF00>" + join.Hour.ToString("D2") + ":" + join.Minute.ToString("D2")  + "~";
            
            //退室済みの場合
            if(0 < send_value[_selectNum].w)
            {
                double l = nowUtcUnix - (_baseTime + send_value[_selectNum].w);
                DateTimeOffset left = DateTimeOffset.Now - TimeSpan.FromSeconds(l);
                //_name.text += "</color><br><#0000FF>" + left.Hour + ";" + left.Minute;
                _name.text += left.Hour.ToString("D2") + ":" + left.Minute.ToString("D2");
            }

            //イースターエッグ
            if (0 <= _todaysLuck[mynum])
            {
                _name.text += "</color><br><#0000FF>" + lucks[_todaysLuck[mynum]];
            }

            _name.fontSharedMaterial = materialPresets[1];
            _name.SetMaterialDirty();
            _name.SetVerticesDirty();
            
            Vector3 pos = _namePlates[_selectNum].GetComponent<RectTransform>().localPosition;
            RectTransform rect = _decorationPlate.GetComponent<RectTransform>();
            rect.localPosition = pos;

            //decolation
            int pattern_num = UnityEngine.Random.Range(0, _decolationPattern.Length);
            _decorationText.text = _decolationPattern[pattern_num];
            _decorationPlate.SetActive(true);
        }

        public void ListeningExit_ActiveMode()
        {
            _modeChange = true;
            isEnter = false;

            TMP_Text _name = _namePlates[_selectNum].GetComponentInChildren<TMP_Text>();
            int threeOrMin = (int)Mathf.Min(3f, _plateText[_selectNum].Length);
            _name.text = _plateText[_selectNum].Substring(0, threeOrMin);
            _name.fontSharedMaterial = materialPresets[0];
            _name.SetMaterialDirty();
            _name.SetVerticesDirty();

            _decorationPlate.SetActive(false);
        }


        bool _clicked = false;   //なんか1クリックで3クリック分くらい判定出てて良くないので1度目で止める
        int _easterEggCount = 0;
        bool _easterEggEnd = false;
        public void ListeningPointerDown_ActiveMode(int mynum)
        {
            if (_clicked) return;

            _clicked = true;
            int _uranaiNum = -1;
            if (!_easterEggEnd) //イースターは1回だけ
            {             
                //5連続で自分の水滴を移動させたとき、イースターエッグを発火する
                if ((Networking.LocalPlayer.playerId - 1) == mynum) { _easterEggCount++; }
                else { _easterEggCount = 0; }

                if (5 <= _easterEggCount)
                {
                    //占う
                    _uranaiNum = UnityEngine.Random.Range(0, 5);
                    _easterEggEnd = true;
                }
            }

            SendCustomNetworkEvent(NetworkEventTarget.All, "ResetPosition", mynum, _uranaiNum);
        }

        //重なって触りづらいplateへの対策として位置変更機能
        [NetworkCallable]
        public void ResetPosition(int num, int easterNum)
        {
            //Resetするplateに触れているなら全員Exitさせる
            if(num == _selectNum)
            {
                ListeningExit_ActiveMode();
            }

            //オーナーのみ同期変数に触れて位置を再度設定する。残りのプレイヤーには勝手に同期される。
            if (Networking.LocalPlayer.IsOwner(this.gameObject))
            {
                Vector2 rand = UnityEngine.Random.insideUnitCircle * circleRange;
                sync_value[num].x = rand.x;
                sync_value[num].y = rand.y;

                if(0 <= easterNum)
                {
                    _todaysLuck[num] = easterNum;
                }

                RequestSerialization();
            }
        }

        /// <summary>
        /// 非ActiveなPlateが触れられた場合の処理(ローカル):オーナーへ対象plateのmynumを通知し更新してもらう。更新結果は同期される。
        /// SendValue[mynum].zには予めランダムな値が入っており、この値が水滴のサイズ。
        /// ここに0を入力することでローカルでのみ水滴を見えなく(触れて消える)する。
        /// </summary>
        float def_pitch;
        float def_vol;
        public void ListeningEnter_NonActiveMode(int mynum)
        {
            //Random.Range(.5f, .6f);
            if (.56f <= send_value[mynum].z) { _se[0].PlayOneShot(_se[0].clip); }
            else if(.53f <= send_value[mynum].z) { _se[1].PlayOneShot(_se[1].clip); }
            else { _se[2].PlayOneShot(_se[2].clip); }

            send_value[mynum].z = 0f;

            SendCustomNetworkEvent(NetworkEventTarget.Owner, "UpdateNonActivePlate", mynum);
        }

        public void ListeningExit_NonActiveMode()
        {

        }


        //オーナーのみの処理
        [NetworkCallable]
        public void UpdateNonActivePlate(int mynum)
        {
            if (processing[mynum]) return;      //処理中の変数は操作しない

            float r = .5f;
            Vector2 rand = UnityEngine.Random.insideUnitCircle * r;
            float randScale = UnityEngine.Random.Range(.5f, .6f);
            sync_value[mynum].x = rand.x;
            sync_value[mynum].y = rand.y;

            RequestSerialization();
        }
        /// <summary>
        /// nameplateのHideに関連。
        /// </summary>

        int _blinkCount = 0;
        bool plateHide = false;
        bool onClick = false;
        int _dragTime = 0;
        public void PointerDownCanvas()
        {
            onClick = true;
            plateHide = !plateHide;
            if(_blinkCount < 0) { _blinkCount = 50; }
        }

        public void PointerUpCanvas()
        {
            onClick = false;

            if(600 < _dragTime) { ResetValues(); }
            
            _dragTime = 0;
        }

        public void PointerExitCanvas()
        {
            onClick = false;
            _dragTime = 0;
        }

        float plateAlpha = 1f;
        private void platesHideControl()
        {
            if (_blinkCount < 0) return;

            if (plateHide) { plateAlpha = _blinkCount * .02f; }         //非表示へ
            if (!plateHide) { plateAlpha = 1 - (_blinkCount * .02f); }  //表示へ

            _blinkCount--;
            blitMap();
        }

        private void forcePlateEnable()
        {
            plateHide = false;
            _blinkCount = -1;
            plateAlpha = 1;
        }

        public void ResetValues()
        {
            //Debug.Log("Reset!");
            Array.Copy(initialize_value, temp_value, initialize_value.Length);
            Array.Copy(initialize_value, send_value, initialize_value.Length);
            Array.Copy(tempNames, temp_plateText, tempNames.Length);
        }

        /// <summary>
        /// Blitに関わる処理
        /// </summary>
        float power = 0;
        int updateCount = 0;
        private void redy()
        {
            timeLeft--;
            if(timeLeft < -600) { timeLeft = 0; blitMap(); return; }    //何もない時も600fに一回くらい更新しとく

            if (_modeChange)
            {
                power = Mathf.Lerp(power, 0f, .1f);     //EnterまたはExitがあった時、まずpowerを0へ誘導する。
                if (power <= .01f) { power = 0f; _modeChange = false; }
            }
            else
            {
                if (isEnter) { power = Mathf.Lerp(power, 1f, .05f); }    //modeChangeの処理が終わった後にEnterであればpowerを1へ誘導する。
            }

            power = Mathf.Clamp01(power);   //たまに真っ白になる原因がpowerだと予想してclamp

            //UI操作中は常に更新
            if (0f < power)
            {
                blitMap();
                return;
            }

            //SelfOnDeserialization内の処理中であればblit
            if (0 < timeLeft)
            {
                blitMap();
                return;
            }
        }


        Vector4[] send_value = new Vector4[100];
        bool _closeBlit = false; //1フレームで何度もさせたくないので1度終えたら閉じる
        private void blitMap()
        {
            if (_closeBlit) return;

            calcDurationTime();

            Vector4 select = new Vector4(power, _selectNum, _durationTime, plateAlpha);
            VRCShader.SetGlobalVector(_selectid, select);

            VRCShader.SetGlobalVectorArray(_valueid, send_value);

            VRCGraphics.Blit(null, rt, _blitMat);

            _closeBlit = true;
        }
    }
}
