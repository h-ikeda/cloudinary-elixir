defmodule Cloudinary.Transformation.VideoCodec do
  @moduledoc """
  Representing the `video_codec` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> %#{__MODULE__}{codec: :h265} |> to_string()
      "vc_h265"

      iex> %#{__MODULE__}{codec: :h264, profile: "baseline", level: "3.1"} |> to_string()
      "vc_h264:baseline:3.1"
  """
  @type t ::
          %__MODULE__{
            codec: :vp9 | :vp8 | :prores | :h264 | :h265 | :theora | :auto,
            profile: String.t() | nil,
            level: String.t() | nil
          }
  defstruct [:codec, :profile, :level]

  defimpl String.Chars do
    def to_string(%{codec: codec, profile: nil, level: nil})
        when codec in [:vp9, :vp8, :prores, :h264, :h265, :theora, :auto] do
      "vc_#{codec}"
    end

    def to_string(%{profile: profile, level: nil} = video_codec) when is_binary(profile) do
      "#{%{video_codec | profile: nil}}:#{profile}"
    end

    def to_string(%{level: level} = video_codec) when is_binary(level) do
      "#{%{video_codec | level: nil}}:#{level}"
    end
  end
end
