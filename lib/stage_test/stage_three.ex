defmodule StageTest.StageThree do

  alias Experimental.GenStage

  use GenStage

  def start_link({id, count}) do
    name = :"#{__MODULE__}#{id}"
    GenStage.start_link(__MODULE__, count, name: name)
  end

  def init(count) do
    stage_two =
      for id <- 1..count do
        :"Elixir.StageTest.StageTwo#{id}"
      end
    {:producer_consumer, [], subscribe_to: stage_two}
  end

  def handle_events(events, _from, state) do
    events =
      for event <- events do
        "Stage Three <- " <> event
      end
    {:noreply, events, state}
  end

end
