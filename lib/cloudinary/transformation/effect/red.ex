defmodule Cloudinary.Transformation.Effect.Red do
  @moduledoc """
  Representing the red channel adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{value: 50} |> to_string()
      "e_red:50"
  """
  @type t :: %__MODULE__{value: -100..100}
  defstruct value: 0

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -100..100, do: "e_red:#{value}"
  end
end
