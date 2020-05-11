defmodule Cloudinary.Transformation.Overlay.Video do
  @moduledoc """
  Representing video `overlay` parameter of transformation.
  ## Official documentation
  ## Example
      iex> %#{__MODULE__}{public_id: "dog"} |> to_string()
      "l_video:dog"
  """
  @type t :: %__MODULE__{public_id: String.t()}
  defstruct [:public_id]

  defimpl String.Chars do
    def to_string(%{public_id: public_id}) when is_binary(public_id), do: "l_video:#{public_id}"
  end
end
