#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

mkdir -p builds/windows

/workspace/godot --headless --path . --export-release "Windows Desktop" builds/windows/CatClimber.exe

echo "Build finished: builds/windows/CatClimber.exe"
