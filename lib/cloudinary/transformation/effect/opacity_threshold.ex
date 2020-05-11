defmodule Cloudinary.Transformation.Effect.OpacityThreshold do
  @moduledoc """
  Representing the transparency level of the semi-transparent pixels.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{threshold: 40} |> to_string()
      "e_opacity_threshold:40"
  """
  @type t :: %__MODULE__{threshold: 0..100}
  defstruct threshold: 50

  defimpl String.Chars do
    def to_string(%{threshold: threshold}) when threshold in 0..100 do
      "e_opacity_threshold:#{threshold}"
    end
  end
end
