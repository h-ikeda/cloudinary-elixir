defmodule Cloudinary.Transformation.Y do
  @moduledoc """
  Representing the `y` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#y_parameter
  ## Example
      iex> %#{__MODULE__}{value: 40} |> to_string()
      "y_40"

      iex> %#{__MODULE__}{value: 0.3} |> to_string()
      "y_0.3"
  """
  @type t :: %__MODULE__{value: integer | float}
  defstruct value: 0

  defimpl String.Chars do
    def to_string(%{value: y}) when is_integer(y) or is_float(y), do: "y_#{y}"
  end
end
