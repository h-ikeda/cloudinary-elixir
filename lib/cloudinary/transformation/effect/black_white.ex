defmodule Cloudinary.Transformation.Effect.BlackWhite do
  @moduledoc """
  Representing the effect to generate an image with only black and white.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_blackwhite"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_blackwhite"
  end
end
