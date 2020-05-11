defmodule Cloudinary.Transformation.Layer.TextStyle do
  @moduledoc """
  Representing a text style used to overlay/underlay text captions.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#styling_parameters
  ## Example
      iex> %#{__MODULE__}{font_family: "verdana", font_size: 75, font_weight: :bold, text_decoration: :underline, letter_spacing: 14} |> to_string()
      "verdana_75_bold_underline_letter_spacing_14"
  """
  @type t :: %__MODULE__{
          font_family: String.t(),
          font_size: pos_integer,
          font_weight: :normal | :bold | :thin | :light,
          font_style: :normal | :italic,
          text_decoration: :normal | :underline | :strikethrough,
          text_align: :left | :center | :right | :end | :start | :justify,
          stroke: :none | :stroke,
          letter_spacing: integer | nil,
          line_spacing: integer | nil,
          font_antialias: :none | :gray | :subpixel | :fast | :good | :best | nil,
          font_hinting: :none | :slight | :medium | :full | nil
        }
  defstruct font_family: nil,
            font_size: nil,
            font_weight: :normal,
            font_style: :normal,
            text_decoration: :normal,
            text_align: :left,
            stroke: :none,
            letter_spacing: nil,
            line_spacing: nil,
            font_antialias: nil,
            font_hinting: nil

  defimpl String.Chars do
    def to_string(%{font_hinting: font_hinting} = style)
        when font_hinting in [:none, :slight, :medium, :full] do
      "#{%{style | font_hinting: nil}}_hinting_#{font_hinting}"
    end

    def to_string(%{font_antialias: font_antialias} = style)
        when font_antialias in [:none, :gray, :subpixel, :fast, :good, :best] do
      "#{%{style | font_antialias: nil}}_antialias_#{font_antialias}"
    end

    def to_string(%{line_spacing: line_spacing} = style)
        when is_integer(line_spacing) do
      "#{%{style | line_spacing: nil}}_line_spacing_#{line_spacing}"
    end

    def to_string(%{letter_spacing: letter_spacing} = style)
        when is_integer(letter_spacing) do
      "#{%{style | letter_spacing: nil}}_letter_spacing_#{letter_spacing}"
    end

    def to_string(%{stroke: :stroke} = style), do: "#{%{style | stroke: :none}}_stroke"

    def to_string(%{text_align: text_align} = style)
        when text_align in [:center, :right, :end, :start, :justify] do
      "#{%{style | text_align: :left}}_#{text_align}"
    end

    def to_string(%{text_decoration: text_decoration} = style)
        when text_decoration in [:underline, :strikethrough] do
      "#{%{style | text_decoration: :normal}}_#{text_decoration}"
    end

    def to_string(%{font_style: :italic} = style), do: "#{%{style | font_style: :normal}}_italic"

    def to_string(%{font_weight: font_weight} = style)
        when font_weight in [:bold, :thin, :light] do
      "#{%{style | font_weight: :normal}}_#{font_weight}"
    end

    def to_string(%{
          font_family: font_family,
          font_size: font_size,
          font_weight: :normal,
          font_style: :normal,
          text_decoration: :normal,
          text_align: :left,
          stroke: :none,
          letter_spacing: nil,
          line_spacing: nil,
          font_antialias: nil,
          font_hinting: nil
        })
        when is_binary(font_family) and is_integer(font_size) and font_size > 0 do
      "#{font_family}_#{font_size}"
    end
  end
end
