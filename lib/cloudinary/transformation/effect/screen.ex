defmodule Cloudinary.Transformation.Effect.Screen do
  @moduledoc """
  Representing the screen blending with the overlay image.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_screen"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_screen"
  end
end
