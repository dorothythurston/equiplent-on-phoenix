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

  scope "/", Equiplent do
    pipe_through :browser # Use the default browser stack

    get "/", DashboardController, :show
    get "/signup", UserController, :new
    resources "/users", UserController, only: [:create]
    get "/login", SessionController, :new
    resources "/sessions", SessionController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Equiplent do
  #   pipe_through :api
  # end
end
