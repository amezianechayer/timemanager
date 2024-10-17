defmodule ApiTimeManagerWeb.Router do
  use ApiTimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiTimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
<<<<<<< HEAD
<<<<<<< HEAD
    resources "/workingtimes", WorkingTimeController, except: [:new, :edit]
=======
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
      post "/workingtimes/:userID", WorkingtimeController, :create_for_user
      get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user
      put "/workingtimes/:id", WorkingtimeController, :edit
>>>>>>> ed97b3001893390fab2e6cb118e581f5cc07943c
=======
    post "/users/login", UserController, :sign_in
>>>>>>> docker

    # Working Time Routes
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    post "/workingtimes/:userID", WorkingtimeController, :create_for_user
    get "/workingtimes/:userID/:id", WorkingtimeController, :get_working_time_for_user
    put "/workingtimes/:id", WorkingtimeController, :edit
    # Clock Routes
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
