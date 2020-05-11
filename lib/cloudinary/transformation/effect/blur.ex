defmodule Cloudinary.Transformation.Effect.Blur do
  @moduledoc """
  Representing the blur effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 300} |> to_string()
      "e_blur:300"
  """
  @type t :: %__MODULE__{strength: 1..2000}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..2000, do: "e_blur:#{strength}"
  end
end
