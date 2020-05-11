defmodule Cloudinary.Transformation.AudioFrequency do
  @moduledoc """
  Representing the `audio_frequency` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#audio_settings
  ## Example
      iex> %#{__MODULE__}{hz: :initial_frequency} |> to_string()
      "af_iaf"

      iex> %#{__MODULE__}{hz: 44100} |> to_string()
      "af_44100"
  """
  @type t :: %__MODULE__{
          hz:
            :initial_frequency
            | 8000
            | 11025
            | 16000
            | 22050
            | 32000
            | 37800
            | 44056
            | 44100
            | 47250
            | 48000
            | 88200
            | 96000
            | 176_400
            | 192_000
        }
  defstruct hz: :initial_frequency

  defimpl String.Chars do
    def to_string(%{hz: :initial_frequency}), do: "af_iaf"

    def to_string(%{hz: frequency})
        when frequency === 8000
        when frequency === 11025
        when frequency === 16000
        when frequency === 22050
        when frequency === 32000
        when frequency === 37800
        when frequency === 44056
        when frequency === 44100
        when frequency === 47250
        when frequency === 48000
        when frequency === 88200
        when frequency === 96000
        when frequency === 176_400
        when frequency === 192_000 do
      "af_#{frequency}"
    end
  end
end
