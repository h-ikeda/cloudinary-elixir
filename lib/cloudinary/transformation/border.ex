defmodule Cloudinary.Transformation.Border do
  @moduledoc """
  Representing the `border` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#border_parameter
  ## Example
      iex> %#{__MODULE__}{width: 4, color: 0x483F62} |> to_string()
      "bo_4px_solid_rgb:483f62"

      iex> %#{__MODULE__}{width: 6, style: :solid, color: "blue"} |> to_string()
      "bo_6px_solid_blue"
  """
  @type t :: %__MODULE__{width: pos_integer, style: :solid, color: String.t() | 0..0xFFFFFFFF}
  defstruct width: 2, style: :solid, color: "black"

  defimpl String.Chars do
    def to_string(%{width: width, style: :solid, color: color})
        when is_integer(width) and is_binary(color) and width > 0 do
      "bo_#{width}px_solid_#{color}"
    end

    def to_string(%{width: width, style: :solid, color: color})
        when is_integer(width) and width > 0 and color in 0..0xFFFFFFFF do
      "bo_#{width}px_solid_rgb:#{Integer.to_string(color, 16) |> String.downcase(:ascii)}"
    end
  end
end
