defmodule Cloudinary.Transformation.Gravity do
  @moduledoc """
  Representing the `gravity` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#gravity_parameter
  https://cloudinary.com/documentation/video_transformation_reference#resizing_and_cropping_videos
  https://cloudinary.com/documentation/image_transformations#control_gravity
  https://cloudinary.com/documentation/video_manipulation_and_delivery#automatic_cropping
  ## Example
      iex> %#{__MODULE__}{direction: :north} |> to_string()
      "g_north"

      iex> %#{__MODULE__}{direction: :face, modifier: :auto} |> to_string()
      "g_face:auto"
  """
  @type t ::
          %__MODULE__{
            direction:
              :north_west
              | :north
              | :north_east
              | :west
              | :center
              | :east
              | :south_west
              | :south
              | :south_east
              | :xy_center
              | :liquid
              | :ocr_text
              | :adv_face
              | :adv_faces
              | :adv_eyes,
            modifier: nil
          }
          | %__MODULE__{direction: :face | :faces, modifier: :center | :auto | nil}
          | %__MODULE__{direction: :body, modifier: :face | nil}
          | %__MODULE__{
              direction: :custom,
              modifier: :face | :faces | :adv_face | :adv_faces | nil
            }
  defstruct direction: :center, modifier: nil

  defimpl String.Chars do
    def to_string(%{direction: direction})
        when direction in [
               :north_west,
               :north,
               :north_east,
               :west,
               :center,
               :east,
               :south_west,
               :south,
               :south_east,
               :xy_center,
               :liquid,
               :ocr_text,
               :adv_face,
               :adv_faces,
               :adv_eyes
             ] do
      "g_#{direction}"
    end

    def to_string(%{direction: direction, modifier: modifier})
        when direction in [:face, :faces] and modifier in [:center, :auto, nil] do
      "g_#{direction}#{if modifier, do: ":#{modifier}"}"
    end

    def to_string(%{direction: :body, modifier: modifier}) when modifier in [:face, nil] do
      "g_body#{if modifier, do: ":#{modifier}"}"
    end

    def to_string(%{direction: :custom, modifier: modifier})
        when modifier in [:face, :faces, :adv_face, :adv_faces, nil] do
      "g_custom#{if modifier, do: ":#{modifier}"}"
    end
  end
end
