defmodule Cloudinary.Transformation.Angle do
  @moduledoc false
  defguardp is_mode(mode) when mode in [:auto_right, :auto_left, :ignore, :vflip, :hflip]

  @spec to_url_string(Cloudinary.Transformation.angle()) :: String.t()
  def to_url_string(angle) when is_number(angle) or is_mode(angle), do: "#{angle}"

  def to_url_string(modes) when is_list(modes) do
    if Enum.all?(modes, fn mode -> is_mode(mode) end) do
      Enum.join(modes, ".")
    else
      raise ArgumentError, "expeted a list of the angle mode atoms"
    end
  end
end
