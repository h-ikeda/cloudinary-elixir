defmodule Cloudinary.UploaderTest do
  use ExUnit.Case
  alias Cloudinary.Uploader
  doctest Uploader

  describe "convert_params/1" do
    test "encodes the allowed_formats parameter with a string" do
      assert Uploader.convert_params(%{allowed_formats: "txt"}) == [allowed_formats: "txt"]
    end

    test "encodes the allowed_formats parameter with an atom" do
      assert Uploader.convert_params(%{allowed_formats: :png}) == [allowed_formats: :png]
    end

    test "encodes the allowed_formats parameter with a list" do
      assert Uploader.convert_params(%{allowed_formats: ["txt", :svg]}) ==
               [allowed_formats: "txt,svg"]
    end

    test "raises if the allowed_formats parameter with a list including invalid formats" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{allowed_formats: [:dwg, "png"]})
      end
    end

    test "encodes the custom_coordinates parameter with a tuple of numbers" do
      assert Uploader.convert_params(%{custom_coordinates: {85, 120, 220, 310}}) ==
               [custom_coordinates: "85,120,220,310"]
    end

    test "encodes the face_coordinates parameter with a tuple of numbers" do
      assert Uploader.convert_params(%{face_coordinates: {85, 120, 220, 310}}) ==
               [face_coordinates: "85,120,220,310"]
    end

    test "encodes the face_coordinates parameter with a list of tuples" do
      assert Uploader.convert_params(%{face_coordinates: [{10, 20, 150, 130}, {213, 345, 82, 61}]}) ==
               [face_coordinates: "10,20,150,130|213,345,82,61"]
    end

    test "encodes the access_mode parameter with an atom" do
      assert Uploader.convert_params(%{access_mode: :public}) == [access_mode: :public]
    end

    test "encodes the background_removal parameter with an atom" do
      assert Uploader.convert_params(%{background_removal: :cloudinary_ai}) ==
               [background_removal: :cloudinary_ai]
    end

    test "encodes the detection parameter with an atom" do
      assert Uploader.convert_params(%{detection: :adv_face}) == [detection: :adv_face]
    end

    test "encodes the moderation parameter with an atom" do
      assert Uploader.convert_params(%{moderation: :metascan}) == [moderation: :metascan]
    end

    test "encodes the ocr parameter with an atom" do
      assert Uploader.convert_params(%{ocr: :adv_ocr}) == [ocr: :adv_ocr]
    end

    test "encodes the raw_convert parameter with an atom" do
      assert Uploader.convert_params(%{raw_convert: :extract_text}) == [
               raw_convert: :extract_text
             ]
    end

    test "encodes the type parameter with an atom" do
      assert Uploader.convert_params(%{type: :authenticated}) == [type: :authenticated]
    end

    test "encodes the categorization parameter with an atom" do
      assert Uploader.convert_params(%{categorization: :google_video_tagging}) ==
               [categorization: :google_video_tagging]
    end

    test "encodes the categorization parameter with a list of atoms" do
      assert Uploader.convert_params(%{categorization: [:google_video_tagging, :aws_rek_tagging]}) ==
               [categorization: "google_video_tagging,aws_rek_tagging"]
    end

    test "raises if the categorization parameter with a list including invalid categorizations" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{categorization: [:unkown, :google_video_tagging]})
      end
    end

    test "encodes the access_control parameter with an access_type option" do
      assert Uploader.convert_params(%{access_control: [access_type: :anonymous]}) ==
               [access_control: "{\"access_type\":\"anonymous\"}"]
    end

    test "encodes the access_control parameter with access_type and start options" do
      access_control = [access_type: :anonymous, start: DateTime.from_unix!(1_427_110_463)]

      assert Uploader.convert_params(%{access_control: access_control}) ==
               [
                 access_control:
                   "{\"access_type\":\"anonymous\",\"start\":\"2015-03-23T11:34:23Z\"}"
               ]
    end

    test "encodes the access_control parameter with access_type and end options" do
      access_control = [access_type: :anonymous, end: DateTime.from_unix!(1_527_840_601)]

      assert Uploader.convert_params(%{access_control: access_control}) ==
               [
                 access_control:
                   "{\"access_type\":\"anonymous\",\"end\":\"2018-06-01T08:10:01Z\"}"
               ]
    end

    test "encodes the access_control parameter with access_type, start and end options" do
      access_control = [
        access_type: :anonymous,
        start: DateTime.from_unix!(1_427_110_463),
        end: DateTime.from_unix!(1_527_840_601)
      ]

      assert Uploader.convert_params(%{access_control: access_control}) ==
               [
                 access_control:
                   "{\"access_type\":\"anonymous\",\"start\":\"2015-03-23T11:34:23Z\",\"end\":\"2018-06-01T08:10:01Z\"}"
               ]
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

      assert Uploader.convert_params(%{responsive_breakpoints: responsive_breakpoint}) ==
               [
                 responsive_breakpoints:
                   "[{\"create_derived\":true,\"transformation\":\"c_fill,ar_16:9,g_face\",\"max_width\":1000,\"min_width\":200,\"bytes_step\":20000,\"max_images\":20}]"
               ]
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
        },
        [create_derived: true]
      ]

      assert Uploader.convert_params(%{responsive_breakpoints: responsive_breakpoints}) ==
               [
                 responsive_breakpoints:
                   "[{\"create_derived\":true,\"transformation\":\"c_fill,ar_16:9,g_face\",\"max_width\":1000,\"min_width\":200,\"bytes_step\":20000,\"max_images\":20},{\"create_derived\":false,\"format\":\"jpg\",\"transformation\":\"c_fill,w_0.75,e_sharpen\",\"max_width\":2000,\"min_width\":350,\"max_images\":18},{\"create_derived\":true}]"
               ]
    end

    test "raises if the responsive_breakpoints parameter has invalid format options" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{
          responsive_breakpoints: [create_derived: true, format: :unknown]
        })
      end
    end

    test "raises if the responsive_breakpoints parameter has invalid max_width options" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{
          responsive_breakpoints: [create_derived: true, max_width: "invalid"]
        })
      end
    end

    test "raises if the responsive_breakpoints parameter has invalid min_width options" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{
          responsive_breakpoints: [create_derived: true, min_width: "invalid"]
        })
      end
    end

    test "raises if the responsive_breakpoints parameter has invalid bytes_step options" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{
          responsive_breakpoints: [create_derived: true, bytes_step: "invalid"]
        })
      end
    end

    test "raises if the responsive_breakpoints parameter has invalid max_images options" do
      assert_raise ArgumentError, fn ->
        Uploader.convert_params(%{
          responsive_breakpoints: [create_derived: true, max_images: "invalid"]
        })
      end
    end

    test "encodes the context parameter with the context values" do
      assert Uploader.convert_params(%{context: [alt: "My = image", caption: "Profile | image"]}) ==
               [context: "alt=My \\= image|caption=Profile \\| image"]
    end

    test "encodes the metadata parameter with the metadata values" do
      metadata = [in_stock_id: 50, color_id: "[\"green\",\"red\"]"]

      assert Uploader.convert_params(%{metadata: metadata}) ==
               [metadata: "in_stock_id=50|color_id=[\\\"green\\\",\\\"red\\\"]"]
    end

    test "encodes the eager parameter with an eager transformation" do
      eager = [transformation: [crop: :fit, angle: 6, effect: :auto_contrast]]
      assert Uploader.convert_params(%{eager: eager}) == [eager: "c_fit,a_6,e_auto_contrast"]
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

      assert Uploader.convert_params(%{eager: eager}) ==
               [eager: "c_fit,a_6,e_auto_contrast/png|e_art:audrey/e_art:zorro"]
    end

    test "encodes the headers parameter with a tuple" do
      assert Uploader.convert_params(%{headers: {"x-robots-tag", "noindex"}}) ==
               [headers: "x-robots-tag: noindex"]
    end

    test "encodes the headers parameter with a list of tuples" do
      headers = [
        {"x-robots-tag", "noindex"},
        {"link", "<https://example.com>; rel=\"preconnect\""}
      ]

      assert Uploader.convert_params(%{headers: headers}) ==
               [headers: "x-robots-tag: noindex\nlink: <https://example.com>; rel=\"preconnect\""]
    end
  end
end
