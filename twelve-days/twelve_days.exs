defmodule TwelveDays do
  @ordinals %{
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth",
    10 => "tenth",
    11 => "eleventh",
    12 => "twelfth"
  }

  @gifts %{
    12 => "twelve Drummers Drumming",
    11 => "eleven Pipers Piping",
    10 => "ten Lords-a-Leaping",
    9 => "nine Ladies Dancing",
    8 => "eight Maids-a-Milking",
    7 => "seven Swans-a-Swimming",
    6 => "six Geese-a-Laying",
    5 => "five Gold Rings",
    4 => "four Calling Birds",
    3 => "three French Hens",
    2 => "two Turtle Doves",
    1 => "a Partridge in a Pear Tree"
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    for(i <- 1..number, do: @gifts[i]) # verses from last in the verse to first
    |> case do # add "and" before partridge
      [head | tail] when tail != []
        -> ["and #{head}" | tail]
      other -> other
    end
    |> Enum.reverse() # put into correct order for song
    |> Enum.join(", ") # finish formatting verse
    |> (&"On the #{@ordinals[number]} day of Christmas my true love gave to me, #{&1}.").()
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
