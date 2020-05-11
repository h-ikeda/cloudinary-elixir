defmodule Cloudinary.Transformation.Effect.Accelerate do
  @moduledoc """
  Representing the video speeding up effect.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{percent: 100} |> to_string()
      "e_accelerate:100"
  """
  @type t :: %__MODULE__{percent: -50..100}
  defstruct percent: 0

  defimpl String.Chars do
    def to_string(%{percent: percent}) when percent in -50..100, do: "e_accelerate:#{percent}"
  end
end
