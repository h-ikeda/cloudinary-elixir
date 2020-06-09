defmodule Cloudinary.Transformation.Effect.Preview do
  @moduledoc false
  defguardp is_duration(duration) when is_number(duration) and duration > 0
  defguardp is_max_seg(max_seg) when is_integer(max_seg) and max_seg > 0

  @spec to_url_string(%{
          optional(:duration) => number,
          optional(:max_segments) => pos_integer,
          optional(:min_segment_duration) => number
        }) :: String.t()
  def to_url_string(%{duration: duration, max_segments: max_seg, min_segment_duration: min_dur})
      when is_duration(duration) and is_max_seg(max_seg) and is_duration(min_dur) do
    "preview:duration_#{duration}:max_seg_#{max_seg}:min_seg_dur_#{min_dur}"
  end

  def to_url_string(%{duration: duration, max_segments: max_seg})
      when is_duration(duration) and is_max_seg(max_seg) do
    "preview:duration_#{duration}:max_seg_#{max_seg}"
  end

  def to_url_string(%{duration: duration, min_segment_duration: min_dur})
      when is_duration(duration) and is_duration(min_dur) do
    "preview:duration_#{duration}:min_seg_dur_#{min_dur}"
  end

  def to_url_string(%{max_segments: max_seg, min_segment_duration: min_dur})
      when is_max_seg(max_seg) and is_duration(min_dur) do
    "preview:max_seg_#{max_seg}:min_seg_dur_#{min_dur}"
  end

  def to_url_string(%{duration: duration}) when is_duration(duration) do
    "preview:duration_#{duration}"
  end

  def to_url_string(%{max_segments: max_seg}) when is_max_seg(max_seg) do
    "preview:max_seg_#{max_seg}"
  end

  def to_url_string(%{min_segment_duration: min_dur}) when is_duration(min_dur) do
    "preview:min_seg_dur_#{min_dur}"
  end
end
