defmodule Cloudinary.Transformation.Flags do
  @moduledoc false
  defguardp is_flag(flag)
            when flag in [
                   :animated,
                   :any_format,
                   :attachment,
                   :apng,
                   :awebp,
                   :clip,
                   :clip_evenodd,
                   :cutter,
                   :force_strip,
                   :force_icc,
                   :getinfo,
                   :hlsv3,
                   :ignore_aspect_ratio,
                   :immutable_cache,
                   :keep_attribution,
                   :keep_dar,
                   :keep_iptc,
                   :layer_apply,
                   :lossy,
                   :mono,
                   :no_overflow,
                   :no_stream,
                   :preserve_transparency,
                   :png8,
                   :png24,
                   :png32,
                   :progressive,
                   :rasterize,
                   :region_relative,
                   :relative,
                   :replace_image,
                   :sanitize,
                   :splice,
                   :streaming_attachment,
                   :strip_profile,
                   :text_no_trim,
                   :text_disallow_overflow,
                   :tiff8_lzw,
                   :tiled,
                   :truncate_ts,
                   :waveform
                 ]

  @spec to_url_string(Cloudinary.Transformation.flags() | [Cloudinary.Transformation.flags()]) ::
          String.t()
  def to_url_string(flag) when is_flag(flag), do: "#{flag}"

  def to_url_string(flags) when is_list(flags) do
    if Enum.all?(flags, &is_flag/1) do
      Enum.join(flags, ".")
    else
      raise ArgumentError,
            "unknown flag #{inspect(Enum.find(flags, &(!is_flag(&1))))} as a transformation parameter"
    end
  end
end
