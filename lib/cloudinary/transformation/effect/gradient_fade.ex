defmodule Cloudinary.Transformation.Effect.GradientFade do
  @moduledoc """
  Representing the gradient fade effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 40} |> to_string()
      "e_gradient_fade:40"

      iex> %#{__MODULE__}{strength: 25, symmetric: true} |> to_string()
      "e_gradient_fade:symmetric:25"

      iex> %#{__MODULE__}{strength: 50, symmetric: :pad} |> to_string()
      "e_gradient_fade:symmetric_pad:50"
  """
  @type t :: %__MODULE__{strength: 0..100, symmetric: boolean | :pad}
  defstruct strength: 20, symmetric: false

  defimpl String.Chars do
    def to_string(%{strength: strength, symmetric: :pad}) when strength in 0..100 do
      "e_gradient_fade:symmetric_pad:#{strength}"
    end

    def to_string(%{strength: strength, symmetric: true}) when strength in 0..100 do
      "e_gradient_fade:symmetric:#{strength}"
    end

    def to_string(%{strength: strength, symmetric: false}) when strength in 0..100 do
      "e_gradient_fade:#{strength}"
    end
  end
end
