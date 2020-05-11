defmodule Cloudinary.Transformation.Overlay.Subtitles do
  @moduledoc """
  Representing `overlay` parameter of transformation which adds subtitles.
  ## Official documentation
  https://cloudinary.com/documentation/video_manipulation_and_delivery#adding_subtitles
  ## Example
      iex> %#{__MODULE__}{public_id: "sample_sub_en.srt"} |> to_string()
      "l_subtitles:sample_sub_en.srt"

      iex> %#{__MODULE__}{public_id: "sample_sub_en.srt", style: %Cloudinary.Transformation.Layer.TextStyle{font_family: "arial", font_size: 20}} |> to_string()
      "l_subtitles:arial_20:sample_sub_en.srt"
  """
  alias Cloudinary.Transformation.Layer.TextStyle
  @type t :: %__MODULE__{public_id: String.t(), style: TextStyle.t() | nil}
  defstruct [:public_id, :style]

  defimpl String.Chars do
    def to_string(%{public_id: public_id, style: nil}) when is_binary(public_id) do
      "l_subtitles:#{public_id}"
    end

    def to_string(%{public_id: public_id, style: %TextStyle{} = style})
        when is_binary(public_id) do
      "l_subtitles:#{style}:#{public_id}"
    end
  end
end
