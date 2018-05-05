defmodule LogApiWeb.UserView do
  use LogApiWeb, :view
  alias LogApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  # - modified to not return password
  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
#      password: user.password,
      is_active: user.is_active}
  end

  def render("sign_in.json",  %{user: user} ) do
      %{data:
          %{user:
            %{id: user.id,
              email: user.email}}}
  end

  def render("401.json",  %{message: message} ) do
      %{errors:
          %{detail: message}}

  end


end
