defmodule Cloudinary.Transformation.Effect.Vectorize do
  @moduledoc false
  defguardp is_colors(colors) when colors in 2..30
  defguardp is_detail(detail) when (detail <= 1 and detail >= 0) or detail in 2..1000
  defguardp is_despeckle(despeckl) when (despeckl <= 1 and despeckl >= 0) or despeckl in 2..100
  defguardp is_paths(paths) when paths <= 100 and paths >= 0
  defguardp is_corners(corners) when corners <= 100 and corners >= 0
  defguardp is_not_map_key(map, key) when not is_map_key(map, key)
  defguardp is_not_map_key(map, k1, k2) when is_not_map_key(map, k1) and is_not_map_key(map, k2)
  defguardp is_not_map_key(m, k1, k2, k3) when is_not_map_key(m, k1, k2) and is_not_map_key(m, k3)

  @spec to_url_string(%{
          optional(:colors) => 2..30,
          optional(:detail) => 0..1000 | float,
          optional(:despeckle) => 0..100 | float,
          optional(:paths) => 0..100 | float,
          optional(:corners) => 0..100 | float
        }) :: String.t()
  def to_url_string(%{colors: c, detail: t, despeckle: s, paths: p, corners: r})
      when is_colors(c) and is_detail(t) and is_despeckle(s) and is_paths(p) and is_corners(r) do
    "vectorize:#{c}:#{t}:#{s}:#{p}:#{r}"
  end

  def to_url_string(%{colors: c, detail: t, despeckle: s, paths: p})
      when is_colors(c) and is_detail(t) and is_despeckle(s) and is_paths(p) do
    "vectorize:#{c}:#{t}:#{s}:#{p}"
  end

  def to_url_string(%{colors: c, detail: t, despeckle: s} = options)
      when is_colors(c) and is_detail(t) and is_despeckle(s) and is_not_map_key(options, :corners) do
    "vectorize:#{c}:#{t}:#{s}"
  end

  def to_url_string(%{colors: c, detail: t} = options)
      when is_colors(c) and is_detail(t) and is_not_map_key(options, :paths, :corners) do
    "vectorize:#{c}:#{t}"
  end

  def to_url_string(%{colors: c} = options)
      when is_colors(c) and is_not_map_key(options, :despeckle, :paths, :corners) do
    "vectorize:#{c}"
  end

  def to_url_string(%{colors: c} = options) when is_colors(c) do
    "#{to_url_string(Map.delete(options, :colors))}:colors:#{c}"
  end

  def to_url_string(%{detail: t} = options) when is_detail(t) do
    "#{to_url_string(Map.delete(options, :detail))}:detail:#{t}"
  end

  def to_url_string(%{despeckle: s} = options) when is_despeckle(s) do
    "#{to_url_string(Map.delete(options, :despeckle))}:despeckle:#{s}"
  end

  def to_url_string(%{paths: p} = options) when is_paths(p) do
    "#{to_url_string(Map.delete(options, :paths))}:paths:#{p}"
  end

  def to_url_string(%{corners: r} = options) when is_corners(r) do
    "#{to_url_string(Map.delete(options, :corners))}:corners:#{r}"
  end

  def to_url_string(%{}), do: "vectorize"
end
