defmodule Cloudinary.Transformation.Effect.Deshake do
  @moduledoc """
  Representing the removing small motion shifts.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{pixels: 32} |> to_string()
      "e_deshake:32"
  """
  @type t :: %__MODULE__{pixels: 16 | 32 | 48 | 64}
  defstruct pixels: 16

  defimpl String.Chars do
    def to_string(%{pixels: pixels}) when pixels in [16, 32, 48, 64], do: "e_deshake:#{pixels}"
  end
end
