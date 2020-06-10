defmodule Cloudinary.Transformation do
  @moduledoc """
  Handles the cloudinary transformation options.

  A cloudinary transformation is represented by a `t:map/0` or a `t:keyword/0`, and a `t:list/0` of
  transformations represents chained transformations.

  See each type documentation to know available ranges and options, and to recognize how parameters
  to be converted to an URL string.
  """
  import Cloudinary.Format
  import __MODULE__.Color

  @typedoc """
  A keyword list or a map containing transformation parameters.
  """
  @type t :: keyword | map
  @typedoc """
  A number greater than 0.
  """
  @type pos_number :: pos_integer | float
  @typedoc """
  A number greater than or equal to 0.
  """
  @type non_neg_number :: non_neg_integer | float
  @doc """
  Converts the cloudinary transformation parameters to an URL string.

  If the argument is a list of transformation keywords/maps, it returns chained (joined by slash)
  transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations
  * https://cloudinary.com/documentation/video_manipulation_and_delivery
  * https://cloudinary.com/documentation/audio_transformations
  * https://cloudinary.com/documentation/image_transformation_reference
  * https://cloudinary.com/documentation/video_transformation_reference
  ## Example
      iex> #{__MODULE__}.to_url_string(
      ...>   overlay: "horses",
      ...>   width: 220,
      ...>   height: 140,
      ...>   crop: :fill,
      ...>   y: 140,
      ...>   x: -110,
      ...>   radius: 20
      ...> )
      "l_horses,w_220,h_140,c_fill,y_140,x_-110,r_20"
      
      iex> #{__MODULE__}.to_url_string(
      ...>   overlay: %{
      ...>     text: "Memories from our trip",
      ...>     font_family: "Parisienne",
      ...>     font_size: 35,
      ...>     font_weight: :bold
      ...>   },
      ...>   color: '990C47',
      ...>   y: 155
      ...> )
      "l_text:Parisienne_35_bold:Memories%20from%20our%20trip,co_rgb:990C47,y_155"

      iex> #{__MODULE__}.to_url_string(
      ...>   if: #{__MODULE__}.expression(:illustrative_likelihood > 0.5),
      ...>   width: 120,
      ...>   height: 150,
      ...>   crop: :pad
      ...> )
      "if_ils_gt_0.5,w_120,h_150,c_pad"

      iex> #{__MODULE__}.to_url_string(
      ...>   raw_transformation: "w_$small,h_$medium,c_$mode",
      ...>   variables: [small: 90, medium: 135, mode: "crop"]
      ...> )
      "$small_90,$medium_135,$mode_!crop!,w_$small,h_$medium,c_$mode"
  """
  @spec to_url_string(t | [t]) :: String.t()
  def to_url_string(transformation) when is_list(transformation) or is_map(transformation) do
    if is_map(transformation) || Keyword.keyword?(transformation) do
      transformation |> Enum.sort(&sort/2) |> Enum.map_join(",", &encode/1)
    else
      transformation |> Enum.map_join("/", &to_url_string/1)
    end
  end

  # `:if` and `:variables` to be first, `:raw_transformation` to be last.
  @spec sort({atom, any}, {atom, any}) :: boolean
  defp sort(_, {:if, _}), do: false
  defp sort(_, {:variables, _}), do: false
  defp sort({:raw_transformation, _}, _), do: false
  defp sort(_, _), do: true

  @spec encode(
          {:if, __MODULE__.Expression.as_boolean()}
          | {:variables, keyword | map}
          | {:angle, angle}
          | {:aspect_ratio, aspect_ratio}
          | {:audio_codec, audio_codec}
          | {:audio_frequency, audio_frequency}
          | {:background, color}
          | {:bit_rate, bit_rate}
          | {:border, border}
          | {:color, color}
          | {:color_space, color_space}
          | {:crop, crop}
          | {:custom_function, custom_function}
          | {:custom_pre_function, custom_function}
          | {:default_image, default_image}
          | {:delay, delay}
          | {:density, density}
          | {:device_pixel_ratio, device_pixel_ratio}
          | {:duration, duration}
          | {:effect, effect}
          | {:end_offset, offset}
          | {:flags, flags | [flags]}
          | {:fetch_format, fetch_format}
          | {:fps, fps}
          | {:gravity, gravity}
          | {:height, height}
          | {:keyframe_interval, keyframe_interval}
          | {:opacity, opacity}
          | {:overlay, overlay}
          | {:page, page}
          | {:quality, quality}
          | {:radius, radius}
          | {:start_offset, offset}
          | {:streaming_profile, streaming_profile}
          | {:transformation, transformation}
          | {:underlay, underlay}
          | {:video_codec, video_codec}
          | {:video_sampling, video_sampling}
          | {:width, width}
          | {:x, x}
          | {:y, y}
          | {:zoom, zoom}
          | {:raw_transformation, String.t()}
        ) :: String.t()
  @typedoc """
  The angle parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#angle_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#rotating_and_rounding_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(angle: 5)
      "a_5"

      iex> #{__MODULE__}.to_url_string(angle: [:auto_right, :hflip])
      "a_auto_right.hflip"
  """
  @type angle ::
          number
          | :auto_right
          | :auto_left
          | :ignore
          | :vflip
          | :hflip
          | [:auto_right | :auto_left | :ignore | :vflip | :hflip]
  defp encode({:angle, angle}), do: "a_#{__MODULE__.Angle.to_url_string(angle)}"

  @typedoc """
  The aspect_ratio parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#aspect_ratio_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(aspect_ratio: {16, 9})
      "ar_16:9"

      iex> #{__MODULE__}.to_url_string(aspect_ratio: 1.3)
      "ar_1.3"
  """
  @type aspect_ratio :: {pos_number, pos_number} | pos_number
  defp encode({:aspect_ratio, {left, right}})
       when is_number(left) and left > 0 and is_number(right) and right > 0 do
    "ar_#{left}:#{right}"
  end

  defp encode({:aspect_ratio, aspect_ratio}) when is_number(aspect_ratio) and aspect_ratio > 0 do
    "ar_#{aspect_ratio}"
  end

  @typedoc """
  The audio_codec parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#audio_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(audio_codec: :vorbis)
      "ac_vorbis"
  """
  @type audio_codec :: :none | :aac | :vorbis | :mp3 | :opus
  defp encode({:audio_codec, audio_codec})
       when audio_codec in [:none, :aac, :vorbis, :mp3, :opus] do
    "ac_#{audio_codec}"
  end

  @typedoc """
  The audio_frequency parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#audio_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(audio_frequency: :initial_frequency)
      "af_iaf"

      iex> #{__MODULE__}.to_url_string(audio_frequency: 44100)
      "af_44100"
  """
  @type audio_frequency ::
          :initial_frequency
          | 8000
          | 11025
          | 16000
          | 22050
          | 32000
          | 37800
          | 44056
          | 44100
          | 47250
          | 48000
          | 88200
          | 96000
          | 176_400
          | 192_000
  defp encode({:audio_frequency, :initial_frequency}), do: "af_iaf"

  defp encode({:audio_frequency, audio_frequency})
       when audio_frequency in [
              8000,
              11025,
              16000,
              22050,
              32000,
              37800,
              44056,
              44100,
              47250,
              48000,
              88200,
              96000,
              176_400,
              192_000
            ] do
    "af_#{audio_frequency}"
  end

  @typedoc """
  The bit_rate parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(bit_rate: 12000000)
      "br_12m"

      iex> #{__MODULE__}.to_url_string(bit_rate: {800000, :constant})
      "br_800k:constant"
  """
  @type bit_rate :: pos_number | {pos_number, :constant}
  defp encode({:bit_rate, bit_rate}), do: "br_#{__MODULE__.BitRate.to_url_string(bit_rate)}"

  @typedoc """
  The border parameter of transformations.

  Options:
  * `:width` - the border width in pixels.
  * `:style` - an `t:atom/0` of the border style name.
  * `:color` - a `t:charlist/0` representing the color hex triplet or a `t:binary/0` color name.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#border_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(border: [width: 4, color: '483F62'])
      "bo_4px_solid_rgb:483F62"

      iex> #{__MODULE__}.to_url_string(border: [width: 6, style: :solid, color: "blue"])
      "bo_6px_solid_blue"
  """
  @type border :: keyword | map
  defp encode({:border, options}) when is_list(options) do
    encode({:border, Enum.into(options, %{})})
  end

  defp encode({:border, options}) when is_map(options) do
    "bo_#{__MODULE__.Border.to_url_string(options)}"
  end

  @typedoc """
  The color/background parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#color_parameter  
  * https://cloudinary.com/documentation/image_transformation_reference#background_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(color: "red")
      "co_red"

      iex> #{__MODULE__}.to_url_string(color: '3BA67D68')
      "co_rgb:3BA67D68"

      iex> #{__MODULE__}.to_url_string(background: "blue")
      "b_blue"

      iex> #{__MODULE__}.to_url_string(background: '4BC67F68')
      "b_rgb:4BC67F68"
  """
  @type color :: Cloudinary.Transformation.Color.t()
  defp encode({:background, color}) when is_binary(color), do: "b_#{color}"
  defp encode({:background, color}) when is_rgb(color) or is_rgba(color), do: "b_rgb:#{color}"
  defp encode({:color, color}) when is_binary(color), do: "co_#{color}"
  defp encode({:color, color}) when is_rgb(color) or is_rgba(color), do: "co_rgb:#{color}"

  @typedoc """
  The color_space parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#color_space_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(color_space: :keep_cmyk)
      "cs_keep_cmyk"

      iex> #{__MODULE__}.to_url_string(color_space: {:icc, "uploaded.icc"})
      "cs_icc:uploaded.icc"
  """
  @type color_space ::
          :srgb | :tinysrgb | :cmyk | :no_cmyk | :keep_cmyk | :copy | {:icc, String.t()}
  defp encode({:color_space, {:icc, id}}) when is_binary(id), do: "cs_icc:#{id}"

  defp encode({:color_space, preset})
       when preset in [:srgb, :tinysrgb, :cmyk, :no_cmyk, :keep_cmyk, :copy] do
    "cs_#{preset}"
  end

  @typedoc """
  The crop parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#crop_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos  
  * https://cloudinary.com/documentation/image_transformations#resizing_and_cropping_images  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#resizing_and_cropping_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(crop: :lpad)
      "c_lpad"
  """
  @type crop ::
          :scale
          | :fit
          | :limit
          | :mfit
          | :fill
          | :lfill
          | :pad
          | :lpad
          | :mpad
          | :fill_pad
          | :crop
          | :thumb
          | :imagga_crop
          | :imagga_scale
  defp encode({:crop, mode})
       when mode in [
              :scale,
              :fit,
              :limit,
              :mfit,
              :fill,
              :lfill,
              :pad,
              :lpad,
              :mpad,
              :fill_pad,
              :crop,
              :thumb,
              :imagga_crop,
              :imagga_scale
            ] do
    "c_#{mode}"
  end

  @typedoc """
  The custom_function/custom_pre_function parameters in the transformations.

  Options:
  * `:function_type` - `:remote` or `:wasm`.
  * `:source` - the source of function, an URL or a public_id.
  ## Official documentation
  * https://cloudinary.com/documentation/custom_functions  
  * https://cloudinary.com/documentation/image_transformation_reference#custom_function_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(custom_function: [function_type: :wasm, source: "example.wasm"])
      "fn_wasm:example.wasm"

      iex> #{__MODULE__}.to_url_string(custom_function: [function_type: :remote, source: "https://example.com/fun"])
      "fn_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="

      iex> #{__MODULE__}.to_url_string(custom_pre_function: [function_type: :remote, source: "https://example.com/fun"])
      "fn_pre_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
  """
  @type custom_function :: keyword | map
  defp encode({param_key, options})
       when param_key in [:custom_function, :custom_pre_function] and is_list(options) do
    encode({param_key, Enum.into(options, %{})})
  end

  defp encode({:custom_function, options}) when is_map(options) do
    "fn_#{__MODULE__.CustomFunction.to_url_string(options)}"
  end

  defp encode({:custom_pre_function, %{function_type: :remote} = options}) when is_map(options) do
    "fn_pre_#{__MODULE__.CustomFunction.to_url_string(options)}"
  end

  @typedoc """
  The default_image parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#default_image_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(default_image: "avatar.png")
      "d_avatar.png"
  """
  @type default_image :: String.t()
  defp encode({:default_image, id}) when is_binary(id), do: "d_#{id}"

  @typedoc """
  The delay parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#delay_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#converting_videos_to_animated_images
  ## Example
      iex> #{__MODULE__}.to_url_string(delay: 20)
      "dl_20"
  """
  @type delay :: number
  defp encode({:delay, delay}) when is_number(delay), do: "dl_#{delay}"

  @typedoc """
  The density parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#density_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(density: :initial_density)
      "dn_idn"

      iex> #{__MODULE__}.to_url_string(density: 400)
      "dn_400"
  """
  @type density :: pos_number | :initial_density
  defp encode({:density, :initial_density}), do: "dn_idn"
  defp encode({:density, density}) when is_number(density) and density > 0, do: "dn_#{density}"

  @typedoc """
  The dpr parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#dpr_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings  
  * https://cloudinary.com/documentation/responsive_images#automatic_pixel_density_detection
  ## Example
      iex> #{__MODULE__}.to_url_string(device_pixel_ratio: :auto)
      "dpr_auto"

      iex> #{__MODULE__}.to_url_string(device_pixel_ratio: 3.0)
      "dpr_3.0"
  """
  @type device_pixel_ratio :: pos_number | :auto
  defp encode({:device_pixel_ratio, dpr}) when (is_number(dpr) and dpr > 0) or dpr == :auto do
    "dpr_#{dpr}"
  end

  @typedoc """
  The duration parameter of transformation.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#trimming_and_overlay_offsets
  ## Example
      iex> #{__MODULE__}.to_url_string(duration: 6.32)
      "du_6.32"

      iex> #{__MODULE__}.to_url_string(duration: {62, :percents})
      "du_62p"
  """
  @type duration :: offset
  defp encode({:duration, {duration, :percents}}) when duration <= 100 and duration >= 0 do
    "du_#{duration}p"
  end

  defp encode({:duration, duration}) when is_number(duration) and duration >= 0 do
    "du_#{duration}"
  end

  @typedoc """
  The effect parameter of transformations.

  See `#{__MODULE__}.Effect` module documentation for more informations about each effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(effect: {:art, :sizzle})
      "e_art:sizzle"
  """
  @type effect :: __MODULE__.Effect.t()
  defp encode({:effect, effect}), do: "e_#{__MODULE__.Effect.to_url_string(effect)}"

  @typedoc """
  The start_offset/end_offset parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#trimming_and_overlay_offsets
  ## Example
      iex> #{__MODULE__}.to_url_string(start_offset: 8.24)
      "so_8.24"

      iex> #{__MODULE__}.to_url_string(start_offset: {88, :percents})
      "so_88p"

      iex> #{__MODULE__}.to_url_string(end_offset: 5.32)
      "eo_5.32"

      iex> #{__MODULE__}.to_url_string(end_offset: {32, :percents})
      "eo_32p"
  """
  @type offset :: non_neg_number | {0..100 | float, :percents} | :auto
  defp encode({:end_offset, {offset, :percents}}) when offset <= 100 and offset >= 0 do
    "eo_#{offset}p"
  end

  defp encode({:end_offset, offset}) when is_number(offset) and offset >= 0, do: "eo_#{offset}"

  defp encode({:start_offset, {offset, :percents}}) when offset <= 100 and offset >= 0 do
    "so_#{offset}p"
  end

  defp encode({:start_offset, offset}) when is_number(offset) and offset >= 0, do: "so_#{offset}"
  defp encode({:start_offset, :auto}), do: "so_auto"

  @typedoc """
  The fetch_format parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#fetch_format_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings  
  * https://cloudinary.com/documentation/image_transformations#automatic_format_selection
  ## Example
      iex> #{__MODULE__}.to_url_string(fetch_format: :png)
      "f_png"

      iex> #{__MODULE__}.to_url_string(fetch_format: :auto)
      "f_auto"
  """
  @type fetch_format :: Cloudinary.Format.t() | :auto
  defp encode({:fetch_format, :auto}), do: "f_auto"

  defp encode({:fetch_format, format}) when is_supported(format) do
    "f_#{format}"
  end

  @typedoc """
  The flags parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#flags_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#video_transformation_flags
  ## Example
      iex> #{__MODULE__}.to_url_string(flags: :awebp)
      "fl_awebp"

      iex> #{__MODULE__}.to_url_string(flags: [:force_strip, :preserve_transparency])
      "fl_force_strip.preserve_transparency"
  """
  @type flags ::
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
  defp encode({:flags, flags}), do: "fl_#{__MODULE__.Flags.to_url_string(flags)}"

  @typedoc """
  The fps parameter of transformations.

  Options:
  * `:min` - specifies the minimum frame rate.
  * `:max` - specifies the maximum frame rate.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(fps: [min: 25])
      "fps_25-"

      iex> #{__MODULE__}.to_url_string(fps: [min: 20, max: 30])
      "fps_20-30"
  """
  @type fps :: keyword | map
  defp encode({:fps, options}) when is_list(options), do: encode({:fps, Enum.into(options, %{})})

  defp encode({:fps, %{min: min, max: max}})
       when is_number(max) and max > 0 and min <= max and min > 0 do
    "fps_#{min}-#{max}"
  end

  defp encode({:fps, %{min: min}}) when is_number(min) and min > 0, do: "fps_#{min}-"

  @typedoc """
  The gravity parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#gravity_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos  
  * https://cloudinary.com/documentation/image_transformations#control_gravity  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#automatic_cropping
  ## Example
      iex> #{__MODULE__}.to_url_string(gravity: :north)
      "g_north"

      iex> #{__MODULE__}.to_url_string(gravity: {:face, :auto})
      "g_face:auto"
  """
  @type gravity ::
          :north_west
          | :north
          | :north_east
          | :west
          | :center
          | :east
          | :south_west
          | :south
          | :south_east
          | :xy_center
          | :liquid
          | :ocr_text
          | :adv_face
          | :adv_faces
          | :adv_eyes
          | :face
          | :faces
          | :body
          | :custom
          | {:face | :faces, :center | :auto}
          | {:body, :face}
          | {:custom, :face | :faces | :adv_face | :adv_faces}
  defp encode({:gravity, gravity}), do: "g_#{__MODULE__.Gravity.to_url_string(gravity)}"

  @typedoc """
  The height parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#height_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(height: 40)
      "h_40"

      iex> #{__MODULE__}.to_url_string(height: 0.3)
      "h_0.3"
  """
  @type height :: non_neg_number
  defp encode({:height, height}) when (height <= 1 or is_integer(height)) and height >= 0 do
    "h_#{height}"
  end

  @typedoc """
  The `keyframe_interval` parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(keyframe_interval: 0.15)
      "ki_0.15"
  """
  @type keyframe_interval :: pos_number
  defp encode({:keyframe_interval, interval}) when is_number(interval) and interval > 0 do
    "ki_#{interval}"
  end

  @typedoc """
  The opacity parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#opacity_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(opacity: 30)
      "o_30"

      iex> #{__MODULE__}.to_url_string(opacity: 60)
      "o_60"
  """
  @type opacity :: 0..100 | float
  defp encode({:opacity, opacity}) when opacity <= 100 and opacity >= 0, do: "o_#{opacity}"

  @typedoc """
  The overlay parameter of transformations.

  See `#{__MODULE__}.Layer` module documentation for more informations about available options.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#overlay_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(overlay: "badge")
      "l_badge"
  """
  @type overlay :: String.t() | keyword | map
  defp encode({:overlay, options}) when is_list(options) do
    encode({:overlay, Enum.into(options, %{})})
  end

  defp encode({:overlay, overlay}) when is_map(overlay) or is_binary(overlay) do
    "l_#{__MODULE__.Layer.to_url_string(overlay)}"
  end

  @typedoc """
  The page parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#page_parameter  
  * https://cloudinary.com/documentation/animated_images#deliver_a_single_frame  
  * https://cloudinary.com/documentation/paged_and_layered_media#deliver_a_pdf_or_selected_pages_of_a_pdf  
  * https://cloudinary.com/documentation/paged_and_layered_media#delivering_photoshop_images
  ## Example
      iex> #{__MODULE__}.to_url_string(page: 2)
      "pg_2"

      iex> #{__MODULE__}.to_url_string(page: 6..8)
      "pg_6-8"

      iex> #{__MODULE__}.to_url_string(page: "-11;15")
      "pg_-11;15"

      iex> #{__MODULE__}.to_url_string(page: [3, 5..7, "9-"])
      "pg_3;5-7;9-"

      iex> #{__MODULE__}.to_url_string(page: [name: "main"])
      "pg_name:main"

      iex> #{__MODULE__}.to_url_string(page: [name: ["record_cover", "Shadow"]])
      "pg_name:record_cover:Shadow"
  """
  @type page ::
          integer
          | Range.t()
          | String.t()
          | [integer | Range.t() | String.t()]
          | [name: String.t() | [String.t()]]
          | %{name: String.t() | [String]}
  defp encode({:page, page}) when is_integer(page) or is_binary(page), do: "pg_#{page}"
  defp encode({:page, first..last}), do: "pg_#{first}-#{last}"

  defp encode({:page, pages}) when is_list(pages) do
    "pg_#{
      Enum.map_join(pages, ";", fn
        page when is_integer(page) or is_binary(page) -> page
        first..last -> "#{first}-#{last}"
      end)
    }"
  end

  defp encode({:page, name: name}), do: encode({:page, %{name: name}})
  defp encode({:page, %{name: name}}) when is_binary(name), do: "pg_name:#{name}"

  defp encode({:page, %{name: names}}) when is_list(names) do
    "pg_name:#{Enum.map_join(names, ":", fn name when is_binary(name) -> name end)}"
  end

  @typedoc """
  The quality parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#quality_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings  
  * https://cloudinary.com/documentation/image_transformations#adjusting_image_quality  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#quality_control
  ## Example
      iex> #{__MODULE__}.to_url_string(quality: 20)
      "q_20"

      iex> #{__MODULE__}.to_url_string(quality: {20, chroma: 444})
      "q_20:444"

      iex> #{__MODULE__}.to_url_string(quality: :jpegmini)
      "q_jpegmini"

      iex> #{__MODULE__}.to_url_string(quality: {:auto, :eco})
      "q_auto:eco"

      iex> #{__MODULE__}.to_url_string(quality: {70, max_quantization: 80})
      "q_70:qmax_80"
  """
  @type quality ::
          1..100
          | float
          | :jpegmini
          | :auto
          | {:auto, :best | :good | :eco | :low}
          | {1..100 | float, chroma: 420 | 444}
          | {1..100 | float, max_quantization: 1..100 | float}
  defp encode({:quality, quality})
       when (quality <= 100 and quality >= 1) or quality in [:jpegmini, :auto] do
    "q_#{quality}"
  end

  defp encode({:quality, {:auto, level}}) when level in [:best, :good, :eco, :low] do
    "q_auto:#{level}"
  end

  defp encode({:quality, {quality, chroma: chroma}})
       when quality <= 100 and quality >= 1 and chroma in [420, 444] do
    "q_#{quality}:#{chroma}"
  end

  defp encode({:quality, {quality, max_quantization: qmax}})
       when quality <= 100 and quality >= 1 and qmax <= 100 and qmax >= 1 do
    "q_#{quality}:qmax_#{qmax}"
  end

  @typedoc """
  The radius parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#radius_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#rotating_and_rounding_videos
  ## Example
      iex> #{__MODULE__}.to_url_string(radius: 20)
      "r_20"

      iex> #{__MODULE__}.to_url_string(radius: {20, 0, 40, 40})
      "r_20:0:40:40"

      iex> #{__MODULE__}.to_url_string(radius: :max)
      "r_max"
  """
  @type radius ::
          non_neg_number
          | {non_neg_number}
          | {non_neg_number, non_neg_number}
          | {non_neg_number, non_neg_number, non_neg_number}
          | {non_neg_number, non_neg_number, non_neg_number, non_neg_number}
          | :max
  defp encode({:radius, radius}) when is_number(radius) and radius >= 0, do: "r_#{radius}"
  defp encode({:radius, {radius}}) when is_number(radius) and radius >= 0, do: "r_#{radius}"

  defp encode({:radius, {top_left_bottom_right, top_right_bottom_left}})
       when is_number(top_left_bottom_right) and top_left_bottom_right >= 0 and
              is_number(top_right_bottom_left) and top_right_bottom_left >= 0 do
    "r_#{top_left_bottom_right}:#{top_right_bottom_left}"
  end

  defp encode({:radius, {top_left, top_right_bottom_left, bottom_right}})
       when is_number(top_left) and top_left >= 0 and
              is_number(top_right_bottom_left) and top_right_bottom_left >= 0 and
              is_number(bottom_right) and bottom_right >= 0 do
    "r_#{top_left}:#{top_right_bottom_left}:#{bottom_right}"
  end

  defp encode({:radius, {top_left, top_right, bottom_right, bottom_left}})
       when is_number(top_left) and top_left >= 0 and
              is_number(top_right) and top_right >= 0 and
              is_number(bottom_right) and bottom_right >= 0 and
              is_number(bottom_left) and bottom_left >= 0 do
    "r_#{top_left}:#{top_right}:#{bottom_right}:#{bottom_left}"
  end

  defp encode({:radius, :max}), do: "r_max"

  @typedoc """
  The streaming_profile parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#predefined_streaming_profiles  
  * https://cloudinary.com/documentation/admin_api#get_adaptive_streaming_profiles  
  * https://cloudinary.com/documentation/admin_api#create_a_streaming_profile
  ## Example
      iex> #{__MODULE__}.to_url_string(streaming_profile: "full_hd")
      "sp_full_hd"
  """
  @type streaming_profile :: String.t()
  defp encode({:streaming_profile, profile}) when is_binary(profile), do: "sp_#{profile}"

  @typedoc """
  The named transformation parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#transformation_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(transformation: "media_lib_thumb")
      "t_media_lib_thumb"
  """
  @type transformation :: String.t()
  defp encode({:transformation, name}) when is_binary(name), do: "t_#{name}"

  @typedoc """
  The underlay parameter of transformations.

  See `#{__MODULE__}.Layer` module documentation for more informations about available options.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#underlay_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(underlay: "background_image_1")
      "u_background_image_1"

      iex> #{__MODULE__}.to_url_string(underlay: public_id: "background_image_2")
      "u_background_image_2"
  """
  @type underlay :: String.t() | keyword | map
  defp encode({:underlay, options}) when is_list(options) do
    encode({:underlay, Enum.into(options, %{})})
  end

  defp encode({:underlay, underlay}) when is_map(underlay) or is_binary(underlay) do
    "u_#{__MODULE__.Layer.to_url_string(underlay)}"
  end

  @typedoc """
  The video_codec parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> #{__MODULE__}.to_url_string(video_codec: :h265)
      "vc_h265"

      iex> #{__MODULE__}.to_url_string(video_codec: {:h264, "baseline"})
      "vc_h264:baseline"

      iex> #{__MODULE__}.to_url_string(video_codec: {:h264, "baseline", "3.1"})
      "vc_h264:baseline:3.1"
  """
  @type video_codec ::
          :vp9
          | :vp8
          | :prores
          | :h264
          | :h265
          | :theora
          | :auto
          | {:h264 | :h265, String.t()}
          | {:h264 | :h265, String.t(), String.t()}
  defp encode({:video_codec, codec})
       when codec in [:vp9, :vp8, :prores, :h264, :h265, :theora, :auto] do
    "vc_#{codec}"
  end

  defp encode({:video_codec, {codec, profile}})
       when codec in [:h264, :h265] and is_binary(profile) do
    "vc_#{codec}:#{profile}"
  end

  defp encode({:video_codec, {codec, profile, level}})
       when codec in [:h264, :h265] and is_binary(profile) and is_binary(level) do
    "vc_#{codec}:#{profile}:#{level}"
  end

  @typedoc """
  The video_sampling parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#converting_videos_to_animated_images
  ## Example
      iex> #{__MODULE__}.to_url_string(video_sampling: 20)
      "vs_20"

      iex> #{__MODULE__}.to_url_string(video_sampling: {2.3, :seconds})
      "vs_2.3s"
  """
  @type video_sampling :: pos_integer | {pos_number, :seconds}
  defp encode({:video_sampling, {every, :seconds}}) when is_number(every) and every > 0 do
    "vs_#{every}s"
  end

  defp encode({:video_sampling, total}) when is_integer(total) and total > 0, do: "vs_#{total}"

  @typedoc """
  The width parameter of transformations.

  Options for the `:auto` setting:
  * `:rounding_step` - the step to round width up.
  * `:width` - the width specification overriding the client header.
  * `:breakpoints` - if true, set the default breakpoints to round width up. Or, you can pass options
    with a keyword list or a map. Breakpoints options:
    * `:min_width`
    * `:max_width`
    * `:bytes_step`
    * `:max_images`
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#width_parameter  
  * https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos  
  * https://cloudinary.com/documentation/responsive_images#automatic_image_width  
  * https://cloudinary.com/documentation/responsive_images#automatic_image_width_using_optimal_responsive_breakpoints
  ## Example
      iex> #{__MODULE__}.to_url_string(width: 600)
      "w_600"

      iex> #{__MODULE__}.to_url_string(width: 1.22)
      "w_1.22"

      iex> #{__MODULE__}.to_url_string(width: :auto)
      "w_auto"

      iex> #{__MODULE__}.to_url_string(width: {:auto, rounding_step: 50})
      "w_auto:50"

      iex> #{__MODULE__}.to_url_string(width: {:auto, rounding_step: 50, client_width: 87})
      "w_auto:50:87"

      iex> #{__MODULE__}.to_url_string(width: {:auto, breakpoints: true})
      "w_auto:breakpoints"

      iex> #{__MODULE__}.to_url_string(width: {:auto, breakpoints: [min_width: 70, max_width: 1200, bytes_step: 10_000, max_images: 30]})
      "w_auto:breakpoints_70_1200_10_30"
  """
  @type width :: non_neg_number | :auto | {:auto, keyword | map}
  defp encode({:width, {:auto, options}}) when is_list(options) do
    encode({:width, {:auto, Enum.into(options, %{})}})
  end

  defp encode({:width, {:auto, %{breakpoints: breakpoints} = opts}}) when is_list(breakpoints) do
    encode({:width, {:auto, %{opts | breakpoints: Enum.into(breakpoints, %{})}}})
  end

  defp encode({:width, width}), do: "w_#{__MODULE__.Width.to_url_string(width)}"

  @typedoc """
  The x parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#x_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(x: 40)
      "x_40"

      iex> #{__MODULE__}.to_url_string(x: 0.3)
      "x_0.3"
  """
  @type x :: number
  defp encode({:x, x}) when is_number(x), do: "x_#{x}"

  @typedoc """
  The y parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#y_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(y: 40)
      "y_40"

      iex> #{__MODULE__}.to_url_string(y: 0.3)
      "y_0.3"
  """
  @type y :: number
  defp encode({:y, y}) when is_number(y), do: "y_#{y}"

  @typedoc """
  The zoom parameter of transformations.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#zoom_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(zoom: 1.2)
      "z_1.2"

      iex> #{__MODULE__}.to_url_string(zoom: 2)
      "z_2"
  """
  @type zoom :: number
  defp encode({:zoom, zoom}) when is_number(zoom), do: "z_#{zoom}"

  defp encode({:raw_transformation, raw_transformation}), do: raw_transformation
  defp encode({:if, condition}), do: "if_#{condition}"

  defp encode({:variables, variables}) do
    Enum.map_join(variables, ",", fn
      {name, value} -> "$#{name}_#{__MODULE__.Expression.build(value)}"
    end)
  end

  @doc """
  Builds an expression with operators and custom variables those are evaluated on the cloud.
  Expressions can be used in several transformation parameters.

  Atoms are treated as predefined values.
      #{__MODULE__}.expression(:initial_height / :initial_width)
  Variable names are treated as user defined variables.
      #{__MODULE__}.expression(smallsize * 2)
  If you want to use local variables, use the pin operator.
      #{__MODULE__}.expression(^local_variable * :initial_height)
  ## Official documentation
  * https://cloudinary.com/documentation/conditional_transformations  
  * https://cloudinary.com/documentation/user_defined_variables  
  * https://cloudinary.com/documentation/video_conditional_expressions  
  * https://cloudinary.com/documentation/video_user_defined_variables
  ## Example
      iex> #{__MODULE__}.expression(:initial_width / :width)
      %#{__MODULE__}.Expression{numerable: true, source: "iw_div_w"}

      iex> #{__MODULE__}.expression(:face_count * unit)
      %#{__MODULE__}.Expression{numerable: true, source: "fc_mul_$unit"}

      iex> dynamic_height = 200 * 2
      ...> #{__MODULE__}.expression(^dynamic_height * :aspect_ratio)
      %#{__MODULE__}.Expression{numerable: true, source: "400_mul_ar"}

      iex> #{__MODULE__}.expression(:initial_width == 500)
      %#{__MODULE__}.Expression{booleanable: true, source: "iw_eq_500"}

      iex> #{__MODULE__}.expression(["tag1", "tag2"] in :tags)
      %#{__MODULE__}.Expression{booleanable: true, source: "!tag1:tag2!_in_tags"}

      iex> #{__MODULE__}.expression(:context["productType"] not in :page_names)
      %#{__MODULE__}.Expression{booleanable: true, source: "ctx:!productType!_nin_pgnames"}

      iex> #{__MODULE__}.expression(:context["name"] != "John")
      %#{__MODULE__}.Expression{booleanable: true, source: "ctx:!name!_ne_!John!"}
  """
  @spec expression(Macro.t()) :: Macro.t()
  defmacro expression(ast) do
    __MODULE__.Expression.traverse(ast)
  end
end
