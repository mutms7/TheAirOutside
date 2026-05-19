using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using VisualNovel.Shared.Services;
using VisualNovel.Web;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });
builder.Services.AddSingleton<StoryService>();
builder.Services.AddSingleton<SettingsService>();

var host = builder.Build();

using (var scope = host.Services.CreateScope())
{
    var http = scope.ServiceProvider.GetRequiredService<HttpClient>();
    var story = host.Services.GetRequiredService<StoryService>();
    var json = await http.GetStringAsync("_content/VisualNovel.Shared/story.json");
    story.LoadFromJson(json);

    var settings = host.Services.GetRequiredService<SettingsService>();
    await settings.LoadAsync();
}

await host.RunAsync();
