defmodule Cloudinary.Transformation.Effect.Tint do
  @moduledoc """
  Representing the tint effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#tint_effects
  ## Example
      iex> %#{__MODULE__}{amount: 80, colors: ["blue", "green", 0x47DA8B]} |> to_string()
      "e_tint:80:blue:green:rgb:47da8b"

      iex> %#{__MODULE__}{amount: 50, colors: [{0x6F71EA, 40}, {"yellow", 35}]} |> to_string()
      "e_tint:50:rgb:6f71ea:40p:yellow:35p"
  """
  @type colors :: [0..0xFFFFFF | String.t()] | [{0..0xFFFFFF | String.t(), 0..100}]
  @type t :: %__MODULE__{
          equalize: boolean,
          amount: 0..100,
          colors: colors
        }
  defstruct equalize: false, amount: 60, colors: ["red"]

  defimpl String.Chars do
    def to_string(%{equalize: equalize, amount: amount, colors: colors})
        when is_boolean(equalize) and amount in 0..100 and is_list(colors) and length(colors) > 0 do
      "e_tint:#{if equalize, do: "equalize:"}#{amount}:#{colors_to_string(colors)}"
    end

    @spec colors_to_string(@for.colors()) :: String.t()
    defp colors_to_string(colors) do
      colors
      |> Enum.map(fn
        color when color in 0..0xFFFFFF ->
          "rgb:#{Integer.to_string(color, 16) |> String.downcase(:ascii)}"

        color when is_binary(color) ->
          color

        {color, position} when color in 0..0xFFFFFF and position in 0..100 ->
          "rgb:#{Integer.to_string(color, 16) |> String.downcase(:ascii)}:#{position}p"

        {color, position} when is_binary(color) and position in 0..100 ->
          "#{color}:#{position}p"
      end)
      |> Enum.join(":")
    end
  end
end
