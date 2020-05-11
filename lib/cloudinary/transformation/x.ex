defmodule Cloudinary.Transformation.X do
  @moduledoc """
  Representing the `x` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#x_parameter
  ## Example
      iex> %#{__MODULE__}{value: 40} |> to_string()
      "x_40"

      iex> %#{__MODULE__}{value: 0.3} |> to_string()
      "x_0.3"
  """
  @type t :: %__MODULE__{value: integer | float}
  defstruct value: 0

  defimpl String.Chars do
    def to_string(%{value: x}) when is_integer(x) or is_float(x), do: "x_#{x}"
  end
end
