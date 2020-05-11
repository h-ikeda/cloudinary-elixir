defmodule Cloudinary.Transformation.Flags do
  @moduledoc """
  Representing the `flags` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#flags_parameter
  https://cloudinary.com/documentation/video_transformation_reference#video_transformation_flags
  ## Example
      iex> %#{__MODULE__}{flags: [:force_strip, :preserve_transparency]} |> to_string()
      "fl_force_strip.preserve_transparency"
  """
  @type t :: %__MODULE__{
          flags: [
            :animated
            | :any_format
            | :attachment
            | :apng
            | :awebp
            | :clip
            | :clip_evenodd
            | :cutter
            | :force_strip
            | :force_icc
            | :getinfo
            | :hlsv3
            | :ignore_aspect_ratio
            | :immutable_cache
            | :keep_attribution
            | :keep_dar
            | :keep_iptc
            | :layer_apply
            | :lossy
            | :mono
            | :no_overflow
            | :no_stream
            | :preserve_transparency
            | :png8
            | :png24
            | :png32
            | :progressive
            | :rasterize
            | :region_relative
            | :relative
            | :replace_image
            | :sanitize
            | :splice
            | :streaming_attachment
            | :strip_profile
            | :text_no_trim
            | :text_disallow_overflow
            | :tiff8_lzw
            | :tiled
            | :truncate_ts
            | :waveform
          ]
        }
  defstruct flags: []

  defimpl String.Chars do
    def to_string(%{flags: flags}) when is_list(flags) and length(flags) > 0 do
      "fl_#{Enum.join(flags, ".")}"
    end
  end
end
