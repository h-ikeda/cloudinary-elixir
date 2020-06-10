defmodule Cloudinary.Transformation.Border do
  @moduledoc false
  import Cloudinary.Transformation.Color
  defguardp is_width(width) when is_number(width) and width > 0
  defguardp is_style(style) when style in [:solid]

  @spec to_url_string(%{
          optional(:width) => pos_integer | float,
          optional(:style) => :solid,
          optional(:color) => Cloudinary.Transformation.Color.t()
        }) :: String.t()
  def to_url_string(%{width: width, style: style, color: color})
      when is_width(width) and is_style(style) and is_binary(color) do
    "#{width}px_#{style}_#{color}"
  end

  def to_url_string(%{width: width, style: style, color: color})
      when is_width(width) and is_style(style) and (is_rgb(color) or is_rgba(color)) do
    "#{width}px_#{style}_rgb:#{color}"
  end

  def to_url_string(%{style: style, color: color}) when is_style(style) and is_binary(color) do
    "2px_#{style}_#{color}"
  end

  def to_url_string(%{style: style, color: color})
      when is_style(style) and (is_rgb(color) or is_rgba(color)) do
    "2px_#{style}_rgb:#{color}"
  end

  def to_url_string(%{width: width, color: color}) when is_width(width) and is_binary(color) do
    "#{width}px_solid_#{color}"
  end

  def to_url_string(%{width: width, color: color})
      when is_width(width) and (is_rgb(color) or is_rgba(color)) do
    "#{width}px_solid_rgb:#{color}"
  end

  def to_url_string(%{width: width, style: style}) when is_width(width) and is_style(style) do
    "#{width}px_#{style}_black"
  end

  def to_url_string(%{color: color}) when is_binary(color) do
    "2px_solid_#{color}"
  end

  def to_url_string(%{color: color}) when is_rgb(color) or is_rgba(color) do
    "2px_solid_rgb:#{color}"
  end

  def to_url_string(%{style: style}) when is_style(style), do: "2px_#{style}_black"
  def to_url_string(%{width: width}) when is_width(width), do: "#{width}px_solid_black"
end
