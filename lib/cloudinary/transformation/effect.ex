defmodule Cloudinary.Transformation.Effect do
  @moduledoc """
  The effect parameter of transformations.

  To apply an effect without options, pass an `t:atom/0` as a transformation's effect parameter. To
  apply with options, use a `t:tuple/0` instead. For details of each options, see the corresponding
  documentation for that type.
  """
  import Cloudinary.Transformation.Color

  @typedoc """
  A number greater than or equal to 0.
  """
  @type non_neg_number :: non_neg_integer | float
  @typedoc """
  Any type of an effect.
  """
  @type t ::
          accelerate
          | adv_redeye
          | anti_removal
          | art
          | assist_colorblind
          | auto_brightness
          | auto_color
          | auto_contrast
          | background_removal
          | blackwhite
          | blue
          | blur
          | blur_faces
          | blur_region
          | boomerang
          | brightness
          | brightness_hsb
          | cartoonify
          | colorize
          | contrast
          | cut_out
          | deshake
          | displace
          | distort
          | fade
          | fill_light
          | gamma
          | gradient_fade
          | grayscale
          | green
          | hue
          | improve
          | loop
          | make_transparent
          | multiply
          | negate
          | noise
          | oil_paint
          | opacity_threshold
          | ordered_dither
          | outline
          | overlay
          | pixelate
          | pixelate_faces
          | pixelate_region
          | preview
          | progressbar
          | recolor
          | red
          | redeye
          | replace_color
          | reverse
          | saturation
          | screen
          | sepia
          | shadow
          | sharpen
          | shear
          | simulate_colorblind
          | style_transfer
          | tint
          | transition
          | trim
          | unsharp_mask
          | vectorize
          | vibrance
          | viesus_correct
          | vignette
          | volume
  @doc """
  Converts an atom or a tuple representing an effect parameter to a URL string.
  """
  @spec to_url_string(t) :: String.t()
  @typedoc """
  The video speeding up effect.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:accelerate)
      "accelerates"

      iex> #{__MODULE__}.to_url_string({:accelerate, 100})
      "accelerate:100"
  """
  @type accelerate :: :accelerate | {:accelerate, -50..100 | float}
  def to_url_string(:accelerate), do: "accelerate"

  def to_url_string({:accelerate, acceleration})
      when acceleration <= 100 and acceleration >= -50 do
    "accelerate:#{acceleration}"
  end

  @typedoc """
  The removing red eyes filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter  
  * https://cloudinary.com/documentation/advanced_facial_attributes_detection_addon
  ## Example
      iex> #{__MODULE__}.to_url_string(:adv_redeye)
      "adv_redeye"
  """
  @type adv_redeye :: :adv_redeye
  def to_url_string(:adv_redeye), do: "adv_redeye"

  @typedoc """
  The overlay anti removal level.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:anti_removal)
      "anti_removal"

      iex> #{__MODULE__}.to_url_string({:anti_removal, 90})
      "anti_removal:90"
  """
  @type anti_removal :: :anti_removal | {:anti_removal, 1..100 | float}
  def to_url_string(:anti_removal), do: "anti_removal"

  def to_url_string({:anti_removal, level}) when level <= 100 and level >= 1 do
    "anti_removal:#{level}"
  end

  @typedoc """
  The artistic filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string({:art, :frost})
      "art:frost"
  """
  @type art ::
          {:art,
           :al_dente
           | :athena
           | :audrey
           | :aurora
           | :daguerre
           | :eucalyptus
           | :fes
           | :frost
           | :hairspray
           | :hokusai
           | :incognito
           | :linen
           | :peacock
           | :primavera
           | :quartz
           | :red_rock
           | :refresh
           | :sizzle
           | :sonnet
           | :ukulele
           | :zorro}
  def to_url_string({:art, filter})
      when filter in [
             :al_dente,
             :athena,
             :audrey,
             :aurora,
             :daguerre,
             :eucalyptus,
             :fes,
             :frost,
             :hairspray,
             :hokusai,
             :incognito,
             :linen,
             :peacock,
             :primavera,
             :quartz,
             :red_rock,
             :refresh,
             :sizzle,
             :sonnet,
             :ukulele,
             :zorro
           ] do
    "art:#{filter}"
  end

  @typedoc """
  The color blind friendly filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:assist_colorblind)
      "assist_colorblind"

      iex> #{__MODULE__}.to_url_string({:assist_colorblind, 8})
      "assist_colorblind:8"

      iex> #{__MODULE__}.to_url_string({:assist_colorblind, :xray})
      "assist_colorblind:xray"
  """
  @type assist_colorblind :: :assist_colorblind | {:assist_colorblind, 1..100 | float | :xray}
  def to_url_string(:assist_colorblind), do: "assist_colorblind"

  def to_url_string({:assist_colorblind, strength})
      when (strength <= 100 and strength >= 1) or strength == :xray do
    "assist_colorblind:#{strength}"
  end

  @typedoc """
  The automatic brightness adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:auto_brightness)
      "auto_brightness"

      iex> #{__MODULE__}.to_url_string({:auto_brightness, 70})
      "auto_brightness:70"
  """
  @type auto_brightness :: :auto_brightness | {:auto_brightness, 0..100 | float}
  def to_url_string(:auto_brightness), do: "auto_brightness"

  def to_url_string({:auto_brightness, amount}) when amount <= 100 and amount >= 0 do
    "auto_brightness:#{amount}"
  end

  @typedoc """
  The automatic color balance adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:auto_color)
      "auto_color"

      iex> #{__MODULE__}.to_url_string({:auto_color, 90})
      "auto_color:90"
  """
  @type auto_color :: :auto_color | {:auto_color, 0..100 | float}
  def to_url_string(:auto_color), do: "auto_color"

  def to_url_string({:auto_color, amount}) when amount <= 100 and amount >= 0 do
    "auto_color:#{amount}"
  end

  @typedoc """
  The automatic contrast adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:auto_contrast)
      "auto_contrast"

      iex> #{__MODULE__}.to_url_string({:auto_contrast, 90})
      "auto_contrast:90"
  """
  @type auto_contrast :: :auto_contrast | {:auto_contrast, 0..100 | float}
  def to_url_string(:auto_contrast), do: "auto_contrast"

  def to_url_string({:auto_contrast, amount}) when amount <= 100 and amount >= 0 do
    "auto_contrast:#{amount}"
  end

  @typedoc """
  The background removing filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:background_removal)
      "bgremoval"

      iex> #{__MODULE__}.to_url_string({:background_removal, :screen})
      "bgremoval:screen"

      iex> #{__MODULE__}.to_url_string({:background_removal, '8AF02B'})
      "bgremoval:8AF02B"

      iex> #{__MODULE__}.to_url_string({:background_removal, {'8af02b', :screen}})
      "bgremoval:screen:8af02b"
  """
  @type background_removal ::
          :background_removal
          | {:background_removal,
             Cloudinary.Transformation.Color.t()
             | :screen
             | {Cloudinary.Transformation.Color.t(), :screen}}
  def to_url_string(:background_removal), do: "bgremoval"
  def to_url_string({:background_removal, :screen}), do: "bgremoval:screen"

  def to_url_string({:background_removal, clr}) when is_rgb(clr) or is_rgba(clr) do
    "bgremoval:#{clr}"
  end

  def to_url_string({:background_removal, {clr, :screen}}) when is_rgb(clr) or is_rgba(clr) do
    "bgremoval:screen:#{clr}"
  end

  @typedoc """
  The black/white filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:blackwhite)
      "blackwhite"
  """
  @type blackwhite :: :blackwhite
  def to_url_string(:blackwhite), do: "blackwhite"

  @typedoc """
  The blue channel adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:blue)
      "blue"

      iex> #{__MODULE__}.to_url_string({:blue, 90})
      "blue:90"
  """
  @type blue :: :blue | {:blue, -100..100 | float}
  def to_url_string(:blue), do: "blue"
  def to_url_string({:blue, blue}) when blue <= 100 and blue >= -100, do: "blue:#{blue}"

  @typedoc """
  The blur effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:blur)
      "blur"

      iex> #{__MODULE__}.to_url_string({:blur, 300})
      "blur:300"
  """
  @type blur :: :blur | {:blur, 1..2000 | float}
  def to_url_string(:blur), do: "blur"

  def to_url_string({:blur, strength}) when strength <= 2000 and strength >= 1 do
    "blur:#{strength}"
  end

  @typedoc """
  The blur effect on faces.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:blur_faces)
      "blur_faces"

      iex> #{__MODULE__}.to_url_string({:blur_faces, 600})
      "blur_faces:600"
  """
  @type blur_faces :: :blur_faces | {:blur_faces, 1..2000 | float}
  def to_url_string(:blur_faces), do: "blur_faces"

  def to_url_string({:blur_faces, strength}) when strength <= 2000 and strength >= 1 do
    "blur_faces:#{strength}"
  end

  @typedoc """
  The blur effect on a specified region.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:blur_region)
      "blur_region"

      iex> #{__MODULE__}.to_url_string({:blur_region, 200})
      "blur_region:200"
  """
  @type blur_region :: :blur_region | {:blur_region, 1..2000 | float}
  def to_url_string(:blur_region), do: "blur_region"

  def to_url_string({:blur_region, strength}) when strength <= 2000 and strength >= 1 do
    "blur_region:#{strength}"
  end

  @typedoc """
  The boomerang playing conversion.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#create_a_boomerang_video_clip
  ## Example
      iex> #{__MODULE__}.to_url_string(:boomerang)
      "boomerang"
  """
  @type boomerang :: :boomerang
  def to_url_string(:boomerang), do: "boomerang"

  @typedoc """
  The brightness adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:brightness)
      "brightness"

      iex> #{__MODULE__}.to_url_string({:brightness, 60})
      "brightness:60"
  """
  @type brightness :: :brightness | {:brightness, -99..100 | float}
  def to_url_string(:brightness), do: "brightness"

  def to_url_string({:brightness, adjustment}) when adjustment <= 100 and adjustment >= -99 do
    "brightness:#{adjustment}"
  end

  @typedoc """
  The brightness adjustment in HSB.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:brightness_hsb)
      "brightness_hsb"

      iex> #{__MODULE__}.to_url_string({:brightness_hsb, 50})
      "brightness_hsb:50"
  """
  @type brightness_hsb :: :brightness_hsb | {:brightness_hsb, -99..100 | float}
  def to_url_string(:brightness_hsb), do: "brightness_hsb"

  def to_url_string({:brightness_hsb, adjustment}) when adjustment <= 100 and adjustment >= -99 do
    "brightness_hsb:#{adjustment}"
  end

  @typedoc """
  The cartoon effect.

  Options:
  * `:line_strength` - the thickness of lines.
  * `:color_reduction` - the decrease level in the number of colors or `:blackwhite`.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:cartoonify)
      "cartoonify"

      iex> #{__MODULE__}.to_url_string({:cartoonify, line_strength: 40})
      "cartoonify:40"

      iex> #{__MODULE__}.to_url_string({:cartoonify, color_reduction: 55})
      "cartoonify:50:55"

      iex> #{__MODULE__}.to_url_string({:cartoonify, color_reduction: :blackwhite})
      "cartoonify:50:bw"
      
      iex> #{__MODULE__}.to_url_string({:cartoonify, line_strength: 20, color_reduction: 60})
      "cartoonify:20:60"

      iex> #{__MODULE__}.to_url_string({:cartoonify, line_strength: 30, color_reduction: :blackwhite})
      "cartoonify:30:bw"
  """
  @type cartoonify :: :cartoonify | {:cartoonify, keyword | map}
  def to_url_string(:cartoonify), do: "cartoonify"

  def to_url_string({:cartoonify, options}) when is_list(options) do
    to_url_string({:cartoonify, Enum.into(options, %{})})
  end

  def to_url_string({:cartoonify, options}) when is_map(options) do
    __MODULE__.Cartoonify.to_url_string(options)
  end

  @typedoc """
  The colorize effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:colorize)
      "colorize"

      iex> #{__MODULE__}.to_url_string({:colorize, 80})
      "colorize:80"
  """
  @type colorize :: :colorize | {:colorize, 0..100 | float}
  def to_url_string(:colorize), do: "colorize"

  def to_url_string({:colorize, strength}) when strength <= 100 and strength >= 0 do
    "colorize:#{strength}"
  end

  @typedoc """
  The contrast adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:contrast)
      "contrast"

      iex> #{__MODULE__}.to_url_string({:contrast 90})
      "contrast:90"
  """
  @type contrast :: :contrast | {:contrast, -100..100 | float}
  def to_url_string(:contrast), do: "contrast"

  def to_url_string({:contrast, adjustment}) when adjustment <= 100 and adjustment >= -100 do
    "contrast:#{adjustment}"
  end

  @typedoc """
  The trimming transparent pixels of the overlay image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:cut_out)
      "cut_out"
  """
  @type cut_out :: :cut_out
  def to_url_string(:cut_out), do: "cut_out"

  @typedoc """
  The removing small motion shifts.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:deshake)
      "deshake"

      iex> #{__MODULE__}.to_url_string({:deshake, 32})
      "deshake:32"
  """
  @type deshake :: :deshake | {:deshake, 16 | 32 | 48 | 64}
  def to_url_string(:deshake), do: "deshake"
  def to_url_string({:deshake, extent}) when extent in [16, 32, 48, 64], do: "deshake:#{extent}"

  @typedoc """
  The displacing by color channels.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:displace)
      "displace"
  """
  @type displace :: :displace
  def to_url_string(:displace), do: "displace"

  @typedoc """
  The distortion effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string({:distort, {{5, 34}, {70, 10}, {70, 75}, {5, 55}}})
      "distort:5:34:70:10:70:75:5:55"

      iex> #{__MODULE__}.to_url_string({:distort, {:arc, 180}})
      "distort:arc:180"
  """
  @type distort ::
          {:distort,
           {:arc, number}
           | {{number, number}, {number, number}, {number, number}, {number, number}}}
  def to_url_string({:distort, {:arc, angle}}) when is_number(angle), do: "distort:arc:#{angle}"

  def to_url_string({:distort, {{x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}}})
      when is_number(x1) and is_number(y1) and is_number(x2) and is_number(y2) and
             is_number(x3) and is_number(y3) and is_number(x4) and is_number(y4) do
    "distort:#{x1}:#{y1}:#{x2}:#{y2}:#{x3}:#{y3}:#{x4}:#{y4}"
  end

  @typedoc """
  The fading in/out.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:fade)
      "fade"

      iex> #{__MODULE__}.to_url_string({:fade, 2000})
      "fade:2000"
  """
  @type fade :: :fade | {:fade, non_neg_number}
  def to_url_string(:fade), do: "fade"
  def to_url_string({:fade, fade}) when is_number(fade) and fade >= 0, do: "fade:#{fade}"

  @typedoc """
  The fill light adjustment.

  Options:
  * `:amount` - a `t:number/0` between 0 to 100.
  * `:bias` - a `t:number/0` between -100 to 100. 
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:fill_light)
      "fill_light"

      iex> #{__MODULE__}.to_url_string({:fill_light, amount: 40})
      "fill_light:40"

      iex> #{__MODULE__}.to_url_string({:fill_light, amount: 70, bias: 20})
      "fill_light:70:20"
  """
  @type fill_light :: :fill_light | {:fill_light, keyword | map}
  def to_url_string(:fill_light), do: "fill_light"

  def to_url_string({:fill_light, options}) when is_list(options) do
    to_url_string({:fill_light, Enum.into(options, %{})})
  end

  def to_url_string({:fill_light, options}) when is_map(options) do
    __MODULE__.FillLight.to_url_string(options)
  end

  @typedoc """
  The gamma level adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:gamma)
      "gamma"

      iex> #{__MODULE__}.to_url_string({:gamma, 50})
      "gamma:50"
  """
  @type gamma :: :gamma | {:gamma, -50..150 | float}
  def to_url_string(:gamma), do: "gamma"
  def to_url_string({:gamma, level}) when level <= 150 and level >= -50, do: "gamma:#{level}"

  @typedoc """
  The gradient fade effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:gradient_fade)
      "gradient_fade"

      iex> #{__MODULE__}.to_url_string({:gradient_fade, 40})
      "gradient_fade:40"

      iex> #{__MODULE__}.to_url_string({:gradient_fade, :symmetric})
      "gradient_fade:symmetric"

      iex> #{__MODULE__}.to_url_string({:gradient_fade, {25, :symmetric}})
      "gradient_fade:symmetric:25"

      iex> #{__MODULE__}.to_url_string({:gradient_fade, {50, :symmetric_pad}})
      "gradient_fade:symmetric_pad:50"
  """
  @type gradient_fade ::
          :gradient_fade
          | {:gradient_fade,
             0..100
             | float
             | :symmetric
             | :symmetric_pad
             | {0..100 | float, :symmetric | :symmetric_pad}}
  def to_url_string(:gradient_fade), do: "gradient_fade"

  def to_url_string({:gradient_fade, strength_or_mode})
      when strength_or_mode <= 100 and strength_or_mode >= 0
      when strength_or_mode in [:symmetric, :symmetric_pad] do
    "gradient_fade:#{strength_or_mode}"
  end

  def to_url_string({:gradient_fade, {strength, mode}})
      when strength <= 100 and strength >= 0 and mode in [:symmetric, :symmetric_pad] do
    "gradient_fade:#{mode}:#{strength}"
  end

  @typedoc """
  The effect that generates a gray-scaled image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:grayscale)
      "grayscale"
  """
  @type grayscale :: :grayscale
  def to_url_string(:grayscale), do: "grayscale"

  @typedoc """
  The green channel adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:green)
      "green"

      iex> #{__MODULE__}.to_url_string({:green, -30})
      "green:-30"
  """
  @type green :: :green | {:green, -100..100 | float}
  def to_url_string(:green), do: "green"
  def to_url_string({:green, green}) when green <= 100 and green >= -100, do: "green:#{green}"

  @typedoc """
  The hue adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:hue)
      "hue"

      iex> #{__MODULE__}.to_url_string({:hue, 40})
      "hue:40"
  """
  @type hue :: :hue | {:hue, -100..100 | float}
  def to_url_string(:hue), do: "hue"
  def to_url_string({:hue, hue}) when hue <= 100 and hue >= -100, do: "hue:#{hue}"

  @typedoc """
  The automatic image improvement.

  Options:
  * `:mode` - `:outdoor` or `:indoor`.
  * `:blend` - `t:number/0` representing improvement amounts between 0 to 100.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:improve)
      "improve"

      iex> #{__MODULE__}.to_url_string({:improve, blend: 40})
      "improve:40"

      iex> #{__MODULE__}.to_url_string({:improve, mode: :indoor})
      "improve:indoor"

      iex> #{__MODULE__}.to_url_string({:improve, mode: :indoor, blend: 50})
      "improve:indoor:50"
  """
  @type improve :: :improve | {:improve, keyword | map}
  def to_url_string(:improve), do: "improve"

  def to_url_string({:improve, options}) when is_list(options) do
    to_url_string({:improve, Enum.into(options, %{})})
  end

  def to_url_string({:improve, options}) when is_map(options) do
    __MODULE__.Improve.to_url_string(options)
  end

  @typedoc """
  The loop playing times.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string({:loop, 2})
      "loop:2"
  """
  @type loop :: {:loop, non_neg_integer}
  def to_url_string({:loop, loop}) when is_integer(loop) and loop >= 0, do: "loop:#{loop}"

  @typedoc """
  The making background transparent.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:make_transparent)
      "make_transparent"

      iex> #{__MODULE__}.to_url_string({:make_transparent, 40})
      "make_transparent:40"
  """
  @type make_transparent :: :make_transparent | {:make_transparent, 0..100 | float}
  def to_url_string(:make_transparent), do: "make_transparent"

  def to_url_string({:make_transparent, tolerance}) when tolerance <= 100 and tolerance >= 0 do
    "make_transparent:#{tolerance}"
  end

  @typedoc """
  The multiply blending with the overlay image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:multiply)
      "multiply"
  """
  @type multiply :: :multiply
  def to_url_string(:multiply), do: "multiply"

  @typedoc """
  The nagating color effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:negate)
      "negate"
  """
  @type negate :: :negate
  def to_url_string(:negate), do: "negate"

  @typedoc """
  The noise effect.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:noise)
      "noise"

      iex> #{__MODULE__}.to_url_string({:noise, 10})
      "noise:10"
  """
  @type noise :: :noise | {:noise, 0..100 | float}
  def to_url_string(:noise), do: "noise"
  def to_url_string({:noise, level}) when level <= 100 and level >= 0, do: "noise:#{level}"

  @typedoc """
  The oil paint effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:oil_paint)
      "oil_paint"

      iex> #{__MODULE__}.to_url_string({:oil_paint, 40})
      "oil_paint:40"
  """
  @type oil_paint :: :oil_paint | {:oil_paint, 0..100 | float}
  def to_url_string(:oil_paint), do: "oil_paint"

  def to_url_string({:oil_paint, strength}) when strength <= 100 and strength >= 0 do
    "oil_paint:#{strength}"
  end

  @typedoc """
  The transparency level of the semi-transparent pixels.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(threshold: 40)
      "opacity_threshold:40"
  """
  @type opacity_threshold :: {:opacity_threshold, 1..100 | float}
  def to_url_string(:opacity_threshold), do: "opacity_threshold"

  def to_url_string({:opacity_threshold, level}) when level <= 100 and level >= 1 do
    "opacity_threshold:#{level}"
  end

  @typedoc """
  The dither effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:ordered_dither)
      "ordered_dither"

      iex> #{__MODULE__}.to_url_string({:ordered_dither, 3})
      "ordered_dither:3"
  """
  @type ordered_dither :: :ordered_dither | {:ordered_dither, 0..18}
  def to_url_string(:ordered_dither), do: "ordered_dither"
  def to_url_string({:ordered_dither, level}) when level in 0..18, do: "ordered_dither:#{level}"

  @typedoc """
  The outline effect.

  Options:
  * `:mode` - an `t:atom/0` representing how to apply the outline effect.
  * `:width` - the thickness of the outline.
  * `:blur` - the blur level of the outline.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#outline_effects
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:outline)
      "outline"

      iex> #{__MODULE__}.to_url_string({:outline, width: 3})
      "outline:8"

      iex> #{__MODULE__}.to_url_string({:outline, width: 8, blur: 20})
      "outline:8:20"

      iex> #{__MODULE__}.to_url_string({:outline, mode: :inner})
      "outline:inner"

      iex> #{__MODULE__}.to_url_string({:outline, mode: :inner_fill, width: 7})
      "outline:inner_fill:7"

      iex> #{__MODULE__}.to_url_string({:outline, mode: :outer, width: 10, blur: 200})
      "outline:outer:10:200"
  """
  @type outline :: :outline | {:outline, keyword | map}
  def to_url_string(:outline), do: "outline"

  def to_url_string({:outline, options}) when is_list(options) do
    to_url_string({:outline, Enum.into(options, %{})})
  end

  def to_url_string({:outline, options}) when is_map(options) do
    __MODULE__.Outline.to_url_string(options)
  end

  @typedoc """
  The overlay blending with the overlay image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:overlay)
      "overlay"
  """
  @type overlay :: :overlay
  def to_url_string(:overlay), do: "overlay"

  @typedoc """
  The pixelate effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:pixelate)
      "pixelate"

      iex> #{__MODULE__}.to_url_string({:pixelate, 3})
      "pixelate:3"
  """
  @type pixelate :: :pixelate | {:pixelate, 1..200 | float}
  def to_url_string(:pixelate), do: "pixelate"

  def to_url_string({:pixelate, size}) when size <= 200 and size >= 1 do
    "pixelate:#{size}"
  end

  @typedoc """
  The pixelate effect on faces.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:pixelate_faces)
      "pixelate_faces"

      iex> #{__MODULE__}.to_url_string({:pixelate_faces, 7})
      "pixelate_faces:7"
  """
  @type pixelate_faces :: :pixelate_faces | {:pixelate_faces, 1..200 | float}
  def to_url_string(:pixelate_faces), do: "pixelate_faces"

  def to_url_string({:pixelate_faces, size}) when size <= 200 and size >= 1 do
    "pixelate_faces:#{size}"
  end

  @typedoc """
  The pixelate effect on the specified region.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:pixelate_region)
      "pixelate_region"

      iex> #{__MODULE__}.to_url_string({:pixelate_region, 20})
      "pixelate_region:20"
  """
  @type pixelate_region :: :pixelate_region | {:pixelate_region, 1..200 | float}
  def to_url_string(:pixelate_region), do: "pixelate_region"

  def to_url_string({:pixelate_region, size}) when size <= 200 and size >= 1 do
    "pixelate_region:#{size}"
  end

  @typedoc """
  The generating a preview.

  Options:
  * `:duration` - the duration in seconds.
  * `:max_segments` - the maximum number of segments.
  * `:min_segment_duration` - the minimum duration for each segment in seconds.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:preview)
      "preview"

      iex> #{__MODULE__}.to_url_string({:preview, duration: 8})
      "preview:duration_8"

      iex> #{__MODULE__}.to_url_string({:preview, max_segments: 6})
      "preview:max_seg_6"

      iex> #{__MODULE__}.to_url_string({:preview, min_segment_duration: 2})
      "preview:min_seg_dur_2"

      iex> #{__MODULE__}.to_url_string({:preview, duration: 20, max_segments: 7})
      "preview:duration_20:max_seg_7"

      iex> #{__MODULE__}.to_url_string({:preview, duration: 12, min_segment_duration: 3})
      "preview:duration_12:min_seg_dur_3"

      iex> #{__MODULE__}.to_url_string({:preview, max_segments: 2, min_segment_duration: 2})
      "preview:max_seg_2:min_seg_dur_2"

      iex> #{__MODULE__}.to_url_string({:preview, duration: 12, max_segments: 3, min_segment_duration: 3})
      "preview:duration_12:max_seg_3:min_seg_dur_3"
  """
  @type preview :: :preview | {:preview, keyword | map}
  def to_url_string(:preview), do: "preview"

  def to_url_string({:preview, options}) when is_list(options) do
    to_url_string({:preview, Enum.into(options, %{})})
  end

  def to_url_string({:preview, options}) when is_map(options) do
    __MODULE__.Preview.to_url_string(options)
  end

  @typedoc """
  The adding a progressbar.

  Options:
  * `:type` - `:frame` or `:bar`.
  * `:color` - a `t:String.t/0` as a color name or an `t:integer/0` as a RGB hex triplet.
  * `:width` - a positive number.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:progressbar)
      "progressbar"

      iex> #{__MODULE__}.to_url_string({:progressbar, type: :frame})
      "progressbar:frame"

      iex> #{__MODULE__}.to_url_string({:progressbar, color: 'E8F7D4'})
      "progressbar:color_E8F7D4"

      iex> #{__MODULE__}.to_url_string({:progressbar, width: 12})
      "progressbar:width_12"

      iex> #{__MODULE__}.to_url_string({:progressbar, type: :frame, color: "green"})
      "progressbar:frame:green"

      iex> #{__MODULE__}.to_url_string({:progressbar, type: :frame, width: 4})
      "progressbar:type_frame:width_4"

      iex> #{__MODULE__}.to_url_string({:progressbar, color: 'abaf40', width: 6})
      "progressbar:color_abaf40:width_6"

      iex> #{__MODULE__}.to_url_string({:progressbar, type: :frame, color: "blue", width: 8})
      "progressbar:frame:blue:8"
  """
  @type progressbar :: :progressbar | {:progressbar, keyword | map}
  def to_url_string(:progressbar), do: "progressbar"

  def to_url_string({:progressbar, options}) when is_list(options) do
    to_url_string({:progressbar, Enum.into(options, %{})})
  end

  def to_url_string({:progressbar, options}) when is_map(options) do
    __MODULE__.Progressbar.to_url_string(options)
  end

  @typedoc """
  The replacing color with a rgb(a) matrix.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string({:recolor, {{0.3, 0.7, 0.1}, {0.3, 0.6, 0.1}, {0.2, 0.5, 0.1}}})
      "recolor:0.3:0.7:0.1:0.3:0.6:0.1:0.2:0.5:0.1"

      iex> #{__MODULE__}.to_url_string({:recolor, {{0.3, 0.7, 0.1, 0.4}, {0.3, 0.6, 0.1, 0.2}, {0.2, 0.5, 0.1, 0.6}, {0.8, 0.7, 0.4, 0.3}}})
      "recolor:0.3:0.7:0.1:0.4:0.3:0.6:0.1:0.2:0.2:0.5:0.1:0.6:0.8:0.7:0.4:0.3"
  """
  @type recolor ::
          {:recolor,
           {{float | 0 | 1, float | 0 | 1, float | 0 | 1},
            {float | 0 | 1, float | 0 | 1, float | 0 | 1},
            {float | 0 | 1, float | 0 | 1, float | 0 | 1}}
           | {{float | 0 | 1, float | 0 | 1, float | 0 | 1, float | 0 | 1},
              {float | 0 | 1, float | 0 | 1, float | 0 | 1, float | 0 | 1},
              {float | 0 | 1, float | 0 | 1, float | 0 | 1, float | 0 | 1},
              {float | 0 | 1, float | 0 | 1, float | 0 | 1, float | 0 | 1}}}
  def to_url_string({:recolor, {{a, b, c}, {d, e, f}, {g, h, i}}})
      when a <= 1 and a >= 0 and b <= 1 and b >= 0 and c <= 1 and c >= 0 and
             d <= 1 and d >= 0 and e <= 1 and e >= 0 and f <= 1 and f >= 0 and
             g <= 1 and g >= 0 and h <= 1 and h >= 0 and i <= 1 and i >= 0 do
    "recolor:#{a}:#{b}:#{c}:#{d}:#{e}:#{f}:#{g}:#{h}:#{i}"
  end

  def to_url_string({:recolor, {{a, b, c, d}, {e, f, g, h}, {i, j, k, l}, {m, n, o, p}}})
      when a <= 1 and a >= 0 and b <= 1 and b >= 0 and c <= 1 and c >= 0 and d <= 1 and d >= 0 and
             e <= 1 and e >= 0 and f <= 1 and f >= 0 and g <= 1 and g >= 0 and h <= 1 and h >= 0 and
             i <= 1 and i >= 0 and j <= 1 and j >= 0 and k <= 1 and k >= 0 and l <= 1 and l >= 0 and
             m <= 1 and m >= 0 and n <= 1 and n >= 0 and o <= 1 and o >= 0 and p <= 1 and p >= 0 do
    "recolor:#{a}:#{b}:#{c}:#{d}:#{e}:#{f}:#{g}:#{h}:#{i}:#{j}:#{k}:#{l}:#{m}:#{n}:#{o}:#{p}"
  end

  @typedoc """
  The red channel adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string({:red, 50})
      "red:50"
  """
  @type red :: :red | {:red, -100..100 | float}
  def to_url_string(:red), do: "red"

  def to_url_string({:red, adjustment}) when adjustment <= 100 and adjustment >= -100 do
    "red:#{adjustment}"
  end

  @typedoc """
  The removing redeyes.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string()
      "redeye"
  """
  @type redeye :: :redeye
  def to_url_string(:redeye), do: "redeye"

  @typedoc """
  The replacing color.

  Options:
  * `:to_color` - the target output color.
  * `:tolerance` - the tolerance threshold from the input color.
  * `:from_color` - the base input color.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#color_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(to_color: 'af2b4c')
      "replace_color:af2b4c"

      iex> #{__MODULE__}.to_url_string(to_color: "saddlebrown", tolerance: 30)
      "replace_color:saddlebrown:30"

      iex> #{__MODULE__}.to_url_string(to_color: '2F4F4F', tolerance: 20)
      "replace_color:2f4f4f:20"

      iex> #{__MODULE__}.to_url_string(to_color: "silver", tolerance: 60, from_color: '89B8ED')
      "replace_color:silver:60:89b8ed"

      iex> #{__MODULE__}.to_url_string(to_color: "gray", tolerance: 60, from_color: "blue")
      "replace_color:gray:60:blue"
  """
  @type replace_color :: {:replace_color, keyword | map}
  def to_url_string({:replace_color, options}) when is_list(options) do
    to_url_string({:replace_color, Enum.into(options, %{})})
  end

  def to_url_string({:replace_color, options}) when is_map(options) do
    __MODULE__.ReplaceColor.to_url_string(options)
  end

  @typedoc """
  The generating a reverse playing video.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:reverse)
      "reverse"
  """
  @type reverse :: :reverse
  def to_url_string(:reverse), do: "reverse"

  @typedoc """
  The color saturation adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:saturation)
      "saturation"

      iex> #{__MODULE__}.to_url_string({:saturation, 70})
      "saturation:70"
  """
  @type saturation :: :saturation | {:saturation, -100..100}
  def to_url_string(:saturation), do: "saturation"

  def to_url_string({:saturation, adjustment}) when adjustment <= 100 and adjustment >= -100 do
    "saturation:#{adjustment}"
  end

  @typedoc """
  The screen blending with the overlay image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:screen)
      "screen"
  """
  @type screen :: :screen
  def to_url_string(:screen), do: "screen"

  @typedoc """
  The sepia effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:sepia)
      "sepia"

      iex> #{__MODULE__}.to_url_string({:sepia, 50})
      "sepia:50"
  """
  @type sepia :: :sepia | {:sepia, 1..100 | float}
  def to_url_string(:sepia), do: "sepia"

  def to_url_string({:sepia, strength}) when strength <= 100 and strength >= 1 do
    "sepia:#{strength}"
  end

  @typedoc """
  The shadow effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter  
  * https://cloudinary.com/documentation/image_transformations#image_shape_changes_and_distortion_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:shadow)
      "shadow"

      iex> #{__MODULE__}.to_url_string({:shadow, 50})
      "shadow:50"
  """
  @type shadow :: :shadow | {:shadow, 0..100 | float}
  def to_url_string(:shadow), do: "shadow"

  def to_url_string({:shadow, strength}) when strength <= 100 and strength >= 0 do
    "shadow:#{strength}"
  end

  @typedoc """
  The sharpening filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:sharpen)
      "sharpen"

      iex> #{__MODULE__}.to_url_string({:sharpen, 400})
      "sharpen:400"
  """
  @type sharpen :: :sharpen | {:sharpen, 1..2000 | float}
  def to_url_string(:sharpen), do: "sharpen"

  def to_url_string({:sharpen, strength}) when strength <= 2000 and strength >= 1 do
    "sharpen:#{strength}"
  end

  @typedoc """
  The skewing effect.

  Options:
  * `:x` - skewing degrees on the x-axis.
  * `:y` - skewing degrees on the y-axis.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(x: 20)
      "shear:20:0"
  """
  @type shear :: {:shear, keyword | map}
  def to_url_string({:shear, options}) when is_list(options) do
    to_url_string({:shear, Enum.into(options, %{})})
  end

  def to_url_string({:shear, options}) when is_map(options) do
    __MODULE__.Shear.to_url_string(options)
  end

  @typedoc """
  The simulating color blind condition.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:simulate_colorblind)
      "simulate_colorblind"

      iex> #{__MODULE__}.to_url_string({:simulate_colorblind, :tritanomaly})
      "simulate_colorblind:tritanomaly"
  """
  @type simulate_colorblind ::
          :simulate_colorblind
          | {:simulate_colorblind,
             :deuteranopia
             | :protanopia
             | :tritanopia
             | :tritanomaly
             | :deuteranomaly
             | :cone_monochromacy
             | :rod_monochromacy}
  def to_url_string(:simulate_colorblind), do: "simulate_colorblind"

  def to_url_string({:simulate_colorblind, mode})
      when mode in [
             :deuteranopia,
             :protanopia,
             :tritanopia,
             :tritanomaly,
             :deuteranomaly,
             :cone_monochromacy,
             :rod_monochromacy
           ] do
    "simulate_colorblind:#{mode}"
  end

  @typedoc """
  The style transfer effect.

  Options:
  * `:preserve_color` - A `t:as_boolean/1` representing either retains the original colors or not.
  * `:style_strength` - A `t:number/0` between 0 to 100.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/neural_artwork_style_transfer_addon
  ## Example
      iex> #{__MODULE__}.to_url_string(:style_transfer)
      "style_transfer"

      iex> #{__MODULE__}.to_url_string({:style_transfer, style_strength: 60})
      "style_transfer:60"

      iex> #{__MODULE__}.to_url_string({:style_transfer, preserve_color: true, style_strength: 40})
      "style_transfer:preserve_color:40"
  """
  @type style_transfer :: :style_transfer | {:style_transfer, keyword | map}
  def to_url_string(:style_transfer), do: "style_transfer"

  def to_url_string({:style_transfer, options}) when is_list(options) do
    to_url_string({:style_transfer, Enum.into(options, %{})})
  end

  def to_url_string({:style_transfer, options}) when is_map(options) do
    __MODULE__.StyleTransfer.to_url_string(options)
  end

  @typedoc """
  The tint effect.

  Options:
  * `:amount` - A `t:number/0` between 0 and 100.
  * `:color` - A `t:String.t/0` as a color name, an `t:charlist/0` as a RGB hex triplet, or a
    `t:tuple/0` with a color and a `t:number/0` to adjust positions of the blend. It also can be a
    `t:list/0` of colors or a `t:list/0` of color and position `t:tuple/0`s.
  * `:equalize` - A `t:as_boolean/1` representing either equalize colors before tinting or not.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#tint_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:tint)
      "tint"

      iex> #{__MODULE__}.to_url_string({:tint, amount: 80})
      "tint:80"

      iex> #{__MODULE__}.to_url_string({:tint, amount: 80, color: ["blue", "green", '47DA8B']})
      "tint:80:blue:green:rgb:47DA8B"

      iex> #{__MODULE__}.to_url_string({:tint, amount: 50, color: [{'6F71EA', 40}, {"yellow", 35}]})
      "tint:50:rgb:6F71EA:40p:yellow:35p"

      iex> #{__MODULE__}.to_url_string({:tint, equalize: true, amount: 80, color: "green"})
      "tint:equalize:80:green"

      iex> #{__MODULE__}.to_url_string({:tint, equalize: false, amount: 80, color: {"green", 60})
      "tint:equalize:80:green:60p"
  """
  @type tint :: :tint | {:tint, keyword | map}
  def to_url_string(:tint), do: "tint"

  def to_url_string({:tint, options}) when is_list(options) do
    to_url_string({:tint, Enum.into(options, %{})})
  end

  def to_url_string({:tint, options}) when is_map(options) do
    __MODULE__.Tint.to_url_string(options)
  end

  @typedoc """
  The transition effect.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:transition)
      "transition"
  """
  @type transition :: :transition
  def to_url_string(:transition), do: "transition"

  @typedoc """
  The edge trimming effect.

  Options:
  * `:color_similarity` - A `t:number/0` between 0 and 100 as the tolerance level.
  * `:color_override` - A `t:String.t/0` as a color name or an `t:charlist/0` as a RGB(A) hex
    triplet.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:trim)
      "trim"

      iex> #{__MODULE__}.to_url_string({:trim, color_similarity: 30, color_override: "white"})
      "trim:30:white"

      iex> #{__MODULE__}.to_url_string({:trim, color_similarity: 30, color_override: 'E8D9AA'})
      "trim:30:rgb:E8D9AA"

      iex> #{__MODULE__}.to_url_string({:trim, color_similarity: 40})
      "trim:40"

      iex> #{__MODULE__}.to_url_string({:trim, color_override: 'A674B3D0'})
      "trim:10:rgb:A674B3D0"
  """
  @type trim :: :trim | {:trim, keyword | map}
  def to_url_string(:trim), do: "trim"

  def to_url_string({:trim, options}) when is_list(options) do
    to_url_string({:trim, Enum.into(options, %{})})
  end

  def to_url_string({:trim, options}) when is_map(options) do
    __MODULE__.Trim.to_url_string(options)
  end

  @typedoc """
  The unsharp mask filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:unsharp_mask)
      "unsharp_mask"

      iex> #{__MODULE__}.to_url_string({:unsharp_mask, 200})
      "unsharp_mask:200"
  """
  @type unsharp_mask :: :unsharp_mask | {:unsharp_mask, 1..2000 | float}
  def to_url_string(:unsharp_mask), do: "unsharp_mask"

  def to_url_string({:unsharp_mask, strength}) when strength <= 2000 and strength >= 1 do
    "unsharp_mask:#{strength}"
  end

  @typedoc """
  The vectorization.

  Options:
  * `:colors` - An `t:integer/0` representing number of colors in range between 2 and 30.
  * `:detail` - A `t:float/0` between 0.0 to 1.0 as a percentage or an `t:integer/0` between 0 to
    1000 as an absolute number of pixels.
  * `:despeckle` - A `t:float/0` between 0.0 to 1.0 as a percentage or an `t:integer/0` between 0
    to 100 as an absolute number of pixels.
  * `:paths` - A `t:number/0` representing bezier curve optimization in range between 0 to 100.
  * `:corners` - A `t:number/0` representing corner threshold parameter in range between 0 to 100. 
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:vectorize)
      "vectorize"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 3})
      "vectorize:3"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 3, detail: 0.5})
      "vectorize:3:0.5"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 3, detail: 550, despeckle: 60})
      "vectorize:3:550:60"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 3, detail: 550, despeckle: 0.4, paths: 20})
      "vectorize:3:550:0.4:20"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 3, detail: 550, despeckle: 0.4, paths: 20, corners: 40})
      "vectorize:3:550:0.4:20:40"

      iex> #{__MODULE__}.to_url_string({:vectorize, detail: 550, despeckle: 0.3, paths: 20, corners: 40})
      "vectorize:detail:550:despeckle:0.3:paths:20:corners:40"

      iex> #{__MODULE__}.to_url_string({:vectorize, colors: 6, detail: 0.5, despeckle: 30, corners: 40})
      "vectorize:colors:6:detail:0.5:despeckle:30:corners:40"
  """
  @type vectorize :: :vectorize | {:vectorize, keyword | map}
  def to_url_string(:vectorize), do: "vectorize"

  def to_url_string({:vectorize, options}) when is_list(options) do
    to_url_string({:vectorize, Enum.into(options, %{})})
  end

  def to_url_string({:vectorize, options}) when is_map(options) do
    __MODULE__.Vectorize.to_url_string(options)
  end

  @typedoc """
  The vibrance filter.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(:vibrance)
      "vibrance"

      iex> #{__MODULE__}.to_url_string({:vibrance, 70})
      "vibrance:70"
  """
  @type vibrance :: :vibrance | {:vibrance, -100..100 | float}
  def to_url_string(:vibrance), do: "vibrance"

  def to_url_string({:vibrance, strength}) when strength <= 100 and strength >= 100 do
    "vibrance:#{strength}"
  end

  @typedoc """
  The automatic image enhancement.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/viesus_automatic_image_enhancement_addon
  ## Example
      iex> #{__MODULE__}.to_url_string(:viesus_correct)
      "viesus_correct"
  """
  @type viesus_correct :: :viesus_correct
  def to_url_string(:viesus_correct), do: "viesus_correct"

  @typedoc """
  The vignette effect.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string(:vignette)
      "vignette"

      iex> #{__MODULE__}.to_url_string({:vignette, 30})
      "vignette:30"
  """
  @type vignette :: :vignette | {:vignette, 0..100 | float}
  def to_url_string(:vignette), do: "vignette"

  def to_url_string({:vignette, strength}) when strength <= 100 and strength >= 0 do
    "vignette:#{strength}"
  end

  @typedoc """
  The volume adjustment.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> #{__MODULE__}.to_url_string({:volume, 70})
      "volume:70"

      iex> #{__MODULE__}.to_url_string({:volume, {-10, :decibels}})
      "volume:-10dB"

      iex> #{__MODULE__}.to_url_string({:volume, :mute})
      "volume:mute"
  """
  @type volume :: {:volume, -100..400 | float | {number, :decibels} | :mute}
  def to_url_string({:volume, :mute}), do: "volume:mute"

  def to_url_string({:volume, percents}) when percents <= 400 and percents >= -100 do
    "volume:#{percents}"
  end

  def to_url_string({:volume, {db, :decibels}}) when is_integer(db) or is_float(db) do
    "volume:#{db}dB"
  end
end
