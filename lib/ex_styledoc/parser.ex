defmodule ExStyledoc.Parser do
  @moduledoc """
  Functions to parse styledocs.
  """

  import Phoenix.HTML, only: [safe_to_string: 1]
  # import Phoenix.HTML.Tag, only: [content_tag: 3]

  @doc """
  Parse a styledoc.
  """
  def parse_styledoc(doc) do
    Regex.replace(~r/```(.*?)```/s, doc, &parse_example/2)
    |> ExStyledoc.Markdown.to_html()
  end

  defp parse_example(_, string) do
    # [
    #   content_tag(:div, eval_example(string), class: "example"),
    #   content_tag(:div, string, class: "code")
    # ]
    # |> Enum.map(fn(x) -> safe_to_string(x) end)
    # |> Enum.join("\n")

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
