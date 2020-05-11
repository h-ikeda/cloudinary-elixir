defmodule Cloudinary.Transformation.Effect.Shear do
  @moduledoc """
  Representing the skewing effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{x: 20} |> to_string()
      "e_shear:20:0"
  """
  @type t :: %__MODULE__{x: integer, y: integer}
  defstruct x: 0, y: 0

  defimpl String.Chars do
    def to_string(%{x: x, y: y}) when is_integer(x) and is_integer(y), do: "e_shear:#{x}:#{y}"
  end
end
