using Ink.Runtime;

namespace VisualNovel.Shared.Services;

public sealed class StoryService
{
    private Story? _story;
    private readonly List<StorySnapshot> _timeline = new();
    private int _timelineIndex = -1;

    public string CurrentText { get; private set; } = "";
    public string Speaker { get; private set; } = "";
    public string Motif { get; private set; } = "";
    public string Art { get; private set; } = "";
    public IReadOnlyList<string> CurrentSfx { get; private set; } = Array.Empty<string>();

    public string Background { get; private set; } = "";
    public string CharacterOnStage { get; private set; } = "";
    public string Voice { get; private set; } = "modulated";
    public string Pacing { get; private set; } = "normal";
    public string Audio { get; private set; } = "";
    public string CurrentAudioCue { get; private set; } = "";
    public int Scene { get; private set; }
    public bool IsClimaxPause { get; private set; }
    public string EndingTitle { get; private set; } = "";

    public IReadOnlyList<Choice> CurrentChoices { get; private set; } = Array.Empty<Choice>();

    public HashSet<int> VisitedScenes { get; } = new();
    public List<HistoryEntry> History { get; } = new();

    public bool IsPrologueDone { get; private set; }

    public void MergeVisited(IEnumerable<int> scenes)
    {
        foreach (var s in scenes) VisitedScenes.Add(s);
        StateChanged?.Invoke();
    }

    public void MarkPrologueDone()
    {
        IsPrologueDone = true;
        StateChanged?.Invoke();
    }

    public void SetProtagonistName(string name)
    {
        if (_story is null) return;
        var n = string.IsNullOrWhiteSpace(name) ? "Wren" : name.Trim();
        try
        {
            _story.variablesState["protagonist_name"] = n;
        }
        catch { /* variable may not exist yet, safely ignored */ }
        IsPrologueDone = true;
        Start();
    }

    public bool IsLoaded => _story is not null;
    public bool CanAdvance =>
        _story is not null
        && ((_timelineIndex >= 0 && _timelineIndex < _timeline.Count - 1) || _story.canContinue);
    public bool CanGoBack => _story is not null && _timelineIndex > 0;
    public bool IsAtChoice => CurrentChoices.Count > 0;
    public bool IsEnded => _story is not null && !CanAdvance && !IsAtChoice;

    public event Action? StateChanged;

    private bool _started;

    public void LoadFromJson(string json)
    {
        _story = new Story(json);
        _started = false;
        _timeline.Clear();
        _timelineIndex = -1;
        StateChanged?.Invoke();
    }

    public void Start()
    {
        if (_started) return;
        _started = true;
        Advance();
    }

    public void Advance()
    {
        if (_story is null) return;

        if (_timelineIndex >= 0 && _timelineIndex < _timeline.Count - 1)
        {
            RestoreSnapshot(_timelineIndex + 1);
            return;
        }

        Speaker = "";
        Motif = "";
        Art = "";
        CurrentAudioCue = "";
        IsClimaxPause = false;
        var sfx = new List<string>();

        if (_story.canContinue)
        {
            CurrentText = _story.Continue().TrimEnd('\n').Trim();
            ApplyTags(_story.currentTags ?? new List<string>(), sfx);
            if (!string.IsNullOrEmpty(CurrentText))
            {
                History.Add(new HistoryEntry(Scene, Speaker, CurrentText));
            }
        }
        else
        {
            CurrentText = "";
        }

        CurrentSfx = sfx;
        CurrentChoices = _story.currentChoices?.ToList() ?? new List<Choice>();
        PushSnapshot();
        StateChanged?.Invoke();
    }

    public void Choose(int index)
    {
        if (_story is null) return;
        TrimFutureTimeline();
        _story.ChooseChoiceIndex(index);
        Advance();
    }

    public bool GoBack()
    {
        if (_story is null || _timelineIndex <= 0) return false;
        RestoreSnapshot(_timelineIndex - 1);
        return true;
    }

    public bool JumpToKnot(string knot)
    {
        if (_story is null || string.IsNullOrEmpty(knot)) return false;
        try
        {
            // Reset persistent stage state so a new scene doesn't inherit
            // the previous scene's character, background, motif, art etc.
            Background = "";
            CharacterOnStage = "";
            Motif = "";
            Art = "";
            Audio = "";
            CurrentAudioCue = "";
            CurrentSfx = Array.Empty<string>();
            CurrentChoices = Array.Empty<Choice>();
            _timeline.Clear();
            _timelineIndex = -1;

            _story.ChoosePathString(knot);
            Advance();
            return true;
        }
        catch
        {
            return false;
        }
    }

    private void PushSnapshot()
    {
        if (_story is null) return;
        TrimFutureTimeline();
        _timeline.Add(new StorySnapshot(
            _story.state.ToJson(),
            CurrentText,
            Speaker,
            Motif,
            Art,
            Background,
            CharacterOnStage,
            Voice,
            Pacing,
            Audio,
            Scene,
            IsClimaxPause,
            EndingTitle));
        _timelineIndex = _timeline.Count - 1;
    }

    private void TrimFutureTimeline()
    {
        if (_timelineIndex >= 0 && _timelineIndex < _timeline.Count - 1)
        {
            _timeline.RemoveRange(_timelineIndex + 1, _timeline.Count - _timelineIndex - 1);
        }
    }

    private void RestoreSnapshot(int index)
    {
        if (_story is null || index < 0 || index >= _timeline.Count) return;

        var snapshot = _timeline[index];
        _story.state.LoadJson(snapshot.StateJson);
        _timelineIndex = index;

        CurrentText = snapshot.CurrentText;
        Speaker = snapshot.Speaker;
        Motif = snapshot.Motif;
        Art = snapshot.Art;
        Background = snapshot.Background;
        CharacterOnStage = snapshot.CharacterOnStage;
        Voice = snapshot.Voice;
        Pacing = snapshot.Pacing;
        Audio = snapshot.Audio;
        CurrentAudioCue = "";
        CurrentSfx = Array.Empty<string>();
        Scene = snapshot.Scene;
        IsClimaxPause = snapshot.IsClimaxPause;
        EndingTitle = snapshot.EndingTitle;
        CurrentChoices = _story.currentChoices?.ToList() ?? new List<Choice>();
        StateChanged?.Invoke();
    }

    public string GetVar(string name)
    {
        if (_story is null) return "";
        try
        {
            return _story.variablesState[name]?.ToString() ?? "";
        }
        catch
        {
            return "";
        }
    }

    private void ApplyTags(IList<string> tags, List<string> sfx)
    {
        foreach (var raw in tags)
        {
            var (key, value) = SplitTag(raw);
            switch (key)
            {
                case "scene":
                    if (int.TryParse(value, out var s))
                    {
                        Scene = s;
                        VisitedScenes.Add(s);
                    }
                    break;
                case "pacing":  Pacing = value; break;
                case "voice":   Voice = value; break;
                case "bg":      Background = value; break;
                case "char":    CharacterOnStage = value; break;
                case "speaker": Speaker = value; break;
                case "motif":   Motif = value; break;
                case "art":     Art = value; break;
                case "audio":
                    Audio = value;
                    CurrentAudioCue = value;
                    break;
                case "sfx":     sfx.Add(value); break;
                case "pause":
                    if (value == "climax-window") IsClimaxPause = true;
                    break;
                case "ending":
                    EndingTitle = value;
                    break;
            }
        }
    }

    private static (string key, string value) SplitTag(string raw)
    {
        var idx = raw.IndexOf(':');
        if (idx < 0) return (raw.Trim(), "");
        return (raw[..idx].Trim(), raw[(idx + 1)..].Trim());
    }

    private sealed record StorySnapshot(
        string StateJson,
        string CurrentText,
        string Speaker,
        string Motif,
        string Art,
        string Background,
        string CharacterOnStage,
        string Voice,
        string Pacing,
        string Audio,
        int Scene,
        bool IsClimaxPause,
        string EndingTitle);
}
