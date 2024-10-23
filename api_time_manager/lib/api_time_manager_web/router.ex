defmodule ApiTimeManagerWeb.Router do
  use ApiTimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["user", "manager", "admin"]
  end

  pipeline :require_manager do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["manager", "admin"]
  end

  pipeline :require_admin do
    plug ApiTimeManagerWeb.Plugs.AuthPlug, ["admin"]
  end

    # Public routes
  scope "/api", ApiTimeManagerWeb do
    pipe_through :api

    post "/register", AuthController, :register
    post "/login", AuthController, :login
  end

  scope "/api", ApiTimeManagerWeb do
    pipe_through [:api, :authenticate]

    # User Routes
    get "/users/me", UserController, :get_current_user
    put "/users/me", UserController, :update_current_user
    delete "/users/me", UserController, :delete_current_user

    # Clock Routes
    post "/clocks", ClockController, :create_for_authenticated_user
    get "/clocks", ClockController, :show_for_authenticated_user

    # Working Time Routes
    get "/workingtimes", WorkingtimeController, :user_get_working_times
    post "/workingtimes", WorkingtimeController, :create_for_authenticated_user
    put "/workingtimes/:id", WorkingtimeController, :update_for_authenticated_user



    # Accessible route only from admins users
    scope "/admin" do
      pipe_through [:require_admin]

      # Manage users
      get "/users", UserController, :fetch_users
      resources "/users", UserController, except: [:new, :edit]

      # Manage clocks
      post "/clocks/:userID", ClockController, :create_for_user
      get "/clocks", ClockController, :index
      get "/clocks/:userID", ClockController, :show_by_user

      # Manage workingtimes
      resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
      post "/workingtimes/:userID", WorkingtimeController, :create_for_user
      get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user
      get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user

      # Promote user
      post "/promote/:userID", PromoteController, :promote_user_to_manager
      post "/demote/:userID", PromoteController, :demote_manager_to_user
    end

    # Accessible route only from managers and admins
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
