defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @actions [
    {0b1, "wink"},
    {0b10, "double blink"},
    {0b100, "close your eyes"},
    {0b1000, "jump"}
  ]

  # Return true if the code matches the given bit pattern; i.e. if all the bits
  # in the pattern are set in the code.
  @spec is_set(code :: integer, bits :: integer) :: integer
  defp is_set(code, bits), do: (code &&& bits) === bits

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    result = for {bits, action} <- @actions, is_set(code, bits), do: action

    if is_set(code, 0b10000) do
      Enum.reverse(result)
    else
      result
    end
  end
end
