using UnityEngine;

public class ParticleBakerFloatAsset : MonoBehaviour
{
    [Header("Source (RenderTexture)")]
    public RenderTexture source;

    [Header("Target (Texture2D .asset / RGBAFloat)")]
    public Texture2D target;

    [Header("Asset Create Settings")]
    public string assetName = "BakedCenters_Float";
    public int width = 1024;
    public int height = 1024;

    [Tooltip("If true, clears the texture to (0,0,0,1) on creation.")]
    public bool clearOnCreate = true;

    [Range(0f, 1f)]
    public float clearAlpha = 1f;

    [Header("Copy Settings")]
    [Tooltip("If true, checks that RT size equals target size before copying.")]
    public bool requireSameSize = true;

    [Tooltip("If true, forces Point sampling on the RT before copy (helps avoid accidental filtering in some paths).")]
    public bool forceRTPointFilter = true;

    [Tooltip("Alpha to force after copy (set to 1 for data). If negative, do not override alpha.")]
    public float forceAlphaAfterCopy = 1f;
}
