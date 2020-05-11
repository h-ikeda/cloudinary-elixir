defmodule Cloudinary.Transformation.Width do
  @moduledoc """
  Representing the `width` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#width_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  https://cloudinary.com/documentation/responsive_images#automatic_image_width
  https://cloudinary.com/documentation/responsive_images#automatic_image_width_using_optimal_responsive_breakpoints
  ## Example
      iex> %#{__MODULE__}{value: 600} |> to_string()
      "w_600"

      iex> %#{__MODULE__}{value: 1.22} |> to_string()
      "w_1.22"

      iex> %#{__MODULE__}{value: :auto, rounding_step: 50} |> to_string()
      "w_auto:50"

      iex> %#{__MODULE__}{value: :auto, rounding_step: 50, client_width: 87} |> to_string()
      "w_auto:50:87"
  """
  @type t :: %__MODULE__{
          value: pos_integer | float | :auto,
          rounding_step: pos_integer,
          client_width: pos_integer | nil
        }
  defstruct value: 1.0, rounding_step: 100, client_width: nil

  defimpl String.Chars do
    def to_string(%{value: width}) when (is_integer(width) or is_float(width)) and width > 0 do
      "w_#{width}"
    end

    def to_string(%{value: :auto, rounding_step: rounding_step, client_width: nil})
        when is_integer(rounding_step) and rounding_step > 0 do
      "w_auto:#{rounding_step}"
    end

    def to_string(%{value: :auto, rounding_step: rounding_step, client_width: client_width})
        when is_integer(rounding_step) and rounding_step > 0 and
               is_integer(client_width) and client_width > 0 do
      "w_auto:#{rounding_step}:#{client_width}"
    end
  end
end
