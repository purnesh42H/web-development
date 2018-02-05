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

  test "test expr 5 + 6 * 5 / 5 + 5" do
    assert Calc.eval("5 + 6 * 5 / 5 + 5") == 16
  end

  test "test expr 2 - 4 / 5 - 8" do
    assert Calc.eval("2 - 4 / 5 - 8") == -6
  end

  test "test expr 5 + 6 * 5 / 5 - 35" do
    assert Calc.eval("5 + 6 * 5 / 5 - 35") == -24
  end

  test "test expr 24 / 6 + (5 - 4)" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
  end

  test "test expr 2 + (2 + (3 * 4))" do
    assert Calc.eval("2 + (2 + (3 * 4))") == 16
  end

  test "test expr (2 + (2 + (3 * 4))" do
    assert Calc.eval("(2 + (2 + (3 * 4))") == 16
  end

  test "test expr 2 * (3 + 5)" do
    assert Calc.eval("2 * (3 + 5)") == 16
  end

  test "test expr 2 / ((3 + 5) + 4)" do
    assert Calc.eval("2 / ((3 + 5) + 4)") == 0
  end

  test "test expr 2 - ((3 + 5) + 4)" do
    assert Calc.eval("2 - ((3 + 5) + 4)") == -10
  end

  test "test expr 2 - (32 * (3 + (-8 + 6)))" do
    assert Calc.eval("2 - (32 * (3 + (-8 + 6)))") == -30
  end

  test "test expr (2 + 3)" do
    assert Calc.eval("(2 + 3)") == 5
  end

  test "test operate  2, 3, +" do
    assert Calc.operate(2, 3, "+") == 5
  end

  test "test operate  2, 3, *" do
    assert Calc.operate(2, 3, "*") == 6
  end

  test "test operate  2, 3, -" do
    assert Calc.operate(2, 3, "-") == -1
  end

  test "test operate  2, 3, /" do
    assert Calc.operate(2, 3, "/") == 0
  end
end
