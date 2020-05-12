defmodule Cloudinary.Transformation.RadiusTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Radius

  describe "String.Chars.to_string/1 implementation" do
    test "for a value of integer" do
      assert "#{%Radius{pixels: 11}}" == "r_11"
    end

    test "for a list of 1 value" do
      assert "#{%Radius{pixels: [12]}}" == "r_12"
    end

    test "for a list of 2 values" do
      assert "#{%Radius{pixels: [13, 14]}}" == "r_13:14"
    end

    test "for a list of 3 values" do
      assert "#{%Radius{pixels: [15, 15, 17]}}" == "r_15:15:17"
    end

    test "for a list of 4 values" do
      assert "#{%Radius{pixels: [20, 22, 23, 25]}}" == "r_20:22:23:25"
    end
  end
end
