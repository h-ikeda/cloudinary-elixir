defmodule Cloudinary.Transformation.Effect.Sepia do
  @moduledoc """
  Representing the sepia effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 50} |> to_string()
      "e_sepia:50"
  """
  @type t :: %__MODULE__{strength: 1..100}
  defstruct strength: 80

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..100, do: "e_sepia:#{strength}"
  end
end
