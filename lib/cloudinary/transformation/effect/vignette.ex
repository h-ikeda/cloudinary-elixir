defmodule Cloudinary.Transformation.Effect.Vignette do
  @moduledoc """
  Representing the vignette effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{strength: 30} |> to_string()
      "e_vignette:30"
  """
  @type t :: %__MODULE__{strength: 0..100}
  defstruct strength: 20

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 0..100, do: "e_vignette:#{strength}"
  end
end
