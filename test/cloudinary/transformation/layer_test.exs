defmodule Cloudinary.Transformation.LayerTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Layer
  doctest Layer

  describe "to_url_string/1" do
    test "converts a string" do
      assert Layer.to_url_string("id/of/image") == "id:of:image"
    end

    test "converts the url option" do
      assert Layer.to_url_string(%{url: "http://example.com/path/to/remote/image.jpg"}) ==
               "fetch:aHR0cDovL2V4YW1wbGUuY29tL3BhdGgvdG8vcmVtb3RlL2ltYWdlLmpwZw=="
    end

    test "converts the lut option" do
      assert Layer.to_url_string(%{lut: "table.3dl"}) == "lut:table.3dl"
    end

    test "converts the video option" do
      assert Layer.to_url_string(%{video: "overlay_video"}) == "video:overlay_video"
    end

    test "converts the subtitles option" do
      assert Layer.to_url_string(%{subtitles: "en.srt"}) == "subtitles:en.srt"
    end

    test "converts the subtitles option with font style specifications" do
      assert Layer.to_url_string(%{subtitles: "en.srt", font_family: "Arial", font_size: 30}) ==
               "subtitles:Arial_30:en.srt"
    end

    test "converts the text option with predefined text image ID" do
      assert Layer.to_url_string(%{text: "TEXT", predefined: "text_img"}) == "text:text_img:TEXT"
    end

    test "converts the text option with font style specifications" do
      assert Layer.to_url_string(%{text: "TEXT", font_family: "Arial", font_size: 30}) ==
               "text:Arial_30:TEXT"
    end

    test "converts the text option with full font style specifications" do
      url_string =
        Layer.to_url_string(%{
          text: "TEXT",
          font_family: "Arial",
          font_size: 30,
          font_weight: :bold,
          font_style: :italic,
          text_decoration: :underline,
          text_align: :right,
          stroke: :stroke,
          letter_spacing: 10,
          line_spacing: 5,
          font_antialias: :good,
          font_hinting: :slight
        })

      assert String.length(url_string) == 116
      assert String.starts_with?(url_string, "text:Arial_30_")
      assert url_string =~ "_bold"
      assert url_string =~ "_italic"
      assert url_string =~ "_underline"
      assert url_string =~ "_right"
      assert url_string =~ "_stroke"
      assert url_string =~ "_letter_spacing_10"
      assert url_string =~ "_line_spacing_5"
      assert url_string =~ "_antialias_good"
      assert url_string =~ "_hinting_slight"
      assert String.ends_with?(url_string, ":TEXT")
    end

    test "converts the text option including slashes" do
      assert Layer.to_url_string(%{text: "T/EX/T", predefined: "sample"}) ==
               "text:sample:T%2FEX%2FT"
    end

    test "converts the text option including spaces" do
      assert Layer.to_url_string(%{text: "T EX T", predefined: "sample"}) ==
               "text:sample:T%20EX%20T"
    end

    test "converts the text option including percents" do
      assert Layer.to_url_string(%{text: "T%EX%T", predefined: "sample"}) ==
               "text:sample:T%2525EX%2525T"
    end

    test "converts the text option including comma" do
      assert Layer.to_url_string(%{text: "T,EX,T", predefined: "sample"}) ==
               "text:sample:T%252CEX%252CT"
    end
  end
end
