param (
    [parameter(Mandatory=$false)]
    [switch]
    $ForceInstall = $false
)
$InstallDirectory = 'C:/gitlab-runner'
$ExecutableName = "gitlab-runner.exe"
$ExecutablePath = "$InstallDirectory/$ExecutableName"

# Install gitlab-runner if it does not exists.
if (-Not $ForceInstall -And (Test-Path "$InstallDirectory/*.exe")) {
    "Gitlab Runner seems to be installed already. Skipping installation."
} else {
    "Installing Gitlab Runner at $ExecutablePath."

    New-Item -ItemType Directory -Force -Path $InstallDirectory

    # Download the runner executable if it does not exist:
    if (-Not (Test-Path $ExecutablePath)) {
        Invoke-WebRequest -Uri "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe" -OutFile $ExecutablePath
    }

    "Download complete! Now installing..."

    & "$ExecutablePath"  install

    "Installation of gitlab-runner complete!"
}



# Register this new gitlab-runner instance with our gitlab server

