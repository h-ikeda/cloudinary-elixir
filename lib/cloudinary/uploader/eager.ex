defmodule Cloudinary.Uploader.Eager do
  @moduledoc false
  import Cloudinary.Format

  @spec to_string(%{
          required(:transformation) =>
            Cloudinary.Transformation.t() | [Cloudinary.Transformation.t()],
          optional(:format) => Cloudinary.Format.t()
        }) :: String.t()
  def to_string(%{transformation: transformation, format: format}) when is_supported(format) do
    "#{Cloudinary.Transformation.to_url_string(transformation)}/#{format}"
  end

  def to_string(%{transformation: transformation}) do
    Cloudinary.Transformation.to_url_string(transformation)
  end
end
