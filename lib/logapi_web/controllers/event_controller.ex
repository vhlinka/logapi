defmodule LogApiWeb.EventController do
  use LogApiWeb, :controller

  alias LogApi.Shipment
  alias LogApi.Shipment.Event

  action_fallback LogApiWeb.FallbackController

  def index(conn, _params) do
    events = Shipment.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Shipment.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Shipment.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Shipment.get_event!(id)

    with {:ok, %Event{} = event} <- Shipment.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Shipment.get_event!(id)
    with {:ok, %Event{}} <- Shipment.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
