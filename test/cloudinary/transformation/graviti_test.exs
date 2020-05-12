defmodule Cloudinary.Transformation.GravityTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Gravity

  describe "String.Chars.to_string/1 implementation" do
    test "for body direction without modifier" do
      assert "#{%Gravity{direction: :body}}" == "g_body"
    end

    test "for body direction with face modifier" do
      assert "#{%Gravity{direction: :body, modifier: :face}}" == "g_body:face"
    end

    test "for custom direction without modifier" do
      assert "#{%Gravity{direction: :custom}}" == "g_custom"
    end

    test "for custom direction with faces modifier" do
      assert "#{%Gravity{direction: :custom, modifier: :faces}}" == "g_custom:faces"
    end
  end
end
