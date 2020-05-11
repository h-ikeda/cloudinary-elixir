defmodule Cloudinary.Transformation.Effect.Green do
  @moduledoc """
  Representing the green channel adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{value: -30} |> to_string()
      "e_green:-30"
  """
  @type t :: %__MODULE__{value: -100..100}
  defstruct value: 0

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -100..100, do: "e_green:#{value}"
  end
end
