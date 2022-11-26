defmodule Benford do
  @moduledoc """
  Documentation for `Benford`.
  """

  alias Benford.Scanner
  alias Benford.Law

  def main([path, extensions]) do
    with {:ok, path} <- Scanner.expand(path),
         lines = Scanner.walk(path, extensions, &Scanner.lines/1),
         {counts, rate, total} <- Law.calculate(lines) do
      result = %{
        total: total,
        distribution: counts,
        rate: rate,
        probability: Law.probability()
      }

      IO.inspect(result, label: "items")
    else
      {:error, :not_dir} ->
        incorrect_usage()
    end
  end

  def main(_args) do
    incorrect_usage()
  end

  defp incorrect_usage do
    IO.puts("""
      Usage:
        benford path_to_src extensions
      Example
        benford . ex,exs
    """)
  end
end
