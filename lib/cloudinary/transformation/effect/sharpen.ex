defmodule Cloudinary.Transformation.Effect.Sharpen do
  @moduledoc """
  Representing the sharpening filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 400} |> to_string()
      "e_sharpen:400"
  """
  @type t :: %__MODULE__{strength: 1..2000}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..2000, do: "e_sharpen:#{strength}"
  end
end
