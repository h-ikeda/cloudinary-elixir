defmodule Cloudinary.Transformation.Effect.Reverse do
  @moduledoc """
  Representing the effect that generates a reversed video.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_reverse"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_reverse"
  end
end
