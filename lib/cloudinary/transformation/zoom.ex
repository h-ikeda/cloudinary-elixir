defmodule Cloudinary.Transformation.Zoom do
  @moduledoc """
  Representing the `zoom` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#zoom_parameter
  ## Example
      iex> %#{__MODULE__}{value: 1.2} |> to_string()
      "z_1.2"

      iex> %#{__MODULE__}{value: 0.7} |> to_string()
      "z_0.7"
  """
  @type t :: %__MODULE__{value: float}
  defstruct value: 1.0

  defimpl String.Chars do
    def to_string(%{value: zoom}) when is_float(zoom) and zoom > 0, do: "z_#{zoom}"
  end
end
