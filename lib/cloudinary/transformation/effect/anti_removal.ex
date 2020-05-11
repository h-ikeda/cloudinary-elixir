defmodule Cloudinary.Transformation.Effect.AntiRemoval do
  @moduledoc """
  Representing the overlay anti removal level.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{level: 90} |> to_string()
      "e_anti_removal:90"
  """
  @type t :: %__MODULE__{level: 1..100}
  defstruct level: 50

  defimpl String.Chars do
    def to_string(%{level: level}) when level in 1..100, do: "e_anti_removal:#{level}"
  end
end
