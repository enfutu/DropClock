
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;
using TMPro;

namespace enfutu.UdonScript
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.Continuous)]
    public class SampleUI : UdonSharpBehaviour
    {
        [SerializeField] DropClock _sc;
        [SerializeField] Animator _anim;

        //Select
        [SerializeField] Color32[] _selectCol;
        [SerializeField] Image[] styleImage;
        [SerializeField] Image[] sampleColorImage;
        [SerializeField] Image[] frameImage;

        //Colors
        [SerializeField] Color32[] _MainColor;
        [SerializeField] Color32[] _SubColor;
        [SerializeField] Color32[] _FontColor;

        [SerializeField] Material[] _FrontMat;
        [SerializeField] Material[] _BackMat;
        [SerializeField] Material[] _FrameMat;
        [SerializeField] Material[] _fontMat;
        [SerializeField] Material nullMat;

        //Parts
        [SerializeField] MeshRenderer back;
        [SerializeField] MeshRenderer frame;
        [SerializeField] MeshRenderer front;
        [SerializeField] MeshRenderer marker;
        [SerializeField] MeshRenderer stand_frame;
        [SerializeField] MeshRenderer stand_noFrame;

        void Start()
        {
            Style_Wall();
            Frame_Enable();
            Col0();

            /*
            Front0();
            Frame2();
            Back0();
            Water0();
            WaterEm();
            Hand0();
            HandEm();
            Font0();
            ScaleChange();
            WallChange();
            PosterToggle();
            MirrorToggle();
            */
        }

        //TestPlay----------------------------------------------------------
        [UdonSynced(UdonSyncMode.None)] int _useCount = 0;
        public void TestPlay()
        {
            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "TestPlayCall");
        }
        public void TestPlayCall()
        {
            _useCount++;
            _sc.TestPlayEnter(_useCount);
        }

        //Style----------------------------------------------------------
        int style = 0;
        public void Style_Wall()
        {
            style = 0;
            _anim.SetTrigger("Wall");

            wallNum = 0;
            WallSwitch();

            _posterEnable = false;
            PosterToggle();

            _mirrorEnable = false;
            MirrorToggle();
            SelectCol_Style();
            ScaleChange();
        }

        public void Style_Desk()
        {
            style = 1;
            _anim.SetTrigger("Desk");

            _mirrorEnable = false;
            MirrorToggle();
            SelectCol_Style();
            ScaleChange();
        }

        public void Style_Mirror()
        {
            style = 2;
            _anim.SetTrigger("Mirror");

            wallNum = 1;
            WallSwitch();

            _posterEnable = false;
            PosterToggle();

            _mirrorEnable = false;
            MirrorToggle();
            SelectCol_Style();
            ScaleChange();
        }

        public void SelectCol_Style()
        {
            for(int i = 0; i < styleImage.Length; i++)
            {
                if(i == style) { styleImage[i].color = _selectCol[0]; }
                else { styleImage[i].color = _selectCol[1]; }
            }
        }

        //Frame----------------------------------------------------------
        public void Frame_Enable()
        {
            frame.enabled = true; stand_frame.enabled = true; stand_noFrame.enabled = false;
            frameImage[0].color = _selectCol[0]; frameImage[1].color = _selectCol[1];
        }

        public void Frame_Disable()
        {
            frame.enabled = false; stand_frame.enabled = false; stand_noFrame.enabled = true;
            frameImage[0].color = _selectCol[1]; frameImage[1].color = _selectCol[0];
        }

        //Switch----------------------------------------------------------
        bool _mirrorEnable = true;
        [SerializeField] GameObject _mirror;
        public void MirrorToggle() 
        {
            _mirror.SetActive(_mirrorEnable);
            _mirrorEnable = !_mirrorEnable;       
        }

        //wall
        [SerializeField] Material[] wallMats;
        [SerializeField] MeshRenderer _wall;
        int wallNum = 0;
        public void WallSwitch()
        {
            _wall.material = wallMats[wallNum];
            if(wallNum < 2) { wallNum++; }
            else { wallNum = 0; }
        }

        //poster
        bool _posterEnable = true;
        [SerializeField] GameObject _poster;
        public void PosterToggle()
        {
            _poster.SetActive(_posterEnable);
            _posterEnable = !_posterEnable;
        }

        //Pattern----------------------------------------------------------

        int colnum = 0;
        public void Col0()
        {
            colnum = 0;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col1()
        {
            colnum = 1;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col2()
        {
            colnum = 2;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col3()
        {
            colnum = 3;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col4()
        {
            colnum = 4;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col5()
        {
            colnum = 5;
            SelectCol_Col();
            SetMaterials();
        }

        public void Col6()
        {
            colnum = 6;
            SelectCol_Col();
            SetMaterials();
        }

        [SerializeField] RectTransform[] _colsRect;
        [SerializeField] RectTransform _selectImage;
        public void SelectCol_Col()
        {
            Vector3 pos = new Vector3(_colsRect[colnum].position.x, _selectImage.position.y, _selectImage.position.z);
            _selectImage.position = pos;
        }

        [SerializeField] Material _waterMat;
        [SerializeField] GameObject _nameplateRoot;
        public void SetMaterials()
        {
            front.material = _FrontMat[colnum];
            back.material = _BackMat[colnum];
            frame.material = _FrameMat[colnum];
            marker.material = _FrameMat[colnum];
            stand_frame.material = _FrameMat[colnum];
            stand_noFrame.material = _FrameMat[colnum];

            _waterMat.SetColor("_WaterColor", _MainColor[colnum]);
            _waterMat.SetColor("_HandsColor", _SubColor[colnum]);

            for (int i = 0; i < _fontMat.Length; i++)
            {
                _fontMat[i].SetColor("_FaceColor", _FontColor[colnum]);
            }
            _nameplateRoot.SetActive(false);
            _nameplateRoot.SetActive(true);
        }

        //Scale
        [SerializeField] Transform dropClock;
        [SerializeField] Slider _scaleSlider;
        public void ScaleChange()
        {
            if(style == 1) 
            {
                _scaleSlider.interactable = false;
                dropClock.localScale = Vector3.one; 
                return;
            }

            _scaleSlider.interactable = true;
            float v = Mathf.Lerp(.5f, 1.8f, _scaleSlider.value);
            Vector3 scale = new Vector3(v, v, 1f); 
            dropClock.localScale = scale;
        }

        /*
        //FrontColor----------------------------------------------------------
        [SerializeField] MeshRenderer _front;
        [SerializeField] Vector4[] _emissionColor;
        [SerializeField] Material[] _fmat;
        bool em = true;
        public void Front0() { setFrontMaterial(0); }
        public void Front1() { setFrontMaterial(1); }
        public void Front2() { setFrontMaterial(2); }
        public void Front3()
        {
            em = !em;
            for (int i = 0; i < _fmat.Length; i++)
            {
                if (em) { _fmat[i].SetVector("_EmissionColor", _emissionColor[i]); }
                else { _fmat[i].SetVector("_EmissionColor", Vector4.zero); }
            }
        }
        public void Front4() { _front.enabled = false; }
        private void setFrontMaterial(int num)
        {
            _front.enabled = true;
            _front.material = _fmat[num];
        }

        //BackColor----------------------------------------------------------
        [SerializeField] MeshRenderer _back;
        [SerializeField] Material[] _bmat;
        public void Back0() { setBackMaterial(0); }
        public void Back1() { setBackMaterial(1); }
        public void Back2() { setBackMaterial(2); }
        public void Back3() { setBackMaterial(3); }
        public void Back4() { _back.enabled = false; }
        private void setBackMaterial(int num)
        {
            _back.enabled = true;
            _back.material = _bmat[num];
        }

        //FrameColor----------------------------------------------------------
        [SerializeField] MeshRenderer _frame;
        [SerializeField] MeshRenderer _stand0;
        [SerializeField] MeshRenderer _stand1;
        [SerializeField] MeshRenderer _marker;
        [SerializeField] Material[] _frmat;
        public void Frame0() { setFrameMaterial(0); }
        public void Frame1() { setFrameMaterial(1); }
        public void Frame2() { setFrameMaterial(2); }
        public void Frame3() { setFrameMaterial(3); }
        public void Frame4() { _frame.enabled = false; _stand0.enabled = false; _stand1.enabled = false; _marker.enabled = false; }
        private void setFrameMaterial(int num)
        {
            _frame.enabled = true;
            _stand0.enabled = true;
            _stand1.enabled = true;
            _marker.enabled = true;

            _frame.material = _frmat[num];
            _stand0.material = _frmat[num];
            _stand1.material = _frmat[num];
        }


        //WaterColor
        [SerializeField] Material _waterMat;
        [SerializeField] Color32[] _waterColor;
        [SerializeField] Slider _waterEmSlider;
        public void Water0() { _waterMat.SetColor("_WaterColor", _waterColor[0]); }
        public void Water1() { _waterMat.SetColor("_WaterColor", _waterColor[1]); }
        public void Water2() { _waterMat.SetColor("_WaterColor", _waterColor[2]); }
        public void Water3() { _waterMat.SetColor("_WaterColor", _waterColor[3]); }
        public void Water4() { _waterMat.SetColor("_WaterColor", _waterColor[4]); }
        public void Water5() { _waterMat.SetColor("_WaterColor", _waterColor[5]); }
        public void WaterEm() { _waterMat.SetFloat("_WaterEmissionPow", _waterEmSlider.value); }

        //HandColor
        [SerializeField] Slider _handEmSlider;
        public void Hand0() { _waterMat.SetColor("_HandsColor", _waterColor[0]); }
        public void Hand1() { _waterMat.SetColor("_HandsColor", _waterColor[1]); }
        public void Hand2() { _waterMat.SetColor("_HandsColor", _waterColor[2]); }
        public void Hand3() { _waterMat.SetColor("_HandsColor", _waterColor[3]); }
        public void Hand4() { _waterMat.SetColor("_HandsColor", _waterColor[4]); }
        public void Hand5() { _waterMat.SetColor("_HandsColor", _waterColor[5]); }
        public void HandEm() { _waterMat.SetFloat("_HandEmissionPow", _handEmSlider.value); }

        //FontColor
        [SerializeField] Material[] _fontMat;
        [SerializeField] Color32[] _fontColor;
        [SerializeField] GameObject _nameplateRoot;
        public void Font0() { setFontColor(0); }
        public void Font1() { setFontColor(1); }
        public void Font2() { setFontColor(2); }
        public void Font3() { setFontColor(3); }
        public void Font4() { setFontColor(4); }
        public void Font5() { setFontColor(5); }
        private void setFontColor(int num)
        {
            for (int i = 0; i < _fontMat.Length; i++)
            {
                _fontMat[i].SetColor("_FaceColor", _fontColor[num]);
            }


        }

        //Scale
        [SerializeField] Transform dropClock;
        [SerializeField] Slider _scaleSlider;
        public void ScaleChange()
        {
            dropClock.localScale = Vector3.one * Mathf.Lerp(.2f, 2f, _scaleSlider.value);
        }

        //material
        int _wallNum = 0;
        [SerializeField] Material[] _wallMat;
        [SerializeField] MeshRenderer _wall;
        public void WallChange() 
        {
            _wall.material = _wallMat[_wallNum];
            _wallNum++;
            if((_wallMat.Length - 1) < _wallNum) { _wallNum = 0; }
        }

        //poster
        bool _posterEnable = true;
        [SerializeField] GameObject _poster;
        public void PosterToggle() 
        { 
            _posterEnable = !_posterEnable; 
            _poster.SetActive(_posterEnable);
        }

        //mirror
        bool _mirrorEnable = true;
        [SerializeField] GameObject _mirror;
        public void MirrorToggle() { _mirrorEnable = !_mirrorEnable; _mirror.SetActive(_mirrorEnable); }

        */
    }
}
