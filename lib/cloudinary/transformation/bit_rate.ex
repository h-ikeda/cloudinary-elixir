defmodule Cloudinary.Transformation.BitRate do
  @moduledoc false
  @spec to_url_string(Cloudinary.Transformation.bit_rate()) :: String.t()
  def to_url_string(bit_rate) when is_number(bit_rate) and bit_rate > 0, do: shorten(bit_rate)

  def to_url_string({bit_rate, :constant}) when is_number(bit_rate) and bit_rate > 0 do
    "#{shorten(bit_rate)}:constant"
  end

  defp shorten(bit_rate) when is_integer(bit_rate) do
    Integer.to_string(bit_rate)
    |> String.replace_suffix("000000", "m")
    |> String.replace_suffix("000", "k")
  end

  defp shorten(bit_rate) when is_float(bit_rate) do
    :erlang.float_to_binary(bit_rate, [:compact, decimals: 20])
    |> String.replace_suffix("000000.0", "m")
    |> String.replace_suffix("000.0", "k")
  end
end
