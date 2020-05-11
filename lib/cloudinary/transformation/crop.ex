defmodule Cloudinary.Transformation.Crop do
  @moduledoc """
  Representing the `crop` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#crop_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  https://cloudinary.com/documentation/image_transformations#resizing_and_cropping_images
  https://cloudinary.com/documentation/video_manipulation_and_delivery#resizing_and_cropping_videos
  ## Example
      iex> %#{__MODULE__}{mode: :lpad} |> to_string()
      "c_lpad"
  """
  @type t :: %__MODULE__{
          mode:
            :scale
            | :fit
            | :limit
            | :mfit
            | :fill
            | :lfill
            | :pad
            | :lpad
            | :mpad
            | :fill_pad
            | :crop
            | :thumb
            | :imagga_crop
            | :imagga_scale
        }
  defstruct mode: :scale

  defimpl String.Chars do
    def to_string(%{mode: mode})
        when mode in [
               :scale,
               :fit,
               :limit,
               :mfit,
               :fill,
               :lfill,
               :pad,
               :lpad,
               :mpad,
               :fill_pad,
               :crop,
               :thumb,
               :imagga_crop,
               :imagga_scale
             ] do
      "c_#{mode}"
    end
  end
end
