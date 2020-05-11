defmodule Cloudinary.Transformation.Effect.Hue do
  @moduledoc """
  Representing the hue adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{value: 40} |> to_string()
      "e_hue:40"
  """
  @type t :: %__MODULE__{value: -100..100}
  defstruct value: 80

  defimpl String.Chars do
    def to_string(%{value: value}) when value in -100..100, do: "e_hue:#{value}"
  end
end
