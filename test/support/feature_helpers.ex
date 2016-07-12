defmodule FeatureHelpers do
  use Hound.Helpers

  def fill_in(name, text) do
    {:name, name} |> fill_field(text)
  end

  def submit do
    {:css, "input[type=submit]"}
    |> submit_element
  end
end
