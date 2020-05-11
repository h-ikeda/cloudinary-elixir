defmodule Cloudinary.Transformation.Angle do
  @moduledoc """
  Representing the `angle` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#angle_parameter
  https://cloudinary.com/documentation/video_transformation_reference#rotating_and_rounding_videos
  ## Example
      iex> %#{__MODULE__}{degrees: 5} |> to_string()
      "a_5"

      iex> %#{__MODULE__}{modes: [:auto_right, :hflip]} |> to_string()
      "a_auto_right.hflip"
  """
  @type t :: %__MODULE__{
          degrees: integer,
          modes: [:auto_right | :auto_left | :ignore | :vflip | :hflip]
        }
  defstruct degrees: 0, modes: []

  defimpl String.Chars do
    def to_string(%{modes: [], degrees: degrees}) when is_integer(degrees), do: "a_#{degrees}"
    def to_string(%{modes: modes}) when is_list(modes), do: "a_#{Enum.join(modes, ".")}"
  end
end
