defmodule Cloudinary.Transformation.Effect.OilPaint do
  @moduledoc """
  Representing the oil paint effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 40} |> to_string()
      "e_oil_paint:40"
  """
  @type t :: %__MODULE__{strength: 0..100}
  defstruct strength: 30

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 0..100, do: "e_oil_paint:#{strength}"
  end
end
