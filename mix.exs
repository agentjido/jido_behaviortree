defmodule Jido.BehaviorTree.MixProject do
  use Mix.Project

  @version "1.0.1"
  @source_url "https://github.com/agentjido/jido_behaviortree"
  @description "Behavior Tree implementation for Jido agents with integrated action support."

  def vsn do
    @version
  end

  def project do
    [
      app: :jido_behaviortree,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "Jido Behavior Tree",
      description: @description,
      source_url: @source_url,
      homepage_url: @source_url,
      package: package(),
      docs: docs(),

      # Coverage
      test_coverage: [
        tool: ExCoveralls,
        summary: [threshold: 85],
        export: "cov"
      ],

      # Dialyzer
      dialyzer: [
        plt_local_path: "priv/plts/project.plt",
        plt_core_path: "priv/plts/core.plt"
      ]
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.json": :test,
        "coveralls.github": :test,
        "coveralls.lcov": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test,
        "coverage.check": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Jido.BehaviorTree.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "bench"]
  defp elixirc_paths(_), do: ["lib"]

  defp docs do
    [
      main: "readme",
      api_reference: false,
      source_ref: "v#{@version}",
      source_url: @source_url,
      authors: ["Mike Hostetler <mike.hostetler@gmail.com>"],
      extras: [
        {"README.md", title: "Home"},
        {"CHANGELOG.md", title: "Changelog"},
        {"guides/getting-started.md", title: "Getting Started"},
        {"guides/nodes.md", title: "Node Reference"},
        {"guides/custom-nodes.md", title: "Creating Custom Nodes"},
        {"guides/migration.md", title: "Migration Guide"}
      ],
      extra_section: "Guides",
      groups_for_extras: [
        Guides: ~r/guides\/.*/
      ],
      formatters: ["html"],
      skip_undefined_reference_warnings_on: [
        "CHANGELOG.md",
        "LICENSE.md"
      ],
      groups_for_modules: [
        Core: [
          Jido.BehaviorTree,
          Jido.BehaviorTree.Status,
          Jido.BehaviorTree.Tick,
          Jido.BehaviorTree.Blackboard,
          Jido.BehaviorTree.Node,
          Jido.BehaviorTree.Tree,
          Jido.BehaviorTree.Error
        ],
        "Composite Nodes": [
          Jido.BehaviorTree.Nodes.Sequence,
          Jido.BehaviorTree.Nodes.Selector
        ],
        "Decorator Nodes": [
          Jido.BehaviorTree.Nodes.Inverter,
          Jido.BehaviorTree.Nodes.Succeeder,
          Jido.BehaviorTree.Nodes.Failer,
          Jido.BehaviorTree.Nodes.Repeat
        ],
        "Leaf Nodes": [
          Jido.BehaviorTree.Nodes.Action,
          Jido.BehaviorTree.Nodes.Wait,
          Jido.BehaviorTree.Nodes.SetBlackboard
        ],
        Execution: [
          Jido.BehaviorTree.Agent,
          Jido.BehaviorTree.Skill
        ]
      ]
    ]
  end

  defp package do
    [
      files: ["lib", "guides", "mix.exs", "README.md", "CHANGELOG.md", "usage-rules.md", "LICENSE.md"],
      maintainers: ["Mike Hostetler"],
      licenses: ["Apache-2.0"],
      links: %{
        "Changelog" => "https://hexdocs.pm/jido_behaviortree/changelog.html",
        "Discord" => "https://agentjido.xyz/discord",
        "Documentation" => "https://hexdocs.pm/jido_behaviortree",
        "GitHub" => @source_url,
        "Website" => "https://agentjido.xyz"
      }
    ]
  end

  defp deps do
    [
      # Core dependencies
      {:jido, "~> 2.3"},
      {:telemetry, "~> 1.3"},
      {:jason, "~> 1.4"},

      # Development & Test Dependencies
      {:credo, "~> 1.7.16", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:doctor, "~> 0.21", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40.1", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18.3", only: [:dev, :test]},

      # Zoi and Splode
      {:zoi, "~> 0.18"},
      {:splode, "~> 0.3"},

      # Git tooling
      {:git_hooks, "~> 0.8", only: [:dev, :test], runtime: false},
      {:git_ops, "~> 2.10.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      test: "test --exclude flaky",
      "coverage.check": ["coveralls.json", "run scripts/coverage_gate.exs"],
      docs: "docs -f html",
      q: ["quality"],
      quality: [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "dialyzer",
        "credo --strict",
        "doctor",
        "deps.audit --format brief"
      ]
    ]
  end
end
