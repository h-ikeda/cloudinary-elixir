defmodule Cloudinary.Transformation.Effect.Trim do
  @moduledoc false
  import Cloudinary.Transformation.Color
  defguardp is_color_similarity(similarity) when similarity <= 100 and similarity >= 0

  @spec to_url_string(%{
          optional(:color_similarity) => 0..100 | float,
          optional(:color_override) => Cloudinary.Transformation.Color.t()
        }) :: String.t()
  def to_url_string(%{color_similarity: similarity, color_override: override})
      when is_color_similarity(similarity) and (is_rgb(override) or is_rgba(override)) do
    "trim:#{similarity}:rgb:#{override}"
  end

  def to_url_string(%{color_similarity: similarity, color_override: override})
      when is_color_similarity(similarity) and is_binary(override) do
    "trim:#{similarity}:#{override}"
  end

  def to_url_string(%{color_similarity: similarity}) when is_color_similarity(similarity) do
    "trim:#{similarity}"
  end

  def to_url_string(%{color_override: override}) do
    to_url_string(%{color_similarity: 10, color_override: override})
  end
end
