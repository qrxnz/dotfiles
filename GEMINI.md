# GEMINI.md

## Project Overview

This repository contains a comprehensive set of dotfiles and NixOS configurations managed with `snowfall-lib`. The setup is tailored for IT security and DevOps tasks, with a strong emphasis on reproducibility and a personalized, efficient workflow. The project supports both NixOS and non-NixOS machines (Linux and macOS), using `stow` for dotfile management on the latter. The visual theme is consistently `Catppuccin`.

### Key Technologies

-   **Nix & NixOS:** For declarative system configuration.
-   **Home Manager:** For managing user-specific packages and dotfiles within NixOS.
-   **Snowfall Lib:** A library for structuring and simplifying Nix Flakes.
-   **Hyprland:** A dynamic tiling Wayland compositor.
-   **Zsh & Starship:** The shell and prompt configuration.
-   **Neovim:** The primary text editor, configured via a separate flake.
-   **Stow:** For managing dotfiles on non-NixOS systems.

## Building and Running

### NixOS

The primary way to use this repository is to build a NixOS system.

-   **Rebuild the system:**
    ```bash
    sudo sys rebuild
    ```
-   **Test an ephemeral config:**
    ```bash
    sudo sys test
    ```
-   **Deploy to a server:**
    ```bash
    sudo sys deploy HOSTNAME
    ```

### Non-NixOS (Linux & macOS)

For non-NixOS systems, the `setup.sh` script is used to install the dotfiles.

-   **Hyprland setup (Linux):**
    ```bash
    ./setup.sh --hyprland-default
    ```
-   **Shell-only setup (Linux):**
    ```bash
    ./setup.sh --shell-only
    ```
-   **macOS setup:**
    ```bash
    ./setup.sh --macos
    ```

## Development Conventions

-   **Modularity:** The NixOS configuration is highly modular, using a "suites" system to group related configurations (e.g., `desktop`, `development`, `creative`).
-   **Cross-Platform Support:** The repository is designed to work on both NixOS and non-NixOS systems, with clear separation of concerns.
-   **Customization:** The user has a highly customized environment, with many aliases, functions, and scripts to streamline their workflow.
-   **Theming:** The `Catppuccin` theme is used consistently across all applications.
-   **Dotfile Management:** `stow` is used for managing dotfiles on non-NixOS systems, while Home Manager is used for NixOS.
