defmodule Poller.PollSupervisor do
  use DynamicSupervisor
  alias Poller.PollServer

  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def start_poll(district_id) do
    child_spec = {PollServer, district_id}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  # Callbacks
  def init(_opts), do: DynamicSupervisor.init(strategy: :one_for_one)
end
