defmodule Cloudinary.Transformation.Effect.PixelateRegion do
  @moduledoc """
  Representing the pixelate effect on the specified region.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{pixels: 20} |> to_string()
      "e_pixelate_region:20"
  """
  @type t :: %__MODULE__{pixels: 1..200}
  defstruct pixels: 5

  defimpl String.Chars do
    def to_string(%{pixels: pixels}) when pixels in 1..200, do: "e_pixelate_region:#{pixels}"
  end
end
