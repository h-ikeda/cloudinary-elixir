defmodule Cloudinary.Transformation.Opacity do
  @moduledoc """
  Representing the `opacity` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#opacity_parameter
  ## Example
      iex> %#{__MODULE__}{percents: 30.0} |> to_string()
      "o_30.0"

      iex> %#{__MODULE__}{percents: 60.0} |> to_string()
      "o_60.0"
  """
  @type t :: %__MODULE__{percents: float}
  defstruct [:percents]

  defimpl String.Chars do
    def to_string(%{percents: opacity})
        when is_float(opacity) and opacity >= 0 and opacity <= 100 do
      "o_#{opacity}"
    end
  end
end
