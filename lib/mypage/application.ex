defmodule Mypage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MypageWeb.Telemetry,
      Mypage.Repo,
      {DNSCluster, query: Application.get_env(:mypage, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mypage.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Mypage.Finch},
      # Start a worker by calling: Mypage.Worker.start_link(arg)
      # {Mypage.Worker, arg},
      # Start to serve requests, typically the last entry
      MypageWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mypage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MypageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
