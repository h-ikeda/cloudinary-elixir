defmodule Cloudinary.Transformation.Effect.BackgroundRemoval do
  @moduledoc """
  Representing the background removing filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_bgremoval"

      iex> %#{__MODULE__}{preset: :screen} |> to_string()
      "e_bgremoval:screen"

      iex> %#{__MODULE__}{background_color: 0x8AF02B} |> to_string()
      "e_bgremoval:8af02b"

      iex> %#{__MODULE__}{preset: :screen, background_color: 0x8AF02B} |> to_string()
      "e_bgremoval:screen:8af02b"
  """
  @type t :: %__MODULE__{preset: :screen | nil, background_color: 0..0xFFFFFFFF | nil}
  defstruct [:preset, :background_color]

  defimpl String.Chars do
    def to_string(%{background_color: color} = removal) when color in 0..0xFFFFFF do
      "#{%{removal | background_color: nil}}:#{Integer.to_string(color, 16) |> String.downcase()}"
    end

    def to_string(%{preset: preset}) when preset in [:screen, nil] do
      "e_bgremoval#{if preset, do: ":#{preset}"}"
    end
  end
end
