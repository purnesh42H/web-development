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
  def get_precedence(char) when char == "+" or char == "-" do
    1
  end

  def get_precedence(char) when char == "*" or char == "/" do
    2
  end

  def get_precedence(char) when char == "(" or char == ")" do
    3
  end

  def expression_list(char_list, n, new_list, symbol, first, last) when last == ")"  do
    expression_list((tl char_list), n - 1, new_list ++ [String.trim(symbol, ")"), ")"],
    (hd char_list), String.first(hd char_list), String.last(hd char_list))
  end

  def expression_list(char_list, n, new_list, symbol, first, last) when first == "(" do
    expression_list((tl char_list), n - 1, new_list ++ ["(", String.trim(symbol, "(")],
    (hd char_list), String.first(hd char_list), String.last(hd char_list))
  end

  def expression_list(char_list, n, new_list, symbol, first, last) do
    expression_list((tl char_list), n - 1, new_list ++ [symbol],
    (hd char_list), String.first(hd char_list), String.last(hd char_list))
  end

  def expression_list(char_list, n, new_list, symbol, first, last) when n == 0 do
    new_list ++ [symbol]
  end

  def expression_list(char_list, n, new_list, symbol, first, last) when n == 0 and last == ')' do
    new_list ++ [String.trim(symbol, ")"), ")"]
  end

  def separate_bracks(char_list) do
    expression_list((tl char_list), length(char_list) - 1, [],
    (hd char_list), String.first(hd char_list), String.last(hd char_list))
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
