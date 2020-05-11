defmodule Cloudinary.Transformation.Effect.Multiply do
  @moduledoc """
  Representing the multiply blending with the overlay image.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_multiply"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_multiply"
  end
end
