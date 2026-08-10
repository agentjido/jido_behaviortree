# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

No unreleased changes.

## [1.0.0] - 2026-02-27

### Added
- Initial implementation of Behavior Tree framework
- Core modules: Tree, Node, Tick, Blackboard, Status
- Agent for stateful execution
- Skill for AI integration
- Error handling with Splode
- Zoi-based struct definitions
- Coverage gate script (`mix coverage.check`) with critical-path thresholds
- Strategy, telemetry, tree, and node regression test suites
- Migration guide (`guides/migration.md`) for production semantics

### Changed
- Upgraded Jido stack to stable `2.0.0` releases (`jido`, `jido_action`, `jido_signal`)
- Raised minimum Elixir version to `~> 1.18`
- Raised coverage summary threshold from 80% to 85%
- Updated agent telemetry namespace to `[:jido, :bt, :agent, :tick, ...]`
- Included guides and `LICENSE.md` in package artifacts
- Tick sequence metadata now increments per tick in both agent and strategy execution paths

### Fixed
- `Skill.run/3` now propagates timeout/error results and returns `{:error, reason}` on tree failure
- Auto mode skill execution now polls for terminal status and exits early when complete
- `Agent` ticking now uses context-aware traversal so blackboard writes persist
- `SetBlackboard` now supports `tick_with_context/2` and correctly threads updated ticks
- `Action.tick_with_context/2` now returns error status tuples consistently with `tick/2`
- BehaviorTree strategy status normalization now guarantees snapshot-compatible atom statuses
- Hex package build now succeeds without dependency overrides

### Migration Notes
- `Skill.run/3` behavior changed: tree `:failure` is now an error result (`{:error, reason}`)
- Telemetry consumers should listen on `[:jido, :bt, ...]` namespaces
- See `guides/migration.md` for upgrade details

<!-- changelog -->

## [v1.0.1](https://github.com/agentjido/jido_behaviortree/compare/v1.0.0...v1.0.1) (2026-08-10)




### Bug Fixes:

* deps: update Mint for CVE-2026-59249 by mikehostetler

* remove unused logger require by mikehostetler