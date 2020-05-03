defmodule Cloudinary.TransformationTest do
  use ExUnit.Case
  doctest Cloudinary.Transformation

  describe "exp/1" do
    test "converts + to _add_" do
      argument = [angle: Cloudinary.Transformation.exp(:initial_width + :initial_height)]
      expected = "a_iw_add_ih"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts - to _sub_" do
      argument = [angle: Cloudinary.Transformation.exp(:aspect_ratio - :current_page)]
      expected = "a_ar_sub_cp"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts * to _mul_" do
      argument = [angle: Cloudinary.Transformation.exp(:face_count * :height)]
      expected = "a_fc_mul_h"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts / to _div_" do
      argument = [angle: Cloudinary.Transformation.exp(:initial_aspect_ratio / :page_count)]
      expected = "a_iar_div_pc"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts pow function to _pow_" do
      argument = [angle: Cloudinary.Transformation.exp(pow(:page_x, 2))]
      expected = "a_px_pow_2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts mod function to _mod_" do
      argument = [angle: Cloudinary.Transformation.exp(mod(:page_y, 10))]
      expected = "a_py_mod_10"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts == to _eq_" do
      argument = [if: Cloudinary.Transformation.exp(:width == :height), zoom: 1.2]
      expected = "if_w_eq_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts != to _ne_" do
      argument = [if: Cloudinary.Transformation.exp(:width != :height), zoom: 1.2]
      expected = "if_w_ne_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts < to _lt_" do
      argument = [if: Cloudinary.Transformation.exp(:width < :height), zoom: 1.2]
      expected = "if_w_lt_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts > to _gt_" do
      argument = [if: Cloudinary.Transformation.exp(:width > :height), zoom: 1.2]
      expected = "if_w_gt_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts <= to _lte_" do
      argument = [if: Cloudinary.Transformation.exp(:width <= :height), zoom: 1.2]
      expected = "if_w_lte_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts >= to _gte_" do
      argument = [if: Cloudinary.Transformation.exp(:width >= :height), zoom: 1.2]
      expected = "if_w_gte_h,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts && to _and_" do
      argument = [
        if: Cloudinary.Transformation.exp(:width == :height && :current_page < 10),
        zoom: 1.2
      ]

      expected = "if_w_eq_h_and_cp_lt_10,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "converts || to _or_" do
      argument = [
        if: Cloudinary.Transformation.exp(:width == :height || :current_page < 10),
        zoom: 1.2
      ]

      expected = "if_w_eq_h_or_cp_lt_10,z_1.2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end
  end

  describe "encode/1" do
    test "applies angle (float)" do
      argument = [angle: 30.0]
      expected = "a_30.0"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies angle (atom)" do
      argument = [angle: :ignore]
      expected = "a_ignore"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies angle (list of atoms)" do
      argument = [angle: [:auto_right, :hflip]]
      expected = "a_auto_right.hflip"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies angle (expression)" do
      argument = [angle: Cloudinary.Transformation.exp(:initial_height / :initial_width)]
      expected = "a_ih_div_iw"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies aspect_ratio (float)" do
      argument = [aspect_ratio: 1.8]
      expected = "ar_1.8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies aspect_ratio (string)" do
      argument = [aspect_ratio: "11:8"]
      expected = "ar_11:8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies aspect_ratio (expression)" do
      argument = [aspect_ratio: Cloudinary.Transformation.exp(:page_x / :page_y)]
      expected = "ar_px_div_py"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies background (color name)" do
      argument = [background: "blue"]
      expected = "b_blue"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies background (#rgb style)" do
      argument = [background: "#1a2b3d"]
      expected = "b_rgb:1a2b3d"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies background (rgb:### style)" do
      argument = [background: "rgb:2b3c5f"]
      expected = "b_rgb:2b3c5f"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies color (color name)" do
      argument = [color: "blue"]
      expected = "co_blue"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies color (#rgb style)" do
      argument = [color: "#1a2b3d"]
      expected = "co_rgb:1a2b3d"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies color (rgb:### style)" do
      argument = [color: "rgb:2b3c5f"]
      expected = "co_rgb:2b3c5f"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies border (with width)" do
      argument = [border: [width: 4]]
      expected = "bo_4px_solid_black"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies border (with #rgb style color)" do
      argument = [border: [color: "#a0b9c8"]]
      expected = "bo_2px_solid_rgb:a0b9c8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies border (with rgb:### style color)" do
      argument = [border: [color: "rgb:890abc60"]]
      expected = "bo_2px_solid_rgb:890abc60"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies border (with color name)" do
      argument = [border: [color: "blue"]]
      expected = "bo_2px_solid_blue"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies border (with width and color)" do
      argument = [border: [width: 4, color: "#b3c2a1"]]
      expected = "bo_4px_solid_rgb:b3c2a1"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies crop" do
      argument = [crop: :limit]
      expected = "c_limit"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies dpr (float)" do
      argument = [dpr: 2.0]
      expected = "dpr_2.0"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies dpr (auto)" do
      argument = [dpr: :auto]
      expected = "dpr_auto"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies dpr (expression)" do
      argument = [dpr: Cloudinary.Transformation.exp(:height * :width / 1000)]
      expected = "dpr_h_mul_w_div_1000"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies effect (atom)" do
      argument = [effect: :redeye]
      expected = "e_redeye"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies effect (with single value)" do
      argument = [effect: [shadow: 50]]
      expected = "e_shadow:50"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies effect (with multiple values)" do
      argument = [effect: [distort: [5, 34, 70, 10, 70, 75, 5, 55]]]
      expected = "e_distort:5:34:70:10:70:75:5:55"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies effect (with expression value)" do
      argument = [effect: [shadow: Cloudinary.Transformation.exp(pow(:height, 2) / 10000)]]
      expected = "e_shadow:h_pow_2_div_10000"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies flags (atom)" do
      argument = [flags: :apng]
      expected = "fl_apng"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies flags (list)" do
      argument = [flags: [:force_strip, :force_icc]]
      expected = "fl_force_strip.force_icc"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom_function (web assembly)" do
      argument = [custom_function: [function_type: :wasm, source: "sample.wasm"]]
      expected = "fn_wasm:sample.wasm"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom_function (remote)" do
      argument = [custom_function: [function_type: :remote, source: "https://example.com/fun"]]
      expected = "fn_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom_pre_function (web assembly)" do
      argument = [custom_pre_function: [function_type: :wasm, source: "xample.wasm"]]
      expected = "fn_pre_wasm:xample.wasm"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom_pre_function (remote)" do
      argument = [custom_pre_function: [function_type: :remote, source: "https://example.com/fn"]]
      expected = "fn_pre_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mbg=="
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies fps (integer)" do
      argument = [fps: 30]
      expected = "fps_30"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies fps (list)" do
      argument = [fps: [30, 60]]
      expected = "fps_30-60"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (fetch url)" do
      argument = [overlay: [type: :fetch, url: "http://example.com/path/to/remote/image.jpg"]]
      expected = "l_fetch:aHR0cDovL2V4YW1wbGUuY29tL3BhdGgvdG8vcmVtb3RlL2ltYWdlLmpwZw=="
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (fetch url with plain string)" do
      argument = [overlay: "fetch:http://example.com/path/to/remote/image.jpg"]
      expected = "l_fetch:aHR0cDovL2V4YW1wbGUuY29tL3BhdGgvdG8vcmVtb3RlL2ltYWdlLmpwZw=="
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (public_id)" do
      argument = [overlay: [public_id: "sample/example"]]
      expected = "l_sample:example"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (public_id with plain string)" do
      argument = [overlay: "sample/example"]
      expected = "l_sample:example"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (lut)" do
      argument = [overlay: [resource_type: :lut, public_id: "sample/example.3dl"]]
      expected = "l_lut:sample:example.3dl"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (subtitles)" do
      argument = [overlay: [resource_type: :subtitles, public_id: "sample/example.srt"]]
      expected = "l_subtitles:sample:example.srt"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (subtitles with style)" do
      argument = [
        overlay: [
          resource_type: :subtitles,
          public_id: "sample/example.srt",
          font_family: "arial",
          font_size: 20
        ]
      ]

      expected = "l_subtitles:arial_20:sample:example.srt"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (text with public_id)" do
      argument = [overlay: [resource_type: :text, text: "すごい,タイトル", public_id: "sample/default"]]

      expected =
        "l_text:sample:default:%25E3%2581%2599%25E3%2581%2594%25E3%2581%2584%252C%25E3%2582%25BF%25E3%2582%25A4%25E3%2583%2588%25E3%2583%25AB"

      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (text with style)" do
      argument = [
        overlay: [
          resource_type: :text,
          text: "とてもCool😎",
          font_family: "arial",
          font_size: 80,
          font_weight: :bold,
          font_style: :italic,
          text_decoration: :strikethrough,
          text_align: :center,
          stroke: :stroke,
          letter_spacing: 10,
          line_spacing: 20,
          font_antialias: :fast,
          font_hinting: :medium
        ]
      ]

      expected =
        "l_text:arial_80_bold_italic_strikethrough_center_stroke_letter_spacing_10_line_spacing_20_antialias_fast_hinting_medium:%25E3%2581%25A8%25E3%2581%25A6%25E3%2582%2582Cool%25F0%259F%2598%258E"

      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies overlay (text with default style)" do
      argument = [
        overlay: [
          resource_type: :text,
          text: "とてもHot😎",
          font_family: "arial",
          font_size: 80,
          font_weight: :normal,
          font_style: :normal,
          text_decoration: :normal,
          text_align: :left,
          stroke: :none,
          letter_spacing: 15,
          line_spacing: 25,
          font_antialias: :subpixel,
          font_hinting: :full
        ]
      ]

      expected =
        "l_text:arial_80_letter_spacing_15_line_spacing_25_antialias_subpixel_hinting_full:%25E3%2581%25A8%25E3%2581%25A6%25E3%2582%2582Hot%25F0%259F%2598%258E"

      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies underlay (public_id)" do
      argument = [underlay: [public_id: "sample/example2"]]
      expected = "u_sample:example2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies opacity (float)" do
      argument = [opacity: 55.0]
      expected = "o_55.0"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies opacity (expression)" do
      argument = [opacity: Cloudinary.Transformation.exp(:initial_height * small)]
      expected = "o_ih_mul_$small"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies quality (float)" do
      argument = [quality: 70.0]
      expected = "q_70.0"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies quality (expression)" do
      argument = [quality: Cloudinary.Transformation.exp(:face_count + 20)]
      expected = "q_fc_add_20"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies radius (integer)" do
      argument = [radius: 20]
      expected = "r_20"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies radius (list of integer)" do
      argument = [radius: [20, 30, 10]]
      expected = "r_20:30:10"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies radius (expression)" do
      argument = [radius: Cloudinary.Transformation.exp(pow(:width, 2))]
      expected = "r_w_pow_2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies radius (list of integer and expression)" do
      argument = [radius: [20, Cloudinary.Transformation.exp(:height / 10), 10]]
      expected = "r_20:h_div_10:10"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies radius (:max)" do
      argument = [radius: :max]
      expected = "r_max"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies named transformation" do
      argument = [transformation: "my_default"]
      expected = "t_my_default"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies named transformations" do
      argument = [transformation: ["rotate", "flip"]]
      expected = "t_rotate.flip"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies width (integer)" do
      argument = [width: 400]
      expected = "w_400"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies width (float)" do
      argument = [width: 0.8]
      expected = "w_0.8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies width (expression)" do
      argument = [width: Cloudinary.Transformation.exp(:height * 0.9)]
      expected = "w_h_mul_0.9"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies x (integer)" do
      argument = [x: 400]
      expected = "x_400"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies x (float)" do
      argument = [x: 0.8]
      expected = "x_0.8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies x (expression)" do
      argument = [x: Cloudinary.Transformation.exp(:height * 0.9)]
      expected = "x_h_mul_0.9"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies y (integer)" do
      argument = [y: 400]
      expected = "y_400"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies y (float)" do
      argument = [y: 0.8]
      expected = "y_0.8"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies y (expression)" do
      argument = [y: Cloudinary.Transformation.exp(:height * 0.9)]
      expected = "y_h_mul_0.9"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies zoom (float)" do
      argument = [zoom: 1.3]
      expected = "z_1.3"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies zom (expression)" do
      argument = [zoom: Cloudinary.Transformation.exp(:height / :initial_width)]
      expected = "z_h_div_iw"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies audio_codec" do
      argument = [audio_codec: "aac"]
      expected = "ac_aac"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (integer)" do
      argument = [bit_rate: 5500]
      expected = "br_5500"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (integer kilo bits)" do
      argument = [bit_rate: 550_000]
      expected = "br_550k"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (integer mega bits)" do
      argument = [bit_rate: 55_000_000]
      expected = "br_55m"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string)" do
      argument = [bit_rate: "5500"]
      expected = "br_5500"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string kilo bits)" do
      argument = [bit_rate: "550000"]
      expected = "br_550k"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string mega bits)" do
      argument = [bit_rate: "55000000"]
      expected = "br_55m"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string with modifier)" do
      argument = [bit_rate: "5500:constant"]
      expected = "br_5500:constant"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string kilo bits with modifier)" do
      argument = [bit_rate: "550000:constant"]
      expected = "br_550k:constant"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies bit_rate (string mega bits with modifier)" do
      argument = [bit_rate: "55000000:constant"]
      expected = "br_55m:constant"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies color_space" do
      argument = [color_space: "tinysrgb"]
      expected = "cs_tinysrgb"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies default_image" do
      argument = [default_image: "sample/avater.png"]
      expected = "d_sample:avater.png"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies delay" do
      argument = [delay: 15]
      expected = "dl_15"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies density" do
      argument = [density: 150]
      expected = "dn_150"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies duration (float)" do
      argument = [duration: 6.12]
      expected = "du_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies duration (string)" do
      argument = [duration: "6.12"]
      expected = "du_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies duration (persent string)" do
      argument = [duration: "60%"]
      expected = "du_60p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies duration (persent raw string)" do
      argument = [duration: "40p"]
      expected = "du_40p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies start_offset (float)" do
      argument = [start_offset: 6.12]
      expected = "so_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies start_offset (string)" do
      argument = [start_offset: "6.12"]
      expected = "so_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies start_offset (persent string)" do
      argument = [start_offset: "60%"]
      expected = "so_60p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies start_offset (persent raw string)" do
      argument = [start_offset: "40p"]
      expected = "so_40p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies end_offset (float)" do
      argument = [end_offset: 6.12]
      expected = "eo_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies end_offset (string)" do
      argument = [end_offset: "6.12"]
      expected = "eo_6.12"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies end_offset (persent string)" do
      argument = [end_offset: "60%"]
      expected = "eo_60p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies end_offset (persent raw string)" do
      argument = [end_offset: "40p"]
      expected = "eo_40p"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies fetch_format (string)" do
      argument = [fetch_format: "jpg"]
      expected = "f_jpg"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies fetch_format (auto)" do
      argument = [fetch_format: :auto]
      expected = "f_auto"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies gravity (atom)" do
      argument = [gravity: :body]
      expected = "g_body"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies gravity (list)" do
      argument = [gravity: [:faces, :auto]]
      expected = "g_faces:auto"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies keyframe_interval" do
      argument = [keyframe_interval: 0.15]
      expected = "ki_0.15"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies page (integer)" do
      argument = [page: 2]
      expected = "pg_2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies page (string representing numbers)" do
      argument = [page: "-2;4;9-11"]
      expected = "pg_-2;4;9-11"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies page (string representing layer)" do
      argument = [page: "layer_name"]
      expected = "pg_name:layer_name"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies page (list of numbers)" do
      argument = [page: [2, 3, "4-6", "8-"]]
      expected = "pg_2;3;4-6;8-"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies page (list of string representing layers)" do
      argument = [page: ["layer1", "layer2"]]
      expected = "pg_name:layer1:layer2"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies streaming_profile" do
      argument = [streaming_profile: "full_hd_wifi"]
      expected = "sp_full_hd_wifi"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_codec (string)" do
      argument = [video_codec: "h264"]
      expected = "vc_h264"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_codec (:auto)" do
      argument = [video_codec: :auto]
      expected = "vc_auto"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_codec (keyword list with codec)" do
      argument = [video_codec: [codec: "h264"]]
      expected = "vc_h264"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_codec (keyword list with codec and profile)" do
      argument = [video_codec: [codec: "h264", profile: "baseline"]]
      expected = "vc_h264:baseline"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_codec (keyword list with codec, profile and level)" do
      argument = [video_codec: [codec: "h264", profile: "baseline", level: "3.1"]]
      expected = "vc_h264:baseline:3.1"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_sampling (integer)" do
      argument = [video_sampling: 20]
      expected = "vs_20"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_sampling (string representing number of frames)" do
      argument = [video_sampling: "20"]
      expected = "vs_20"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies video_sampling (string representing seconds between each frame)" do
      argument = [video_sampling: "2.3s"]
      expected = "vs_2.3s"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies if condition" do
      argument = [if: Cloudinary.Transformation.exp(:initial_height == :initial_width)]
      expected = "if_ih_eq_iw"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom variable definitions (by value)" do
      argument = [variables: [small: 30, medium: 50, large: "large"]]
      expected = "$small_30,$medium_50,$large_!large!"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies custom variable definitions (by expression)" do
      argument = [variables: [small: Cloudinary.Transformation.exp(:face_count * 10), max: 50]]
      expected = "$small_fc_mul_10,$max_50"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "applies raw_transformation" do
      argument = [raw_transformation: "t_named,l_layer_id"]
      expected = "t_named,l_layer_id"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "sorts if and variables to always be first" do
      argument = [
        angle: Cloudinary.Transformation.exp(tilt),
        variables: [tilt: 3],
        density: 500,
        if: Cloudinary.Transformation.exp(:width > :height),
        zoom: 1.1
      ]

      expected = "if_w_gt_h,$tilt_3,a_$tilt,dn_500,z_1.1"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "sorts raw_transformation to always be last" do
      argument = [
        angle: Cloudinary.Transformation.exp(tilt),
        variables: [tilt: 3],
        raw_transformation: "t_test.rotate.shear,ar_3",
        density: 500,
        if: Cloudinary.Transformation.exp(:width > :height),
        zoom: 1.1
      ]

      expected = "if_w_gt_h,$tilt_3,a_$tilt,dn_500,z_1.1,t_test.rotate.shear,ar_3"
      assert Cloudinary.Transformation.encode(argument) == expected
    end

    test "chains transformations" do
      argument = [
        [angle: 3.0, width: 500, height: 300],
        [zoom: 1.1, if: Cloudinary.Transformation.exp(:face_count > 1)]
      ]

      expected = "a_3.0,w_500,h_300/if_fc_gt_1,z_1.1"
      assert Cloudinary.Transformation.encode(argument) == expected
    end
  end
end
