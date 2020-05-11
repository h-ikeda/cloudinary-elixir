defmodule Cloudinary.Transformation.Effect.Contrast do
  @moduledoc """
  Representing the contrast adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{value: 90} |> to_string()
      "e_contrast:90"
  """
  @type t :: %__MODULE__{value: -100..100}
  defstruct value: 0

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -100..100, do: "e_contrast:#{value}"
  end
end
