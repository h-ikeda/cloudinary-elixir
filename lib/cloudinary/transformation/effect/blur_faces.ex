defmodule Cloudinary.Transformation.Effect.BlurFaces do
  @moduledoc """
  Representing the blur effect on faces.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 600} |> to_string()
      "e_blur_faces:600"
  """
  @type t :: %__MODULE__{strength: 1..2000}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 1..2000, do: "e_blur_faces:#{strength}"
  end
end
