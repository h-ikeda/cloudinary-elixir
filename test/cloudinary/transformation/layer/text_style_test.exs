defmodule Cloudinary.Transformation.Layer.TextStyleTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Layer.TextStyle

  describe "String.Chars.to_string/1 implementation for TextStyle" do
    test "with only font family and font size" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28}}" === "Arial_28"
    end

    test "with font style" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, font_style: :italic}}" ===
               "Arial_28_italic"
    end

    test "with text decoration" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, text_decoration: :underline}}" ===
               "Arial_28_underline"
    end

    test "with text align" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, text_align: :right}}" ===
               "Arial_28_right"
    end

    test "with stroke" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, stroke: :stroke}}" ===
               "Arial_28_stroke"
    end

    test "with letter spacing" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, letter_spacing: 10}}" ===
               "Arial_28_letter_spacing_10"
    end

    test "with line spacing" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, line_spacing: 20}}" ===
               "Arial_28_line_spacing_20"
    end

    test "with font antialias" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, font_antialias: :fast}}" ===
               "Arial_28_antialias_fast"
    end

    test "with font hinting" do
      assert "#{%TextStyle{font_family: "Arial", font_size: 28, font_hinting: :full}}" ===
               "Arial_28_hinting_full"
    end
  end
end
