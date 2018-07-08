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

  defp info(msg), do: IO.puts "\n[[ #{msg} ]] \n"

  defp rotate_char(chr, shift) do
    cond do
      chr in ?a..?z ->
        info "lowercase: #{chr}"
        rotate_char_base(chr, shift, ?a)
      chr in ?A..?Z ->
        info "uppercase #{chr}"
        rotate_char_base(chr, shift, ?A)
      true ->
        info "other: #{chr}"
        chr
    end
  end

  defp rotate_char_base(chr, shift, base) do
    offset = chr - base
    shifted = rem(offset + shift, 1+?z-?a)
    result = base + shifted
    info "chr=#{chr}, shift=#{shift}, base=#{base}, offset=#{offset}, shifted=#{shifted}, result=#{result}"
    result
  end
end
