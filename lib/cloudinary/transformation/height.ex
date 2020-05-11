defmodule Cloudinary.Transformation.Height do
  @moduledoc """
  Representing the `height` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#height_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> %#{__MODULE__}{value: 40} |> to_string()
      "h_40"

      iex> %#{__MODULE__}{value: 0.3} |> to_string()
      "h_0.3"
  """
  @type t :: %__MODULE__{value: pos_integer | float}
  defstruct value: 1.0

  defimpl String.Chars do
    def to_string(%{value: value}) when (is_integer(value) or is_float(value)) and value > 0 do
      "h_#{value}"
    end
  end
end
