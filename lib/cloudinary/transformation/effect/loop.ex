defmodule Cloudinary.Transformation.Effect.Loop do
  @moduledoc """
  Representing the effect making the animation or the video to run multiple times.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{times: 2} |> to_string()
      "e_loop:2"
  """
  @type t :: %__MODULE__{times: non_neg_integer}
  defstruct [:times]

  defimpl String.Chars do
    def to_string(%{times: times}) when is_integer(times) and times >= 0, do: "e_loop:#{times}"
  end
end
