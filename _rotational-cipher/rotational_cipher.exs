defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_string(for << chr <- text >>, do: rotate_char(chr, shift))
  end

  # Return the character shifted by the given amount of characters if it's a
  # letter; otherwise return or the character itself.
  defp rotate_char(chr, shift) when chr in ?a..?z, do: rotate_char_base(chr, shift, ?a)
  defp rotate_char(chr, shift) when chr in ?A..?Z, do: rotate_char_base(chr, shift, ?A)
  defp rotate_char(chr, shift), do: chr

  # Return the character shifted by the given amount of characters with respect
  # to the given base character - the character at position zero in the alphabet
  defp rotate_char_base(chr, shift, base) do
    offset = chr - base
    shifted = rem(offset + shift, 1+?z-?a)
    base + shifted
  end
end
