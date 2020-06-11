defmodule Cloudinary.Transformation.Effect.Improve do
  @moduledoc false
  defguardp is_mode(mode) when mode in [:indoor, :outdoor]
  defguardp is_blend(blend) when blend <= 100 and blend >= 0

  @spec to_url_string(%{optional(:mode) => :indoor | :outdoor, optional(:blend) => 1..100 | float}) ::
          String.t()
  def to_url_string(%{mode: mode, blend: blend}) when is_mode(mode) and is_blend(blend) do
    "improve:#{mode}:#{blend}"
  end

  def to_url_string(%{mode: mode}) when is_mode(mode), do: "improve:#{mode}"
  def to_url_string(%{blend: blend}) when is_blend(blend), do: "improve:#{blend}"
end
