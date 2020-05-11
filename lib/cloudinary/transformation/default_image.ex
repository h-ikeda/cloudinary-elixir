defmodule Cloudinary.Transformation.DefaultImage do
  @moduledoc """
  Representing the `default_image` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#default_image_parameter
  ## Example
      iex> %#{__MODULE__}{public_id: "avatar.png"} |> to_string()
      "d_avatar.png"
  """
  @type t :: %__MODULE__{public_id: String.t()}
  defstruct [:public_id]

  defimpl String.Chars do
    def to_string(%{public_id: public_id}) when is_binary(public_id), do: "d_#{public_id}"
  end
end
