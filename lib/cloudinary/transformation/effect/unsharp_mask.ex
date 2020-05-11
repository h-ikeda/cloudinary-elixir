defmodule Cloudinary.Transformation.Effect.UnsharpMask do
  @moduledoc """
  Representing the unsharp mask filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 200} |> to_string()
      "e_unsharp_mask:200"
  """
  @type t :: %__MODULE__{strength: 1..2000}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..2000 do
      "e_unsharp_mask:#{strength}"
    end
  end
end
