defmodule Cloudinary.Transformation.Gravity do
  @moduledoc false
  @spec to_url_string(Cloudinary.Transformation.gravity()) :: String.t()
  def to_url_string(direction)
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
             :adv_eyes,
             :face,
             :faces,
             :body,
             :custom
           ] do
    "#{direction}"
  end

  def to_url_string({direction, modifier})
      when direction in [:face, :faces] and modifier in [:center, :auto]
      when direction in [:custom] and modifier in [:face, :faces, :adv_face, :adv_faces] do
    "#{direction}:#{modifier}"
  end

  def to_url_string({:body, :face}), do: "body:face"
end
