defmodule Cloudinary.Transformation.Effect.Tint do
  @moduledoc false
  import Cloudinary.Transformation.Color
  defguardp is_truthy(as_boolean) when as_boolean not in [false, nil]
  defguardp is_amount(amount) when amount <= 100 and amount >= 0
  defguardp is_position(position) when position <= 100 and position >= 0

  @spec to_url_string(%{
          optional(:equalize) => as_boolean(any),
          optional(:amount) => 0..100 | float,
          optional(:color) =>
            Cloudinary.Transformation.Color.t()
            | {Cloudinary.Transformation.Color.t(), 0..100 | float}
            | [Cloudinary.Transformation.Color.t()]
            | [{Cloudinary.Transformation.Color.t(), 0..100 | float}]
        }) :: String.t()
  def to_url_string(%{equalize: equalize, amount: amount, color: {color, position}})
      when is_truthy(equalize) and is_amount(amount) and is_rgb(color) and is_position(position) do
    "tint:equalize:#{amount}:rgb:#{color}:#{position}p"
  end

  def to_url_string(%{equalize: equalize, amount: amount, color: {color, position}})
      when is_truthy(equalize) and is_amount(amount) and
             is_binary(color) and is_position(position) do
    "tint:equalize:#{amount}:#{color}:#{position}p"
  end

  def to_url_string(%{equalize: equalize, amount: amount, color: color})
      when is_truthy(equalize) and is_amount(amount) and is_rgb(color) do
    "tint:equalize:#{amount}:rgb:#{color}"
  end

  def to_url_string(%{equalize: equalize, amount: amount, color: color})
      when is_truthy(equalize) and is_amount(amount) and is_binary(color) do
    "tint:equalize:#{amount}:#{color}"
  end

  def to_url_string(%{equalize: equalize, amount: amount, color: colors})
      when is_truthy(equalize) and is_amount(amount) and is_list(colors) do
    "tint:equalize:#{amount}:#{extract_color_list(colors)}"
  end

  def to_url_string(%{amount: amount, color: {color, position}})
      when is_amount(amount) and is_rgb(color) and is_position(position) do
    "tint:#{amount}:rgb:#{color}:#{position}p"
  end

  def to_url_string(%{amount: amount, color: {color, position}})
      when is_amount(amount) and is_binary(color) and is_position(position) do
    "tint:#{amount}:#{color}:#{position}p"
  end

  def to_url_string(%{amount: amount, color: color}) when is_amount(amount) and is_rgb(color) do
    "tint:#{amount}:rgb:#{color}"
  end

  def to_url_string(%{amount: amount, color: color})
      when is_amount(amount) and is_binary(color) do
    "tint:#{amount}:#{color}"
  end

  def to_url_string(%{amount: amount, color: colors})
      when is_amount(amount) and is_list(colors) do
    "tint:#{amount}:#{extract_color_list(colors)}"
  end

  def to_url_string(%{equalize: equalize, amount: amount})
      when is_amount(amount) and is_truthy(equalize) do
    "tint:equalize:#{amount}"
  end

  def to_url_string(%{equalize: equalize, color: {color, position}})
      when is_truthy(equalize) and is_rgb(color) and is_position(position) do
    "tint:equalize:60:rgb:#{color}:#{position}p"
  end

  def to_url_string(%{equalize: equalize, color: {color, position}})
      when is_truthy(equalize) and is_binary(color) and is_position(position) do
    "tint:equalize:60:#{color}:#{position}p"
  end

  def to_url_string(%{equalize: equalize, color: color})
      when is_truthy(equalize) and is_rgb(color) do
    "tint:equalize:60:rgb:#{color}"
  end

  def to_url_string(%{equalize: equalize, color: color})
      when is_truthy(equalize) and is_binary(color) do
    "tint:equalize:60:#{color}"
  end

  def to_url_string(%{equalize: equalize, color: colors})
      when is_truthy(equalize) and is_list(colors) do
    "tint:equalize:60:#{extract_color_list(colors)}"
  end

  def to_url_string(%{amount: amount}) when is_amount(amount), do: "tint:#{amount}"

  def to_url_string(%{color: {color, position}}) when is_rgb(color) and is_position(position) do
    "tint:60:rgb:#{color}:#{position}p"
  end

  def to_url_string(%{color: {color, position}})
      when is_binary(color) and is_position(position) do
    "tint:60:#{color}:#{position}p"
  end

  def to_url_string(%{color: color}) when is_rgb(color), do: "tint:60:rgb:#{color}"
  def to_url_string(%{color: color}) when is_binary(color), do: "tint:60:#{color}"

  def to_url_string(%{color: colors}) when is_list(colors) do
    "tint:60:#{extract_color_list(colors)}"
  end

  def to_url_string(%{equalize: equalize}) when is_truthy(equalize), do: "tint:equalize"

  @spec extract_color_list(
          [Cloudinary.Transformation.Color.t()]
          | [{Cloudinary.Transformation.Color.t(), 0..100 | float}]
        ) :: String.t()
  defp extract_color_list(colors) when is_list(colors) do
    cond do
      Enum.all?(colors, &is_tuple/1) -> Enum.map_join(colors, ":", &position_to_string/1)
      true -> Enum.map_join(colors, ":", &color_to_string/1)
    end
  end

  @spec position_to_string({Cloudinary.Transformation.Color.t(), 0..100 | float}) :: String.t()
  defp position_to_string({color, position}) when is_rgb(color) and is_position(position) do
    "rgb:#{color}:#{position}p"
  end

  defp position_to_string({color, position}) when is_binary(color) and is_position(position) do
    "#{color}:#{position}p"
  end

  @spec color_to_string(Cloudinary.Transformation.Color.t()) :: String.t()
  defp color_to_string(color) when is_rgb(color), do: "rgb:#{color}"
  defp color_to_string(color) when is_binary(color), do: color
end
