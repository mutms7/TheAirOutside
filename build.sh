#!/usr/bin/env bash
# Vercel build entry point — installs .NET 10, compiles Ink, publishes Blazor WASM.
set -euo pipefail

echo "==> Installing .NET 10 SDK"
curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh
/tmp/dotnet-install.sh --channel 10.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
dotnet --info

echo "==> Compiling Ink narrative → story.json"
dotnet run --project src/VisualNovel.InkBuild --configuration Release

echo "==> Publishing Blazor WASM → publish/wwwroot"
dotnet publish src/VisualNovel.Web -c Release -o publish

echo "==> Done. Static output at publish/wwwroot"
ls -la publish/wwwroot | head -20
