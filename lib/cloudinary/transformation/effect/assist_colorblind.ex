defmodule Cloudinary.Transformation.Effect.AssistColorblind do
  @moduledoc """
  Representing the effect generating an easy color differentiatable image for people with color
  blind conditions.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{strength: 8} |> to_string()
      "e_assist_colorblind:8"

      iex> %#{__MODULE__}{assist_type: :xray} |> to_string()
      "e_assist_colorblind:xray"
  """
  @type t :: %__MODULE__{assist_type: :stripes | :xray, strength: 1..100}
  defstruct assist_type: :stripes, strength: 10

  defimpl String.Chars do
    def to_string(%{assist_type: :stripes, strength: strength}) when strength in 1..100 do
      "e_assist_colorblind:#{strength}"
    end

    def to_string(%{assist_type: :xray}), do: "e_assist_colorblind:xray"
  end
end
