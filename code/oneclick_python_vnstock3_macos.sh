#!/bin/bash

# Function to check if a required Python version is installed
check_python() {
    required_version="3.10"
    installed_versions=()

    # Check for various common Python executable names
    python_executables=("python3" "python3.10" "python3.11" "python3.12")
    for exe in "${python_executables[@]}"; do
        if command -v $exe &> /dev/null; then
            version_output=$($exe --version 2>&1)
            version_string=${version_output#"Python "}
            version=$(echo $version_string | awk '{print $1}')
            installed_versions+=("$exe:$version")
        fi
    done

    # Find the highest installed version
    if [ ${#installed_versions[@]} -gt 0 ]; then
        highest_version=$(printf "%s\n" "${installed_versions[@]}" | sort -t':' -k2 -V | tail -n1)
        highest_exe=${highest_version%%:*}
        highest_ver=${highest_version##*:}
        if [ "$(printf '%s\n' "$required_version" "$highest_ver" | sort -V | head -n1)" = "$required_version" ]; then
            echo "$highest_exe version $highest_ver is already installed."
            return 0
        fi
    fi

    echo "No suitable Python version found."
    return 1
}

# Function to install Python 3.10
install_python() {
    if check_python; then return; fi
    echo "Installing Python 3.10..."
    python_installer_url="https://www.python.org/ftp/python/3.10.0/python-3.10.0-macos11.pkg"
    python_installer_path="$HOME/Downloads/python-3.10.0-macos11.pkg"
    curl -o $python_installer_path $python_installer_url
    sudo installer -pkg $python_installer_path -target /
    rm $python_installer_path
    echo "Python 3.10 installation complete."

    # Add Python to the PATH
    echo 'export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    echo "Python 3.10 has been added to the system PATH."
}

# Function to check if Visual Studio Code is installed
check_vscode() {
    if command -v code &> /dev/null; then
        echo "Visual Studio Code is already installed."
        return 0
    else
        echo "Visual Studio Code is not installed."
        return 1
    fi
}

# Function to install Visual Studio Code
install_vscode() {
    if check_vscode; then return; fi
    echo "Installing Visual Studio Code..."
    vscode_installer_url="https://update.code.visualstudio.com/latest/darwin/stable"
    vscode_installer_path="$HOME/Downloads/VSCode-darwin-stable.zip"
    curl -o $vscode_installer_path $vscode_installer_url
    unzip $vscode_installer_path -d $HOME/Downloads
    mv "$HOME/Downloads/Visual Studio Code.app" /Applications/
    rm $vscode_installer_path
    echo "Visual Studio Code installation complete."
}

# Function to check if a VS Code extension is installed
check_vscode_extension() {
    if code --list-extensions | grep -q $1; then
        echo "VS Code extension $1 is already installed."
        return 0
    else
        echo "VS Code extension $1 is not installed."
        return 1
    fi
}

# Function to install VS Code extensions
install_vscode_extensions() {
    if ! check_vscode_extension "ms-toolsai.jupyter"; then
        echo "Installing VS Code extension ms-toolsai.jupyter..."
        code --install-extension ms-toolsai.jupyter
        echo "VS Code extension ms-toolsai.jupyter installation complete."
    fi
    if ! check_vscode_extension "ms-python.python"; then
        echo "Installing VS Code extension ms-python.python..."
        code --install-extension ms-python.python
        echo "VS Code extension ms-python.python installation complete."
    fi
}

# Function to check if a Python package is installed
check_python_package() {
    if python3 -m pip show $1 &> /dev/null; then
        echo "Python package $1 is already installed."
        return 0
    else
        echo "Python package $1 is not installed."
        return 1
    fi
}

# Function to install Python packages
install_python_packages() {
    packages=("vnstock3" "pandas" "requests" "beautifulsoup4" "selenium" "openpyxl" "PyYAML")
    for package in "${packages[@]}"; do
        if ! check_python_package $package; then
            echo "Installing Python package $package..."
            python3 -m pip install $package
            echo "Python package $package installation complete."
        fi
    done
}

# Main function to run all installations
main() {
    install_python
    install_vscode
    install_vscode_extensions
    install_python_packages
    echo "Setup complete!"
}

# Execute the main function
main
