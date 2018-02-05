defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.

  ## Examples

  """
  defp separate_bracks(str) do
    str
    |> String.replace("(", "( ")
    |> String.replace(")", " )")
  end

  defp parse(line) do
    line
    |> separate_bracks()
    |> String.split()
  end

  def eval(line) do
    line
    |> parse
    |> calculator()
  end

  defp evaluate(op1, op2, "+") do
    op1 + op2
  end

  defp evaluate(op1, op2, "-") do
    op1 - op2
  end

  defp evaluate(op1, op2, "*") do
    op1 * op2
  end

  defp evaluate(op1, op2, "/") do
    div(op1,  op2)
  end

  def operate(op1, op2, operator) do
    evaluate(op1, op2, operator)
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len ==  0 and num_len == 1 and op_len == 1 do
    last_op = List.last(op_stack)
    if last_op == "(" do
      {paran, op_stack} = List.pop_at(op_stack, -1)
      calculate(expression_list, exp_len,
      num_stack, num_len, op_stack, op_len - 1, head_char)
    else
      {op2, decimal} = Integer.parse(head_char)
      op1 = hd num_stack
      operate(op1, op2, (hd op_stack))
    end
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len <=  0 and num_len == 1 and op_len == 0 do
      (hd num_stack)
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when exp_len <= 0 do
    last_op = List.last(op_stack)
    if last_op == "(" do
      {paran, op_stack} = List.pop_at(op_stack, -1)
      calculate(expression_list, exp_len,
      num_stack, num_len, op_stack, op_len - 1, head_char)
    else
      {op2, num_stack} = List.pop_at(num_stack, -1)
      {op1, num_stack} = List.pop_at(num_stack, -1)
      {operator, op_stack} = List.pop_at(op_stack, -1)
      res = operate(op1, op2, operator)
      num_stack = num_stack ++ [res]
      calculate(expression_list, exp_len,
      num_stack, num_len - 1, op_stack, op_len - 1, head_char)
    end
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when head_char == ")" do
      last_op = List.last(op_stack)
      IO.inspect num_stack
      IO.inspect op_stack
      if last_op == "(" do
        {paran, op_stack} = List.pop_at(op_stack, -1)
        calculate((tl expression_list), exp_len - 1,
          num_stack, num_len, op_stack, op_len - 1, (hd expression_list))
      else
        {op2, num_stack} = List.pop_at(num_stack, -1)
        {op1, num_stack} = List.pop_at(num_stack, -1)
        {operator, op_stack} = List.pop_at(op_stack, -1)
        res = operate(op1, op2, operator)
        num_stack = num_stack ++ [res]
        calculate(expression_list, exp_len,
        num_stack, num_len - 1, op_stack, op_len - 1, head_char)
      end
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "(") do
      calculate((tl expression_list), exp_len - 1,
      num_stack, num_len, op_stack ++ [head_char], op_len + 1, (hd expression_list))
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "+" or head_char == "-" or head_char == "*" or head_char == "/")  and op_len == 0 do
      calculate((tl expression_list), exp_len - 1,
      num_stack, num_len, op_stack ++ [head_char], op_len + 1, (hd expression_list))
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)
    when (head_char == "+" or head_char == "-" or head_char == "*" or head_char == "/") do
      last_op = List.last(op_stack)
      if last_op == "(" or ((head_char == "*" or head_char == "/") and (last_op == "+" or last_op == "-"))  do
      	calculate((tl expression_list), exp_len - 1,
          num_stack, num_len, op_stack ++ [head_char], op_len + 1, (hd expression_list))
      else
        {op2, num_stack} = List.pop_at(num_stack, -1)
        {op1, num_stack} = List.pop_at(num_stack, -1)
        {operator, op_stack} = List.pop_at(op_stack, -1)
        res = operate(op1, op2, operator)
        num_stack = num_stack ++ [res]
        calculate(expression_list, exp_len,
        num_stack, num_len - 1, op_stack, op_len - 1, head_char)
      end
  end

  defp calculate(expression_list, exp_len, num_stack, num_len, op_stack, op_len, head_char)  do
    {int, decimal} = Integer.parse(head_char)
    calculate((tl expression_list), exp_len - 1,
      num_stack ++ [int], num_len + 1, op_stack, op_len, (hd expression_list))
  end

  defp calculator(expression_list) do
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
