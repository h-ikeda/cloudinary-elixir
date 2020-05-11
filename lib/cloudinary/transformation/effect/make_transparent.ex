defmodule Cloudinary.Transformation.Effect.MakeTransparent do
  @moduledoc """
  Representing the effect making the image background transparent.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{tolerance: 40} |> to_string()
      "e_make_transparent:40"
  """
  @type t :: %__MODULE__{tolerance: 0..100}
  defstruct tolerance: 10

  defimpl String.Chars do
    def to_string(%{tolerance: tolerance}) when tolerance in 0..100 do
      "e_make_transparent:#{tolerance}"
    end
  end
end
