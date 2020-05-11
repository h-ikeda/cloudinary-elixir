defmodule Cloudinary.Transformation.Effect.Grayscale do
  @moduledoc """
  Representing the effect that generates a gray-scaled image.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_grayscale"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_grayscale"
  end
end
