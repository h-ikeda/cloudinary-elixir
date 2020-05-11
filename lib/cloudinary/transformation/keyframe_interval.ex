defmodule Cloudinary.Transformation.KeyframeInterval do
  @moduledoc """
  Representing the `keyframe_interval` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> %#{__MODULE__}{seconds: 0.15} |> to_string()
      "ki_0.15"
  """
  @type t :: %__MODULE__{seconds: float}
  defstruct [:seconds]

  defimpl String.Chars do
    def to_string(%{seconds: sec}) when is_float(sec) and sec > 0, do: "ki_#{sec}"
  end
end
