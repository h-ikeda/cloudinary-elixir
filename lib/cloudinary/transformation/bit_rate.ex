defmodule Cloudinary.Transformation.BitRate do
  @moduledoc """
  Representing the `bit_rate` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> %#{__MODULE__}{bps: 12000000} |> to_string()
      "br_12m"

      iex> %#{__MODULE__}{bps: 800000, constant: true} |> to_string()
      "br_800k:constant"
  """
  @type t :: %__MODULE__{bps: pos_integer, constant: boolean}
  defstruct bps: 5_000_000, constant: false

  defimpl String.Chars do
    def to_string(%{constant: true} = bit_rate), do: "#{%{bit_rate | constant: false}}:constant"

    def to_string(%{bps: bps, constant: false}) when is_integer(bps) and bps > 0 do
      "br_#{"#{bps}" |> String.replace_suffix("000000", "m") |> String.replace_suffix("000", "k")}"
    end
  end
end
