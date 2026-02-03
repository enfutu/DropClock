
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
            Grass2();
            Circle();
            Water0();
            WaterEm();
            Hand0();
            HandEm();
            Font1();
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

        //GlassColor----------------------------------------------------------
        [SerializeField] MeshRenderer[] Glass;
        [SerializeField] Material[] GlassMaterial;
        public void Grass1() { setGlassMaterial(0); }
        public void Grass2() { setGlassMaterial(1); }
        public void Grass3() { setGlassMaterial(2); }
        public void Grass4() { setGlassMaterial(3); }
        public void Grass5() { setGlassMaterial(4); }
        private void setGlassMaterial(int num)
        {
            for(int i = 0; i < Glass.Length; i++)
            {
                Glass[i].material = GlassMaterial[num];
            }
        }

        //Shape----------------------------------------------------------
        [SerializeField] GameObject[] models;
        public void Square() { ShapesHide(); models[0].SetActive(true); }
        public void Pentagon() { ShapesHide(); models[1].SetActive(true); }
        public void Triangle() { ShapesHide(); models[2].SetActive(true); }
        public void Circle() { ShapesHide(); models[3].SetActive(true); }
        public void NoneShape() { ShapesHide(); models[4].SetActive(true); }
        private void ShapesHide() 
        {
            for(int i = 0; i < models.Length; i++)
            {
                models[i].SetActive(false);
            }
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
