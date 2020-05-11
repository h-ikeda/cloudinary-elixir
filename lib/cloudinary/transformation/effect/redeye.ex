defmodule Cloudinary.Transformation.Effect.Redeye do
  @moduledoc """
  Representing the removing redeyes effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_redeye"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_redeye"
  end
end
