defmodule Cloudinary.Transformation.AudioCodec do
  @moduledoc """
  Representing the `audio_codec` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#audio_settings
  ## Example
      iex> %#{__MODULE__}{codec: :vorbis} |> to_string()
      "ac_vorbis"
  """
  @type t :: %__MODULE__{codec: :none | :aac | :vorbis | :mp3 | :opus}
  defstruct [:codec]

  defimpl String.Chars do
    def to_string(%{codec: codec}) when codec in [:none, :aac, :vorbis, :mp3, :opus] do
      "ac_#{codec}"
    end
  end
end
