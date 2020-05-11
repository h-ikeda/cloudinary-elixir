defmodule Cloudinary.Transformation.Effect.BlurRegion do
  @moduledoc """
  Representing the blur effect on a specified region.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 200} |> to_string()
      "e_blur_region:200"
  """
  @type t :: %__MODULE__{strength: 1..2000}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..2000, do: "e_blur_region:#{strength}"
  end
end
