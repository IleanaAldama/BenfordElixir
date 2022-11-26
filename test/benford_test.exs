defmodule BenfordTest do
  use ExUnit.Case
  doctest Benford

  test "greets the world" do
    assert Benford.hello() == :world
  end
end
