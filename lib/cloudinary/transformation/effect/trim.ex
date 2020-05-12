defmodule Cloudinary.Transformation.Effect.Trim do
  @moduledoc """
  Representing the effect that trims the image edges.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{color_similarity: 30, color_override: "white"} |> to_string()
      "e_trim:30:white"

      iex> %#{__MODULE__}{color_similarity: 30, color_override: 0xE8D9AA} |> to_string()
      "e_trim:30:rgb:e8d9aa"

      iex> %#{__MODULE__}{color_similarity: 40} |> to_string()
      "e_trim:40"
  """
  @type t :: %__MODULE__{
          color_similarity: 0..100,
          color_override: 0..0xFFFFFFFF | String.t() | nil
        }
  defstruct color_similarity: 10, color_override: nil

  defimpl String.Chars do
    def to_string(%{color_override: color_override} = trim)
        when color_override in 0..0xFFFFFFFF do
      "#{%{trim | color_override: nil}}" <>
        ":rgb:#{Integer.to_string(color_override, 16) |> String.downcase()}"
    end

    def to_string(%{color_override: color_override} = trim) when is_binary(color_override) do
      "#{%{trim | color_override: nil}}:#{color_override}"
    end

    def to_string(%{color_similarity: color_similarity, color_override: nil})
        when color_similarity in 0..100 do
      "e_trim:#{color_similarity}"
    end
  end
end
