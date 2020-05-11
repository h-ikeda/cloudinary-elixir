defmodule Cloudinary.Transformation.Effect.Transition do
  @moduledoc """
  Representing the transition effect.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_transition"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_transition"
  end
end
