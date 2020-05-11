defmodule Cloudinary.Transformation.Effect.Outline do
  @moduledoc """
  Representing the effect that adds outlines.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#outline_effects
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{width: 8, blur: 20} |> to_string()
      "e_outline:8:20"

      iex> %#{__MODULE__}{mode: :outer, width: 10, blur: 200} |> to_string()
      "e_outline:outer:10:200"
  """
  @type t :: %__MODULE__{
          mode: :inner | :inner_fill | :outer | :fill | nil,
          width: 1..100,
          blur: 0..200
        }
  defstruct mode: nil, width: 5, blur: 0

  defimpl String.Chars do
    def to_string(%{mode: mode, width: width, blur: blur})
        when mode in [:inner, :inner_fill, :outer, :fill, nil] and
               width in 1..100 and blur in 0..200 do
      "e_outline:#{if mode, do: "#{mode}:"}#{width}:#{blur}"
    end
  end
end
