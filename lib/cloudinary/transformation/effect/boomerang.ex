defmodule Cloudinary.Transformation.Effect.Boomerang do
  @moduledoc """
  Representing the effect that generates a movie playing alternate forward and backward.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  https://cloudinary.com/documentation/video_manipulation_and_delivery#create_a_boomerang_video_clip
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_boomerang"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_reverse"
  end
end
