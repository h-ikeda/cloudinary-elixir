defmodule Cloudinary.Transformation.EffectTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Effect
  doctest Effect

  describe "to_url_string/1" do
    test "converts the :accelerate" do
      assert Effect.to_url_string(:accelerate) == "accelerate"
    end

    test "converts the :accelerate with an integer" do
      assert Effect.to_url_string({:accelerate, -10}) == "accelerate:-10"
    end

    test "converts the :accelerate with a float" do
      assert Effect.to_url_string({:accelerate, 28.5}) == "accelerate:28.5"
    end

    test "converts the :adv_redeye" do
      assert Effect.to_url_string(:adv_redeye) == "adv_redeye"
    end

    test "converts the :anti_removal" do
      assert Effect.to_url_string(:anti_removal) == "anti_removal"
    end

    test "converts the :anti_removal with an integer" do
      assert Effect.to_url_string({:anti_removal, 40}) == "anti_removal:40"
    end

    test "converts the :anti_removal with a float" do
      assert Effect.to_url_string({:anti_removal, 30.5}) == "anti_removal:30.5"
    end

    test "converts the :art with an atom" do
      assert Effect.to_url_string({:art, :hokusai}) == "art:hokusai"
    end

    test "converts the :assist_colorblind" do
      assert Effect.to_url_string(:assist_colorblind) == "assist_colorblind"
    end

    test "converts the :assist_colorblind with an integer" do
      assert Effect.to_url_string({:assist_colorblind, 10}) == "assist_colorblind:10"
    end

    test "converts the :assist_colorblind with a float" do
      assert Effect.to_url_string({:assist_colorblind, 28.5}) == "assist_colorblind:28.5"
    end

    test "converts the :assist_colorblind with the :xray" do
      assert Effect.to_url_string({:assist_colorblind, :xray}) == "assist_colorblind:xray"
    end

    test "converts the :auto_brightness" do
      assert Effect.to_url_string(:auto_brightness) == "auto_brightness"
    end

    test "converts the :auto_brightness with an integer" do
      assert Effect.to_url_string({:auto_brightness, 40}) == "auto_brightness:40"
    end

    test "converts the :auto_brightness with a float" do
      assert Effect.to_url_string({:auto_brightness, 30.5}) == "auto_brightness:30.5"
    end

    test "converts the :auto_color" do
      assert Effect.to_url_string(:auto_color) == "auto_color"
    end

    test "converts the :auto_color with an integer" do
      assert Effect.to_url_string({:auto_color, 40}) == "auto_color:40"
    end

    test "converts the :auto_color with a float" do
      assert Effect.to_url_string({:auto_color, 30.5}) == "auto_color:30.5"
    end

    test "converts the :auto_contrast" do
      assert Effect.to_url_string(:auto_contrast) == "auto_contrast"
    end

    test "converts the :auto_contrast with an integer" do
      assert Effect.to_url_string({:auto_contrast, 40}) == "auto_contrast:40"
    end

    test "converts the :auto_contrast with a float" do
      assert Effect.to_url_string({:auto_contrast, 30.5}) == "auto_contrast:30.5"
    end

    test "converts the :background_removal" do
      assert Effect.to_url_string(:background_removal) == "bgremoval"
    end

    test "converts the :background_removal with the :screen" do
      assert Effect.to_url_string({:background_removal, :screen}) == "bgremoval:screen"
    end

    test "converts the :background_removal with a hex triplet color" do
      assert Effect.to_url_string({:background_removal, '64AF3C'}) == "bgremoval:64AF3C"
    end

    test "converts the :background_removal with a hex triplet color and the :screen" do
      assert Effect.to_url_string({:background_removal, {'64AF3C', :screen}}) ==
               "bgremoval:screen:64AF3C"
    end

    test "converts the :blackwhite" do
      assert Effect.to_url_string(:blackwhite) == "blackwhite"
    end

    test "converts the :blue" do
      assert Effect.to_url_string(:blue) == "blue"
    end

    test "converts the :blue with an integer" do
      assert Effect.to_url_string({:blue, -10}) == "blue:-10"
    end

    test "converts the :blue with a float" do
      assert Effect.to_url_string({:blue, 28.5}) == "blue:28.5"
    end

    test "converts the :blur" do
      assert Effect.to_url_string(:blur) == "blur"
    end

    test "converts the :blur with an integer" do
      assert Effect.to_url_string({:blur, 10}) == "blur:10"
    end

    test "converts the :blur with a float" do
      assert Effect.to_url_string({:blur, 28.5}) == "blur:28.5"
    end

    test "converts the :blur_faces" do
      assert Effect.to_url_string(:blur_faces) == "blur_faces"
    end

    test "converts the :blur_faces with an integer" do
      assert Effect.to_url_string({:blur_faces, 10}) == "blur_faces:10"
    end

    test "converts the :blur_faces with a float" do
      assert Effect.to_url_string({:blur_faces, 28.5}) == "blur_faces:28.5"
    end

    test "converts the :blur_region" do
      assert Effect.to_url_string(:blur_region) == "blur_region"
    end

    test "converts the :blur_region with an integer" do
      assert Effect.to_url_string({:blur_region, 10}) == "blur_region:10"
    end

    test "converts the :blur_region with a float" do
      assert Effect.to_url_string({:blur_region, 28.5}) == "blur_region:28.5"
    end

    test "converts the :boomerang" do
      assert Effect.to_url_string(:boomerang) == "boomerang"
    end

    test "converts the :brightness" do
      assert Effect.to_url_string(:brightness) == "brightness"
    end

    test "converts the :brightness with an integer" do
      assert Effect.to_url_string({:brightness, -10}) == "brightness:-10"
    end

    test "converts the :brightness with a float" do
      assert Effect.to_url_string({:brightness, 28.5}) == "brightness:28.5"
    end

    test "converts the :brightness_hsb" do
      assert Effect.to_url_string(:brightness_hsb) == "brightness_hsb"
    end

    test "converts the :brightness_hsb with an integer" do
      assert Effect.to_url_string({:brightness_hsb, -10}) == "brightness_hsb:-10"
    end

    test "converts the :brightness_hsb with a float" do
      assert Effect.to_url_string({:brightness_hsb, 28.5}) == "brightness_hsb:28.5"
    end

    test "converts the :cartoonify" do
      assert Effect.to_url_string(:cartoonify) == "cartoonify"
    end

    test "converts the :cartoonify with a line_strength option" do
      assert Effect.to_url_string({:cartoonify, line_strength: 11}) == "cartoonify:11"
    end

    test "converts the :cartoonify with a color_reduction option" do
      assert Effect.to_url_string({:cartoonify, color_reduction: 55}) == "cartoonify:50:55"
    end

    test "converts the :cartoonify with the :blackwhite color_reduction option" do
      assert Effect.to_url_string({:cartoonify, color_reduction: :blackwhite}) ==
               "cartoonify:50:bw"
    end

    test "converts the :cartoonify with line_strength and color_reduction options" do
      assert Effect.to_url_string({:cartoonify, line_strength: 11, color_reduction: 55}) ==
               "cartoonify:11:55"
    end

    test "converts the :cartoonify with line_strength and :blackwhite color_reduction options" do
      assert Effect.to_url_string({:cartoonify, line_strength: 11, color_reduction: :blackwhite}) ==
               "cartoonify:11:bw"
    end

    test "converts the :colorize" do
      assert Effect.to_url_string(:colorize) == "colorize"
    end

    test "converts the :colorize with an integer" do
      assert Effect.to_url_string({:colorize, 10}) == "colorize:10"
    end

    test "converts the :colorize with a float" do
      assert Effect.to_url_string({:colorize, 28.5}) == "colorize:28.5"
    end

    test "converts the :contrast" do
      assert Effect.to_url_string(:contrast) == "contrast"
    end

    test "converts the :contrast with an integer" do
      assert Effect.to_url_string({:contrast, -10}) == "contrast:-10"
    end

    test "converts the :contrast with a float" do
      assert Effect.to_url_string({:contrast, 28.5}) == "contrast:28.5"
    end

    test "converts the :cut_out" do
      assert Effect.to_url_string(:cut_out) == "cut_out"
    end

    test "converts the :deshake" do
      assert Effect.to_url_string(:deshake) == "deshake"
    end

    test "converts the :deshake with an integer" do
      assert Effect.to_url_string({:deshake, 32}) == "deshake:32"
    end

    test "converts the :displace" do
      assert Effect.to_url_string(:displace) == "displace"
    end

    test "converts the :distort with a tuple containing four tuples of coodinates" do
      assert Effect.to_url_string({:distort, {{5, 34}, {70, 10}, {70, 75}, {5, 55}}}) ==
               "distort:5:34:70:10:70:75:5:55"
    end

    test "converts the :distort with a tuple containing the :arc and an integer" do
      assert Effect.to_url_string({:distort, {:arc, 12}}) == "distort:arc:12"
    end

    test "converts the :distort with a tuple containing the :arc and a float" do
      assert Effect.to_url_string({:distort, {:arc, 12.5}}) == "distort:arc:12.5"
    end

    test "converts the :fade" do
      assert Effect.to_url_string(:fade) == "fade"
    end

    test "converts the :fade with an integer" do
      assert Effect.to_url_string({:fade, 2500}) == "fade:2500"
    end

    test "converts the :fade with a float" do
      assert Effect.to_url_string({:fade, 25.5}) == "fade:25.5"
    end

    test "converts the :fill_light" do
      assert Effect.to_url_string(:fill_light) == "fill_light"
    end

    test "converts the :fill_light with an amount option" do
      assert Effect.to_url_string({:fill_light, amount: 40}) == "fill_light:40"
    end

    test "converts the :fill_light with an bias option" do
      assert Effect.to_url_string({:fill_light, bias: -40}) == "fill_light:100:-40"
    end

    test "converts the :fill_light with amount and bias options" do
      assert Effect.to_url_string({:fill_light, amount: 60, bias: 30}) == "fill_light:60:30"
    end

    test "converts the :gamma" do
      assert Effect.to_url_string(:gamma) == "gamma"
    end

    test "converts the :gamma with an integer" do
      assert Effect.to_url_string({:gamma, 60}) == "gamma:60"
    end

    test "converts the :gamma with a float" do
      assert Effect.to_url_string({:gamma, -25.5}) == "gamma:-25.5"
    end

    test "converts the :gradient_fade" do
      assert Effect.to_url_string(:gradient_fade) == "gradient_fade"
    end

    test "converts the :gradient_fade with an integer" do
      assert Effect.to_url_string({:gradient_fade, 20}) == "gradient_fade:20"
    end

    test "converts the :gradient_fade with a float" do
      assert Effect.to_url_string({:gradient_fade, 25.5}) == "gradient_fade:25.5"
    end

    test "converts the :gradient_fade with an atom" do
      assert Effect.to_url_string({:gradient_fade, :symmetric}) == "gradient_fade:symmetric"
    end

    test "converts the :gradient_fade with a tuple of integer and atom" do
      assert Effect.to_url_string({:gradient_fade, {64, :symmetric}}) ==
               "gradient_fade:symmetric:64"
    end

    test "converts the :gradient_fade with a tuple of float and atom" do
      assert Effect.to_url_string({:gradient_fade, {63.5, :symmetric}}) ==
               "gradient_fade:symmetric:63.5"
    end

    test "converts the :grayscale" do
      assert Effect.to_url_string(:grayscale) == "grayscale"
    end

    test "converts the :green" do
      assert Effect.to_url_string(:green) == "green"
    end

    test "converts the :green with an integer" do
      assert Effect.to_url_string({:green, 60}) == "green:60"
    end

    test "converts the :green with a float" do
      assert Effect.to_url_string({:green, -10.5}) == "green:-10.5"
    end

    test "converts the :hue" do
      assert Effect.to_url_string(:hue) == "hue"
    end

    test "converts the :hue with an integer" do
      assert Effect.to_url_string({:hue, 60}) == "hue:60"
    end

    test "converts the :hue with a float" do
      assert Effect.to_url_string({:hue, -10.5}) == "hue:-10.5"
    end

    test "converts the :improve" do
      assert Effect.to_url_string(:improve) == "improve"
    end

    test "converts the :improve with a mode option" do
      assert Effect.to_url_string({:improve, mode: :indoor}) == "improve:indoor"
    end

    test "converts the :improve with a blend option" do
      assert Effect.to_url_string({:improve, blend: 35}) == "improve:35"
    end

    test "converts the :improve with mode and blend options" do
      assert Effect.to_url_string({:improve, mode: :indoor, blend: 35.5}) == "improve:indoor:35.5"
    end

    test "converts the :loop with an integer" do
      assert Effect.to_url_string({:loop, 2}) == "loop:2"
    end

    test "converts the :make_transparent" do
      assert Effect.to_url_string(:make_transparent) == "make_transparent"
    end

    test "converts the :make_transparent with an integer" do
      assert Effect.to_url_string({:make_transparent, 60}) == "make_transparent:60"
    end

    test "converts the :make_transparent with a float" do
      assert Effect.to_url_string({:make_transparent, 10.5}) == "make_transparent:10.5"
    end

    test "converts the :multiply" do
      assert Effect.to_url_string(:multiply) == "multiply"
    end

    test "converts the :negate" do
      assert Effect.to_url_string(:negate) == "negate"
    end

    test "converts the :noise" do
      assert Effect.to_url_string(:noise) == "noise"
    end

    test "converts the :noise with an integer" do
      assert Effect.to_url_string({:noise, 60}) == "noise:60"
    end

    test "converts the :noise with a float" do
      assert Effect.to_url_string({:noise, 10.5}) == "noise:10.5"
    end

    test "converts the :oil_paint" do
      assert Effect.to_url_string(:oil_paint) == "oil_paint"
    end

    test "converts the :oil_paint with an integer" do
      assert Effect.to_url_string({:oil_paint, 60}) == "oil_paint:60"
    end

    test "converts the :oil_paint with a float" do
      assert Effect.to_url_string({:oil_paint, 10.5}) == "oil_paint:10.5"
    end

    test "converts the :opacity_threshold" do
      assert Effect.to_url_string(:opacity_threshold) == "opacity_threshold"
    end

    test "converts the :opacity_threshold with an integer" do
      assert Effect.to_url_string({:opacity_threshold, 60}) == "opacity_threshold:60"
    end

    test "converts the :opacity_threshold with a float" do
      assert Effect.to_url_string({:opacity_threshold, 10.5}) == "opacity_threshold:10.5"
    end

    test "converts the :ordered_dither" do
      assert Effect.to_url_string(:ordered_dither) == "ordered_dither"
    end

    test "converts the :ordered_dither with an integer" do
      assert Effect.to_url_string({:ordered_dither, 6}) == "ordered_dither:6"
    end

    test "converts the :outline" do
      assert Effect.to_url_string(:outline) == "outline"
    end

    test "converts the :outline with a mode option" do
      assert Effect.to_url_string({:outline, mode: :inner}) == "outline:inner"
    end

    test "converts the :outline with a width option" do
      assert Effect.to_url_string({:outline, width: 8}) == "outline:8"
    end

    test "converts the :outline with a blur option" do
      assert Effect.to_url_string({:outline, blur: 8}) == "outline:5:8"
    end

    test "converts the :outline with mode and width options" do
      assert Effect.to_url_string({:outline, mode: :outer, width: 6}) == "outline:outer:6"
    end

    test "converts the :outline with mode and blur options" do
      assert Effect.to_url_string({:outline, mode: :inner_fill, blur: 8}) ==
               "outline:inner_fill:5:8"
    end

    test "converts the :outline with width and blur options" do
      assert Effect.to_url_string({:outline, width: 6, blur: 8}) == "outline:6:8"
    end

    test "converts the :outline with mode, width and blur options" do
      assert Effect.to_url_string({:outline, mode: :fill, width: 6, blur: 8}) ==
               "outline:fill:6:8"
    end

    test "converts the :overlay" do
      assert Effect.to_url_string(:overlay) == "overlay"
    end

    test "converts the :pixelate" do
      assert Effect.to_url_string(:pixelate) == "pixelate"
    end

    test "converts the :pixelate with an integer" do
      assert Effect.to_url_string({:pixelate, 6}) == "pixelate:6"
    end

    test "converts the :pixelate with a float" do
      assert Effect.to_url_string({:pixelate, 6.5}) == "pixelate:6.5"
    end

    test "converts the :pixelate_faces" do
      assert Effect.to_url_string(:pixelate_faces) == "pixelate_faces"
    end

    test "converts the :pixelate_faces with an integer" do
      assert Effect.to_url_string({:pixelate_faces, 6}) == "pixelate_faces:6"
    end

    test "converts the :pixelate_faces with a float" do
      assert Effect.to_url_string({:pixelate_faces, 6.5}) == "pixelate_faces:6.5"
    end

    test "converts the :pixelate_region" do
      assert Effect.to_url_string(:pixelate_region) == "pixelate_region"
    end

    test "converts the :pixelate_region with an integer" do
      assert Effect.to_url_string({:pixelate_region, 6}) == "pixelate_region:6"
    end

    test "converts the :pixelate_region with a float" do
      assert Effect.to_url_string({:pixelate_region, 6.5}) == "pixelate_region:6.5"
    end

    test "converts the :preview" do
      assert Effect.to_url_string(:preview) == "preview"
    end

    test "converts the :preview with a duration option" do
      assert Effect.to_url_string({:preview, duration: 7.5}) == "preview:duration_7.5"
    end

    test "converts the :preview with a max_segments option" do
      assert Effect.to_url_string({:preview, max_segments: 4}) == "preview:max_seg_4"
    end

    test "converts the :preview with a min_segment_duration option" do
      assert Effect.to_url_string({:preview, min_segment_duration: 1.2}) ==
               "preview:min_seg_dur_1.2"
    end

    test "converts the :preview with duration and max_segments options" do
      assert Effect.to_url_string({:preview, duration: 7.5, max_segments: 4}) ==
               "preview:duration_7.5:max_seg_4"
    end

    test "converts the :preview with duration and min_segment_duration options" do
      assert Effect.to_url_string({:preview, duration: 7.5, min_segment_duration: 2}) ==
               "preview:duration_7.5:min_seg_dur_2"
    end

    test "converts the :preview with max_segments and min_segment_duration options" do
      assert Effect.to_url_string({:preview, max_segments: 4, min_segment_duration: 2}) ==
               "preview:max_seg_4:min_seg_dur_2"
    end

    test "converts the :preview with duration, max_segments and min_segment_duration options" do
      preview_options = [duration: 16, max_segments: 8, min_segment_duration: 2]

      assert Effect.to_url_string({:preview, preview_options}) ==
               "preview:duration_16:max_seg_8:min_seg_dur_2"
    end

    test "converts the :progressbar" do
      assert Effect.to_url_string(:progressbar) == "progressbar"
    end

    test "converts the :progressbar with a type option" do
      assert Effect.to_url_string({:progressbar, type: :frame}) == "progressbar:frame"
    end

    test "converts the :progressbar with a hex triplet color option" do
      assert Effect.to_url_string({:progressbar, color: '00254b'}) == "progressbar:color_00254b"
    end

    test "converts the :progressbar with a named color option" do
      assert Effect.to_url_string({:progressbar, color: "blue"}) == "progressbar:color_blue"
    end

    test "converts the :progressbar with a width option" do
      assert Effect.to_url_string({:progressbar, width: 12}) == "progressbar:width_12"
    end

    test "converts the :progressbar with type, hex triplet color and width option" do
      assert Effect.to_url_string({:progressbar, type: :frame, color: '00254b', width: 4}) ==
               "progressbar:frame:00254b:4"
    end

    test "converts the :recolor with a 3x3 tuple of tuples of floats" do
      assert Effect.to_url_string({:recolor, {{0.3, 0.7, 0.1}, {0.3, 0.6, 0.1}, {0.2, 0.5, 0.1}}}) ==
               "recolor:0.3:0.7:0.1:0.3:0.6:0.1:0.2:0.5:0.1"
    end

    test "converts the :recolor with a 4x4 tuple of tuples of floats" do
      assert Effect.to_url_string(
               {:recolor,
                {{0.3, 0.7, 0.1, 0.4}, {0.3, 0.6, 0.1, 0.2}, {0.2, 0.5, 0.1, 0.6},
                 {0.8, 0.7, 0.4, 0.3}}}
             ) ==
               "recolor:0.3:0.7:0.1:0.4:0.3:0.6:0.1:0.2:0.2:0.5:0.1:0.6:0.8:0.7:0.4:0.3"
    end

    test "converts the :red" do
      assert Effect.to_url_string(:red) == "red"
    end

    test "converts the :red with an integer" do
      assert Effect.to_url_string({:red, 60}) == "red:60"
    end

    test "converts the :red with a float" do
      assert Effect.to_url_string({:red, -10.5}) == "red:-10.5"
    end

    test "converts the :redeye" do
      assert Effect.to_url_string(:redeye) == "redeye"
    end

    test "converts the :replace_color with a hex triplet to_color option" do
      assert Effect.to_url_string({:replace_color, to_color: '8e426c'}) == "replace_color:8e426c"
    end

    test "converts the :replace_color with a named to_color option" do
      assert Effect.to_url_string({:replace_color, to_color: "brown"}) == "replace_color:brown"
    end

    test "converts the :replace_color with hex triplet to_color and tolerance options" do
      assert Effect.to_url_string({:replace_color, to_color: '8e426c', tolerance: 20}) ==
               "replace_color:8e426c:20"
    end

    test "converts the :replace_color with named to_color and tolerance options" do
      assert Effect.to_url_string({:replace_color, to_color: "brown", tolerance: 20}) ==
               "replace_color:brown:20"
    end

    test "converts the :replace_color with hex triplet to_color and from_color options" do
      assert Effect.to_url_string({:replace_color, to_color: '8e426c', from_color: '6c2b15'}) ==
               "replace_color:8e426c:50:6c2b15"
    end

    test "converts the :replace_color with named to_color and from_color options" do
      assert Effect.to_url_string({:replace_color, to_color: "brown", from_color: "yellow"}) ==
               "replace_color:brown:50:yellow"
    end

    test "converts the :replace_color with hex triplet to_color, from_color, and tolerance options" do
      replace_color_options = [to_color: '8e426c', from_color: '6c2b15', tolerance: 30.5]

      assert Effect.to_url_string({:replace_color, replace_color_options}) ==
               "replace_color:8e426c:30.5:6c2b15"
    end

    test "converts the :replace_color with named to_color, from_color, and tolerance options" do
      replace_color_options = [to_color: "brown", from_color: "yellow", tolerance: 62.8]

      assert Effect.to_url_string({:replace_color, replace_color_options}) ==
               "replace_color:brown:62.8:yellow"
    end

    test "converts the :reverse" do
      assert Effect.to_url_string(:reverse) == "reverse"
    end

    test "converts the :saturation" do
      assert Effect.to_url_string(:saturation) == "saturation"
    end

    test "converts the :saturation with an integer" do
      assert Effect.to_url_string({:saturation, 60}) == "saturation:60"
    end

    test "converts the :saturation with a float" do
      assert Effect.to_url_string({:saturation, -10.5}) == "saturation:-10.5"
    end

    test "converts the :screen" do
      assert Effect.to_url_string(:screen) == "screen"
    end

    test "converts the :sepia" do
      assert Effect.to_url_string(:sepia) == "sepia"
    end

    test "converts the :sepia with an integer" do
      assert Effect.to_url_string({:sepia, 60}) == "sepia:60"
    end

    test "converts the :sepia with a float" do
      assert Effect.to_url_string({:sepia, 10.5}) == "sepia:10.5"
    end

    test "converts the :shadow" do
      assert Effect.to_url_string(:shadow) == "shadow"
    end

    test "converts the :shadow with an integer" do
      assert Effect.to_url_string({:shadow, 60}) == "shadow:60"
    end

    test "converts the :shadow with a float" do
      assert Effect.to_url_string({:shadow, 10.5}) == "shadow:10.5"
    end

    test "converts the :sharpen" do
      assert Effect.to_url_string(:sharpen) == "sharpen"
    end

    test "converts the :sharpen with an integer" do
      assert Effect.to_url_string({:sharpen, 60}) == "sharpen:60"
    end

    test "converts the :sharpen with a float" do
      assert Effect.to_url_string({:sharpen, 10.5}) == "sharpen:10.5"
    end

    test "converts the :shear with an integer x option" do
      assert Effect.to_url_string({:shear, x: 12}) == "shear:12:0"
    end

    test "converts the :shear with an integer y option" do
      assert Effect.to_url_string({:shear, y: 11}) == "shear:0:11"
    end

    test "converts the :shear with a float x option" do
      assert Effect.to_url_string({:shear, x: 10.5}) == "shear:10.5:0"
    end

    test "converts the :shear with a float y option" do
      assert Effect.to_url_string({:shear, y: 10.5}) == "shear:0:10.5"
    end

    test "converts the :shear with integer x and y options" do
      assert Effect.to_url_string({:shear, x: 6, y: 11}) == "shear:6:11"
    end

    test "converts the :shear with float x and y options" do
      assert Effect.to_url_string({:shear, x: 10.5, y: 22.5}) == "shear:10.5:22.5"
    end

    test "converts the :simulate_colorblind" do
      assert Effect.to_url_string(:simulate_colorblind) == "simulate_colorblind"
    end

    test "converts the :simulate_colorblind with an atom" do
      assert Effect.to_url_string({:simulate_colorblind, :deuteranomaly}) ==
               "simulate_colorblind:deuteranomaly"
    end

    test "converts the :style_transfer" do
      assert Effect.to_url_string(:style_transfer) == "style_transfer"
    end

    test "converts the :style_transfer with a preserve_color option" do
      assert Effect.to_url_string({:style_transfer, preserve_color: true}) ==
               "style_transfer:preserve_color"
    end

    test "converts the :style_transfer with a style_strength option" do
      assert Effect.to_url_string({:style_transfer, style_strength: 40}) ==
               "style_transfer:40"
    end

    test "converts the :style_transfer with preserve_color and style_strength options" do
      assert Effect.to_url_string({:style_transfer, preserve_color: true, style_strength: 40.5}) ==
               "style_transfer:preserve_color:40.5"
    end

    test "converts the :tint" do
      assert Effect.to_url_string(:tint) == "tint"
    end

    test "converts the :tint with an amount option" do
      assert Effect.to_url_string({:tint, amount: 80}) == "tint:80"
    end

    test "converts the :tint with an equalize option" do
      assert Effect.to_url_string({:tint, equalize: true}) == "tint:equalize"
    end

    test "converts the :tint with a hex triplet color option" do
      assert Effect.to_url_string({:tint, color: '000000'}) == "tint:60:rgb:000000"
    end

    test "converts the :tint with a named color option" do
      assert Effect.to_url_string({:tint, color: "green"}) == "tint:60:green"
    end

    test "converts the :tint with a hex triplet color position option" do
      assert Effect.to_url_string({:tint, color: {'000000', 65}}) == "tint:60:rgb:000000:65p"
    end

    test "converts the :tint with a named color position option" do
      assert Effect.to_url_string({:tint, color: {"green", 65}}) == "tint:60:green:65p"
    end

    test "converts the :tint with a list of colors option" do
      assert Effect.to_url_string({:tint, color: ['01fe88', "blue"]}) == "tint:60:rgb:01fe88:blue"
    end

    test "converts the :tint with a list of color positions option" do
      assert Effect.to_url_string({:tint, color: [{'01fe88', 32}, {"blue", 64}]}) ==
               "tint:60:rgb:01fe88:32p:blue:64p"
    end

    test "converts the :tint with amount and equalize options" do
      assert Effect.to_url_string({:tint, amount: 80, equalize: true}) == "tint:equalize:80"
    end

    test "converts the :tint with hex triplet color and equalize options" do
      assert Effect.to_url_string({:tint, color: '01fe88', equalize: true}) ==
               "tint:equalize:60:rgb:01fe88"
    end

    test "converts the :tint with named color and equalize options" do
      assert Effect.to_url_string({:tint, color: "blue", equalize: true}) ==
               "tint:equalize:60:blue"
    end

    test "converts the :tint with hex triplet color position and equalize options" do
      assert Effect.to_url_string({:tint, color: {'01fe88', 32}, equalize: true}) ==
               "tint:equalize:60:rgb:01fe88:32p"
    end

    test "converts the :tint with named color position and equalize options" do
      assert Effect.to_url_string({:tint, color: {"blue", 64}, equalize: true}) ==
               "tint:equalize:60:blue:64p"
    end

    test "converts the :tint with list of colors and equalize options" do
      assert Effect.to_url_string({:tint, color: ["blue", '01fe88'], equalize: true}) ==
               "tint:equalize:60:blue:rgb:01fe88"
    end

    test "converts the :tint with list of color positions and equalize options" do
      assert Effect.to_url_string({:tint, color: [{"blue", 32}, {'01fe88', 64}], equalize: true}) ==
               "tint:equalize:60:blue:32p:rgb:01fe88:64p"
    end

    test "converts the :tint with hex triplet color and amount options" do
      assert Effect.to_url_string({:tint, color: '01fe88', amount: 85}) ==
               "tint:85:rgb:01fe88"
    end

    test "converts the :tint with named color and amount options" do
      assert Effect.to_url_string({:tint, color: "blue", amount: 85}) == "tint:85:blue"
    end

    test "converts the :tint with hex triplet color position and amount options" do
      assert Effect.to_url_string({:tint, color: {'01fe88', 32}, amount: 85}) ==
               "tint:85:rgb:01fe88:32p"
    end

    test "converts the :tint with named color position and amount options" do
      assert Effect.to_url_string({:tint, color: {"blue", 64}, amount: 85}) == "tint:85:blue:64p"
    end

    test "converts the :tint with list of colors and amount options" do
      assert Effect.to_url_string({:tint, color: ["blue", '01fe88'], amount: 85}) ==
               "tint:85:blue:rgb:01fe88"
    end

    test "converts the :tint with list of color positions and amount options" do
      assert Effect.to_url_string({:tint, color: [{"blue", 32}, {'01fe88', 64}], amount: 85}) ==
               "tint:85:blue:32p:rgb:01fe88:64p"
    end

    test "converts the :tint with equalize, hex triplet color and amount options" do
      assert Effect.to_url_string({:tint, equalize: true, color: '01fe88', amount: 85}) ==
               "tint:equalize:85:rgb:01fe88"
    end

    test "converts the :tint with equalize, named color and amount options" do
      assert Effect.to_url_string({:tint, equalize: true, color: "blue", amount: 85}) ==
               "tint:equalize:85:blue"
    end

    test "converts the :tint with equalize, hex triplet color position and amount options" do
      assert Effect.to_url_string({:tint, equalize: true, color: {'01fe88', 32}, amount: 85}) ==
               "tint:equalize:85:rgb:01fe88:32p"
    end

    test "converts the :tint with equalize, named color position and amount options" do
      assert Effect.to_url_string({:tint, equalize: true, color: {"blue", 64}, amount: 85}) ==
               "tint:equalize:85:blue:64p"
    end

    test "converts the :tint with equalize, list of colors and amount options" do
      assert Effect.to_url_string({:tint, equalize: true, color: ["blue", '01fe88'], amount: 85}) ==
               "tint:equalize:85:blue:rgb:01fe88"
    end

    test "converts the :tint with equalize, list of color positions and amount options" do
      tint_options = [equalize: true, color: [{"blue", 32}, {'01fe88', 64}], amount: 85]

      assert Effect.to_url_string({:tint, tint_options}) ==
               "tint:equalize:85:blue:32p:rgb:01fe88:64p"
    end

    test "converts the :transition" do
      assert Effect.to_url_string(:transition) == "transition"
    end

    test "converts the :trim" do
      assert Effect.to_url_string(:trim) == "trim"
    end

    test "converts the :trim with a color_similarity option" do
      assert Effect.to_url_string({:trim, color_similarity: 77}) == "trim:77"
    end

    test "converts the :trim with a hex triplet color_override option" do
      assert Effect.to_url_string({:trim, color_override: 'af2c6d'}) == "trim:10:rgb:af2c6d"
    end

    test "converts the :trim with a named color_override option" do
      assert Effect.to_url_string({:trim, color_override: "blue"}) == "trim:10:blue"
    end

    test "converts the :trim with color_similarity and hex triplet color_override options" do
      assert Effect.to_url_string({:trim, color_similarity: 30, color_override: 'af2c6d'}) ==
               "trim:30:rgb:af2c6d"
    end

    test "converts the :trim with color_similarity and named color_override options" do
      assert Effect.to_url_string({:trim, color_similarity: 30, color_override: "blue"}) ==
               "trim:30:blue"
    end

    test "converts the :unsharp_mask" do
      assert Effect.to_url_string(:unsharp_mask) == "unsharp_mask"
    end

    test "converts the :unsharp_mask with an integer" do
      assert Effect.to_url_string({:unsharp_mask, 77}) == "unsharp_mask:77"
    end

    test "converts the :unsharp_mask with a float" do
      assert Effect.to_url_string({:unsharp_mask, 76.5}) == "unsharp_mask:76.5"
    end

    test "converts the :vectorize" do
      assert Effect.to_url_string(:vectorize) == "vectorize"
    end

    test "converts the :vectorize with a colors option" do
      assert Effect.to_url_string({:vectorize, colors: 6}) == "vectorize:6"
    end

    test "converts the :vectorize with a detail option" do
      assert Effect.to_url_string({:vectorize, detail: 0.5}) == "vectorize:detail:0.5"
    end

    test "converts the :vectorize with a despeckle option" do
      assert Effect.to_url_string({:vectorize, despeckle: 0.6}) == "vectorize:despeckle:0.6"
    end

    test "converts the :vectorize with a paths option" do
      assert Effect.to_url_string({:vectorize, paths: 8}) == "vectorize:paths:8"
    end

    test "converts the :vectorize with a corners option" do
      assert Effect.to_url_string({:vectorize, corners: 20}) == "vectorize:corners:20"
    end

    test "converts the :vectorize with colors and detail options" do
      assert Effect.to_url_string({:vectorize, colors: 6, detail: 5}) == "vectorize:6:5"
    end

    test "converts the :vectorize with colors and despeckle options" do
      assert Effect.to_url_string({:vectorize, colors: 6, despeckle: 7}) ==
               "vectorize:colors:6:despeckle:7"
    end

    test "converts the :vectorize with colors and paths options" do
      assert Effect.to_url_string({:vectorize, colors: 6, paths: 8}) ==
               "vectorize:colors:6:paths:8"
    end

    test "converts the :vectorize with colors and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, corners: 20}) ==
               "vectorize:colors:6:corners:20"
    end

    test "converts the :vectorize with detail and despeckle options" do
      assert Effect.to_url_string({:vectorize, detail: 5, despeckle: 7}) ==
               "vectorize:detail:5:despeckle:7"
    end

    test "converts the :vectorize with detail and paths options" do
      assert Effect.to_url_string({:vectorize, detail: 5, paths: 8}) ==
               "vectorize:detail:5:paths:8"
    end

    test "converts the :vectorize with detail and corners options" do
      assert Effect.to_url_string({:vectorize, detail: 5, corners: 20}) ==
               "vectorize:detail:5:corners:20"
    end

    test "converts the :vectorize with despeckle and paths options" do
      assert Effect.to_url_string({:vectorize, despeckle: 7, paths: 8}) ==
               "vectorize:despeckle:7:paths:8"
    end

    test "converts the :vectorize with despeckle and corners options" do
      assert Effect.to_url_string({:vectorize, despeckle: 7, corners: 20}) ==
               "vectorize:despeckle:7:corners:20"
    end

    test "converts the :vectorize with paths and corners options" do
      assert Effect.to_url_string({:vectorize, paths: 8, corners: 20}) ==
               "vectorize:paths:8:corners:20"
    end

    test "converts the :vectorize with colors, detail and despeckle options" do
      assert Effect.to_url_string({:vectorize, colors: 6, detail: 5, despeckle: 7}) ==
               "vectorize:6:5:7"
    end

    test "converts the :vectorize with colors, detail and paths options" do
      assert Effect.to_url_string({:vectorize, colors: 6, detail: 5, paths: 8}) ==
               "vectorize:colors:6:detail:5:paths:8"
    end

    test "converts the :vectorize with colors, detail and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, detail: 5, corners: 20}) ==
               "vectorize:colors:6:detail:5:corners:20"
    end

    test "converts the :vectorize with colors, despeckle and paths options" do
      assert Effect.to_url_string({:vectorize, colors: 6, despeckle: 7, paths: 8}) ==
               "vectorize:colors:6:despeckle:7:paths:8"
    end

    test "converts the :vectorize with colors, despeckle and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, despeckle: 7, corners: 20}) ==
               "vectorize:colors:6:despeckle:7:corners:20"
    end

    test "converts the :vectorize with colors, paths and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, paths: 8, corners: 20}) ==
               "vectorize:colors:6:paths:8:corners:20"
    end

    test "converts the :vectorize with detail, despeckle and paths options" do
      assert Effect.to_url_string({:vectorize, detail: 5, despeckle: 7, paths: 8}) ==
               "vectorize:detail:5:despeckle:7:paths:8"
    end

    test "converts the :vectorize with detail, despeckle and corners options" do
      assert Effect.to_url_string({:vectorize, detail: 5, despeckle: 7, corners: 20}) ==
               "vectorize:detail:5:despeckle:7:corners:20"
    end

    test "converts the :vectorize with detail, paths and corners options" do
      assert Effect.to_url_string({:vectorize, detail: 5, corners: 20, paths: 8}) ==
               "vectorize:detail:5:paths:8:corners:20"
    end

    test "converts the :vectorize with despeckle, paths and corners options" do
      assert Effect.to_url_string({:vectorize, corners: 20, despeckle: 7, paths: 8}) ==
               "vectorize:despeckle:7:paths:8:corners:20"
    end

    test "converts the :vectorize with colors, detail, despeckle and paths options" do
      assert Effect.to_url_string({:vectorize, colors: 6, paths: 8, detail: 5, despeckle: 7}) ==
               "vectorize:6:5:7:8"
    end

    test "converts the :vectorize with colors, detail, despeckle and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, corners: 20, detail: 5, despeckle: 7}) ==
               "vectorize:colors:6:detail:5:despeckle:7:corners:20"
    end

    test "converts the :vectorize with colors, detail, paths and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, corners: 20, detail: 5, paths: 8}) ==
               "vectorize:colors:6:detail:5:paths:8:corners:20"
    end

    test "converts the :vectorize with colors, despeckle, paths and corners options" do
      assert Effect.to_url_string({:vectorize, colors: 6, corners: 20, despeckle: 7, paths: 8}) ==
               "vectorize:colors:6:despeckle:7:paths:8:corners:20"
    end

    test "converts the :vectorize with detail, despeckle, paths and corners options" do
      assert Effect.to_url_string({:vectorize, detail: 5, corners: 20, despeckle: 7, paths: 8}) ==
               "vectorize:detail:5:despeckle:7:paths:8:corners:20"
    end

    test "converts the :vectorize with colors, detail, despeckle, paths and corners options" do
      vectorize_options = [colors: 6, detail: 5, corners: 20, despeckle: 7, paths: 8]
      assert Effect.to_url_string({:vectorize, vectorize_options}) == "vectorize:6:5:7:8:20"
    end

    test "converts the :vibrance" do
      assert Effect.to_url_string(:vibrance) == "vibrance"
    end

    test "converts the :vibrance with an integer" do
      assert Effect.to_url_string({:vibrance, 60}) == "vibrance:60"
    end

    test "converts the :vibrance with a float" do
      assert Effect.to_url_string({:vibrance, -10.5}) == "vibrance:-10.5"
    end

    test "converts the :viesus_correct" do
      assert Effect.to_url_string(:viesus_correct) == "viesus_correct"
    end

    test "converts the :vignette" do
      assert Effect.to_url_string(:vignette) == "vignette"
    end

    test "converts the :vignette with an integer" do
      assert Effect.to_url_string({:vignette, 60}) == "vignette:60"
    end

    test "converts the :vignette with a float" do
      assert Effect.to_url_string({:vignette, 10.5}) == "vignette:10.5"
    end

    test "converts the :volume with the :mute" do
      assert Effect.to_url_string({:volume, :mute}) == "volume:mute"
    end

    test "converts the :volume with an integer" do
      assert Effect.to_url_string({:volume, 60}) == "volume:60"
    end

    test "converts the :volume with a float" do
      assert Effect.to_url_string({:volume, 10.5}) == "volume:10.5"
    end

    test "converts the :volume with an integer decibels" do
      assert Effect.to_url_string({:volume, {10, :decibels}}) == "volume:10dB"
    end

    test "converts the :volume with a float decibels" do
      assert Effect.to_url_string({:volume, {10.5, :decibels}}) == "volume:10.5dB"
    end
  end
end
