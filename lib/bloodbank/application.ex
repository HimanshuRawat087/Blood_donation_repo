defmodule Bloodbank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BloodbankWeb.Telemetry,
      # Start the Ecto repository
      Bloodbank.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bloodbank.PubSub},
      # Start Finch
      {Finch, name: Bloodbank.Finch},
      # Start the Endpoint (http/https)
      BloodbankWeb.Endpoint
      # Start a worker by calling: Bloodbank.Worker.start_link(arg)
      # {Bloodbank.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bloodbank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BloodbankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
