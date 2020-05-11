defmodule Cloudinary.Transformation.Effect.Saturation do
  @moduledoc """
  Representing the color saturation adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{value: 70} |> to_string()
      "e_saturation:70"
  """
  @type t :: %__MODULE__{value: -100..100}
  defstruct value: 80

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -100..100, do: "e_saturation:#{value}"
  end
end
