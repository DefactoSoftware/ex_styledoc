defmodule ExStyledoc do
  @moduledoc """
  Living style guide generation for your Elixir projects.
  """

  defmacro __using__(_options) do
    quote do
      Module.register_attribute(__MODULE__, :styledoc, accumulate: true, persist: true)
    end
  end
end
