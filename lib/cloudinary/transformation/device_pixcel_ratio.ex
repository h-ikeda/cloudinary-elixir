defmodule Cloudinary.Transformation.DevicePixelRatio do
  @moduledoc """
  Representing the `dpr` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#dpr_parameter
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  https://cloudinary.com/documentation/responsive_images#automatic_pixel_density_detection
  ## Example
      iex> %#{__MODULE__}{ratio: :auto} |> to_string()
      "dpr_auto"

      iex> %#{__MODULE__}{ratio: 3.0} |> to_string()
      "dpr_3.0"
  """
  @type t :: %__MODULE__{ratio: float | :auto}
  defstruct ratio: :auto

  defimpl String.Chars do
    def to_string(%{ratio: :auto}), do: "dpr_auto"
    def to_string(%{ratio: ratio}) when is_float(ratio) and ratio > 0, do: "dpr_#{ratio}"
  end
end
