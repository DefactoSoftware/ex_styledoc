defmodule ExStyledoc.Parser do
  @moduledoc """
  Functions to parse styledocs.
  """

  import Phoenix.HTML, only: [safe_to_string: 1]

  @doc """
  Parse a styledoc.
  """
  def parse_styledoc(doc) do
    Regex.replace(~r/```example(.*?)```/s, doc, &parse_example/2)
    |> ExStyledoc.Markdown.to_html()
  end

  defp parse_example(_, string) do
    string = String.trim(string)
    example = eval_example(string) |> safe_to_string()

    ~s"""
    <div class="example">#{example}</div>
    <div class="code"><pre><code class="elixir">#{string}</code></pre></div>
    """
  end

  defp eval_example(string) do
    {result, _} = Code.eval_string(string)
    result
  end
end
