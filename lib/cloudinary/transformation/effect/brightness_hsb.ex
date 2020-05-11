defmodule Cloudinary.Transformation.Effect.BrightnessHsb do
  @moduledoc """
  Representing the brightness modulation adjustment in HSB.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{modulation: 50} |> to_string()
      "e_brightness_hsb:50"
  """
  @type t :: %__MODULE__{modulation: -99..100}
  defstruct modulation: 80

  defimpl String.Chars do
    def to_string(%{modulation: modulation}) when modulation in -99..100 do
      "e_brightness_hsb:#{modulation}"
    end
  end
end
