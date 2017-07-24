defmodule ExStyledoc.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_styledoc,
     version: "0.1.0",
     elixir: "~> 1.4",
     description: "Living style guide generation for your Elixir projects",
     build_embedded: Mix.env == :dev,
     start_permanent: Mix.env == :dev,
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    []
  end

  defp package do
   [
      maintainers: ["Matthijs Kuiper", "Marcel Horlings"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/DefactoSoftware/ex_styledoc",
        "Docs" => "http://hexdocs.pm/ex_styledoc/"
      }
    ]
  end
end
