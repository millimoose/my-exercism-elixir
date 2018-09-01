defmodule Bob do
  def question?(string) do
    String.ends_with?(string, "?")
  end

  def shouting?(string) do
    string == String.upcase(string) && string != String.downcase(string)
  end

  def empty?(string) do
    String.trim(string) == ""
  end

  def hey(input) do
    cond do
      question?(input) && shouting?(input) ->
        "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      empty?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
