defmodule Cloudinary.Transformation.Effect.PixelateFaces do
  @moduledoc """
  Representing the pixelate effect on faces.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{pixels: 7} |> to_string()
      "e_pixelate_faces:7"
  """
  @type t :: %__MODULE__{pixels: 1..200}
  defstruct pixels: 5

  defimpl String.Chars do
    def to_string(%{pixels: pixels}) when pixels in 1..200, do: "e_pixelate_faces:#{pixels}"
  end
end
