defmodule Cloudinary.MixProject do
  use Mix.Project

  def project do
    [
      app: :cloudinary,
      version: "0.0.1",
      elixir: "~> 1.10",
      # start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/h-ikeda/cloudinary-elixir",
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:castore, "~> 0.1.0"},
      {:mint, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      before_closing_head_tag: fn :html ->
        "<script data-ad-client=\"ca-pub-3600741293730423\" async src=\"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js\"></script>"
      end
    ]
  end

  defp package do
    [
      name: "cloudinary_sdk",
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/h-ikeda/cloudinary-elixir"
      }
    ]
  end
end
