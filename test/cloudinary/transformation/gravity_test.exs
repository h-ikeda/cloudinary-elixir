defmodule Cloudinary.Transformation.GravityTest do
  use ExUnit.Case
  alias Cloudinary.Transformation.Gravity

  describe "String.Chars.to_string/1 implementation" do
    test "for north direction (which does not take any modifiers)" do
      assert "#{%Gravity{direction: :north}}" == "g_north"
    end

    test "for face direction without modifier" do
      assert "#{%Gravity{direction: :face}}" == "g_face"
    end

    test "for faces direction without modifier" do
      assert "#{%Gravity{direction: :faces}}" == "g_faces"
    end

    test "for face direction with center modifier" do
      assert "#{%Gravity{direction: :face, modifier: :center}}" == "g_face:center"
    end

    test "for faces direction with auto modifier" do
      assert "#{%Gravity{direction: :faces, modifier: :auto}}" == "g_faces:auto"
    end

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
