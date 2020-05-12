defmodule Cloudinary.Transformation.ColorSpace do
  @moduledoc """
  Representing the `color_space` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#color_space_parameter
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  ## Example
      iex> %#{__MODULE__}{preset: :keep_cmyk} |> to_string()
      "cs_keep_cmyk"

      iex> %#{__MODULE__}{preset: :icc, public_id: "uploaded.icc"} |> to_string()
      "cs_icc:uploaded.icc"
  """
  @type t ::
          %__MODULE__{
            preset: :srgb | :tinysrgb | :cmyk | :no_cmyk | :keep_cmyk | :copy,
            public_id: nil
          }
          | %__MODULE__{preset: :icc, public_id: String.t()}
  defstruct [:preset, :public_id]

  defimpl String.Chars do
    def to_string(%{preset: :icc, public_id: public_id}) when is_binary(public_id) do
      "cs_icc:#{public_id}"
    end

    def to_string(%{preset: preset})
        when preset in [:srgb, :tinysrgb, :cmyk, :no_cmyk, :keep_cmyk, :copy] do
      "cs_#{preset}"
    end
  end
end
