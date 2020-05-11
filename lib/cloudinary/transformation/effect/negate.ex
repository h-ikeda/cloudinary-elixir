defmodule Cloudinary.Transformation.Effect.Negate do
  @moduledoc """
  Representing the nagate color filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_negate"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_negate"
  end
end
