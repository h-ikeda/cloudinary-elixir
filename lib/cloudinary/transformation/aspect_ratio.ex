defmodule Cloudinary.Transformation.AspectRatio do
  @moduledoc """
  Representing the `aspect_ratio` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#aspect_ratio_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> %#{__MODULE__}{ratio: {16, 9}} |> to_string()
      "ar_16:9"

      iex> %#{__MODULE__}{ratio: 1.3} |> to_string()
      "ar_1.3"
  """
  @type t :: %__MODULE__{ratio: {pos_integer, pos_integer} | float}
  defstruct ratio: 1.0

  defimpl String.Chars do
    def to_string(%{ratio: {a, b}}) when is_integer(a) and is_integer(b) and a > 0 and b > 0 do
      "ar_#{a}:#{b}"
    end

    def to_string(%{ratio: ratio}) when is_float(ratio) and ratio > 0, do: "ar_#{ratio}"
  end
end
