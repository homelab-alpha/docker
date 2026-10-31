<!-- markdownlint-disable MD041 -->

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/branding/logo_dark.svg" />
    <img src="assets/branding/logo_light.svg" alt="docker" width="320" />
  </picture>
</p>

[![Super Linter](https://github.com/homelab-alpha/docker/raw/badges/super_linter.svg)](https://github.com/homelab-alpha/docker/actions/workflows/super_linter.yml)
[![CodeQL](https://github.com/homelab-alpha/docker/raw/badges/codeql.svg)](https://github.com/homelab-alpha/docker/actions/workflows/codeql.yml)
[![Last commit](https://github.com/homelab-alpha/docker/raw/badges/last_commit.svg)](https://github.com/homelab-alpha/docker/commits/main/)
[![Repo size](https://github.com/homelab-alpha/docker/raw/badges/repo_size.svg)](https://github.com/homelab-alpha/docker/tree/main)
[![Changelog](https://github.com/homelab-alpha/docker/raw/badges/changelog.svg)](https://github.com/homelab-alpha/docker/blob/main/CHANGELOG.md)
[![Contributor Covenant](https://github.com/homelab-alpha/docker/raw/badges/contributor_covenant.svg)](https://github.com/homelab-alpha/docker/blob/main/CODE_OF_CONDUCT.md)
[![Conventional Commits](https://github.com/homelab-alpha/docker/raw/badges/conventional_commits.svg)](https://conventionalcommits.org)
[![Semantic Versioning](https://github.com/homelab-alpha/docker/raw/badges/semver.svg)](https://semver.org/spec/v2.0.0.html)
[![License](https://github.com/homelab-alpha/docker/raw/badges/license.svg)](https://github.com/homelab-alpha/docker/blob/main/LICENSE)

# Docker

Docker Compose stacks, network guides, and an image template for a self-hosted
homelab.

<details>
  <summary>Table of Contents (click to expand)</summary>
  <p>

1. [Docker](#docker)
   1. [Description](#description)
   2. [Features](#features)
      1. [Stacks](#stacks)
   3. [Project Status](#project-status)
   4. [Getting Started](#getting-started)
      1. [Requirements](#requirements)
      2. [Installation](#installation)
   5. [Development](#development)
   6. [Project Structure](#project-structure)
   7. [CI/CD and Automation](#cicd-and-automation)
      1. [Workflows](#workflows)
      2. [Linting](#linting)
      3. [Dependency Management](#dependency-management)
   8. [Policies and Standards](#policies-and-standards)
   9. [Working with Claude](#working-with-claude)
   10. [Known Issues](#known-issues)
       1. [Currently Being Addressed](#currently-being-addressed)
   11. [Contributing](#contributing)
   12. [Support](#support)
   13. [Security](#security)
   14. [Roadmap](#roadmap)
   15. [License](#license)

  </p>
</details>

## Description

**docker** is a collection of Docker Compose stacks for a self-hosted homelab,
together with guides for Docker networks and a template for building your own
container image. It helps you package, distribute, and manage containerized
applications.

More documentation is on the
[Homelab-Alpha documentation site](https://homelab-alpha.nl/docker/).

## Features

- **28 Docker Compose stacks** in `docker-compose-files/`, each in its own
  directory with a `docker-compose.yml` and its environment files.
- **Network guides** — Setup guides for `bridge`, `ipvlan`, and `macvlan` Docker
  networks in `docker-network-configurations/`.
- **Image template** — A simple Node.js and Express web server in a Docker
  container, as a starting point for your own image, in `image-template/`.

### Stacks

`adguard-home`, `cloudbeaver`, `dockge`, `dozzle`, `freshrss`, `haproxy`,
`harborguard`, `immich`, `it-tools`, `jellyfin`, `mariadb`, `mini-qr`,
`netboot`, `netdata`, `nginx-proxy-manager`, `openspeedtest`, `pi-hole`, `plex`,
`portainer`, `portainer-edge-agent`, `postgresql`, `speedtest-tracker`,
`speedtest-tracker-beta`, `unifi-network-application`, `uptime-kuma`,
`uptime-kuma-beta`, `watchtower`, `xen-orchestra`

## Project Status

> [!NOTE]
>
> **Status:** Maintained
>
> The repository is maintained and updated through pull requests and automated
> dependency updates. Planned work is listed in [ROADMAP.md](./ROADMAP.md).

## Getting Started

### Requirements

Docker with the Docker Compose plugin.

### Installation

Copy the directory of a stack, review the values in its environment files
(`.env` and `stack.env`), and start it:

```bash
git clone https://github.com/homelab-alpha/docker.git
cd docker/docker-compose-files/<stack>
docker compose up -d
```

> [!IMPORTANT]
>
> Change the passwords and secrets in the environment files before you start a
> stack.

## Development

Set up the dev tooling on any computer. It needs Node.js 24 (see `engines` in
`package.json`):

```bash
git clone https://github.com/homelab-alpha/docker.git
cd docker
npm ci
npm run lint
```

Linting has two parts. Every pull request runs `npm run lint` (Prettier,
textlint terminology, and merge conflict markers on the changed files), which
you can also run locally. `npm run lint:fix` repairs formatting and terminology
for you. Every push to `main` runs the full Super Linter, which you can run
locally with Docker:

```bash
docker run --rm -e RUN_LOCAL=true -e USE_FIND_ALGORITHM=true \
  -e VALIDATE_ALL_CODEBASE=true --env-file .github/super_linter.env \
  -v "$PWD":/tmp/lint ghcr.io/super-linter/super-linter:v9.0.0
```

For quick formatting of a single file, `npx prettier --write <file>` uses the
same `.prettierrc`.

## Project Structure

```treeview
docker/
├── .claude/                                    # Claude Code project settings
│   └── settings.json                           # Shared permissions for Claude Code
├── .github/                                    # GitHub-specific configuration and automation
│   ├── DISCUSSION_TEMPLATE/                    # GitHub Discussions templates
│   │   ├── announcements.yml                   # Template for announcements
│   │   ├── feature-request.yml                 # Template for feature requests
│   │   ├── feedback.yml                        # Template for feedback
│   │   ├── help-support.yml                    # Template for help and support
│   │   └── q-a.yml                             # Template for Q&A
│   ├── ISSUE_TEMPLATE/                         # GitHub issue templates
│   │   ├── bug_report.yml                      # Template for bug reports
│   │   ├── config.yml                          # Issue template configuration
│   │   ├── i18n_issue.yml                      # Template for translation & localization
│   │   └── security_report.yml                 # Template for security issues
│   ├── linters/                                # Configuration files for Super Linter
│   │   ├── .checkov.yaml                       # Infrastructure-as-code security rules
│   │   ├── .gitleaks.toml                      # Gitleaks secret scanning configuration
│   │   ├── .markdown-lint.yml                  # Markdown linting rules
│   │   ├── .powershell-psscriptanalyzer.psd1   # PowerShell static analysis rules
│   │   ├── .textlintrc                         # Text/grammar linting configuration
│   │   ├── .yaml-lint.yml                      # YAML linting rules
│   │   └── actionlint.yml                      # GitHub Actions workflow linting rules
│   ├── policies/                               # Internal policies and documentation
│   │   ├── github_actions.md                   # Workflow standards (ENG-CI-001)
│   │   ├── labels.md                           # Label color strategy and rules
│   │   ├── logs.md                             # Logging policies and practices
│   │   ├── review_process.md                   # Code review process
│   │   ├── security.md                         # Security policy
│   │   └── tests.md                            # Testing policy
│   ├── workflows/                              # GitHub Actions workflows
│   │   ├── badges.yml                          # Self-hosted README badges
│   │   ├── codeql.yml                          # CodeQL security analysis
│   │   ├── contributors.yml                    # Contributors list generator
│   │   ├── dependency_review.yml               # Dependency review
│   │   ├── housekeeping.yml                    # Cache and run cleanup
│   │   ├── issues.yml                          # Issue automation
│   │   ├── labels.yml                          # Label synchronization
│   │   ├── lint_pull_request.yml               # npm linting for pull requests
│   │   ├── merge_conflicts.yml                 # Merge conflict detection
│   │   ├── milestone_manager.yml               # Milestone automation
│   │   ├── pull_request.yml                    # Pull request automation
│   │   ├── release_manager.yml                 # Release automation
│   │   ├── signing_test.yml                    # Test API-based commit and tag signing
│   │   ├── stale_issues_and_pull_requests.yml  # Stale issue management
│   │   ├── super_linter.yml                    # Super Linter
│   │   └── unreproducible_issues.yml           # Unreproducible issue management
│   ├── CODEOWNERS                              # Code ownership definitions
│   ├── labels.yml                              # Repository label definitions
│   ├── pull_request_template.md                # Pull request template
│   ├── renovate.json                           # Renovate dependency automation
│   └── super_linter.env                        # Super Linter environment configuration
├── assets/                                     # Static project assets
│   └── branding/                               # Brand guide, logo, icons, and social preview
│       ├── brand_guide.md                      # Brand guide
│       ├── favicon.svg                         # Favicon
│       ├── icon_dark.svg                       # App icon (dark tile)
│       ├── icon_light.svg                      # App icon (light tile)
│       ├── logo_dark.svg                       # Logo (dark backgrounds)
│       ├── logo_light.svg                      # Logo (light backgrounds)
│       ├── logo_tagline_dark.svg               # Logo with slogan (dark)
│       ├── logo_tagline_light.svg              # Logo with slogan (light)
│       ├── mark_dark.svg                       # Mark (dark backgrounds)
│       ├── mark_light.svg                      # Mark (light backgrounds)
│       ├── social_preview.png                  # GitHub social preview (1280x640)
│       └── social_preview.svg                  # Source of the social preview
├── docker-compose-files/                       # 28 Docker Compose stacks
├── docker-network-configurations/              # Docker network setup guides
│   ├── bridge_network_setup.md                 # Create a bridge network
│   ├── ipvlan_network_setup.md                 # Create an ipvlan network
│   └── macvlan_network_setup.md                # Create a macvlan network
├── docs/                                       # Project documentation (API, usage, guides)
│   └── code_style_and_standards_guides.md      # Coding standards and style guidelines
├── image-template/                             # Template for a Node.js container image
│   ├── app.js                                  # Express web server
│   ├── docker-compose.yml                      # Compose file for the template
│   ├── Dockerfile                              # Image build instructions
│   ├── package.json                            # Node.js dependencies of the template
│   └── README.md                               # Usage of the template
├── scripts/                                    # Utility and automation shell scripts
│   ├── generate_badges.py                      # Renders the README badges as SVG files
│   ├── lint.sh                                 # Local lint (Prettier, textlint, conflict markers)
│   ├── setup_gpg.sh                            # Configures API or GPG signing for Git operations
│   └── verify_signatures.sh                    # Verifies commit and tag signatures
├── .editorconfig                               # Editor settings (indent, line endings)
├── .gitignore                                  # Git ignore rules
├── .gitleaksignore                             # Gitleaks secret scanning allowlist
├── .npmrc                                      # npm supply-chain hardening
├── .pre-commit-config.yaml                     # Local pre-commit hooks (mirrors CI)
├── .prettierignore                             # Files excluded from Prettier formatting
├── .prettierrc                                 # Prettier configuration file
├── AI_CONTRIBUTION_POLICY.md                   # Rules for contributions made with AI assistance
├── CHANGELOG.md                                # Project change history
├── CLAUDE.md                                   # Project rules for Claude Code
├── CODE_OF_CONDUCT.md                          # Contributor Covenant Code of Conduct
├── CONTRIBUTING.md                             # Contribution guidelines
├── CONTRIBUTORS.md                             # Auto-generated contributors list
├── GOVERNANCE.md                               # Project governance model
├── LICENSE                                     # Creative Commons BY-NC-SA 4.0 license
├── MAINTAINERS.md                              # Project maintainer list and process
├── NOTICE                                      # Attribution and license notice
├── package-lock.json                           # Locked versions of the dev tooling
├── package.json                                # Dev tooling (Prettier, textlint) and lint scripts
├── README.md                                   # Primary repository documentation
├── ROADMAP.md                                  # Planned features and milestones
├── SECURITY.md                                 # Security policy and reporting guidelines
├── SUPPORT.md                                  # Support channels and response times
└── TERMS_OF_SERVICE.md                         # Terms of service
```

## CI/CD and Automation

The repository includes a set of GitHub Actions workflows that run automatically
on push, pull request, and scheduled triggers.

### Workflows

| Workflow                             | Trigger                   | Purpose                                              |
| :----------------------------------- | :------------------------ | :--------------------------------------------------- |
| `badges.yml`                         | Push, workflow run, daily | Renders the README badges to the `badges` branch     |
| `codeql.yml`                         | Push, PR, schedule        | CodeQL static analysis for security vulnerabilities  |
| `contributors.yml`                   | Push to `main`            | Auto-generates `CONTRIBUTORS.md`                     |
| `dependency_review.yml`              | PR                        | Reviews dependency changes for known vulnerabilities |
| `housekeeping.yml`                   | Weekly schedule, manual   | Cleans up old workflow runs and Actions caches       |
| `issues.yml`                         | Issue events              | Automates issue labeling and triage                  |
| `labels.yml`                         | Push, manual              | Synchronizes repository labels from `labels.yml`     |
| `lint_pull_request.yml`              | PR, manual                | Runs `npm run lint` on the changed files             |
| `merge_conflicts.yml`                | Push, PR                  | Detects merge conflicts in open pull requests        |
| `milestone_manager.yml`              | Manual                    | Automates milestone creation and lifecycle           |
| `pull_request.yml`                   | PR events                 | Pull request automation and validation               |
| `release_manager.yml`                | Manual                    | Automates GitHub Releases                            |
| `signing_test.yml`                   | Manual                    | Tests API-based commit and tag signing               |
| `stale_issues_and_pull_requests.yml` | Schedule                  | Marks and closes stale issues and pull requests      |
| `super_linter.yml`                   | Push to `main`, manual    | Runs Super Linter across the codebase                |
| `unreproducible_issues.yml`          | Schedule                  | Manages issues that cannot be reproduced             |

All workflows follow the standards documented in
[`.github/policies/github_actions.md`](./.github/policies/github_actions.md),
including actions pinned to a commit SHA, concurrency controls, timeout limits,
bot filtering, and structured job summaries.

The README badges are not fetched from a third-party service. `badges.yml`
renders them with `scripts/generate_badges.py` (Python standard library only)
and publishes the SVG files to the `badges` branch, which the README links to
through `github.com/<owner>/<repo>/raw/badges/`. The Super Linter and CodeQL
badges show the latest run on the default branch and refresh when those
workflows finish (the `workflow_run` trigger lists their names, so update it
when you rename them). The workflow creates the branch on its first run. The
badges follow the colors in
[`assets/branding/brand_guide.md`](./assets/branding/brand_guide.md) and switch
to a dark variant with the system theme.

### Linting

Pull requests are linted with `npm run lint` (`scripts/lint.sh`), which uses
Prettier, textlint, and a merge conflict marker check with the configuration
files below. Pushes to `main` run
[Super Linter](https://github.com/super-linter/super-linter), configured through
`.github/super_linter.env`. The following linters are enabled: Checkov, ENV,
GitHub Actions (actionlint), Gitleaks, Git merge conflict markers, JSON
(Prettier), Markdown (Prettier), Natural Language (textlint), Pre-commit,
Renovate, and YAML (Prettier).

Linter-specific configuration files are stored in `.github/linters/` and include
rules for Checkov, Gitleaks, markdownlint, textlint, yamllint, actionlint, and
PowerShell.

### Dependency Management

Dependency updates are managed by [Renovate](https://github.com/apps/renovate).
The configuration in `.github/renovate.json` pins GitHub Actions to commit SHAs
and npm packages to exact versions, waits 7 days before it proposes a new
release, merges patch, pin, and digest updates automatically with squash, and
prioritizes security updates. Major and minor updates are never merged
automatically. Renovate also keeps a dependency dashboard issue.

## Policies and Standards

The repository includes internal policies that define how the project operates.
These are documented in `.github/policies/` and in root-level files:

| Document                                                                               | Purpose                                              |
| :------------------------------------------------------------------------------------- | :--------------------------------------------------- |
| [`.github/policies/github_actions.md`](./.github/policies/github_actions.md)           | Workflow structure, security, and logging standards  |
| [`.github/policies/labels.md`](./.github/policies/labels.md)                           | Label naming, color strategy, and usage rules        |
| [`.github/policies/logs.md`](./.github/policies/logs.md)                               | Logging conventions for workflows and scripts        |
| [`.github/policies/review_process.md`](./.github/policies/review_process.md)           | Code review stages, criteria, and merge strategy     |
| [`.github/policies/security.md`](./.github/policies/security.md)                       | Security scanning and vulnerability management       |
| [`.github/policies/tests.md`](./.github/policies/tests.md)                             | Testing standards, structure, and conventions        |
| [`docs/code_style_and_standards_guides.md`](./docs/code_style_and_standards_guides.md) | Coding style guidelines and Prettier configuration   |
| [`AI_CONTRIBUTION_POLICY.md`](./AI_CONTRIBUTION_POLICY.md)                             | Rules for contributions made with AI assistance      |
| [`GOVERNANCE.md`](./GOVERNANCE.md)                                                     | Project governance model and decision-making process |
| [`MAINTAINERS.md`](./MAINTAINERS.md)                                                   | Maintainer roles, responsibilities, and current list |
| [`TERMS_OF_SERVICE.md`](./TERMS_OF_SERVICE.md)                                         | Terms of use for the repository                      |

## Working with Claude

Project rules and conventions for Claude Code live in
[`CLAUDE.md`](./CLAUDE.md). The shared settings are in
[`.claude/settings.json`](./.claude/settings.json). The code style guide is in
[`docs/code_style_and_standards_guides.md`](./docs/code_style_and_standards_guides.md),
so a session on any computer follows the same rules.

## Known Issues

The maintainers strive to provide a seamless experience. Below are any known
bugs, limitations, or issues you might encounter. This section is updated
regularly.

### Currently Being Addressed

No known issues at this time.

If you discover a bug or experience an issue not listed here, please
[open an issue on GitHub](https://github.com/homelab-alpha/docker/issues/new/choose).

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](./CONTRIBUTING.md) for
contribution guidelines, branch naming conventions, commit message format, and
the review process. AI-assisted contributions follow
[AI_CONTRIBUTION_POLICY.md](./AI_CONTRIBUTION_POLICY.md).

## Support

For setup questions, troubleshooting, and general help, see
[SUPPORT.md](./SUPPORT.md).

## Security

To report a security vulnerability, please follow the process described in
[SECURITY.md](./SECURITY.md). Do **not** report security issues via public
GitHub issues or discussions.

## Roadmap

Planned features, milestones, and the long-term direction of the project are
documented in [ROADMAP.md](./ROADMAP.md).

## License

This project is licensed under the **Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International License** (CC BY-NC-SA
4.0). See the [LICENSE](./LICENSE) and [NOTICE](./NOTICE) files for the full
license text and attribution requirements.
