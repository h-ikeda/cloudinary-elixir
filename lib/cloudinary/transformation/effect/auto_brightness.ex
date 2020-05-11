defmodule Cloudinary.Transformation.Effect.AutoBrightness do
  @moduledoc """
  Representing the automatic brightness adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{amount: 70} |> to_string()
      "e_auto_brightness:70"
  """
  @type t :: %__MODULE__{amount: 0..100}
  defstruct amount: 100

  defimpl String.Chars do
    def to_string(%{amount: amount}) when amount in 0..100, do: "e_auto_brightness:#{amount}"
  end
end
