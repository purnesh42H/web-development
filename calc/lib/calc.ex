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

  def parse(line) do
    line
    |> String.split()
  end

  def eval(line) do
    line
    |> parse
    |> create_stacks()
  end

  def create_stacks(char_list) do
    stack_push((tl char_list), length(char_list) - 1, [], [], (hd char_list))
  end

  def stack_push(char_list, n, op_stack, num_stack, char) when n == 0 do
    {op_stack, num_stack ++ [char]}
  end

  def stack_push(char_list, n, op_stack, num_stack, char) when char == "*" or char == "-" or char == "+" or char == "/" do
    stack_push((tl char_list), n - 1, op_stack ++ [char], num_stack, (hd char_list))
  end

  def stack_push(char_list, n, op_stack, num_stack, char) do
    stack_push((tl char_list), n - 1, op_stack, num_stack ++ [char], (hd char_list))
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