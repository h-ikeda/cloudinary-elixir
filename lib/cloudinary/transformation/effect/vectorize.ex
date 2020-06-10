defmodule Cloudinary.Transformation.Effect.Vectorize do
  @moduledoc false
  defguardp is_colors(colors) when colors in 2..30
  defguardp is_detail(detail) when (detail <= 1 and detail >= 0) or detail in 2..1000
  defguardp is_despeckle(despeckl) when (despeckl <= 1 and despeckl >= 0) or despeckl in 2..100
  defguardp is_paths(paths) when paths <= 100 and paths >= 0
  defguardp is_corners(corners) when corners <= 100 and corners >= 0

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

  def to_url_string(%{colors: c, detail: t, despeckle: s, corners: r})
      when is_colors(c) and is_detail(t) and is_despeckle(s) and is_corners(r) do
    "vectorize:colors:#{c}:detail:#{t}:despeckle:#{s}:corners:#{r}"
  end

  def to_url_string(%{colors: c, detail: t, paths: p, corners: r})
      when is_colors(c) and is_detail(t) and is_paths(p) and is_corners(r) do
    "vectorize:colors:#{c}:detail:#{t}:paths:#{p}:corners:#{r}"
  end

  def to_url_string(%{colors: c, despeckle: s, paths: p, corners: r})
      when is_colors(c) and is_despeckle(s) and is_paths(p) and is_corners(r) do
    "vectorize:colors:#{c}:despeckle:#{s}:paths:#{p}:corners:#{r}"
  end

  def to_url_string(%{detail: t, despeckle: s, paths: p, corners: r})
      when is_detail(t) and is_despeckle(s) and is_paths(p) and is_corners(r) do
    "vectorize:detail:#{t}:despeckle:#{s}:paths:#{p}:corners:#{r}"
  end

  def to_url_string(%{colors: c, detail: t, despeckle: s})
      when is_colors(c) and is_detail(t) and is_despeckle(s) do
    "vectorize:#{c}:#{t}:#{s}"
  end

  def to_url_string(%{colors: c, detail: t, paths: p})
      when is_colors(c) and is_detail(t) and is_paths(p) do
    "vectorize:colors:#{c}:detail:#{t}:paths:#{p}"
  end

  def to_url_string(%{colors: c, detail: t, corners: r})
      when is_colors(c) and is_detail(t) and is_corners(r) do
    "vectorize:colors:#{c}:detail:#{t}:corners:#{r}"
  end

  def to_url_string(%{colors: c, despeckle: s, paths: p})
      when is_colors(c) and is_despeckle(s) and is_paths(p) do
    "vectorize:colors:#{c}:despeckle:#{s}:paths:#{p}"
  end

  def to_url_string(%{colors: c, despeckle: s, corners: r})
      when is_colors(c) and is_despeckle(s) and is_corners(r) do
    "vectorize:colors:#{c}:despeckle:#{s}:corners:#{r}"
  end

  def to_url_string(%{colors: c, paths: p, corners: r})
      when is_colors(c) and is_paths(p) and is_corners(r) do
    "vectorize:colors:#{c}:paths:#{p}:corners:#{r}"
  end

  def to_url_string(%{colors: c, detail: t}) when is_colors(c) and is_detail(t) do
    "vectorize:#{c}:#{t}"
  end

  def to_url_string(%{colors: c, despeckle: s}) when is_colors(c) and is_despeckle(s) do
    "vectorize:colors:#{c}:despeckle:#{s}"
  end

  def to_url_string(%{colors: c, paths: p}) when is_colors(c) and is_paths(p) do
    "vectorize:colors:#{c}:paths:#{p}"
  end

  def to_url_string(%{colors: c, corners: r}) when is_colors(c) and is_corners(r) do
    "vectorize:colors:#{c}:corners:#{r}"
  end

  def to_url_string(%{detail: t, despeckle: s}) when is_detail(t) and is_despeckle(s) do
    "vectorize:detail:#{t}:despeckle:#{s}"
  end

  def to_url_string(%{detail: t, paths: p}) when is_detail(t) and is_paths(p) do
    "vectorize:detail:#{t}:paths:#{p}"
  end

  def to_url_string(%{detail: t, corners: r}) when is_detail(t) and is_corners(r) do
    "vectorize:detail:#{t}:corners:#{r}"
  end

  def to_url_string(%{despeckle: s, paths: p}) when is_despeckle(s) and is_paths(p) do
    "vectorize:despeckle:#{s}:paths:#{p}"
  end

  def to_url_string(%{despeckle: s, corners: r}) when is_despeckle(s) and is_corners(r) do
    "vectorize:despeckle:#{s}:corners:#{r}"
  end

  def to_url_string(%{paths: p, corners: r}) when is_paths(p) and is_corners(r) do
    "vectorize:paths:#{p}:corners:#{r}"
  end

  def to_url_string(%{colors: c}) when is_colors(c), do: "vectorize:#{c}"
  def to_url_string(%{detail: t}) when is_detail(t), do: "vectorize:detail:#{t}"
  def to_url_string(%{despeckle: s}) when is_despeckle(s), do: "vectorize:despeckle:#{s}"
  def to_url_string(%{paths: p}) when is_paths(p), do: "vectorize:paths:#{p}"
  def to_url_string(%{corners: r}) when is_corners(r), do: "vectorize:corners:#{r}"
end
