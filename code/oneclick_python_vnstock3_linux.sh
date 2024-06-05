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
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.10 python3.10-venv python3.10-dev
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
    sudo update-alternatives --config python3
    echo "Python 3.10 installation complete."

    # Add Python to the PATH
    echo 'export PATH="/usr/bin/python3.10:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    echo "Python 3.10 has been added to the system PATH."
}

# Function to check if Visual Studio Code is installed
check_vscode() {
    if [ "$REPL_ID" ]; then
        echo "Running in Replit environment. Skipping Visual Studio Code installation."
        return 0
    elif command -v code &> /dev/null; then
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
    
    # Add the GPG key and repository
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    
    # Update and install Visual Studio Code
    sudo apt update
    sudo apt install -y code
    
    echo "Visual Studio Code installation complete."
}

# Function to check if a VS Code extension is installed
check_vscode_extension() {
    if [ "$REPL_ID" ]; then
        return 0
    elif code --list-extensions | grep -q $1; then
        echo "VS Code extension $1 is already installed."
        return 0
    else
        echo "VS Code extension $1 is not installed."
        return 1
    fi
}

# Function to install VS Code extensions
install_vscode_extensions() {
    if [ "$REPL_ID" ]; then
        echo "Running in Replit environment. Skipping VS Code extensions installation."
        return
    fi
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
