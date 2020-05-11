defmodule Cloudinary.Transformation.Effect.StyleTransfer do
  @moduledoc """
  Representing the style transfer effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/neural_artwork_style_transfer_addon
  ## Example
      iex> %#{__MODULE__}{style_strength: 60} |> to_string()
      "e_style_transfer:60"

      iex> %#{__MODULE__}{preserve_color: true, style_strength: 40} |> to_string()
      "e_style_transfer:preserve_color:40"
  """
  @type t :: %__MODULE__{preserve_color: boolean, style_strength: 0..100}
  defstruct preserve_color: false, style_strength: 100

  defimpl String.Chars do
    def to_string(%{preserve_color: preserve_color, style_strength: style_strength})
        when is_boolean(preserve_color) and style_strength in 0..100 do
      "e_style_transfer:#{if preserve_color, do: "preserve_color:"}#{style_strength}"
    end
  end
end
