set dotenv-load := true

# List available commands (default command when you just run `just`)
[private]
list:
    just --list

# install necessary plugins
[group('Getting Started')]
setup:
    sops decrypt --filename-override .env .env.enc > .env
    lefthook install


# build in a CI environment
[private]
ci-build:
    mdbook-mermaid install {{ justfile_directory() }}
    mdbook-admonish install {{ justfile_directory() }}
    just build

# develop loop
[group('Build')]
dev:
    mdbook serve

# open a new branch
[group('Source Control')]
branch topic=`diceware --no-caps -d '-' -n 2`:
    git checkout main
    git pull
    git checkout -b "feat/{{ topic }}"
    git push

# push all changes
[group('Source Control')]
push msg='feat: progress':
    git commit -am '{{ msg }}'
    git push

# open a PR with title msg with a list of all changes
[group('Source Control')]
pr title='feat: progress':
    gh pr new --title '{{ title }}' --web


# lint markdown and other files
[group('Linting & Formatting')]
everything-zap:
    just --unstable --fmt
    nix flake check
    alejandra flake.nix
    statix flake.nix
    mdformat --check README.md src/
    yamllint --no-warnings -d relaxed  .

# Lint and format yaml files
[group('Linting & Formatting')]
yaml-zap +files:
    # TODO: formatter
    yamllint --no-warnings -d relaxed {{ files }}

# Lint and format the Justfile
[group('Linting & Formatting')]
just-zap *files:
    just --unstable --fmt

# Sort and format Nix files
[group('Linting & Formatting')]
nix-zap +files:
  alejandra {{files}}
  statix {{files}}
  nix flake check

# Lint and format markdown files
[group('Linting & Formatting')]
markdown-zap +files:
    mdformat {{ files }}

# decrypt files containing keys
[group('Secrets')]
decrypt:
    sops decrypt --filename-override .env .env.enc > .env


# encrypt files containing keys
[group('Secrets')]
encrypt:
    sops encrypt .env > .env.enc

