defmodule Cloudinary.Transformation.Effect.Progressbar do
  @moduledoc false
  import Cloudinary.Transformation.Color
  defguardp is_type(type) when type in [:frame, :bar]
  defguardp is_color(color) when is_rgb(color) or is_binary(color)
  defguardp is_width(width) when is_number(width) and width >= 0

  @spec to_url_string(%{
          optional(:type) => :frame | :bar,
          optional(:color) => Cloudinary.Transformation.Color.t(),
          optional(:width) => non_neg_integer | float
        }) :: String.t()
  def to_url_string(%{type: type, color: color, width: width})
      when is_type(type) and is_color(color) and is_width(width) do
    "progressbar:#{type}:#{color}:#{width}"
  end

  def to_url_string(%{type: type, color: color}) when is_type(type) and is_color(color) do
    "progressbar:#{type}:#{color}"
  end

  def to_url_string(%{type: type, width: width}) when is_type(type) and is_width(width) do
    "progressbar:type_#{type}:width_#{width}"
  end

  def to_url_string(%{type: type}) when is_type(type), do: "progressbar:#{type}"

  def to_url_string(%{color: color, width: width}) when is_color(color) and is_width(width) do
    "progressbar:color_#{color}:width_#{width}"
  end

  def to_url_string(%{color: color}) when is_color(color), do: "progressbar:color_#{color}"
  def to_url_string(%{width: width}) when is_width(width), do: "progressbar:width_#{width}"
end
