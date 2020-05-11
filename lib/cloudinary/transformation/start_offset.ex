defmodule Cloudinary.Transformation.StartOffset do
  @moduledoc """
  Representing the `start_offset` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#trimming_and_overlay_offsets
  ## Example
      iex> %#{__MODULE__}{seconds: 8.24} |> to_string()
      "so_8.24"

      iex> %#{__MODULE__}{percents: 88.0} |> to_string()
      "so_88.0p"
  """
  @type t ::
          %__MODULE__{seconds: float, percents: nil}
          | %__MODULE__{seconds: nil, percents: float}
  defstruct [:seconds, :percents]

  defimpl String.Chars do
    def to_string(%{seconds: offset, percents: nil}) when is_float(offset) and offset >= 0 do
      "so_#{offset}"
    end

    def to_string(%{seconds: nil, percents: offset}) when is_float(offset) and offset >= 0 do
      "so_#{offset}p"
    end
  end
end
