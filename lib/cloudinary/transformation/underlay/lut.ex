defmodule Cloudinary.Transformation.Underlay.Lut do
  @moduledoc """
  Representing `underlay` parameter of transformation which applies 3D look up tables.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#applying_3d_luts_to_images
  ## Example
      iex> %#{__MODULE__}{public_id: "iwltbap_aspen.3dl"} |> to_string()
      "u_lut:iwltbap_aspen.3dl"
  """
  @type t :: %__MODULE__{public_id: String.t()}
  defstruct [:public_id]

  defimpl String.Chars do
    def to_string(%{public_id: public_id}) when is_binary(public_id), do: "u_lut:#{public_id}"
  end
end
