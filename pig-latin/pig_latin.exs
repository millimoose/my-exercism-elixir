defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    translated_words = for word <- String.split(phrase), do: translate_word(word)
    Enum.join(translated_words, " ")
  end

  @vowels ~W(a e i o u)

  # Translate a single word to Pig Latin
  @spec translate_word(word :: String.t()) :: String.t()
  def translate_word(word) do
    {prefix, suffix} = split_word(word)
    suffix <> prefix <> "ay"
  end

  # Split a word per Pig Latin rules. Returns a tuple {prefix, suffix}, where
  # `prefix` is the part of the word that needs to be shifted to the end of the
  # word.
  @spec split_word(word :: String.t()) :: {String.t(), String.t()}
  def split_word(word) do
    split_word("", word)
  end

  # if suffix starts with a consonant cluster, shift it to the prefix
  def split_word(prefix, ""), do: prefix
  def split_word(prefix, suffix) do
    cond do
      starts_with_any(suffix, @vowels) -> {prefix, suffix}
      starts_with_any(suffix, ~W(x y)) ->
        # look ahead at second letter in suffix
        if String.at(suffix, 1) not in @vowels do
          {prefix, suffix}
        else
          shift(prefix, suffix)
        end
      # special two-character consonant
      String.starts_with?(suffix, "qu") -> (
        {p, s} = shift(prefix, suffix, 2)
        split_word(p, s)
      )
      # other consonants
      true -> (
        {p, s} = shift(prefix, suffix)
        split_word(p, s)
      )
    end
  end


  # shift a given amount of letters from prefix to suffix
  def shift(prefix, suffix, n \\ 1) do
    {infix, suffix} = String.split_at(suffix, n)
    {prefix <> infix, suffix}
  end


  # If `strings` starts with any of the given parts, return the part that
  # matches. Otherwise return nil.
  def starts_with_any(string, [part|parts]) do
    if (String.starts_with?(string, part)) do
      part
    else
      starts_with_any(string, parts)
    end
  end

  def starts_with_any(_, []) do
    nil
  end
end
