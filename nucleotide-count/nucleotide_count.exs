defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if not nucleotide in @nucleotides do
      raise "Not a nucleotide: #{nucleotide}"
    end
    strand
    |> Enum.count &(nucleotide == &1)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    result = Map.new @nucleotides, &({&1, 0}) # result: {Integer => Integer}
    Enum.reduce strand, result, fn nucl, acc ->
      update_in acc[nucl], &(1 + (&1||0))
    end
  end
end
