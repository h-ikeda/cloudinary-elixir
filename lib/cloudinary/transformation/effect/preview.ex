defmodule Cloudinary.Transformation.Effect.Preview do
  @moduledoc """
  Representing the effect that generates a preview of the video.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{duration: 12.0, max_segments: 3, min_segment_duration: 3} |> to_string()
      "e_previes:duration_12.0:max_seg_3:min_seg_dur_3"
  """
  @type t :: %__MODULE__{duration: float, max_segments: pos_integer, min_segment_duration: float}
  defstruct duration: 5.0, max_segments: 1, min_segment_duration: 5.0

  defimpl String.Chars do
    def to_string(%{duration: dur, max_segments: max_seg, min_segment_duration: min_seg_dur})
        when is_float(dur) and dur > 0 and
               is_integer(max_seg) and max_seg > 0 and
               is_float(min_seg_dur) and min_seg_dur > 0 do
      "e_preview:duration_#{dur}:max_seg_#{max_seg}:min_seg_dur_#{min_seg_dur}"
    end
  end
end
