defmodule Cloudinary.Transformation.Effect.Pixelate do
  @moduledoc """
  Representing the pixelate effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{pixels: 3} |> to_string()
      "e_pixelate:3"
  """
  @type t :: %__MODULE__{pixels: 1..200}
  defstruct pixels: 5

  defimpl String.Chars do
    def to_string(%{pixels: pixels}) when pixels in 1..200, do: "e_pixelate:#{pixels}"
  end
end
