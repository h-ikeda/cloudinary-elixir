defmodule Cloudinary.Transformation.Effect.Displace do
  @moduledoc """
  Representing the displace effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_displace"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_displace"
  end
end
