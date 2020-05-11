defmodule Cloudinary.Transformation.Effect.ViesusCorrect do
  @moduledoc """
  Representing the automatic image enhancement.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/viesus_automatic_image_enhancement_addon
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_viesus_correct"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_viesus_correct"
  end
end
