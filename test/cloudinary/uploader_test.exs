defmodule Cloudinary.UploaderTest do
  use ExUnit.Case
  alias Cloudinary.Uploader
  doctest Uploader

  describe "encode_params/1" do
    test "encodes the allowed_formats parameter with a string" do
      assert Uploader.encode_params(%{allowed_formats: "txt"}) == "allowed_formats=txt"
    end

    test "encodes the allowed_formats parameter with an atom" do
      assert Uploader.encode_params(%{allowed_formats: :png}) == "allowed_formats=png"
    end

    test "encodes the allowed_formats parameter with a list" do
      assert Uploader.encode_params(%{allowed_formats: ["txt", :svg]}) ==
               "allowed_formats=txt%2Csvg"
    end

    test "raises if the allowed_formats parameter with a list including invalid formats" do
      assert_raise ArgumentError, fn ->
        Uploader.encode_params(%{allowed_formats: [:dwg, "png"]})
      end
    end

    test "encodes the custom_coordinates parameter with a tuple of numbers" do
      assert Uploader.encode_params(%{custom_coordinates: {85, 120, 220, 310}}) ==
               "custom_coordinates=85%2C120%2C220%2C310"
    end

    test "encodes the face_coordinates parameter with a tuple of numbers" do
      assert Uploader.encode_params(%{face_coordinates: {85, 120, 220, 310}}) ==
               "face_coordinates=85%2C120%2C220%2C310"
    end

    test "encodes the face_coordinates parameter with a list of tuples" do
      assert Uploader.encode_params(%{face_coordinates: [{10, 20, 150, 130}, {213, 345, 82, 61}]}) ==
               "face_coordinates=10%2C20%2C150%2C130%7C213%2C345%2C82%2C61"
    end

    test "encodes the access_mode parameter with an atom" do
      assert Uploader.encode_params(%{access_mode: :public}) == "access_mode=public"
    end

    test "encodes the background_removal parameter with an atom" do
      assert Uploader.encode_params(%{background_removal: :cloudinary_ai}) ==
               "background_removal=cloudinary_ai"
    end

    test "encodes the detection parameter with an atom" do
      assert Uploader.encode_params(%{detection: :adv_face}) == "detection=adv_face"
    end

    test "encodes the moderation parameter with an atom" do
      assert Uploader.encode_params(%{moderation: :metascan}) == "moderation=metascan"
    end

    test "encodes the ocr parameter with an atom" do
      assert Uploader.encode_params(%{ocr: :adv_ocr}) == "ocr=adv_ocr"
    end

    test "encodes the raw_convert parameter with an atom" do
      assert Uploader.encode_params(%{raw_convert: :extract_text}) == "raw_convert=extract_text"
    end

    test "encodes the type parameter with an atom" do
      assert Uploader.encode_params(%{type: :authenticated}) == "type=authenticated"
    end

    test "encodes the categorization parameter with an atom" do
      assert Uploader.encode_params(%{categorization: :google_video_tagging}) ==
               "categorization=google_video_tagging"
    end

    test "encodes the categorization parameter with a list of atoms" do
      assert Uploader.encode_params(%{categorization: [:google_video_tagging, :aws_rek_tagging]}) ==
               "categorization=google_video_tagging%2Caws_rek_tagging"
    end

    test "raises if the categorization parameter with a list including invalid categorizations" do
      assert_raise ArgumentError, fn ->
        Uploader.encode_params(%{categorization: [:unkown, :google_video_tagging]})
      end
    end

    test "encodes the access_control parameter with an access_type option" do
      assert Uploader.encode_params(%{access_control: [access_type: :anonymous]}) ==
               "access_control=%7B%22access_type%22%3A%22anonymous%22%7D"
    end

    test "encodes the access_control parameter with access_type and start options" do
      access_control = [access_type: :anonymous, start: DateTime.from_unix!(1427110463)]

      assert Uploader.encode_params(%{access_control: access_control}) ==
               "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22start%22%3A%222015-03-23T11%3A34%3A23Z%22%7D"
    end

    test "encodes the access_control parameter with access_type and end options" do
      access_control = [access_type: :anonymous, end: DateTime.from_unix!(1527840601)]

      assert Uploader.encode_params(%{access_control: access_control}) ==
               "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22end%22%3A%222018-06-01T08%3A10%3A01Z%22%7D"
    end

    test "encodes the access_control parameter with access_type, start and end options" do
      access_control = [
        access_type: :anonymous,
        start: DateTime.from_unix!(1427110463),
        end: DateTime.from_unix!(1527840601)
      ]

      assert Uploader.encode_params(%{access_control: access_control}) ==
               "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22start%22%3A%222015-03-23T11%3A34%3A23Z%22%2C%22end%22%3A%222018-06-01T08%3A10%3A01Z%22%7D"
    end

    test "encodes the responsive_breakpoints parameter with a breakpoint setting" do
      responsive_breakpoint = [
        create_derived: true,
        bytes_step: 20000,
        min_width: 200,
        max_width: 1000,
        max_images: 20,
        transformation: [crop: :fill, aspect_ratio: {16, 9}, gravity: :face]
      ]

      assert Uploader.encode_params(%{responsive_breakpoints: responsive_breakpoint}) ==
               "responsive_breakpoints=%5B%7B%22create_derived%22%3Atrue%2C%22transformation%22%3A%22c_fill%2Car_16%3A9%2Cg_face%22%2C%22max_width%22%3A1000%2C%22min_width%22%3A200%2C%22bytes_step%22%3A20000%2C%22max_images%22%3A20%7D%5D"
    end

    test "encodes the responsive_breakpoints parameter with a list of breakpoint settings" do
      responsive_breakpoints = [
        [
          create_derived: true,
          bytes_step: 20000,
          min_width: 200,
          max_width: 1000,
          max_images: 20,
          transformation: [crop: :fill, aspect_ratio: {16, 9}, gravity: :face]
        ],
        %{
          create_derived: false,
          format: :jpg,
          min_width: 350,
          max_width: 2000,
          max_images: 18,
          transformation: [crop: :fill, width: 0.75, effect: :sharpen]
        }
      ]

      assert Uploader.encode_params(%{responsive_breakpoints: responsive_breakpoints}) ==
               "responsive_breakpoints=%5B%7B%22create_derived%22%3Atrue%2C%22transformation%22%3A%22c_fill%2Car_16%3A9%2Cg_face%22%2C%22max_width%22%3A1000%2C%22min_width%22%3A200%2C%22bytes_step%22%3A20000%2C%22max_images%22%3A20%7D%2C%7B%22create_derived%22%3Afalse%2C%22format%22%3A%22jpg%22%2C%22transformation%22%3A%22c_fill%2Cw_0.75%2Ce_sharpen%22%2C%22max_width%22%3A2000%2C%22min_width%22%3A350%2C%22max_images%22%3A18%7D%5D"
    end

    test "encodes the context parameter with the context values" do
      assert Uploader.encode_params(%{context: [alt: "My = image", caption: "Profile | image"]}) ==
               "context=alt%3DMy+%5C%3D+image%7Ccaption%3DProfile+%5C%7C+image"
    end

    test "encodes the metadata parameter with the metadata values" do
      metadata = [in_stock_id: 50, color_id: "[\"green\",\"red\"]"]

      assert Uploader.encode_params(%{metadata: metadata}) ==
               "metadata=in_stock_id%3D50%7Ccolor_id%3D%5B%5C%22green%5C%22%2C%5C%22red%5C%22%5D"
    end

    test "encodes the eager parameter with an eager transformation" do
      eager = [transformation: [crop: :fit, angle: 6, effect: :auto_contrast]]
      assert Uploader.encode_params(%{eager: eager}) == "eager=c_fit%2Ca_6%2Ce_auto_contrast"
    end

    test "encodes the eager parameter with a list of eager transformations" do
      eager = [
        [
          transformation: [crop: :fit, angle: 6, effect: :auto_contrast],
          format: :png
        ],
        %{
          transformation: [[effect: {:art, :audrey}], [effect: {:art, :zorro}]]
        }
      ]

      assert Uploader.encode_params(%{eager: eager}) ==
               "eager=c_fit%2Ca_6%2Ce_auto_contrast%2Fpng%7Ce_art%3Aaudrey%2Fe_art%3Azorro"
    end

    test "encodes the headers parameter with a tuple" do
      assert Uploader.encode_params(%{headers: {"x-robots-tag", "noindex"}}) ==
               "headers=x-robots-tag%3A+noindex"
    end

    test "encodes the headers parameter with a list of tuples" do
      headers = [
        {"x-robots-tag", "noindex"},
        {"link", "<https://example.com>; rel=\"preconnect\""}
      ]

      assert Uploader.encode_params(%{headers: headers}) ==
               "headers=x-robots-tag%3A+noindex%0Alink%3A+%3Chttps%3A%2F%2Fexample.com%3E%3B+rel%3D%22preconnect%22"
    end
  end
end
