defmodule Cloudinary.Transformation.Effect.AutoContrast do
  @moduledoc """
  Representing the automatic contrast adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{amount: 90} |> to_string()
      "e_auto_contrast:90"
  """
  @type t :: %__MODULE__{amount: 0..100}
  defstruct amount: 100

  defimpl String.Chars do
    def to_string(%{amount: amount}) when amount in 0..100, do: "e_auto_contrast:#{amount}"
  end
end
