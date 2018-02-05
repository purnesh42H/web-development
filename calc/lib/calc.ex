defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Calc.hello
      :world

  """
  def separate_bracks(str) do
    str
    |> String.replace("(", "( ")
    |> String.replace(")", " )")
  end

  def parse(line) do
    line
    |> separate_bracks()
    |> String.split()
  end

  def eval(line) do
    line
    |> parse
    |> calculator()
  end

  def evaluate(op1, op2, "+") do
    op1 + op2
  end

  def evaluate(op1, op2, "-") do
    op1 - op2
  end

  def evaluate(op1, op2, "*") do
    op1 * op2
  end

  def evaluate(op1, op2, "/") do
    Integer.floor_div(op1,  op2)
  end

  def operate(op1, op2, operator) do
    evaluate(op1, op2, operator)
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len ==  0 and num_len == 1 and op_len == 1 do
      {op2, decimal} = Integer.parse(head_char)
      op1 = hd num_stack
      operate(op1, op2, (hd op_stack))
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len <  0 and num_len == 1 and op_len == 0 do
      (hd num_stack)
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len ==  0 do
    {op2, decimal} = Integer.parse(head_char)
    op1 = (hd (tl num_stack))
    res = operate(op1, op2, (hd op_stack))
    num_stack = (tl num_stack) ++ [res]
    calculate(expression_list, exp_len - 1,
      Enum.reverse(num_stack), num_len - 1, (tl op_stack), op_len - 1, expression_list)
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len < 0 do
    IO.inspect num_stack
    IO.inspect op_stack
    op2 = (hd num_stack)
    op1 = (hd (tl num_stack))
    res = operate(op1, op2, (hd op_stack))
    num_stack = (tl (tl num_stack)) ++ [res]
    calculate(expression_list, exp_len,
      Enum.reverse(num_stack), num_len - 1, (tl op_stack), op_len - 1, head_char)
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "+" or head_char == "-" or head_char == "*" or head_char == "/")  and op_len == 0 do
      calculate((tl expression_list), exp_len - 1,
      num_stack, num_len, Enum.reverse(op_stack ++ [head_char]), op_len + 1, (hd expression_list))
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "*" or head_char == "/") and ((hd op_stack) == "+" or (hd op_stack) == "-") do
      calculate((tl expression_list), exp_len - 1,
      num_stack, num_len, Enum.reverse(op_stack ++ [head_char]), op_len + 1, (hd expression_list))
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "+" or head_char == "-" or head_char == "*" or head_char == "/") do
      op2 = (hd num_stack)
      op1 = (hd (tl num_stack))
      res = operate(op1, op2, (hd op_stack))
      num_stack = (tl (tl num_stack)) ++ [res]
      op_stack = (tl op_stack) ++ [head_char]
      calculate((tl expression_list), exp_len - 1,
        Enum.reverse(num_stack), num_len - 1, Enum.reverse(op_stack), op_len, (hd expression_list))
  end

  def calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)  do
    {int, decimal} = Integer.parse(head_char)
    calculate((tl expression_list), exp_len - 1,
      Enum.reverse(num_stack ++ [int]), num_len + 1, op_stack, op_len, (hd expression_list))
  end

  def calculator(expression_list) do
    calculate((tl expression_list), length(expression_list) - 1,
    [], 0, [], 0, (hd expression_list))
  end

  def main() do
    case IO.gets("> ") do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      line ->
        IO.inspect eval(line)
        main()
    end
  end
end
