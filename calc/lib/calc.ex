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
  def get_precedence(char) when char == "+" or char == "-" do: 1
  def get_precedence(char) when char == "*" or char == "/" do: 2
  def get_precedence(char) when char == "(" or char == ")" do: 3

  def expression_list(char_list, new_list, symbol <> ")") do
    expression_list((tl char_list), n - 1, new_list ++ [symbol, ")"], (hd char_list))
  end

  def expression_list(char_list, new_list, "(" <> symbol) do
    expression_list((tl char_list), n - 1, new_list ++ ["(", symbol], (hd char_list))
  end

  def expression_list(char_list, n, new_list, symbol) do
    expression_list((tl char_list), n - 1, new_list ++ [symbol], (hd char_list))
  end

  def expression_list(char_list, n, new_list, symbol) do when n < 0
    new_list
  end

  def separate_bracks(char_list) do
    char_list
    |> expression_list(char_list, [])
  end

  def parse(line) do
    line
    |> String.split()
    |> separate_bracks()
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
