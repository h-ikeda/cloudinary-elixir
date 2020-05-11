defmodule Cloudinary.Transformation.Underlay do
  @moduledoc """
  Representing the `underlay` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#underlay_parameter
  ## Example
      iex> %#{__MODULE__}{public_id: "background_image"} |> to_string()
      "u_background_image"
  """
  @type t ::
          %__MODULE__{public_id: String.t()}
          | __MODULE__.Fetch.t()
          | __MODULE__.Lut.t()
          | __MODULE__.Text.t()
  defstruct [:public_id]

  defimpl String.Chars do
    def to_string(%{public_id: public_id}) when is_binary(public_id), do: "u_#{public_id}"
  end
end
