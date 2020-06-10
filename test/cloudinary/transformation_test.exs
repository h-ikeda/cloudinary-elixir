defmodule Cloudinary.TransformationTest do
  use ExUnit.Case
  alias Cloudinary.Transformation
  doctest Transformation

  describe "to_url_string/1" do
    test "converts the angle param with an integer" do
      assert Transformation.to_url_string(angle: 8) == "a_8"
    end

    test "converts the angle param with a float" do
      assert Transformation.to_url_string(angle: 8.2) == "a_8.2"
    end

    test "converts the angle param with an atom" do
      assert Transformation.to_url_string(angle: :vflip) == "a_vflip"
    end

    test "converts the angle param with a list of atoms" do
      assert Transformation.to_url_string(angle: [:vflip, :hflip]) == "a_vflip.hflip"
    end

    test "raises if the angle param with a list containing invalid values" do
      assert_raise ArgumentError, fn ->
        Transformation.to_url_string(angle: [:vflip, :unknown])
      end
    end

    test "converts the aspect_ratio param with an integer" do
      assert Transformation.to_url_string(aspect_ratio: 2) == "ar_2"
    end

    test "converts the aspect_ratio param with a float" do
      assert Transformation.to_url_string(aspect_ratio: 1.3) == "ar_1.3"
    end

    test "converts the aspect_ratio param with a tuple of integers" do
      assert Transformation.to_url_string(aspect_ratio: {16, 9}) == "ar_16:9"
    end

    test "converts the aspect_ratio param with a tuple of floats" do
      assert Transformation.to_url_string(aspect_ratio: {12.2, 5.4}) == "ar_12.2:5.4"
    end

    test "converts the audio_codec param with an atom" do
      assert Transformation.to_url_string(audio_codec: :aac) == "ac_aac"
    end

    test "converts the audio_frequency param with the :initial_frequency" do
      assert Transformation.to_url_string(audio_frequency: :initial_frequency) == "af_iaf"
    end

    test "converts the audio_frequency param with an integer" do
      assert Transformation.to_url_string(audio_frequency: 88200) == "af_88200"
    end

    test "converts the bit_rate param with an integer" do
      assert Transformation.to_url_string(bit_rate: 48500) == "br_48500"
    end

    test "converts the bit_rate param with a float" do
      assert Transformation.to_url_string(bit_rate: 48550.5) == "br_48550.5"
    end

    test "converts the bit_rate param with an integer x1000" do
      assert Transformation.to_url_string(bit_rate: 485_000) == "br_485k"
    end

    test "converts the bit_rate param with a float x1000" do
      assert Transformation.to_url_string(bit_rate: 596_000.0) == "br_596k"
    end

    test "converts the bit_rate param with an integer x1000000" do
      assert Transformation.to_url_string(bit_rate: 15_000_000) == "br_15m"
    end

    test "converts the bit_rate param with a float x1000000" do
      assert Transformation.to_url_string(bit_rate: 5_000_000.0) == "br_5m"
    end

    test "converts the bit_rate param with an integer and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {48500, :constant}) == "br_48500:constant"
    end

    test "converts the bit_rate param with a float and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {48550.5, :constant}) == "br_48550.5:constant"
    end

    test "converts the bit_rate param with an integer x1000 and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {485_000, :constant}) == "br_485k:constant"
    end

    test "converts the bit_rate param with a float x1000 and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {596_000.0, :constant}) == "br_596k:constant"
    end

    test "converts the bit_rate param with an integer x1000000 and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {15_000_000, :constant}) == "br_15m:constant"
    end

    test "converts the bit_rate param with a float x1000000 and the :constant flag" do
      assert Transformation.to_url_string(bit_rate: {5_000_000.0, :constant}) == "br_5m:constant"
    end

    test "converts the border param with a width option" do
      assert Transformation.to_url_string(border: [width: 3]) == "bo_3px_solid_black"
    end

    test "converts the border param with a style option" do
      assert Transformation.to_url_string(border: [style: :solid]) == "bo_2px_solid_black"
    end

    test "converts the border param with a color (hex triplet) option" do
      assert Transformation.to_url_string(border: [color: 'ab012f']) == "bo_2px_solid_rgb:ab012f"
    end

    test "converts the border param with a color (color name) option" do
      assert Transformation.to_url_string(border: [color: "white"]) == "bo_2px_solid_white"
    end

    test "converts the border param with width and style options" do
      assert Transformation.to_url_string(border: [width: 3, style: :solid]) ==
               "bo_3px_solid_black"
    end

    test "converts the border param with width and color (hex triplet) options" do
      assert Transformation.to_url_string(border: [width: 3, color: '8e6b4a3c']) ==
               "bo_3px_solid_rgb:8e6b4a3c"
    end

    test "converts the border param with width and color (color name) options" do
      assert Transformation.to_url_string(border: [width: 3, color: "yellow"]) ==
               "bo_3px_solid_yellow"
    end

    test "converts the border param with style and color (hex triplet) options" do
      assert Transformation.to_url_string(border: [style: :solid, color: '8e6b4a3c']) ==
               "bo_2px_solid_rgb:8e6b4a3c"
    end

    test "converts the border param with style and color (color name) options" do
      assert Transformation.to_url_string(border: [style: :solid, color: "yellow"]) ==
               "bo_2px_solid_yellow"
    end

    test "converts the border param with width, style and color (hex triplet) options" do
      assert Transformation.to_url_string(border: [width: 3, style: :solid, color: '8e6b4a3c']) ==
               "bo_3px_solid_rgb:8e6b4a3c"
    end

    test "converts the border param with width, style and color (color name) options" do
      assert Transformation.to_url_string(border: [width: 3, style: :solid, color: "yellow"]) ==
               "bo_3px_solid_yellow"
    end

    test "converts the color param with a charlist" do
      assert Transformation.to_url_string(color: '00002A') == "co_rgb:00002A"
    end

    test "converts the color param with a string" do
      assert Transformation.to_url_string(color: "brown") == "co_brown"
    end

    test "converts the background param with a charlist" do
      assert Transformation.to_url_string(background: '00002A') == "b_rgb:00002A"
    end

    test "converts the background param with a string" do
      assert Transformation.to_url_string(background: "brown") == "b_brown"
    end

    test "converts the color_space param with an atom" do
      assert Transformation.to_url_string(color_space: :keep_cmyk) == "cs_keep_cmyk"
    end

    test "converts the color_space param with the :icc and a string" do
      assert Transformation.to_url_string(color_space: {:icc, "uploaded.icc"}) ==
               "cs_icc:uploaded.icc"
    end

    test "converts the crop param with an atom" do
      assert Transformation.to_url_string(crop: :fill) == "c_fill"
    end

    test "converts the custom_function param with function_type of the :wasm" do
      assert Transformation.to_url_string(
               custom_function: [function_type: :wasm, source: "example.wasm"]
             ) == "fn_wasm:example.wasm"
    end

    test "converts the custom_function param with function_type of the :remote" do
      assert Transformation.to_url_string(
               custom_function: [function_type: :remote, source: "https://example.com/fun"]
             ) == "fn_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
    end

    test "converts the custom_pre_function param with function_type of the :remote" do
      assert Transformation.to_url_string(
               custom_pre_function: [function_type: :remote, source: "https://example.com/fun"]
             ) == "fn_pre_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
    end

    test "converts the default_image param with a string" do
      assert Transformation.to_url_string(default_image: "placeholder.jpg") == "d_placeholder.jpg"
    end

    test "converts the delay param with an integer" do
      assert Transformation.to_url_string(delay: 25) == "dl_25"
    end

    test "converts the delay param with a float" do
      assert Transformation.to_url_string(delay: 12.5) == "dl_12.5"
    end

    test "converts the density param with an integer" do
      assert Transformation.to_url_string(density: 250) == "dn_250"
    end

    test "converts the density param with a float" do
      assert Transformation.to_url_string(density: 120.0) == "dn_120.0"
    end

    test "converts the density param with the :initial_density" do
      assert Transformation.to_url_string(density: :initial_density) == "dn_idn"
    end

    test "converts the device_pixel_ratio param with an integer" do
      assert Transformation.to_url_string(device_pixel_ratio: 2) == "dpr_2"
    end

    test "converts the device_pixel_ratio param with a float" do
      assert Transformation.to_url_string(device_pixel_ratio: 3.0) == "dpr_3.0"
    end

    test "converts the device_pixel_ratio param with the :auto" do
      assert Transformation.to_url_string(device_pixel_ratio: :auto) == "dpr_auto"
    end

    test "converts the effect param with an atom" do
      assert Transformation.to_url_string(effect: :accelerate) == "e_accelerate"
    end

    test "converts the effect param with an atom and options" do
      assert Transformation.to_url_string(effect: {:accelerate, 62}) == "e_accelerate:62"
    end

    test "converts the duration param with an integer" do
      assert Transformation.to_url_string(duration: 8) == "du_8"
    end

    test "converts the duration param with a float" do
      assert Transformation.to_url_string(duration: 5.5) == "du_5.5"
    end

    test "converts the duration param with an integer of the percentage" do
      assert Transformation.to_url_string(duration: {80, :percents}) == "du_80p"
    end

    test "converts the duration param with a float of the percentage" do
      assert Transformation.to_url_string(duration: {62.5, :percents}) == "du_62.5p"
    end

    test "converts the start_offset param with an integer" do
      assert Transformation.to_url_string(start_offset: 7) == "so_7"
    end

    test "converts the start_offset param with a float" do
      assert Transformation.to_url_string(start_offset: 7.5) == "so_7.5"
    end

    test "converts the start_offset param with an integer of percentage" do
      assert Transformation.to_url_string(start_offset: {72, :percents}) == "so_72p"
    end

    test "converts the start_offset param with a float of percentage" do
      assert Transformation.to_url_string(start_offset: {7.8, :percents}) == "so_7.8p"
    end

    test "converts the end_offset param with an integer" do
      assert Transformation.to_url_string(end_offset: 7) == "eo_7"
    end

    test "converts the end_offset param with a float" do
      assert Transformation.to_url_string(end_offset: 7.5) == "eo_7.5"
    end

    test "converts the end_offset param with an integer of percentage" do
      assert Transformation.to_url_string(end_offset: {72, :percents}) == "eo_72p"
    end

    test "converts the end_offset param with a float of percentage" do
      assert Transformation.to_url_string(end_offset: {7.8, :percents}) == "eo_7.8p"
    end

    test "converts the fetch_format param with an atom" do
      assert Transformation.to_url_string(fetch_format: :gif) == "f_gif"
    end

    test "converts the fetch_format param with the :auto" do
      assert Transformation.to_url_string(fetch_format: :auto) == "f_auto"
    end

    test "converts the flags param with an atom" do
      assert Transformation.to_url_string(flags: :force_icc) == "fl_force_icc"
    end

    test "converts the flags param with a list of atoms" do
      assert Transformation.to_url_string(flags: [:force_icc, :progressive]) ==
               "fl_force_icc.progressive"
    end

    test "converts the fps param with a :min option" do
      assert Transformation.to_url_string(fps: [min: 22.5]) == "fps_22.5-"
    end

    test "converts the fps param with a :min and a :max options" do
      assert Transformation.to_url_string(fps: [min: 30, max: 60]) == "fps_30-60"
    end

    test "converts the gravity param with an atom" do
      assert Transformation.to_url_string(gravity: :xy_center) == "g_xy_center"
    end

    test "converts the gravity param with a tuple of atoms" do
      assert Transformation.to_url_string(gravity: {:custom, :adv_face}) == "g_custom:adv_face"
    end

    test "converts the height param with an integer" do
      assert Transformation.to_url_string(height: 320) == "h_320"
    end

    test "converts the height param with a float" do
      assert Transformation.to_url_string(height: 0.65) == "h_0.65"
    end

    test "converts the keyframe_interval param with an integer" do
      assert Transformation.to_url_string(keyframe_interval: 2) == "ki_2"
    end

    test "converts the keyframe_interval param with a float" do
      assert Transformation.to_url_string(keyframe_interval: 2.22) == "ki_2.22"
    end

    test "converts the opacity param with an integer" do
      assert Transformation.to_url_string(opacity: 25) == "o_25"
    end

    test "converts the opacity param with a float" do
      assert Transformation.to_url_string(opacity: 82.2) == "o_82.2"
    end

    test "converts the overlay param with a string" do
      assert Transformation.to_url_string(overlay: "overlay_image.png") == "l_overlay_image.png"
    end

    test "converts the underlay param with a string" do
      assert Transformation.to_url_string(underlay: "underlay.png") == "u_underlay.png"
    end

    test "converts the overlay param with options" do
      assert Transformation.to_url_string(overlay: [lut: "sample.3dl"]) == "l_lut:sample.3dl"
    end

    test "converts the underlay param with options" do
      assert Transformation.to_url_string(underlay: [lut: "sample.3dl"]) == "u_lut:sample.3dl"
    end

    test "converts the page param with a range" do
      assert Transformation.to_url_string(page: 2..4) == "pg_2-4"
    end

    test "converts the page param with an integer" do
      assert Transformation.to_url_string(page: 6) == "pg_6"
    end

    test "converts the page param with a string" do
      assert Transformation.to_url_string(page: "9-") == "pg_9-"
    end

    test "converts the page param with a list" do
      assert Transformation.to_url_string(page: [2..4, 6, "9-"]) == "pg_2-4;6;9-"
    end

    test "converts the page param with a string of name option" do
      assert Transformation.to_url_string(page: [name: "layer1"]) == "pg_name:layer1"
    end

    test "converts the page param with a list of name option" do
      assert Transformation.to_url_string(page: [name: ["layer1", "layer2"]]) ==
               "pg_name:layer1:layer2"
    end

    test "converts the quality param with an integer" do
      assert Transformation.to_url_string(quality: 88) == "q_88"
    end

    test "converts the quality param with a float" do
      assert Transformation.to_url_string(quality: 88.8) == "q_88.8"
    end

    test "converts the quality param with the :jpegmini" do
      assert Transformation.to_url_string(quality: :jpegmini) == "q_jpegmini"
    end

    test "converts the quality param with the :auto" do
      assert Transformation.to_url_string(quality: :auto) == "q_auto"
    end

    test "converts the quality param with a tuple of the :auto and an atom" do
      assert Transformation.to_url_string(quality: {:auto, :eco}) == "q_auto:eco"
    end

    test "converts the quality param with an integer and a chroma option" do
      assert Transformation.to_url_string(quality: {88, chroma: 420}) == "q_88:420"
    end

    test "converts the quality param with a float and a chroma option" do
      assert Transformation.to_url_string(quality: {88.8, chroma: 444}) == "q_88.8:444"
    end

    test "converts the quality param with an integer and a max_quantization option" do
      assert Transformation.to_url_string(quality: {88, max_quantization: 42}) == "q_88:qmax_42"
    end

    test "converts the quality param with a float and a max_quantization option" do
      assert Transformation.to_url_string(quality: {88.8, max_quantization: 44.5}) ==
               "q_88.8:qmax_44.5"
    end

    test "converts the radius param with an integer" do
      assert Transformation.to_url_string(radius: 30) == "r_30"
    end

    test "converts the radius param with a float" do
      assert Transformation.to_url_string(radius: 32.3) == "r_32.3"
    end

    test "converts the radius param with a tuple of an integer" do
      assert Transformation.to_url_string(radius: {30}) == "r_30"
    end

    test "converts the radius param with a tuple of a float" do
      assert Transformation.to_url_string(radius: {32.3}) == "r_32.3"
    end

    test "converts the radius param with a tuple of two integers" do
      assert Transformation.to_url_string(radius: {30, 20}) == "r_30:20"
    end

    test "converts the radius param with a tuple of two floats" do
      assert Transformation.to_url_string(radius: {32.3, 24.5}) == "r_32.3:24.5"
    end

    test "converts the radius param with a tuple of three integers" do
      assert Transformation.to_url_string(radius: {30, 20, 25}) == "r_30:20:25"
    end

    test "converts the radius param with a tuple of three floats" do
      assert Transformation.to_url_string(radius: {32.3, 24.5, 12.8}) == "r_32.3:24.5:12.8"
    end

    test "converts the radius param with a tuple of four integers" do
      assert Transformation.to_url_string(radius: {30, 20, 25, 22}) == "r_30:20:25:22"
    end

    test "converts the radius param with a tuple of four floats" do
      assert Transformation.to_url_string(radius: {32.3, 4.5, 12.8, 6.5}) == "r_32.3:4.5:12.8:6.5"
    end

    test "converts the streaming_profile param with a string" do
      assert Transformation.to_url_string(streaming_profile: "full_hd") == "sp_full_hd"
    end

    test "converts the transformation param with a string" do
      assert Transformation.to_url_string(transformation: "media_lib") == "t_media_lib"
    end

    test "converts the video_codec param with an atom" do
      assert Transformation.to_url_string(video_codec: :theora) == "vc_theora"
    end

    test "converts the video_codec param with an atom and a profile string" do
      assert Transformation.to_url_string(video_codec: {:h264, "baseline"}) == "vc_h264:baseline"
    end

    test "converts the video_codec param with an atom, a profile string, and a level string" do
      assert Transformation.to_url_string(video_codec: {:h264, "baseline", "3.1"}) ==
               "vc_h264:baseline:3.1"
    end

    test "converts the video_sampling param with an integer" do
      assert Transformation.to_url_string(video_sampling: 20) == "vs_20"
    end

    test "converts the video_sampling param with an integer of seconds" do
      assert Transformation.to_url_string(video_sampling: {2, :seconds}) == "vs_2s"
    end

    test "converts the video_sampling param with a float of seconds" do
      assert Transformation.to_url_string(video_sampling: {2.5, :seconds}) == "vs_2.5s"
    end

    test "converts the width param with an integer" do
      assert Transformation.to_url_string(width: 660) == "w_660"
    end

    test "converts the width param with a float" do
      assert Transformation.to_url_string(width: 0.87) == "w_0.87"
    end

    test "converts the width param with the :auto" do
      assert Transformation.to_url_string(width: :auto) == "w_auto"
    end

    test "converts the width param with the :auto and a rounding_step option" do
      assert Transformation.to_url_string(width: {:auto, rounding_step: 45}) == "w_auto:45"
    end

    test "converts the width param with the :auto and a width option" do
      assert Transformation.to_url_string(width: {:auto, width: 530}) == "w_auto:100:530"
    end

    test "converts the width param with the :auto, a rounding_step option and a width option" do
      assert Transformation.to_url_string(width: {:auto, rounding_step: 45, width: 530}) ==
               "w_auto:45:530"
    end

    test "converts the width param with the :auto and a breakpoints option" do
      breakpoints = [min_width: 60, max_width: 890, bytes_step: 40000, max_images: 30]

      assert Transformation.to_url_string(width: {:auto, breakpoints: breakpoints}) ==
               "w_auto:breakpoints_60_890_40_30"
    end

    test "converts the x param with an integer" do
      assert Transformation.to_url_string(x: 89) == "x_89"
    end

    test "converts the x param with a float" do
      assert Transformation.to_url_string(x: -0.75) == "x_-0.75"
    end

    test "converts the y param with an integer" do
      assert Transformation.to_url_string(y: 89) == "y_89"
    end

    test "converts the y param with a float" do
      assert Transformation.to_url_string(y: -0.75) == "y_-0.75"
    end

    test "converts the zoom param with an integer" do
      assert Transformation.to_url_string(zoom: 2) == "z_2"
    end

    test "converts the zoom param with a float" do
      assert Transformation.to_url_string(zoom: 1.35) == "z_1.35"
    end
  end
end
