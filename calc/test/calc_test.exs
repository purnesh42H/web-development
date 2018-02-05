defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "test expr 2  + 3" do
    assert Calc.eval("2 + 3") == 5
  end

  test "test expr 2  + 3 + 5 + 2" do
    assert Calc.eval("2 + 3 + 5 + 2") == 12
  end

  test "test expr 2 - 3" do
    assert Calc.eval("2 - 3") == -1
  end
 
  test "test expr 2 + 3 - 5 - 2" do
    assert Calc.eval("2 + 3 - 5 - 2") == -2
  end

  test "test expr 2 + 3 * 5 - 2" do
    assert Calc.eval("2 + 3 * 5 - 2") == 15
  end

  test "test expr 2 / 3 * 5 - 2" do
    assert Calc.eval("2 / 3 * 5 - 2") == -2
  end

  test "test operate  2, 3, +" do
    assert Calc.operate(2, 3, "+") == 5
  end
end
