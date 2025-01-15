defmodule CalcRelTest do
  use ExUnit.Case
  use CalcRel.DataCase
  doctest CalcRel

  test "greets the world" do
    assert CalcRel.hello() == :world
  end
end
