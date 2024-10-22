defmodule ApiTimeManagerWeb.Router do
  use ApiTimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["user"]
  end

  pipeline :require_admin do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["admin"]
  end

  pipeline :require_manager do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["admin", "manager"]
  end

  # Public routes
  scope "/api", ApiTimeManagerWeb do
    pipe_through :api

    post "/register", AuthController, :register
    post "/login", AuthController, :login
  end

  scope "/api", ApiTimeManagerWeb do
    pipe_through [:api, :authenticate]

    # resources "/users", UserController, except: [:new, :edit]
    get "/users/me", UserController, :get_current_user
    put "/users/me", UserController, :update_current_user

    # Working Time Routes
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    post "/workingtimes/:userID", WorkingtimeController, :create_for_user
    get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user

    # put "/workingtimes/:id", WorkingtimeController, :edit
    # Clock Routes
    get "/clocks", ClockController, :index
    get "/clocks/:userID", ClockController, :show_by_user
    post "/clocks/:userID", ClockController, :create_for_user

    # Route accessible uniquement aux admins
    scope "/admin" do
      pipe_through [:require_admin]

      # Manage users
      resources "/users", UserController, except: [:new, :edit]

      # Promote user
      # post "/promote/:userID", PromoteController, :promote_user

    end

    # Route accessible aux managers et admins
    scope "/manager" do
      pipe_through [:require_manager]
    end
  end


  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api_time_manager, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApiTimeManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end


# UPDATE users_roles
# SET user_id = 3, role_id = 3
# WHERE id = 2;
