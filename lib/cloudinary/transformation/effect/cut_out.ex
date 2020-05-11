defmodule Cloudinary.Transformation.Effect.CutOut do
  @moduledoc """
  Representing the overlay image trimming.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_cut_out"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_cut_out"
  end
end
