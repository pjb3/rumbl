defmodule RumblWeb.Router do
  use RumblWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RumblWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug RumblWeb.RequireAuth
  end

  # Unauthenticated Pages
  scope "/", RumblWeb do
    pipe_through :browser
    resources "/users", UserController, only: [:new, :create]

    get  "/log_in", SessionController, :new
    post "/log_in", SessionController, :create
    post "/log_out", SessionController, :delete

    get "/", PageController, :index
  end

  # Authenticated Pages
  scope "/", RumblWeb do
    pipe_through [:browser, :auth]

    resources "/users", UserController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", RumblWeb do
  #   pipe_through :api
  # end
end
