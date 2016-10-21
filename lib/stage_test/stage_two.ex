defmodule StageTest.StageTwo do

  alias Experimental.GenStage

  use GenStage

  def start_link(id) do
    name = :"#{__MODULE__}#{id}"
    GenStage.start_link(__MODULE__, 0, name: name)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [StageTest.Producer]}
  end

  def handle_events(events, _from, state) do
    events =
      for event <- events do
        "Stage Two <-" <> Integer.to_string(event)
      end
    {:noreply, events, state}
  end

end
