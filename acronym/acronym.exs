defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.split(~r(\W+), string)
    |> Enum.reduce([], &initials_from_word/2)
    |> Enum.reverse()
    |> Enum.join()
    |> String.upcase()
  end

  @doc """
  Consecutively prepend the initials in the given `word` to the given
  accumulator and return it. Every initial is a string containing a single
  grapheme.
  """
  defp initials_from_word(word, acc) do
    Regex.scan(~r(^[[:alpha:]]|[[:upper:]]), word, capture: :first)
    |> Enum.reduce(acc, fn [init], acc -> [init | acc] end)
  end
end
