defmodule Equiplent.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Equiplent.ConnCase

      use Hound.Helpers

      import FeatureHelpers

      hound_session
    end
  end
end