#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(ParticleBakerFloatAsset))]
public class ParticleBakerFloatAssetEditor : Editor
{
    const string OutputFolder = "Assets/enfutu/ParticleBaker/Baked";

    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        var t = (ParticleBakerFloatAsset)target;

        EditorGUILayout.Space(10);

        using (new EditorGUILayout.VerticalScope("box"))
        {
            EditorGUILayout.LabelField("Float Asset Tools", EditorStyles.boldLabel);
            EditorGUILayout.LabelField($"Output: {OutputFolder}");

            using (new EditorGUI.DisabledScope(t.width <= 0 || t.height <= 0))
            {
                if (GUILayout.Button("Create / Recreate RGBAFloat Texture2D.asset"))
                {
                    CreateOrRecreateTargetAsset(t);
                }
            }

            EditorGUILayout.Space(4);

            using (new EditorGUI.DisabledScope(t.source == null || t.target == null))
            {
                if (GUILayout.Button("Copy RT → target (RGBAFloat)"))
                {
                    CopyRTToTarget(t);
                }
            }

            if (t.source == null || t.target == null)
            {
                EditorGUILayout.HelpBox(
                    "Assign both Source (RenderTexture) and Target (Texture2D RGBAFloat .asset) to enable copying.\n" +
                    "Use the Create button to generate a compatible target asset.",
                    MessageType.Info);
            }
        }

        using (new EditorGUILayout.VerticalScope("box"))
        {
            if (t.target != null && GUILayout.Button("Select Target Asset"))
            {
                Selection.activeObject = t.target;
                EditorGUIUtility.PingObject(t.target);
            }
        }
    }

    static void CreateOrRecreateTargetAsset(ParticleBakerFloatAsset t)
    {
        EnsureFolder("Assets/enfutu");
        EnsureFolder("Assets/enfutu/ParticleBaker");
        EnsureFolder(OutputFolder);

        string safeName = string.IsNullOrWhiteSpace(t.assetName) ? "BakedCenters_Float" : t.assetName.Trim();
        safeName = SanitizeFileName(safeName);

        string assetPath = $"{OutputFolder}/{safeName}.asset";

        var existing = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);
        if (existing != null)
        {
            AssetDatabase.DeleteAsset(assetPath);
        }

        var tex = new Texture2D(t.width, t.height, TextureFormat.RGBAFloat, mipChain: false, linear: true)
        {
            name = safeName,
            wrapMode = TextureWrapMode.Clamp,
            filterMode = FilterMode.Point,
            anisoLevel = 0
        };

        if (t.clearOnCreate)
        {
            var c = new Color(0f, 0f, 0f, Mathf.Clamp01(t.clearAlpha));
            var pixels = new Color[t.width * t.height];
            for (int i = 0; i < pixels.Length; i++) pixels[i] = c;
            tex.SetPixels(pixels);
            tex.Apply(false, false);
        }

        AssetDatabase.CreateAsset(tex, assetPath);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        t.target = AssetDatabase.LoadAssetAtPath<Texture2D>(assetPath);
        EditorUtility.SetDirty(t);

        Debug.Log($"Created RGBAFloat Texture2D asset: {assetPath}");
    }

    static void CopyRTToTarget(ParticleBakerFloatAsset t)
    {
        var rt = t.source;
        var tex = t.target;

        if (rt == null) { Debug.LogError("Source RT is null."); return; }
        if (tex == null) { Debug.LogError("Target Texture2D is null."); return; }

        if (tex.format != TextureFormat.RGBAFloat)
        {
            Debug.LogError($"Target texture format must be RGBAFloat. Current: {tex.format}");
            return;
        }

        if (t.requireSameSize && (rt.width != tex.width || rt.height != tex.height))
        {
            Debug.LogError($"Size mismatch. RT: {rt.width}x{rt.height}, Target: {tex.width}x{tex.height}");
            return;
        }

        var prevFilter = rt.filterMode;
        if (t.forceRTPointFilter) rt.filterMode = FilterMode.Point;

        // RT -> Texture2D (RGBAFloat) copy
        var prev = RenderTexture.active;
        RenderTexture.active = rt;

        tex.ReadPixels(new Rect(0, 0, tex.width, tex.height), 0, 0);
        tex.Apply(false, false);

        RenderTexture.active = prev;

        if (t.forceRTPointFilter) rt.filterMode = prevFilter;

        // Optional: force alpha channel to a constant value after copy
        if (t.forceAlphaAfterCopy >= 0f)
        {
            float a = Mathf.Clamp01(t.forceAlphaAfterCopy);

            // Alphaの上書きが必要なら SetPixels で編集（重いので必要時のみ）
            // ※大量サイズで頻繁に押す用途なら、書き込み側シェーダで A=1 固定を推奨
            var pixels = tex.GetPixels();
            for (int i = 0; i < pixels.Length; i++)
                pixels[i].a = a;
            tex.SetPixels(pixels);
            tex.Apply(false, false);
        }

        EditorUtility.SetDirty(tex);
        AssetDatabase.SaveAssets();

        Debug.Log("Copied RenderTexture → RGBAFloat Texture2D asset.");
    }

    static void EnsureFolder(string assetFolderPath)
    {
        if (AssetDatabase.IsValidFolder(assetFolderPath)) return;

        string parent = Path.GetDirectoryName(assetFolderPath)?.Replace("\\", "/");
        string name = Path.GetFileName(assetFolderPath);

        if (string.IsNullOrEmpty(parent))
            parent = "Assets";

        if (!AssetDatabase.IsValidFolder(parent))
            EnsureFolder(parent);

        if (!AssetDatabase.IsValidFolder(assetFolderPath))
            AssetDatabase.CreateFolder(parent, name);
    }

    static string SanitizeFileName(string s)
    {
        foreach (char c in Path.GetInvalidFileNameChars())
            s = s.Replace(c, '_');
        return s;
    }
}
#endif
