defmodule LogApiWeb.EventView do
  use LogApiWeb, :view
  alias LogApiWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      ship_dte: event.ship_dte,
      pkgname: event.pkgname,
      eventlog: event.eventlog}
  end
end
