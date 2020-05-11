defmodule Cloudinary.Transformation.Effect.Brightness do
  @moduledoc """
  Representing the brightness adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{value: 60} |> to_string()
      "e_brightness:60"
  """
  @type t :: %__MODULE__{value: -99..100}
  defstruct value: 80

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -99..100, do: "e_brightness:#{value}"
  end
end
