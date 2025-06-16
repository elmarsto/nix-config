# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Nix Flake configuration repository managing 4 systems (fourcade, bowsprit, sopwith, pamplemoose) using NixOS and Home Manager. The architecture separates shared configurations in `/lattice/share/` from system-specific overrides in `/lattice/sys/`.

## Common Development Commands

### System Management
```bash
# Full system switch (both NixOS and Home Manager)
nix run .

# NixOS rebuild only
nix run .#nrs

# Home Manager switch only  
nix run .#hms

# Target specific system
nixos-rebuild switch --flake .#fourcade
home-manager switch --flake .#fourcade
```

### Development Tasks
```bash
# Format Nix files
nix fmt

# Update flake inputs
nix flake update

# Build custom packages
nix build .#[package-name]
```

## Architecture Overview

### Configuration Layers
- **`/flake.nix`**: Central orchestrator defining all systems and apps
- **`/lattice/share/nixos/`**: Shared system-level configurations
- **`/lattice/share/home-manager/`**: Shared user-level configurations with modular components
- **`/lattice/sys/[hostname]/`**: System-specific configurations and overrides

### Key Shared Modules
- **`/lattice/share/home-manager/shell/`**: Comprehensive CLI environment with language servers and development tools
- **`/lattice/share/home-manager/neovim/`**: Full IDE setup with 80+ plugins and extensive Lua configuration in `/lattice/share/home-manager/neovim/lua/lattice/`
- **`/lattice/share/home-manager/gui/`**: Terminal and graphical applications
- Specialized modules: `audio.nix`, `comms.nix`, `mail/`, `text.nix`, `vcs.nix`, `video.nix`, `virt.nix`, `visual.nix`

### System Configurations
- **fourcade**: Primary workstation (AMD GPU, IOMMU, VM support)
- **bowsprit/sopwith**: Linux workstations
- **pamplemoose**: macOS system (aarch64-darwin)

## Development Environment

The configuration provides extensive development tooling including:
- Language servers for Ruby, Python, TypeScript, Rust, Elixir, Lua, and more
- AI development tools (Claude Code, Aider, GPT CLI)
- Container and infrastructure tools (Docker, Kubernetes, Terraform)
- Modern shell experience with Starship prompt and advanced file management

## Security and System Hardening

- Uses `doas` instead of `sudo`
- Locked-down kernel with custom parameters
- TPM support where available
- Hardware-specific microcode updates