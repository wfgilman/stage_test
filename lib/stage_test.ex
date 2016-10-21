defmodule StageTest do
  use Application

  @max_stage_two 3
  @max_stage_three 3
  @max_consumer 30

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    producer = [
      worker(StageTest.Producer, [])
    ]

    stage_two =
      for id <- 1..@max_stage_two do
        worker(StageTest.StageTwo, [id], id: id)
      end

    stage_three =
      for id <- 1..@max_stage_three do
        worker(StageTest.StageThree, [{id, @max_stage_two}], id: id+@max_stage_two)
      end

    consumers =
      for id <- 1..@max_consumer do
        worker(StageTest.Consumer, [@max_stage_three], id: id+@max_stage_two+@max_stage_three)
      end

    opts = [strategy: :one_for_one, name: StageTest.Supervisor]
    Supervisor.start_link(producer ++ stage_two ++ stage_three ++ consumers, opts)
  end
end
