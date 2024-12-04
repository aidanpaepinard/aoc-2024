defmodule Aoc2024Day3 do
  defp mul_matcher(), do: ~r/mul\((\d+),(\d+)\)/U
  defp dont_matcher(), do: ~r/don't\(\)/
  defp do_matcher(), do: ~r/do\(\)/
  defp file(), do: "input.txt"

  def parse_matches([], acc) do
    acc
  end

  def parse_matches([match | rest], acc) do
    mult = String.to_integer(match.x) * String.to_integer(match.y)
    parse_matches(rest, acc + mult)
  end

  def read_file() do
    case File.read(file()) do
      {:error, reason} ->
        IO.puts("Failed to read #{file()} due to #{reason}")

      {:ok, data} ->
        data
    end
  end

  def part_1(data) do
    matches =
      Regex.scan(mul_matcher(), data, capture: :all_but_first)
      |> Enum.map(fn [x, y] -> %{x: x, y: y} end)

    unless matches === nil do
      parse_matches(matches, 0)
    else
      0
    end
  end

  def part_2(data) do
    enable_disable_loop(:dont, data, 0)
  end

  def enable_disable_loop(type, data, acc) do
    case {data, type} do
      {str, :dont} ->
        case Regex.run(dont_matcher(), str, return: :index) do
          [{start, len}] ->
            {left, right} = String.split_at(str, start + len)
            mult = part_1(left)
            enable_disable_loop(:do, right, acc + mult)

          nil ->
            acc + part_1(str)
        end

      {str, :do} ->
        case Regex.run(do_matcher(), str, return: :index) do
          [{start, len}] ->
            {_, right} = String.split_at(str, start + len)
            enable_disable_loop(:dont, right, acc)

          nil ->
            acc
        end
    end
  end

  def run() do
    data = read_file()
    soln1 = part_1(data)
    soln2 = part_2(data)
    IO.puts("Part 1: #{soln1}\nPart 2: #{soln2}")
  end
end

Aoc2024Day3.run()
