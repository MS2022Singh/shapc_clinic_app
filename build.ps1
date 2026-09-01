# Auto-detect Flutter SDK path dynamically across systems
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    $flutterBin = (Get-ChildItem -Path "C:\" -Filter "flutter.bat" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1).DirectoryName
    if ($flutterBin) { $env:Path += ";$flutterBin" }
}

# Auto-detect Android SDK
if (-not $env:ANDROID_HOME) { 
    $env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk" 
}

# Extract application version from pubspec.yaml
$versionLine = Select-String -Path "pubspec.yaml" -Pattern "^version:\s*([^\+\s]+)" | Select-Object -First 1
$version = if ($versionLine) { $versionLine.Matches.Groups[1].Value } else { "1.0.0" }
$distFolder = "$env:USERPROFILE\Desktop\SHAPC_Clinic_v${version}_Package"

# Platform recovery, cleanup, and release compilation
flutter create . --platforms=windows,android
flutter clean
flutter pub get
flutter build windows --release
flutter build apk --release

# Output packaging
Remove-Item -Path $distFolder -Recurse -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "$distFolder\Windows" -Force | Out-Null
New-Item -ItemType Directory -Path "$distFolder\Android" -Force | Out-Null

Copy-Item -Path "build\windows\x64\runner\Release\*" -Destination "$distFolder\Windows" -Recurse
Copy-Item -Path "build\app\outputs\flutter-apk\app-release.apk" -Destination "$distFolder\Android\SHAPC_Clinic_App.apk"

Write-Host "Build complete: $distFolder" -ForegroundColor Green
