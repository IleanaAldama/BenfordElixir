defmodule Benford.Scanner do
  @moduledoc """
    Utilities for counting the number of lines of the files inside a directory
  """

  @doc "Checks that path is a directory and chenge to an absolute path"
  def expand(path) do
    path = Path.absname(path)

    case File.dir?(path) do
      true -> {:ok, path}
      false -> {:error, :not_dir}
    end
  end

  @doc "Scan all the files inside a directory, with the proviced extensions and applies the given funtion to each file"
  def walk(path, extensions, callback) do
    "#{path}/**/*.{#{extensions}}"
    |> Path.wildcard()
    |> Enum.map(callback)
  end

  @doc "Returns the number of lines contained in a text file"
  def lines(filename) do
    filename
    |> File.stream!()
    |> Enum.to_list()
    |> Enum.count()
  end
end
