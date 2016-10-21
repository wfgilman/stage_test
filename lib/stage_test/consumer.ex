defmodule StageTest.Consumer do

  alias Experimental.GenStage

  use GenStage

  def start_link(count) do
    GenStage.start_link(__MODULE__, count)
  end

  def init(count) do
    stage_three =
      for id <- 1..count do
        :"Elixir.StageTest.StageThree#{id}"
      end
    {:consumer, [], subscribe_to: stage_three}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect {self(), "Consumed <- " <> event}
    end
    {:noreply, [], state}
  end

end
