defmodule Cloudinary.Transformation.Radius do
  @moduledoc """
  Representing the `radius` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#radius_parameter
  https://cloudinary.com/documentation/video_transformation_reference#rotating_and_rounding_videos
  ## Example
      iex> %#{__MODULE__}{pixels: 20} |> to_string()
      "r_20"

      iex> %#{__MODULE__}{pixels: [20, 0, 40, 40]} |> to_string()
      "r_20:0:40:40"

      iex> %#{__MODULE__}{pixels: :max} |> to_string()
      "r_max"

  """
  @type t :: %__MODULE__{pixels: non_neg_integer | [non_neg_integer] | :max}
  defstruct pixels: 0

  defimpl String.Chars do
    def to_string(%{pixels: pixels}) when is_integer(pixels) and pixels >= 0, do: "r_#{pixels}"
    def to_string(%{pixels: :max}), do: "r_max"
    def to_string(%{pixels: [all]}) when is_integer(all) and all >= 0, do: "r_#{all}"

    def to_string(%{pixels: [top_left_bottom_right, top_right_bottom_left]})
        when is_integer(top_left_bottom_right) and top_left_bottom_right >= 0 and
               is_integer(top_right_bottom_left) and top_right_bottom_left >= 0 do
      "r_#{top_left_bottom_right}:#{top_right_bottom_left}"
    end

    def to_string(%{pixels: [top_left, top_right_bottom_left, bottom_right]})
        when is_integer(top_left) and top_left >= 0 and
               is_integer(top_right_bottom_left) and top_right_bottom_left >= 0 and
               is_integer(bottom_right) and bottom_right >= 0 do
      "r_#{top_left}:#{top_right_bottom_left}:#{bottom_right}"
    end

    def to_string(%{pixels: [top_left, top_right, bottom_right, bottom_left]})
        when is_integer(top_left) and top_left >= 0 and
               is_integer(top_right) and top_right >= 0 and
               is_integer(bottom_right) and bottom_right >= 0 and
               is_integer(bottom_left) and bottom_left >= 0 do
      "r_#{top_left}:#{top_right}:#{bottom_right}:#{bottom_left}"
    end
  end
end
