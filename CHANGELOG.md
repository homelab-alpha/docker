# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add a brand guide and branding files in `.github/branding/` (logo, icons,
  favicon, and social preview), and show the logo at the top of `README.md`
- Add the `badges.yml` workflow and `.github/scripts/generate_badges.py` to render the
  README badges, including Super Linter and CodeQL, as SVG files on the `badges`
  branch

### Changed

- Move the repository tooling (`lint.sh`, `generate_badges.py`, `setup_gpg.sh`,
  and `verify_signatures.sh`) from `scripts/` to `.github/scripts/`, the
  branding from `assets/branding/` to `.github/branding/`, and the code style
  guide from `docs/` to `.github/docs/`
- Add a 20 px protective border to the logo SVGs and show the logo in
  `README.md` at a fixed height of 100 px
- Update the badges only after Lint Repository and CodeQL ran and passed for the
  same commit: remove the `push` trigger from `badges.yml` and add the
  `check-workflows` job
- Replace the `img.shields.io` badges in `README.md` with the self-hosted
  badges
- Enable Bash and Bash Exec validation in `.github/super_linter.env`
- Explain in `codeql.yml` when to add a language
- Ignore `notes.md`, `super_linter.log`, and Python cache files in `.gitignore`
- Replace the deprecated `deny-licenses` option in `dependency_review.yml` with
  an `allow-licenses` list of permissive licenses and CC BY-NC-SA 4.0, so GPL
  and LGPL stay blocked
- Check development dependencies too in `dependency_review.yml`, by setting
  `fail-on-scopes` to `runtime, development`
- chore: adopt the blueprint template as the repository standard [4f3a610](https://github.com/homelab-alpha/docker/commit/4f3a610b56d7e50d290cf3f78f558701773c9dc6) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(deps): comment on the pull request only when the dependency review fails [7ae8f07](https://github.com/homelab-alpha/docker/commit/7ae8f0746776ab367f2e3c18246dcc0e8628f1ad) by [@homelab-alpha](https://github.com/homelab-alpha)
- docs: add CLAUDE.md with the project rules for Claude Code [2405014](https://github.com/homelab-alpha/docker/commit/2405014ea4e80250ca998a380ab5177fdb4808bd) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(repo): adopt the current blueprint standard [1274b03](https://github.com/homelab-alpha/docker/commit/1274b0387a996d02c774c1245aee9c056544a44c) by [@homelab-alpha](https://github.com/homelab-alpha)
- style(compose): format the Compose files [8daa53a](https://github.com/homelab-alpha/docker/commit/8daa53ab3a8f223f0aff9287a903581c41af5700) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(repo): sync the latest blueprint updates [59f3d67](https://github.com/homelab-alpha/docker/commit/59f3d67895d0a8de26fd720f814b5aa15d03f273) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(workflows): replace deny-licenses with allow-licenses [dd12b26](https://github.com/homelab-alpha/docker/commit/dd12b269a053053b913fea9cbdc7d45d7849dfd7) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(blueprint): sync with the blueprint [9e442c9](https://github.com/homelab-alpha/docker/commit/9e442c985bc059c511936dd199bed4ba65591672) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(renovate): pin docker image digests [918591b](https://github.com/homelab-alpha/docker/commit/918591bc39b9e716674b02bcd2f14692b6e60cfb) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(plex): update pms-docker to 1.43.5.11079 [35004ff](https://github.com/homelab-alpha/docker/commit/35004ff73ee5af8da7a14980bcf22d904ddeaaa4) by [@homelab-alpha](https://github.com/homelab-alpha)
- ci(workflows): request a reviewer on bot PRs [b3d6d04](https://github.com/homelab-alpha/docker/commit/b3d6d0454f2389340979da1dced62c0814f3b00b) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(github): sync Hugo and Dart Sass rules [ffa8ef9](https://github.com/homelab-alpha/docker/commit/ffa8ef91ac71ed84da27ebc803bef43759f99f1b) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(image-template): update node to 24.22.2 [dbecbcc](https://github.com/homelab-alpha/docker/commit/dbecbcc09427044f831d9821b35c71dd2d5d44ba) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(github): sync runners, Renovate, and linters [3946992](https://github.com/homelab-alpha/docker/commit/3946992e8e0d332f5ff1de80eeb60991c6e62b56) by [@homelab-alpha](https://github.com/homelab-alpha)
- ci(workflows): run workflows for bots [ed9b2d3](https://github.com/homelab-alpha/docker/commit/ed9b2d39dd94ba3137a761fcefcb495b7873f76c) by [@homelab-alpha](https://github.com/homelab-alpha)
- ci(workflows): allow BlueOak-1.0.0 license [03d2927](https://github.com/homelab-alpha/docker/commit/03d292778fab415edadd8239cf60a535f43b03dc) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(labels): add dependency update labels [4ba535c](https://github.com/homelab-alpha/docker/commit/4ba535c9c521796a9a0f627db095e3e10d3990db) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(renovate): remove default assignees [ce35f66](https://github.com/homelab-alpha/docker/commit/ce35f665d42efa713a7ffe6b66b6560f57510a91) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(renovate): group and automerge updates [4270a95](https://github.com/homelab-alpha/docker/commit/4270a95abbb4848bb8dc7eb067826a9a988d9631) by [@homelab-alpha](https://github.com/homelab-alpha)
- chore(sync): sync shared files with blueprint [5b006d3](https://github.com/homelab-alpha/docker/commit/5b006d3f15d13fe9e30b1321d7ba6bfcfa8aa729) by [@homelab-alpha](https://github.com/homelab-alpha)

### Deprecated

### Removed

### Fixed

- Fix the link to the documentation site in `README.md`, which pointed to
  `homelab-alpha.nl/docs/docker/` instead of `homelab-alpha.nl/docker/`
- Fix the GitHub link in `NOTICE`, which pointed to `github.com/docker`
  instead of `github.com/homelab-alpha`
- Fix the table of contents link of `CONTRIBUTING.md` to its first heading
- fix(renovate): fix invalid automergeType and vulnerability rule [44f2cf0](https://github.com/homelab-alpha/docker/commit/44f2cf0a5cce39cc8cb932a2786f090062909fa4) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(compose): fix network conflicts, typos, and outdated images [b1e5d33](https://github.com/homelab-alpha/docker/commit/b1e5d33f043141e2bc59477e60169de0dd05bd06) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(labels): skip unchanged labels and retry failed writes [6210d1d](https://github.com/homelab-alpha/docker/commit/6210d1d4f482e359f470e81a69d27b805401d32a) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(docs): fix the TOC link to the first heading [c8ab5ef](https://github.com/homelab-alpha/docker/commit/c8ab5efd516cab6d9000d99e4b2a1ded79147474) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(docs): fix the documentation site link [5987245](https://github.com/homelab-alpha/docker/commit/5987245cd940e00c91aa152a478a4b85256dbbc0) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(changelog): remove the date from Unreleased [12c130a](https://github.com/homelab-alpha/docker/commit/12c130affffcfdadf0da78352e5bb98a4831a964) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(scripts): restore pull_request_body.py logic [fcf5256](https://github.com/homelab-alpha/docker/commit/fcf52568b802acce61b3b755b2b82b39e9578275) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(changelog): remove the Unreleased link [06661e0](https://github.com/homelab-alpha/docker/commit/06661e030840fe5403923878145d62ba58f6f389) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(image-template): use node 24 base image [2c570c1](https://github.com/homelab-alpha/docker/commit/2c570c191d1bf845c4499bfeaaeea2a3981a1eee) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(workflow): do not draft Renovate PRs [b51be2a](https://github.com/homelab-alpha/docker/commit/b51be2a7bacadcff00ba674bacab75ebaf33df06) by [@homelab-alpha](https://github.com/homelab-alpha)
- fix(ci): harden the CodeQL workflow [e404c9b](https://github.com/homelab-alpha/docker/commit/e404c9bb0ff522909e85fe0fcc62e5b84b3c94b0) by [@homelab-alpha](https://github.com/homelab-alpha)

### Security

- Override the transitive dev dependencies `glob` (14.0.3) and `minimatch`
  (11.0.3) to fix Dependabot alerts, which textlint pulls in
