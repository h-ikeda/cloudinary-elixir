defmodule Cloudinary.Transformation.Effect.Noise do
  @moduledoc """
  Representing the noise effect.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{strength: 10} |> to_string()
      "e_noise:10"
  """
  @type t :: %__MODULE__{strength: 0..100}
  defstruct strength: 0

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 0..100, do: "e_noise:#{strength}"
  end
end
