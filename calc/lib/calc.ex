defmodule Calc do
  defstruct op_stack: []
  defstruct num_stack: []

  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Calc.hello
      :world

  """

  def parse(line) do
    line
    |> String.split()
    |> String.to_charlist
  end

  def eval(line) do
    line
    |> parse
    |> create_stacks()
  end

  def create_stacks(char_list) do
    n = length(char_list)
    char_list
    |> stack_push(n, [], [])
  end

  def stack_push(char_list, n, op_stack, num_stack) when n == 0
    {op_stack, num_stack}
  end

  def stack_push(char_list, n, op_stack, num_stack) when char == '*' or char == '-' or char == '+' or char == '/' do
    op_stack ++ [hd char_list]
    stack_push(tl char_list, n - 1, op_stack, num_stack)
  end

  def stack_push(char_list, n, op_stack, num_stack) do
    num_stack ++ [hd char_list]
    stack_push(tl char_list, n - 1, op_stack, num_stack)
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
