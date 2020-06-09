defmodule Cloudinary.Transformation.Effect.Outline do
  @moduledoc false
  defguardp is_mode(mode) when mode in [:inner, :inner_fill, :outer, :fill]
  defguardp is_width(width) when width <= 100 and width >= 0
  defguardp is_blur(blur) when blur <= 2000 and blur >= 0

  @spec to_url_string(%{
          optional(:mode) => :inner | :inner_fill | :outer | :fill,
          optional(:width) => 1..100 | float,
          optional(:blur) => 0..2000 | float
        }) :: String.t()
  def to_url_string(%{mode: mode, width: width, blur: blur})
      when is_mode(mode) and is_width(width) and is_blur(blur) do
    "outline:#{mode}:#{width}:#{blur}"
  end

  def to_url_string(%{mode: mode, width: width}) when is_mode(mode) and is_width(width) do
    "outline:#{mode}:#{width}"
  end

  def to_url_string(%{mode: mode, blur: blur}) when is_mode(mode) and is_blur(blur) do
    "outline:#{mode}:5:#{blur}"
  end

  def to_url_string(%{width: width, blur: blur}) when is_width(width) and is_blur(blur) do
    "outline:#{width}:#{blur}"
  end

  def to_url_string(%{blur: blur}) when is_blur(blur), do: "outline:5:#{blur}"
  def to_url_string(%{width: width}) when is_width(width), do: "outline:#{width}"
  def to_url_string(%{mode: mode}) when is_mode(mode), do: "outline:#{mode}"
end
