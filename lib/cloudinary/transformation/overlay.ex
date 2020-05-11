defmodule Cloudinary.Transformation.Overlay do
  @moduledoc """
  Representing the `overlay` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#overlay_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> %#{__MODULE__}{public_id: "badge"} |> to_string()
      "l_badge"
  """
  @type t ::
          %__MODULE__{public_id: String.t()}
          | __MODULE__.Fetch.t()
          | __MODULE__.Lut.t()
          | __MODULE__.Text.t()
          | __MODULE__.Subtitles.t()
          | __MODULE__.Video.t()
  defstruct [:public_id]

  defimpl String.Chars do
    def to_string(%{public_id: public_id}) when is_binary(public_id), do: "l_#{public_id}"
  end
end
