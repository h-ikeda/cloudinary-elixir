defmodule Cloudinary.Transformation.Effect.Volume do
  @moduledoc """
  Representing the volume adjustment.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{decibels: -10.0} |> to_string()
      "e_volume:-10.0dB"

      iex> %#{__MODULE__}{decibels: :mute} |> to_string()
      "e_volume:mute"
  """
  @type t :: %__MODULE__{decibels: float | :mute}
  defstruct decibels: 0.0

  defimpl String.Chars do
    def to_string(%{decibels: :mute}), do: "e_volume:mute"
    def to_string(%{decibels: decibels}) when is_float(decibels), do: "e_volume:#{decibels}dB"
  end
end
