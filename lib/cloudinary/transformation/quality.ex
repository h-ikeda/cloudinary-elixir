defmodule Cloudinary.Transformation.Quality do
  @moduledoc """
  Representing the `quality` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#quality_parameter
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  https://cloudinary.com/documentation/image_transformations#adjusting_image_quality
  https://cloudinary.com/documentation/video_manipulation_and_delivery#quality_control
  ## Example
      iex> %#{__MODULE__}{value: 20} |> to_string()
      "q_20"

      iex> %#{__MODULE__}{value: 20, chroma: 444} |> to_string()
      "q_20:444"

      iex> %#{__MODULE__}{value: :jpegmini} |> to_string()
      "q_jpegmini"

      iex> %#{__MODULE__}{value: :auto, level: :eco} |> to_string()
      "q_auto:eco"

      iex> %#{__MODULE__}{value: 70, max_quantization: 80} |> to_string()
      "q_70:qmax_80"
  """
  @type t :: %__MODULE__{
          value: 1..100 | :auto | :jpegmini,
          chroma: 420 | 444 | nil,
          max_quantization: 1..100 | nil,
          level: :best | :good | :eco | :low
        }
  defstruct value: 100, chroma: nil, max_quantization: nil, level: :good

  defimpl String.Chars do
    def to_string(%{value: :jpegmini}), do: "q_jpegmini"

    def to_string(%{value: value, chroma: nil, max_quantization: nil}) when value in 1..100 do
      "q_#{value}"
    end

    def to_string(%{value: value, chroma: chroma, max_quantization: nil})
        when value in 1..100 and chroma in [420, 444] do
      "q_#{value}:#{chroma}"
    end

    def to_string(%{value: value, chroma: nil, max_quantization: qmax})
        when value in 1..100 and qmax in 1..100 do
      "q_#{value}:qmax_#{qmax}"
    end

    def to_string(%{value: :auto, level: level}) when level in [:best, :good, :eco, :low] do
      "q_auto:#{level}"
    end
  end
end
