defmodule Cloudinary.Transformation.Color do
  @moduledoc """
  Representing the `color` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#color_parameter
  ## Example
      iex> %#{__MODULE__}{color: "red"} |> to_string()
      "co_red"

      iex> %#{__MODULE__}{color: 0x3BA67D68} |> to_string()
      "co_rgb:3ba67d68"
  """
  @type t :: %__MODULE__{color: String.t() | 0..0xFFFFFFFF}
  defstruct [:color]

  defimpl String.Chars do
    def to_string(%{color: color}) when is_binary(color), do: "co_#{color}"

    def to_string(%{color: color}) when color in 0..0xFFFFFFFF do
      "co_rgb:#{Integer.to_string(color, 16) |> String.downcase()}"
    end
  end
end
