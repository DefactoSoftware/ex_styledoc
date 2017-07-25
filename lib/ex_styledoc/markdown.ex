defmodule ExStyledoc.Markdown do
  @moduledoc """
  Transform a given document in Markdown to HTML.
  """

  @doc """
  Earmark specific options:
    * `gfm` - boolean. Turns on Github Flavored Markdown extensions. True by default
    * `breaks` - boolean. Only applicable if `gfm` is enabled. Makes all line
      breaks significant (so every line in the input is a new line in the output)
    * `smartypants`: boolean. Turns on smartypants processing, so quotes become curly,
      two or three hyphens become en and em dashes, and so on. True by default
  """
  def to_html(text, opts \\ []) do
    options = struct(Earmark.Options,
             gfm: Keyword.get(opts, :gfm, true),
             line: Keyword.get(opts, :line, 1),
             file: Keyword.get(opts, :file),
             breaks: Keyword.get(opts, :breaks, false),
             smartypants: Keyword.get(opts, :smartypants, true))
    Earmark.as_html!(text, options)
  end
end
