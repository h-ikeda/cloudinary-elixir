defmodule Cloudinary.Transformation.Effect.Colorize do
  @moduledoc """
  Representing the colorize effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 80} |> to_string()
      "e_colorize:80"
  """
  @type t :: %__MODULE__{strength: 0..100}
  defstruct strength: 100

  defimpl String.Chars do
    def to_string(%{strength: strength}) when strength in 0..100, do: "e_colorize:#{strength}"
  end
end
