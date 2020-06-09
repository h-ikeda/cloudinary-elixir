defmodule Cloudinary.Transformation.Effect.FillLight do
  @moduledoc false
  defguardp is_amount(amount) when amount <= 100 and amount >= 0
  defguardp is_bias(bias) when bias <= 100 and bias >= -100

  @spec to_url_string(%{optional(:amount) => 0..100 | float, optional(:bias) => -100..100 | float}) ::
          String.t()
  def to_url_string(%{amount: amount, bias: bias}) when is_amount(amount) and is_bias(bias) do
    "fill_light:#{amount}:#{bias}"
  end

  def to_url_string(%{amount: amount}) when is_amount(amount), do: "fill_light:#{amount}"
  def to_url_string(%{bias: bias}) when is_bias(bias), do: "fill_light:100:#{bias}"
end
