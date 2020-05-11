defmodule Cloudinary.Transformation.Effect.Gamma do
  @moduledoc """
  Representing the gamma level adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{level: 50} |> to_string()
      "e_gamma:50"
  """
  @type t :: %__MODULE__{level: -50..150}
  defstruct level: 0

  defimpl String.Chars do
    def to_string(%{level: level}) when level in -50..150, do: "e_gamma:#{level}"
  end
end
