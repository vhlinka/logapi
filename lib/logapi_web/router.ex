defmodule LogApiWeb.Router do
  use LogApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

#
# -- modified to use simple authenication and session to lock down resources
#
  pipeline :api_auth do
    plug :ensure_authenticated
  end

# --- only allow sing_in to go through the open api
  scope "/api", LogApiWeb do
    pipe_through :api

    post "/users/sign_in", UserController, :sign_in
  end

# --- everything else need to be authenticated
  scope "/api", LogApiWeb do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/events", EventController, except: [:new, :edit]

# --- new method
    defp ensure_authenticated(conn, _opts) do
      current_user_id = get_session(conn, :current_user_id)

      if current_user_id do
        conn
      else
        conn
        |> put_status(:unauthorized)
        |> render(LogApiWeb.ErrorView, "401.json", message: "Unauthenticated User")
        |> halt()
      end
    end

  end
end
