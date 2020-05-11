defmodule Cloudinary.Transformation.Background do
  @moduledoc """
  Representing the `background` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#background_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> %#{__MODULE__}{color: "red"} |> to_string()
      "b_red"

      iex> %#{__MODULE__}{color: 0x3BA67D68} |> to_string()
      "b_rgb:3ba67d68"
  """
  @type t :: %__MODULE__{color: String.t() | 0..0xFFFFFFFF}
  defstruct [:color]

  defimpl String.Chars do
    def to_string(%{color: color}) when is_binary(color), do: "b_#{color}"

    def to_string(%{color: color}) when color in 0..0xFFFFFFFF do
      "b_rgb:#{Integer.to_string(color, 16) |> String.downcase()}"
    end
  end
end
