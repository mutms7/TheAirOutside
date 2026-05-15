using Ink;

namespace VisualNovel.InkBuild;

public static class Program
{
    public static int Main(string[] args)
    {
        var repoRoot = FindRepoRoot();
        if (repoRoot is null)
        {
            Console.Error.WriteLine("InkBuild: could not find VisualNovel.slnx walking up from current directory.");
            return 2;
        }

        var inkDir = Path.Combine(repoRoot, "ink");
        var sourceFile = Path.Combine(inkDir, "story.ink");
        var outputFile = Path.Combine(repoRoot, "src", "VisualNovel.Shared", "wwwroot", "story.json");

        if (!File.Exists(sourceFile))
        {
            Console.Error.WriteLine($"InkBuild: missing source {sourceFile}");
            return 2;
        }

        Console.WriteLine($"InkBuild: compiling {sourceFile}");

        var source = File.ReadAllText(sourceFile);
        var options = new Compiler.Options
        {
            sourceFilename = sourceFile,
            fileHandler = new InkFileHandler(inkDir),
        };
        var compiler = new Compiler(source, options);
        var story = compiler.Compile();
        var json = story.ToJson();

        Directory.CreateDirectory(Path.GetDirectoryName(outputFile)!);
        File.WriteAllText(outputFile, json);

        Console.WriteLine($"InkBuild: wrote {outputFile} ({json.Length:N0} chars)");
        return 0;
    }

    static string? FindRepoRoot()
    {
        var dir = new DirectoryInfo(Environment.CurrentDirectory);
        while (dir is not null)
        {
            if (File.Exists(Path.Combine(dir.FullName, "VisualNovel.slnx")))
                return dir.FullName;
            dir = dir.Parent;
        }
        return null;
    }
}

internal sealed class InkFileHandler(string rootDirectory) : IFileHandler
{
    public string ResolveInkFilename(string includeName) =>
        Path.GetFullPath(Path.Combine(rootDirectory, includeName));

    public string LoadInkFileContents(string fullFilename) =>
        File.ReadAllText(fullFilename);
}
