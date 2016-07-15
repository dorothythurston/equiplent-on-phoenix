defmodule Equiplent.FeatureCase do
  use ExUnit.CaseTemplate, async: false

  using do
    quote do
      use Equiplent.ConnCase

      use Hound.Helpers

      import FeatureHelpers
      import Equiplent.Gettext

      hound_session
    end
  end
end
