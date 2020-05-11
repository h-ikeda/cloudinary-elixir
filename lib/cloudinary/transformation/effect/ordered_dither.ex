defmodule Cloudinary.Transformation.Effect.OrderedDither do
  @moduledoc """
  Representing the dither effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{level: 3} |> to_string()
      "e_ordered_dither:3"
  """
  @type t :: %__MODULE__{level: 0..18}
  defstruct level: 0

  defimpl String.Chars do
    def to_string(%{level: level}) when level in 0..18 do
      "e_ordered_dither:#{level}"
    end
  end
end
