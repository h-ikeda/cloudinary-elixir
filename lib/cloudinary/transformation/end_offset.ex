defmodule Cloudinary.Transformation.EndOffset do
  @moduledoc """
  Representing the `end_offset` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#trimming_and_overlay_offsets
  ## Example
      iex> %#{__MODULE__}{seconds: 5.32} |> to_string()
      "eo_5.32"

      iex> %#{__MODULE__}{percents: 32.0} |> to_string()
      "eo_32.0p"
  """
  @type t ::
          %__MODULE__{seconds: float, percents: nil}
          | %__MODULE__{seconds: nil, percents: float}
  defstruct [:seconds, :percents]

  defimpl String.Chars do
    def to_string(%{seconds: offset, percents: nil})
        when is_float(offset) and offset >= 0 do
      "eo_#{offset}"
    end

    def to_string(%{seconds: nil, percents: offset})
        when is_float(offset) and offset >= 0 do
      "eo_#{offset}p"
    end
  end
end
