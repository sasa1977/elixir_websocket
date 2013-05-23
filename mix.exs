defmodule ElixirWebsocket.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_websocket, version: "0.0.1", deps: deps]
  end

  def application do
    [
      mod: {ElixirWebsocket, []},
      applications: [:mimetypes, :ranch, :cowboy]
    ]
  end

  defp deps do
    [
      {:ranch, github: "extend/ranch"},
      {:cowboy, github: "extend/cowboy"},
      {:mimetypes, github: "spawngrid/mimetypes"}
    ]
  end
end
