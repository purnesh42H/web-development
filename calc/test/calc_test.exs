defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "2 + 3" do
    assert Calc.eval() == 5
  end
end
