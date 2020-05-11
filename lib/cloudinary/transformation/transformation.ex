defmodule Cloudinary.Transformation.Transformation do
  @moduledoc """
  Representing the named `transformation` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#transformation_parameter
  ## Example
      iex> %#{__MODULE__}{name: "media_lib_thumb"} |> to_string()
      "t_media_lib_thumb"
  """
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]

  defimpl String.Chars do
    def to_string(%{name: name}) when is_binary(name), do: "t_#{name}"
  end
end
