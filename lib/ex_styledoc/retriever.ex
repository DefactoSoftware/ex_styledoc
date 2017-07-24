defmodule ExStyledoc.Retriever do
  @moduledoc """
  Functions to retrieve styledocs from modules.
  """

  @styledoc_kinds [:styledoc]

  @doc """
  Returns the styledocs for the given module.
  """
  def get_styledoc(module, kind) when is_atom(module) and kind in @styledoc_kinds do
    case :code.get_object_code(module) do
      {_module, bin, _beam_path} ->
        do_get_styledoc(bin, kind)

      :error -> nil
    end
  end
  def get_styledoc(binpath, kind) when is_binary(binpath) and kind in @styledoc_kinds do
    do_get_styledoc(String.to_charlist(binpath), kind)
  end

  @styledoc_chunk 'Attr'

  defp do_get_styledoc(bin_or_path, kind) do
    case :beam_lib.chunks(bin_or_path, [@styledoc_chunk]) do
      {:ok, {_module, [{@styledoc_chunk, bin}]}} ->
        lookup_styledoc(:erlang.binary_to_term(bin), kind)

      {:error, :beam_lib, {:missing_chunk, _, @styledoc_chunk}} -> nil
    end
  end

  defp lookup_styledoc(docs, kind) do
    Keyword.get_values(docs, kind)
    |> Enum.reduce([], &Enum.into/2)
  end
end
