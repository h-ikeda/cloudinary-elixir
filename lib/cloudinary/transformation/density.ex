defmodule Cloudinary.Transformation.Density do
  @moduledoc """
  Representing the `density` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#density_parameter
  ## Example
      iex> %#{__MODULE__}{dpi: :initial_density} |> to_string()
      "dn_idn"

      iex> %#{__MODULE__}{dpi: 400} |> to_string()
      "dn_400"
  """
  @type t :: %__MODULE__{dpi: :initial_density | pos_integer}
  defstruct dpi: 72

  defimpl String.Chars do
    def to_string(%{dpi: :initial_density}), do: "dn_idn"
    def to_string(%{dpi: dpi}) when is_integer(dpi) and dpi > 0, do: "dn_#{dpi}"
  end
end
