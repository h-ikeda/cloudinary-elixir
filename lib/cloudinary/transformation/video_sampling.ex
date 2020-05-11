defmodule Cloudinary.Transformation.VideoSampling do
  @moduledoc """
  Representing the `video_sampling` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#converting_videos_to_animated_images
  ## Example
      iex> %#{__MODULE__}{frames: 20} |> to_string()
      "vs_20"

      iex> %#{__MODULE__}{seconds: 2.3} |> to_string()
      "vs_2.3s"
  """
  @type t ::
          %__MODULE__{frames: pos_integer, seconds: nil}
          | %__MODULE__{frames: nil, seconds: float}
  defstruct [:frames, :seconds]

  defimpl String.Chars do
    def to_string(%{frames: frames, seconds: nil}) when is_integer(frames), do: "vs_#{frames}"

    def to_string(%{frames: nil, seconds: seconds}) when is_float(seconds) and seconds > 0 do
      "vs_#{seconds}s"
    end
  end
end
