defmodule Cloudinary.Transformation.Angle do
  @moduledoc false
  defguardp is_mode(mode) when mode in [:auto_right, :auto_left, :ignore, :vflip, :hflip]

  @spec to_url_string(Cloudinary.Transformation.angle()) :: String.t()
  def to_url_string(angle) when is_number(angle) or is_mode(angle), do: "#{angle}"
  def to_url_string([mode]) when is_mode(mode), do: "#{mode}"

  def to_url_string([mode1, mode2]) when is_mode(mode1) and is_mode(mode2) do
    "#{mode1}.#{mode2}"
  end

  def to_url_string([mode1, mode2, mode3])
      when is_mode(mode1) and is_mode(mode2) and is_mode(mode3) do
    "#{mode1}.#{mode2}.#{mode3}"
  end

  def to_url_string([mode1, mode2, mode3, mode4])
      when is_mode(mode1) and is_mode(mode2) and is_mode(mode3) and is_mode(mode4) do
    "#{mode1}.#{mode2}.#{mode3}.#{mode4}"
  end

  def to_url_string([mode1, mode2, mode3, mode4, mode5])
      when is_mode(mode1) and
             is_mode(mode2) and is_mode(mode3) and is_mode(mode4) and is_mode(mode5) do
    "#{mode1}.#{mode2}.#{mode3}.#{mode4}.#{mode5}"
  end
end
