defmodule Cloudinary.Transformation.Width do
  @moduledoc false
  defguardp is_width(width) when is_number(width) and width >= 0
  defguardp is_rounding_step(rounding_step) when is_number(rounding_step) and rounding_step > 0

  defguardp is_bytes_step(bytes_step)
            when is_integer(bytes_step) and bytes_step > 0 and rem(bytes_step, 1000) == 0

  defguardp is_max_images(max_images) when max_images in 3..200

  @spec to_url_string(Cloudinary.Transformation.width()) :: String.t()
  def to_url_string(width) when is_width(width) or width == :auto, do: "#{width}"

  def to_url_string({:auto, %{rounding_step: _, breakpoints: _}}) do
    raise ArgumentError, ":rounding_step and :breakpoints options cannot be put at same time"
  end

  def to_url_string({:auto, %{width: _, breakpoints: _}}) do
    raise ArgumentError, ":width and :breakpoints options cannot be put at same time"
  end

  def to_url_string({:auto, %{rounding_step: rounding_step, width: width}})
      when is_rounding_step(rounding_step) and is_width(width) do
    "auto:#{rounding_step}:#{width}"
  end

  def to_url_string({:auto, %{rounding_step: rounding_step}})
      when is_rounding_step(rounding_step) do
    "auto:#{rounding_step}"
  end

  def to_url_string({:auto, %{width: width}}) when is_width(width), do: "auto:100:#{width}"
  def to_url_string({:auto, %{breakpoints: true}}), do: "auto:breakpoints"

  def to_url_string({:auto, %{breakpoints: breakpoints}}) when is_map(breakpoints) do
    "auto:#{breakpoints_to_url_string(breakpoints)}"
  end

  defp breakpoints_to_url_string(%{min_width: mn, max_width: mx, bytes_step: stp, max_images: i})
       when is_width(mx) and mn <= mx and is_bytes_step(stp) and is_max_images(i) do
    "breakpoints_#{mn}_#{mx}_#{div(stp, 1000)}_#{i}"
  end

  defp breakpoints_to_url_string(breakpoints) do
    breakpoints
    |> Map.put_new(:max_images, 20)
    |> Map.put_new(:bytes_step, 20000)
    |> Map.put_new(:max_width, 1000)
    |> Map.put_new(:min_width, 50)
    |> breakpoints_to_url_string()
  end
end
