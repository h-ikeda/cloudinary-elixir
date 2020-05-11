defmodule Cloudinary.Transformation.Duration do
  @moduledoc """
  Representing the `duration` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#trimming_and_overlay_offsets
  ## Example
      iex> %#{__MODULE__}{seconds: 6.32} |> to_string()
      "du_6.32"

      iex> %#{__MODULE__}{percents: 62.0} |> to_string()
      "du_62.0p"
  """
  @type t ::
          %__MODULE__{seconds: float, percents: nil}
          | %__MODULE__{seconds: nil, percents: float}
  defstruct [:seconds, :percents]

  defimpl String.Chars do
    def to_string(%{seconds: duration, percents: nil})
        when is_float(duration) and duration >= 0 do
      "du_#{duration}"
    end

    def to_string(%{seconds: nil, percents: duration})
        when is_float(duration) and duration >= 0 do
      "du_#{duration}p"
    end
  end
end
