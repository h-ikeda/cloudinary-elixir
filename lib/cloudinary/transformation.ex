defmodule Cloudinary.Transformation do
  defmodule Expression do
    @moduledoc false
    @type t() :: %__MODULE__{source: String.t()}
    defstruct source: nil
  end

  @predefined_map %{
    aspect_ratio: "ar",
    current_page: "cp",
    face_count: "fc",
    height: "h",
    initial_aspect_ratio: "iar",
    initial_height: "ih",
    initial_width: "iw",
    page_count: "pc",
    page_x: "px",
    page_y: "py",
    tags: "tags",
    width: "w"
  }
  @operator_map %{
    ==: "eq",
    !=: "ne",
    <: "lt",
    >: "gt",
    <=: "lte",
    >=: "gte",
    &&: "and",
    ||: "or",
    *: "mul",
    /: "div",
    +: "add",
    -: "sub",
    pow: "pow",
    mod: "mod"
  }
  @predefineds Map.keys(@predefined_map)
  @operators Map.keys(@operator_map)
  @doc """
  Builds expressions with arithmetic operators and custom variables those are evaluated on the
  cloud. Expressions can be used in several transformation parameters.

  Atoms are treated as predefined values.
      Cloudinary.Transformation.exp(:initial_height / :initial_width)
  Variable names are treated as user defined variables.
      Cloudinary.Transformation.exp(smallsize * 2)
  If you want to use local variables, use the pin operator.
      Cloudinary.Transformation.exp(^local_variable * :initial_height)
  See
  [Conditional transformations](https://cloudinary.com/documentation/conditional_transformations)
  and
  [User-defined variables and arithmetic image transformations](https://cloudinary.com/documentation/user_defined_variables)
  for more details.
  ## Example
      iex> Cloudinary.Transformation.encode(aspect_ratio: Cloudinary.Transformation.exp(:initial_width / :width))
      "ar_iw_div_w"

      iex> Cloudinary.Transformation.encode(effect: [red: Cloudinary.Transformation.exp(:face_count * unit)], variables: [unit: 5])
      "$unit_5,e_red:fc_mul_$unit"

      iex>dynamic_height = 200
      ...>Cloudinary.Transformation.encode(height: Cloudinary.Transformation.exp(^dynamic_height * :aspect_ratio))
      "h_200_mul_ar"

      iex>height = 123
      ...>Cloudinary.Transformation.encode(angle: Cloudinary.Transformation.exp(height + ^height + :height), variables: [height: 456])
      "$height_456,a_$height_add_123_add_h"
  """
  @spec exp(Macro.t()) :: Macro.t()
  defmacro exp(expression) do
    expression =
      expression
      |> Macro.prewalk(fn
        # Convert predefined variables to short shape
        predefined when predefined in @predefineds ->
          @predefined_map[predefined]

        # Convert operators to URL strings
        {operator, _meta, [left, right]} when operator in @operators ->
          quote do: "#{unquote(left)}_#{unquote(@operator_map[operator])}_#{unquote(right)}"

        # Pin operator enables to handle local variables
        {:^, _meta, [child]} ->
          child

        # Other variables to be user defined variables
        {var, _meta, nil} ->
          "$#{var}"

        other ->
          other
      end)

    quote do: %Expression{source: unquote(expression)}
  end

  @transformation_shorthands %{
    angle: "a",
    aspect_ratio: "ar",
    audio_codec: "ac",
    audio_frequency: "af",
    background: "b",
    bit_rate: "br",
    border: "bo",
    color: "co",
    color_space: "cs",
    crop: "c",
    custom_function: "fn",
    custom_pre_function: "fn_pre",
    default_image: "d",
    delay: "dl",
    density: "dn",
    dpr: "dpr",
    duration: "du",
    effect: "e",
    end_offset: "eo",
    fetch_format: "f",
    flags: "fl",
    fps: "fps",
    gravity: "g",
    height: "h",
    if: "if",
    keyframe_interval: "ki",
    opacity: "o",
    overlay: "l",
    page: "pg",
    quality: "q",
    radius: "r",
    raw_transformation: nil,
    start_offset: "so",
    streaming_profile: "sp",
    transformation: "t",
    underlay: "u",
    variables: nil,
    video_codec: "vc",
    video_sampling: "vs",
    width: "w",
    x: "x",
    y: "y",
    zoom: "z"
  }
  @doc """
  Builds a transformation URL string. A list of transformations are converted to chained
  transformations.
  ## Example
      # Single transfomration
      iex> Cloudinary.Transformation.encode(width: 300, height: 255)
      "w_300,h_255"

      # Chained transformations
      iex> Cloudinary.Transformation.encode([[aspect_ratio: "16:9", crop: :fit, effect: [hue: 40]], [effect: [auto_brightness: 70]]])
      "ar_16:9,c_fit,e_hue:40/e_auto_brightness:70"
  """
  @spec encode(keyword | map | [keyword | map]) :: String.t()
  def encode([h | _] = transformations) when not is_tuple(h) do
    transformations |> Enum.map(&encode/1) |> Enum.join("/")
  end

  def encode(transformation) when is_list(transformation) do
    transformation
    |> Keyword.take(Map.keys(@transformation_shorthands))
    |> Enum.sort_by(&elem(&1, 0), fn
      :if, _ -> true
      _, :if -> false
      :variables, _ -> true
      _, :variables -> false
      :raw_transformation, _ -> false
      _, _ -> true
    end)
    |> Enum.map(fn {k, v} ->
      case @transformation_shorthands[k] do
        nil -> transform(k, v)
        short_name -> "#{short_name}_#{transform(k, v)}"
      end
    end)
    |> Enum.join(",")
  end

  def encode(%{} = transformation) do
    transformation |> Enum.into([]) |> encode()
  end

  # Handles each transformation option.
  @spec transform(atom, any) :: String.Chars.t()
  # angle: atom, float, list of them, or expression.
  defp transform(:angle, modes) when is_list(modes), do: Enum.join(modes, ".")
  defp transform(:angle, angle) when is_float(angle) or is_atom(angle), do: angle
  defp transform(:angle, %Expression{source: source}), do: source
  # aspect_ratio: float, string (for example, "16:9") or expression.
  defp transform(:aspect_ratio, %Expression{source: source}), do: source
  defp transform(:aspect_ratio, ratio) when is_binary(ratio), do: ratio
  defp transform(:aspect_ratio, ratio) when is_float(ratio), do: ratio
  # background: "#a1b2c3" as rgb(a) value or color name.
  defp transform(:background, "#" <> rgb), do: "rgb:#{rgb}"
  defp transform(:background, color) when is_binary(color), do: color
  # color: same as background.
  defp transform(:color, color), do: transform(:background, color)
  # border: keyword list or map containing width(px), style(solid), color(rgb or name).
  defp transform(:border, border) when is_list(border) or is_map(border) do
    border =
      border
      |> Enum.into(%{}, fn
        {:color, "#" <> rgb} -> {:color, "rgb:#{rgb}"}
        t -> t
      end)
      |> Map.put_new(:width, 2)
      |> Map.put_new(:style, "solid")
      |> Map.put_new(:color, "black")

    "#{border.width}px_#{border.style}_#{border.color}"
  end

  # crop: atom.
  defp transform(:crop, mode) when is_atom(mode), do: mode
  # dpr: float, :auto or expression.
  defp transform(:dpr, dpr) when is_float(dpr) or dpr == :auto, do: dpr
  defp transform(:dpr, %Expression{source: source}), do: source
  # effect: atom, keyword list or map with values or expressions.
  # parameter value can be a list (for example, [tint: [50, "red", "blue"]])
  defp transform(:effect, [{name, value}]) when is_list(value) do
    value =
      value
      |> Enum.map(fn
        %Expression{source: source} -> source
        any -> any
      end)
      |> Enum.join(":")

    transform(:effect, [{name, value}])
  end

  defp transform(:effect, [{name, %Expression{source: source}}]) do
    transform(:effect, [{name, source}])
  end

  defp transform(:effect, [{name, value}]), do: "#{name}:#{value}"
  defp transform(:effect, effect) when is_map(effect), do: transform(:effect, Map.to_list(effect))
  defp transform(:effect, effect) when is_atom(effect), do: effect
  # flags: atom or list of atoms.
  defp transform(:flags, flags) when is_list(flags), do: Enum.join(flags, ".")
  defp transform(:flags, flag) when is_atom(flag), do: flag
  # custom_function: keyword list or map.
  defp transform(:custom_function, func) do
    case Enum.into(func, %{}) do
      %{function_type: :remote, source: source} -> "remote:#{Base.url_encode64(source)}"
      %{function_type: type, source: source} -> "#{type}:#{source}"
    end
  end

  # custom_pre_function: same as custom_function.
  defp transform(:custom_pre_function, func), do: transform(:custom_function, func)
  # fps: integer or list of integers.
  defp transform(:fps, fps) when is_integer(fps), do: fps
  defp transform(:fps, [min, max]), do: "#{min}-#{max}"
  # overlay: keyword list or map.
  defp transform(:overlay, layer) when is_list(layer) do
    transform(:overlay, Enum.into(layer, %{}))
  end

  defp transform(:overlay, %{type: :fetch, url: url}), do: "fetch:#{Base.url_encode64(url)}"

  defp transform(:overlay, %{resource_type: :text, text: text} = opts) do
    text = text |> URI.encode_www_form() |> URI.encode_www_form()

    case {layer_text_style?(opts), Map.fetch(opts, :public_id)} do
      {false, {:ok, public_id}} ->
        "text:#{String.replace(public_id, "/", ":")}:#{text}"

      {true, :error} ->
        "text:#{layer_text_style(opts)}:#{text}"
    end
  end

  defp transform(:overlay, %{resource_type: :subtitles, public_id: public_id} = opts) do
    public_id = String.replace(public_id, "/", ":")

    if layer_text_style?(opts) do
      "subtitles:#{layer_text_style(opts)}:#{public_id}"
    else
      "subtitles:#{public_id}"
    end
  end

  defp transform(:overlay, %{resource_type: :lut, public_id: public_id}) do
    "lut:#{transform(:overlay, %{public_id: public_id})}"
  end

  defp transform(:overlay, %{public_id: public_id}), do: String.replace(public_id, "/", ":")
  defp transform(:overlay, "fetch:" <> url), do: transform(:overlay, %{type: :fetch, url: url})

  defp transform(:overlay, public_id) when is_binary(public_id) do
    transform(:overlay, %{public_id: public_id})
  end

  # underlay: same as overlay.
  defp transform(:underlay, layer_options), do: transform(:overlay, layer_options)
  # opacity: float or expression.
  defp transform(:opacity, opacity) when is_float(opacity), do: opacity
  defp transform(:opacity, %Expression{source: source}), do: source
  # quolity: float or expression.
  defp transform(:quality, quality) when is_float(quality), do: quality
  defp transform(:quality, %Expression{source: source}), do: source
  # radius: integer, list of integer, :max or expression.
  defp transform(:radius, radius) when is_integer(radius) or radius == :max, do: radius
  defp transform(:radius, %Expression{source: source}), do: source

  defp transform(:radius, radiuses) when is_list(radiuses) do
    radiuses
    |> Enum.map(fn
      %Expression{source: source} -> source
      radius when is_integer(radius) -> radius
    end)
    |> Enum.join(":")
  end

  # transformation: string or list of strings.
  defp transform(:transformation, name) when is_binary(name), do: name

  defp transform(:transformation, transformations) when is_list(transformations) do
    transformations |> Enum.join(".")
  end

  # height: number or expression.
  defp transform(:height, height) when is_integer(height) or is_float(height), do: height
  defp transform(:height, %Expression{source: source}), do: source
  # width: same as height.
  defp transform(:width, width), do: transform(:height, width)
  # x: same as width.
  defp transform(:x, x), do: transform(:width, x)
  # y: same as height.
  defp transform(:y, y), do: transform(:height, y)
  # zoom: float or expression.
  defp transform(:zoom, zoom) when is_float(zoom), do: zoom
  defp transform(:zoom, %Expression{source: source}), do: source
  # audio_codec: string.
  defp transform(:audio_codec, codec) when is_binary(codec), do: codec
  # audio_frequency: integer or :iaf.
  defp transform(:audio_frequency, af) when is_integer(af) or af == :iaf, do: af
  # bit_rate: integer or string.
  defp transform(:bit_rate, rate) when is_integer(rate), do: replace_metric_prefix(rate)

  defp transform(:bit_rate, rate) when is_binary(rate) do
    case String.split(rate, ":", parts: 2) do
      [rate, modifier] -> "#{replace_metric_prefix(rate)}:#{modifier}"
      [rate] -> "#{replace_metric_prefix(rate)}"
    end
  end

  # color_space: string.
  defp transform(:color_space, color_space) when is_binary(color_space), do: color_space
  # default_image: string.
  defp transform(:default_image, public_id) when is_binary(public_id) do
    String.replace(public_id, "/", ":")
  end

  # delay: integer.
  defp transform(:delay, delay) when is_integer(delay), do: delay
  # density: integer or :initial_density.
  defp transform(:density, density) when is_integer(density), do: density
  defp transform(:density, :initial_density), do: "idn"
  # duration: float or string.
  defp transform(:duration, duration) when is_float(duration), do: duration
  defp transform(:duration, duration) when is_binary(duration), do: replace_percent(duration)
  # start_offset: float or string.
  defp transform(:start_offset, offset) when is_float(offset), do: offset
  defp transform(:start_offset, offset) when is_binary(offset), do: replace_percent(offset)
  # end_offset: same as start_offset.
  defp transform(:end_offset, offset), do: transform(:start_offset, offset)
  # fetch_format: string or auto.
  defp transform(:fetch_format, format) when is_binary(format), do: format
  defp transform(:fetch_format, :auto), do: "auto"
  # gravity: atom or list of atoms.
  defp transform(:gravity, gravity) when is_atom(gravity), do: gravity

  defp transform(:gravity, [gravity, modifier]) when is_atom(gravity) and is_atom(modifier) do
    "#{gravity}:#{modifier}"
  end

  # keyframe_interval: float.
  defp transform(:keyframe_interval, interval) when is_float(interval), do: interval
  # page: integer, string or list of them.
  defp transform(:page, page) when is_integer(page), do: page

  defp transform(:page, page) when is_binary(page) do
    if String.match?(page, ~r/[\d-]+(;[\d-]+)*/), do: page, else: "name:#{page}"
  end

  defp transform(:page, pages) when is_list(pages) do
    if Enum.all?(pages, &(is_integer(&1) || String.match?(&1, ~r/^[\d-]+(;[\d-]+)*$/))) do
      Enum.join(pages, ";")
    else
      "name:#{Enum.join(pages, ":")}"
    end
  end

  # streaming_profile: string.
  defp transform(:streaming_profile, profile) when is_binary(profile), do: profile
  # video_codec: string, keyword list, map or :auto.
  defp transform(:video_codec, codec) when is_list(codec) do
    transform(:video_codec, Enum.into(codec, %{}))
  end

  defp transform(:video_codec, %{codec: codec, profile: profile, level: level}) do
    "#{codec}:#{profile}:#{level}"
  end

  defp transform(:video_codec, %{codec: codec, profile: profile}), do: "#{codec}:#{profile}"
  defp transform(:video_codec, %{codec: codec}), do: codec
  defp transform(:video_codec, codec) when is_binary(codec), do: codec
  defp transform(:video_codec, :auto), do: "auto"
  # video_sampling: integer or string
  defp transform(:video_sampling, number) when is_integer(number), do: number
  defp transform(:video_sampling, time) when is_binary(time), do: time
  # if: expression
  defp transform(:if, %Expression{source: source}), do: source
  # variables: list or map.
  defp transform(:variables, %{} = variables), do: transform(:variables, Map.to_list(variables))

  defp transform(:variables, variables) when is_list(variables) do
    variables
    |> Enum.map(fn
      {name, %Expression{source: source}} -> "$#{name}_#{source}"
      {name, value} when is_binary(value) -> "$#{name}_!#{value}!"
      {name, value} -> "$#{name}_#{value}"
    end)
    |> Enum.join(",")
  end

  # raw_transformation: pass through
  defp transform(:raw_transformation, raw) when is_binary(raw), do: raw

  @layer_text_style_basic_params [
    font_weight: "normal",
    font_style: "normal",
    text_decoration: "normal",
    text_align: "left",
    stroke: "none"
  ]
  @layer_text_style_named_params [
    letter_spacing: "letter_spacing",
    line_spacing: "line_spacing",
    font_antialias: "antialias",
    font_hinting: "hinting"
  ]
  # Builds string representing text style for overlay/underlay.
  @spec layer_text_style(map) :: String.t()
  defp layer_text_style(%{font_family: font_family, font_size: font_size} = layer_options) do
    basic_style =
      Enum.flat_map(@layer_text_style_basic_params, fn {name, default} ->
        case "#{Map.get(layer_options, name, default)}" do
          ^default -> []
          value -> [value]
        end
      end)

    named_style =
      Enum.flat_map(@layer_text_style_named_params, fn {name, prefix} ->
        case Map.get(layer_options, name) do
          nil -> []
          value -> ["#{prefix}_#{value}"]
        end
      end)

    [font_family, font_size | basic_style ++ named_style] |> Enum.join("_")
  end

  @spec layer_text_style?(map) :: boolean
  defp layer_text_style?(layer_options) do
    [
      :font_family,
      :font_size
      | Keyword.keys(@layer_text_style_basic_params ++ @layer_text_style_named_params)
    ]
    |> Enum.any?(&is_map_key(layer_options, &1))
  end

  # 50000 will convert to 50k. A bit shorten transformation string.
  @spec replace_metric_prefix(String.t() | number) :: String.t()
  defp replace_metric_prefix(number) do
    "#{number}" |> String.replace_suffix("000000", "m") |> String.replace_suffix("000", "k")
  end

  # % will be replaced with p.
  @spec replace_percent(String.t()) :: String.t()
  defp replace_percent(value) do
    case Regex.run(~r/^([\d\.]+)\s*([%p]?)$/i, String.trim(value)) do
      [_match, v, ""] -> v
      [_match, v, _] -> "#{v}p"
    end
  end
end
