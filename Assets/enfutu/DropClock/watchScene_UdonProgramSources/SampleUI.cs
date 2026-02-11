
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

        void Start()
        {
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
        [SerializeField] Material[] _frmat;
        public void Frame0() { setFrameMaterial(0); }
        public void Frame1() { setFrameMaterial(1); }
        public void Frame2() { setFrameMaterial(2); }
        public void Frame3() { setFrameMaterial(3); }
        public void Frame4() { _frame.enabled = false; }
        private void setFrameMaterial(int num)
        {
            _frame.enabled = true;
            _frame.material = _frmat[num];
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

            _nameplateRoot.SetActive(false);
            _nameplateRoot.SetActive(true);
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
        public void PosterToggle() { _posterEnable = !_posterEnable; _poster.SetActive(_posterEnable); }

        //mirror
        bool _mirrorEnable = true;
        [SerializeField] GameObject _mirror;
        public void MirrorToggle() { _mirrorEnable = !_mirrorEnable; _mirror.SetActive(_mirrorEnable); }
    }
}
