defmodule Cloudinary.Transformation.Effect.Distort do
  @moduledoc """
  Representing the distort effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{coodinates: [[5, 34], [70, 10], [70, 75], [5, 55]]} |> to_string()
      "e_distort:5:34:70:10:70:75:5:55"
  """
  defmodule Arc do
    @moduledoc """
    https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
    ## Example
        iex> %#{__MODULE__}{degrees: 180} |> to_string()
        "e_distort:arc:180"
    """
    @type t :: %__MODULE__{degrees: integer}
    defstruct degrees: 0

    defimpl String.Chars do
      def to_string(%{degrees: degrees}) when is_integer(degrees), do: "e_distort:arc:#{degrees}"
    end
  end

  @type t :: %__MODULE__{coodinates: [[integer]]} | Arc.t()
  defstruct [:coodinates]

  defimpl String.Chars do
    def to_string(%{coodinates: [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]})
        when is_integer(x1) and is_integer(y1) and is_integer(x2) and is_integer(y2) and
               is_integer(x3) and is_integer(y3) and is_integer(x4) and is_integer(y4) do
      "e_distort:#{x1}:#{y1}:#{x2}:#{y2}:#{x3}:#{y3}:#{x4}:#{y4}"
    end
  end
end
