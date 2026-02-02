
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

namespace enfutu.UdonScript
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class nameplate : UdonSharpBehaviour
    {
        [SerializeField] DropClock _dropsc;

        public int MyNum = -1;  //配列番号
        public bool Active = false;
        public void OnEnter()
        {
            if (Active) { _dropsc.ListeningEnter_ActiveMode(MyNum); }
            else { _dropsc.ListeningEnter_NonActiveMode(MyNum); }

        }

        public void OnExit()
        {
            if (Active) { _dropsc.ListeningExit_ActiveMode(); }
            else { _dropsc.ListeningExit_NonActiveMode(); }
        }

        public void OnPointerDown()
        {
            _dropsc.ListeningPointerDown_ActiveMode(MyNum);
        }
    }
}
