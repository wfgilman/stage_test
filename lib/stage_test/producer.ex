defmodule StageTest.Producer do

  alias Experimental.GenStage

  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(counter) do
    {:producer, counter}
  end

  def handle_demand(demand, state) when demand > 0 do
    events = Enum.to_list(state..state+demand-1)
    {:noreply, events, state+demand}
  end

end
