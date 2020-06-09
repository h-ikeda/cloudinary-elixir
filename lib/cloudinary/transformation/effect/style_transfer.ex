defmodule Cloudinary.Transformation.Effect.StyleTransfer do
  @moduledoc false
  defguardp is_truthy(as_boolean) when as_boolean not in [false, nil]
  defguardp is_style_strength(style_strength) when style_strength <= 100 and style_strength >= 0

  @spec to_url_string(%{
          optional(:preserve_color) => as_boolean(any),
          required(:style_strength) => 0..100 | float
        }) :: String.t()
  def to_url_string(%{preserve_color: preserve_color, style_strength: style_strength})
      when is_truthy(preserve_color) and is_style_strength(style_strength) do
    "style_transfer:preserve_color:#{style_strength}"
  end

  def to_url_string(%{style_strength: style_strength}) when is_style_strength(style_strength) do
    "style_transfer:#{style_strength}"
  end
end
