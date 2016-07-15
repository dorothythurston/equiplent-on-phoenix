defmodule Equiplent.Router do
  use Equiplent.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :require_authentication do
    if Mix.env == :test do
      plug Equiplent.Plug.SessionBackdoor
    end

    plug Equiplent.Plug.Authenticate
  end

  scope "/", Equiplent do
    pipe_through :browser # Use the default browser stack

    get "/signup", UserController, :new
    resources "/users", UserController, only: [:create]
    get "/login", SessionController, :new
    resources "/sessions", SessionController, only: [:create, :delete]
  end

  scope "/", Equiplent do
    pipe_through [:browser, :require_authentication]

    get "/", DashboardController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Equiplent do
  #   pipe_through :api
  # end
end
