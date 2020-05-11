defmodule Cloudinary.Transformation.Effect.Shadow do
  @moduledoc """
  Representing the effect that adds a shadow.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 50} |> to_string()
      "e_shadow:50"
  """
  @type t :: %__MODULE__{strength: 0..100}
  defstruct strength: 40

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 0..100, do: "e_shadow:#{strength}"
  end
end
