defmodule LogApi.ShipmentTest do
  use LogApi.DataCase

  alias LogApi.Shipment

  describe "events" do
    alias LogApi.Shipment.Event

    @valid_attrs %{eventlog: "some eventlog", pkgname: "some pkgname", ship_dte: ~D[2010-04-17]}
    @update_attrs %{eventlog: "some updated eventlog", pkgname: "some updated pkgname", ship_dte: ~D[2011-05-18]}
    @invalid_attrs %{eventlog: nil, pkgname: nil, ship_dte: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shipment.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Shipment.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Shipment.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Shipment.create_event(@valid_attrs)
      assert event.eventlog == "some eventlog"
      assert event.pkgname == "some pkgname"
      assert event.ship_dte == ~D[2010-04-17]
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shipment.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Shipment.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.eventlog == "some updated eventlog"
      assert event.pkgname == "some updated pkgname"
      assert event.ship_dte == ~D[2011-05-18]
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Shipment.update_event(event, @invalid_attrs)
      assert event == Shipment.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Shipment.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Shipment.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Shipment.change_event(event)
    end
  end
end
