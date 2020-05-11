defmodule Cloudinary.Transformation.Fps do
  @moduledoc """
  Representing the `fps` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> %#{__MODULE__}{min: 25} |> to_string()
      "fps_25-"

      iex> %#{__MODULE__}{min: 20, max: 30} |> to_string()
      "fps_20-30"
  """
  @type t :: %__MODULE__{min: pos_integer, max: pos_integer | nil}
  defstruct [:min, :max]

  defimpl String.Chars do
    def to_string(%{min: min, max: max})
        when is_integer(min) and min > 0 and is_integer(max) and max > 0
        when is_integer(min) and min > 0 and is_nil(max) do
      "fps_#{min}-#{max}"
    end
  end
end
