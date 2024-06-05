# Set the output encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Function to check if a required Python version is installed
function Check-Python {
    $requiredVersion = [version]"3.10"
    $installedVersions = @()

    # Check for various common Python executable names
    $pythonExecutables = @("python", "python3", "python3.10", "python3.11", "python3.12")
    foreach ($exe in $pythonExecutables) {
        try {
            $versionOutput = & $exe --version 2>$null
            if ($versionOutput) {
                $versionString = $versionOutput -replace 'Python ', ''
                $version = [version]$versionString
                $installedVersions += [pscustomobject]@{ Name = $exe; Version = $version }
            }
        } catch {
            # Ignore errors for non-existent executables
        }
    }

    # Find the highest installed version
    if ($installedVersions) {
        $highestVersion = $installedVersions | Sort-Object Version -Descending | Select-Object -First 1
        if ($highestVersion.Version -ge $requiredVersion) {
            Write-Output "$($highestVersion.Name) version $($highestVersion.Version) is already installed."
            return $true
        }
    }

    Write-Output "No suitable Python version found."
    return $false
}

# Function to install Python 3.10 and add it to PATH
function Install-Python {
    if (Check-Python) { return }
    Write-Output "Installing Python 3.10..."
    $pythonInstaller = "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"
    $pythonInstallerPath = "$env:TEMP\python-3.10.0-amd64.exe"
    Invoke-WebRequest -Uri $pythonInstaller -OutFile $pythonInstallerPath
    Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    Remove-Item -Path $pythonInstallerPath
    Write-Output "Python 3.10 installation complete."

    # Add Python to the system PATH
    $pythonPath = [System.Environment]::GetEnvironmentVariable("PYTHON", "Machine")
    if (-not $pythonPath) {
        $pythonDir = "C:\Python310"
        [System.Environment]::SetEnvironmentVariable("PYTHON", $pythonDir, "Machine")
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
        $newPath = "$currentPath;$pythonDir;$pythonDir\Scripts"
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Output "Python 3.10 has been added to the system PATH."
    } else {
        Write-Output "Python 3.10 is already in the system PATH."
    }
}

# Function to check if Visual Studio Code is installed
function Check-VSCode {
    try {
        $vscodeVersion = code --version
        Write-Output "Visual Studio Code is already installed."
        return $true
    } catch {
        Write-Output "Visual Studio Code is not installed."
        return $false
    }
}

# Function to install Visual Studio Code
function Install-VSCode {
    if (Check-VSCode) { return }
    Write-Output "Installing Visual Studio Code..."
    $vscodeInstaller = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $vscodeInstallerPath = "$env:TEMP\vscode-setup.exe"
    Invoke-WebRequest -Uri $vscodeInstaller -OutFile $vscodeInstallerPath
    Start-Process -FilePath $vscodeInstallerPath -ArgumentList "/silent /mergetasks=!runcode,desktopicon,addcontextmenufiles,addcontextmenufolders,addtopath" -Wait
    Remove-Item -Path $vscodeInstallerPath
    Write-Output "Visual Studio Code installation complete."
}

# Function to check if a VS Code extension is installed
function Check-VSCodeExtension {
    param ($extension)
    $installedExtensions = code --list-extensions
    if ($installedExtensions -contains $extension) {
        Write-Output "VS Code extension $extension is already installed."
        return $true
    } else {
        Write-Output "VS Code extension $extension is not installed."
        return $false
    }
}

# Function to install VS Code extensions
function Install-VSCodeExtensions {
    if (-not (Check-VSCodeExtension -extension "ms-toolsai.jupyter")) {
        Write-Output "Installing VS Code extension ms-toolsai.jupyter..."
        code --install-extension ms-toolsai.jupyter
        Write-Output "VS Code extension ms-toolsai.jupyter installation complete."
    }
    if (-not (Check-VSCodeExtension -extension "ms-python.python")) {
        Write-Output "Installing VS Code extension ms-python.python..."
        code --install-extension ms-python.python
        Write-Output "VS Code extension ms-python.python installation complete."
    }
}

# Function to check if a Python package is installed
function Check-PythonPackage {
    param ($package)
    $packageInfo = pip show $package 2>$null
    if ($packageInfo) {
        Write-Output "Python package $package is already installed."
        return $true
    } else {
        Write-Output "Python package $package is not installed."
        return $false
    }
}

# Function to install Python packages
function Install-PythonPackages {
    $packages = @("vnstock3", "pandas", "requests", "beautifulsoup4", "selenium", "PyYAML", "openpyxl", "jupyterlab")
    foreach ($package in $packages) {
        if (-not (Check-PythonPackage -package $package)) {
            Write-Output "Installing Python package $package..."
            python -m pip install $package
            Write-Output "Python package $package installation complete."
        }
    }
}

# Main function to run all installations
function Main {
    Install-Python
    Install-VSCode
    Install-VSCodeExtensions
    Install-PythonPackages
    Write-Output "Setup complete!"
}

# Execute the main function
Main