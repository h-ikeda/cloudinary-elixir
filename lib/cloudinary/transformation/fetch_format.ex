defmodule Cloudinary.Transformation.FetchFormat do
  @moduledoc """
  Representing the `fetch_format` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#fetch_format_parameter
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  https://cloudinary.com/documentation/image_transformations#automatic_format_selection
  ## Example
      iex> %#{__MODULE__}{format: :png} |> to_string()
      "f_png"

      iex> %#{__MODULE__}{format: :auto} |> to_string()
      "f_auto"
  """
  @type t :: %__MODULE__{format: Cloudinary.Format.t() | :auto}
  defstruct format: 0
  require Cloudinary.Format

  defimpl String.Chars do
    def to_string(%{format: :auto}), do: "f_auto"
    def to_string(%{format: format}) when Cloudinary.Format.supported?(format), do: "f_#{format}"
  end
end
