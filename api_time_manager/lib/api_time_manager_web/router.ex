defmodule ApiTimeManagerWeb.Router do
  use ApiTimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiTimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/:id", UserController, :show
    post "/users/login", UserController, :sign_in
    get "/users/team/:team_id", UserController, :index_by_team

    # Compagnies Routes
    resources "/compagnies", CompagnyController, except: [:new, :edit]


    # Teams Routes
    resources "/teams", TeamController, except: [:new, :edit]
    get "/teams/:company_id", TeamController, :get_teams_by_company
    post "/teams/:team_id/users/:user_id", UserController, :assign_user_to_team

    # Working Time Routes
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    post "/workingtimes/:userID", WorkingtimeController, :create_for_user
    get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user
    put "/workingtimes/:id", WorkingtimeController, :edit
    # Clock Routes
    get "/clocks", ClockController, :index
    get "/clocks/:userID", ClockController, :show_by_user
    post "/clocks/:userID", ClockController, :create_for_user
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