defmodule InvestorList.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      InvestorListWeb.Telemetry,
      # Start the Ecto repository
      InvestorList.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InvestorList.PubSub},
      # Start Finch
      {Finch, name: InvestorList.Finch},
      # Start the Endpoint (http/https)
      InvestorListWeb.Endpoint
      # Start a worker by calling: InvestorList.Worker.start_link(arg)
      # {InvestorList.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InvestorList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InvestorListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
