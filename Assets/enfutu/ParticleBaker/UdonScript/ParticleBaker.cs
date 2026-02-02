
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using System.Collections;

namespace enfutu.UdonScript
{
    public class ParticleBaker : UdonSharpBehaviour
    {
        [SerializeField] ParticleSystem _pa;
        [SerializeField] Material _mat;
        [SerializeField] RenderTexture _rt;
        [SerializeField] Camera _cam;

        void Start()
        {
        }

        public void StartSimlate()
        {
            _mat.SetVector("_EmitterPos", _pa.transform.position);
            count = 0;
            isClear = false;
            _pa.Emit(particleCount);
        }

        int count = 128;
        bool isClear = false;
        void Update()
        {
            if(count < particleCount)
            {
                if (!isClear) 
                {
                    _cam.clearFlags = CameraClearFlags.SolidColor;
                    isClear = true;
                    return;
                }

                count++;
                SimlatePaticle();
            }
        }

        int particleCount = 128;
        public void SimlatePaticle()
        {
            _cam.clearFlags = CameraClearFlags.Nothing;
            var main = _pa.main;
            float lifeTime = main.startLifetime.constant;
            //float lifeTime = main.startLifetime.constantMax;

            _pa.Pause();
            _pa.Simulate(lifeTime / particleCount, true, false, true);

        }

    }
}
