defmodule Cloudinary.Transformation.Effect.Overlay do
  @moduledoc """
  Representing the overlay blending with the overlay image.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_overlay"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_overlay"
  end
end
