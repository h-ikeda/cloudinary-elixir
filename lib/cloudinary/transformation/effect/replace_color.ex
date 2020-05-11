defmodule Cloudinary.Transformation.Effect.ReplaceColor do
  @moduledoc """
  Representing the simply replacing color filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#color_effects
  ## Example
      iex> %#{__MODULE__}{to: "saddlebrown", tolerance: 30} |> to_string()
      "e_replace_color:saddlebrown:30"

      iex> %#{__MODULE__}{to: 0x2F4F4F, tolerance: 20} |> to_string()
      "e_replace_color:2f4f4f:20"

      iex> %#{__MODULE__}{to: "silver", tolerance: 60, from: 0x89B8ED} |> to_string()
      "e_replace_color:silver:60:89b8ed"
  """
  @type t :: %__MODULE__{
          to: 0..0xFFFFFFFF | String.t(),
          tolerance: non_neg_integer,
          from: 0..0xFFFFFFFF | String.t() | nil
        }
  defstruct to: nil, tolerance: 50, from: nil

  defimpl String.Chars do
    def to_string(%{to: to_color, tolerance: tolerance, from: nil})
        when to_color in 0..0xFFFFFFFF and is_integer(tolerance) and tolerance >= 0 do
      "e_replace_color:#{Integer.to_string(to_color, 16) |> String.downcase(:ascii)}:#{tolerance}"
    end

    def to_string(%{to: to_color, tolerance: tolerance, from: nil})
        when is_binary(to_color) and is_integer(tolerance) and tolerance >= 0 do
      "e_replace_color:#{to_color}:#{tolerance}"
    end

    def to_string(%{from: from_color} = replace) when from_color in 0..0xFFFFFFFF do
      "#{%{replace | from: nil}}:#{Integer.to_string(from_color, 16) |> String.downcase(:ascii)}"
    end

    def to_string(%{from: from_color} = replace) when is_binary(from_color) do
      "#{%{replace | from: nil}}:#{from_color}"
    end
  end
end
