defmodule Cloudinary.Transformation.Effect.Fade do
  @moduledoc """
  Representing the fade in/out effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{milliseconds: 2000} |> to_string()
      "e_fade:2000"
  """
  @type t :: %__MODULE__{milliseconds: integer}
  defstruct milliseconds: 1000

  defimpl String.Chars do
    def to_string(%{milliseconds: milliseconds}) when is_integer(milliseconds) do
      "e_fade:#{milliseconds}"
    end
  end
end
