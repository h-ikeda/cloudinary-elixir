defmodule Cloudinary.Transformation.Delay do
  @moduledoc """
  Representing the `delay` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#delay_parameter
  https://cloudinary.com/documentation/video_transformation_reference#converting_videos_to_animated_images
  ## Example
      iex> %#{__MODULE__}{milliseconds: 20} |> to_string()
      "dl_20"
  """
  @type t :: %__MODULE__{milliseconds: integer}
  defstruct [:milliseconds]

  defimpl String.Chars do
    def to_string(%{milliseconds: delay}) when is_integer(delay), do: "dl_#{delay}"
  end
end
