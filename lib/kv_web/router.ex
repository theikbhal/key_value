defmodule KvWeb.Router do
  use KvWeb, :router

  # Add this pipeline with the other pipelines
  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  # Add this scope with the other scopes
  scope "/", KvWeb do
    pipe_through(:browser)
    get("/", PageController, :index)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", KvWeb do
    pipe_through(:api)

    get("/keys", KeyValueController, :index)
    get("/keys/:key", KeyValueController, :show)
    post("/keys", KeyValueController, :create)
    put("/keys/:key", KeyValueController, :update)
    delete("/keys/:key", KeyValueController, :delete)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:kv, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: KvWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
