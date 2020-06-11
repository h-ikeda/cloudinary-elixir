defmodule Cloudinary.Transformation.Layer do
  @moduledoc """
  The overlay/underlay transformations.
  """
  defguardp is_font_size(font_size) when is_integer(font_size) and font_size >= 0

  @typedoc """
  Any type of overlay/underlay options.

  The `t:String.t/0` is treated as a public ID of the overlay image.
  ## Example
      iex> #{__MODULE__}.to_url_string(overlay: "badge")
      "l_badge"
  """
  @type t :: String.t() | fetch | lut | text | subtitles | video
  @doc """
  Converts the overlay/underlay options to an URL string.
  """
  @spec to_url_string(t) :: String.t()
  def to_url_string(id) when is_binary(id), do: String.replace(id, "/", ":")

  @typedoc """
  The overlay image coming from a remote server.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformation_reference#overlay_parameter
  ## Example
      iex> #{__MODULE__}.to_url_string(%{url: "http://example.com/path/to/remote/image.jpg"})
      "fetch:aHR0cDovL2V4YW1wbGUuY29tL3BhdGgvdG8vcmVtb3RlL2ltYWdlLmpwZw=="
  """
  @type fetch :: %{url: String.t()}
  def to_url_string(%{url: url}) when is_binary(url), do: "fetch:#{Base.url_encode64(url)}"

  @typedoc """
  Applying 3D look up tables to the image.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#applying_3d_luts_to_images
  ## Example
      iex> #{__MODULE__}.to_url_string(%{lut: "iwltbap_aspen.3dl"})
      "lut:iwltbap_aspen.3dl"
  """
  @type lut :: %{lut: String.t()}
  def to_url_string(%{lut: id}) when is_binary(id), do: "lut:#{id}"

  @typedoc """
  The overlay video specified by the public ID.
  ## Official documentation
  * https://cloudinary.com/documentation/video_transformation_reference#adding_overlays_to_videos  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#adding_video_overlays
  ## Example
      iex> #{__MODULE__}.to_url_string(%{video: "dog"})
      "video:dog"
  """
  @type video :: %{video: String.t()}
  def to_url_string(%{video: id}) when is_binary(id), do: "video:#{id}"

  @typedoc """
  Adding subtitles to the video.
  ## Official documentation
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#adding_subtitles
  ## Example
      iex> #{__MODULE__}.to_url_string(%{subtitles: "sample_sub_en.srt"})
      "subtitles:sample_sub_en.srt"

      iex> #{__MODULE__}.to_url_string(%{subtitles: "sample_sub_en.srt", font_family: "arial", font_size: 20})
      "subtitles:arial_20:sample_sub_en.srt"
  """
  @type subtitles :: %{
          required(:subtitles) => String.t(),
          optional(:font_family) => String.t(),
          optional(:font_size) => non_neg_integer
        }
  def to_url_string(%{subtitles: id, font_family: font_family, font_size: font_size})
      when is_binary(id) and is_binary(font_family) and is_font_size(font_size) do
    "subtitles:#{font_family}_#{font_size}:#{id}"
  end

  def to_url_string(%{subtitles: id}) when is_binary(id), do: "subtitles:#{id}"

  @typedoc """
  Adding a text captions to the image.

  The font styles should be specified by the options `:font_family`, `:font_size`, and optional
  style parameters, or a public ID of predefined text image with the `:predefined` option.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#adding_text_captions  
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#adding_text_captions
  ## Example
      iex> #{__MODULE__}.to_url_string(%{text: "Flowers", font_family: "Arial", font_size: 80})
      "text:Arial_80:Flowers"

      iex> #{__MODULE__}.to_url_string(%{text: "Stylish Text/", font_family: "verdana", font_size: 75, font_weight: :bold, text_decoration: :underline, letter_spacing: 14})
      "text:verdana_75_bold_underline_letter_spacing_14:Stylish%20Text%2F"

      iex> #{__MODULE__}.to_url_string(%{text: "Stylish text", predefined: "sample_text_style"})
      "text:sample_text_style:Stylish%20Text"
  """
  @type text ::
          %{text: String.t(), predefined: String.t()}
          | %{
              required(:text) => String.t(),
              required(:font_family) => String.t(),
              required(:font_size) => non_neg_integer,
              optional(:font_weight) => :normal | :bold | :thin | :light,
              optional(:font_style) => :normal | :italic,
              optional(:text_decoration) => :normal | :underline | :strikethrough,
              optional(:text_align) => :left | :center | :right | :end | :start | :justify,
              optional(:stroke) => :none | :stroke,
              optional(:letter_spacing) => number,
              optional(:line_spacing) => number,
              optional(:font_antialias) => :none | :gray | :subpixel | :fast | :good | :best,
              optional(:font_hinting) => :none | :slight | :medium | :full
            }
  def to_url_string(%{text: text, predefined: id}) when is_binary(text) and is_binary(id) do
    "text:#{id}:#{escape(text)}"
  end

  def to_url_string(%{text: text, font_family: font_family, font_size: font_size} = options)
      when is_binary(text) and is_binary(font_family) and is_font_size(font_size) do
    text_style =
      options
      |> Map.take([
        :font_weight,
        :font_style,
        :text_decoration,
        :text_align,
        :stroke,
        :letter_spacing,
        :line_spacing,
        :font_antialias,
        :font_hinting
      ])
      |> Enum.map(fn
        {:font_weight, font_weight} when font_weight in [:normal, :bold, :thin, :light] ->
          font_weight

        {:font_style, font_style} when font_style in [:normal, :italic] ->
          font_style

        {:text_decoration, decoration} when decoration in [:normal, :underline, :strikethrough] ->
          decoration

        {:text_align, align} when align in [:left, :center, :right, :end, :start, :justify] ->
          align

        {:stroke, stroke} when stroke in [:none, :stroke] ->
          stroke

        {:letter_spacing, letter_spacing} when is_number(letter_spacing) ->
          "letter_spacing_#{letter_spacing}"

        {:line_spacing, line_spacing} when is_number(line_spacing) ->
          "line_spacing_#{line_spacing}"

        {:font_antialias, aalias} when aalias in [:none, :gray, :subpixel, :fast, :good, :best] ->
          "antialias_#{aalias}"

        {:font_hinting, hinting} when hinting in [:none, :slight, :medium, :full] ->
          "hinting_#{hinting}"
      end)

    "text:#{Enum.join([font_family, font_size | text_style], "_")}:#{escape(text)}"
  end

  @spec escape(String.t()) :: String.t()
  defp escape(text) do
    text |> URI.encode(&(&1 not in [?,, ?%])) |> URI.encode(&URI.char_unreserved?/1)
  end
end
