defmodule Cloudinary.Transformation.Effect.Vibrance do
  @moduledoc """
  Representing the vibrance filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 70} |> to_string()
      "e_vibrance:70"
  """
  @type t :: %__MODULE__{strength: -100..100}
  defstruct strength: 20

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in -100..100, do: "e_vibrance:#{strength}"
  end
end
