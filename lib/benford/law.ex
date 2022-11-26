defmodule Benford.Law do
  @doc "Returns the Bendord probality of the digits 1-9 "
  def probability do
    1..9
    |> Enum.map(fn d ->
      :math.log10(1.0 + 1.0 / d)
    end)
  end

  @doc ""
  def calculate([]) do
    :error
  end

  def calculate(numbers) do
    count = Enum.count(numbers)

    acc =
      1..9
      |> Enum.map(fn _ -> 0 end)
      |> List.to_tuple()

    counts =
      numbers
      |> Enum.filter(fn d -> d > 0 end)
      |> Enum.map(fn d ->
        d
        |> Integer.digits()
        |> List.first()
      end)
      |> Enum.reduce(acc, fn d, acc ->
        index = d - 1
        value = elem(acc, index) + 1
        put_elem(acc, index, value)
      end)
      |> Tuple.to_list()

    rate =
      counts
      |> Enum.map(fn d -> d / count end)

    {counts, rate, count}
  end
end
