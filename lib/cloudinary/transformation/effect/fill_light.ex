defmodule Cloudinary.Transformation.Effect.FillLight do
  @moduledoc """
  Representing the fill light adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{amount: 70, bias: 20} |> to_string()
      "e_fill_light:70:20"
  """
  @type t :: %__MODULE__{amount: 0..100, bias: -100..100}
  defstruct amount: 100, bias: 0

  defimpl String.Chars do
    def to_string(%{amount: amount, bias: bias}) when amount in 0..100 and bias in -100..100 do
      "e_fill_light:#{amount}:#{bias}"
    end
  end
end
