defmodule Cloudinary.Transformation.CustomPreFunction do
  @moduledoc """
  Used to call a preprocessing custom function in the transformation.
  ## Official documentation
  https://cloudinary.com/documentation/custom_functions#preprocessing_custom_functions
  https://cloudinary.com/documentation/image_transformation_reference#custom_function_parameter
  ## Example
      iex> %#{__MODULE__}{type: :remote, source: "https://example.com/fun"} |> to_string()
      "fn_pre_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
  """
  @type t :: %__MODULE__{type: :remote, source: String.t()}
  defstruct type: :remote, source: nil

  defimpl String.Chars do
    def to_string(%{type: :remote, source: url}) when is_binary(url) do
      "fn_pre_remote:#{Base.url_encode64(url)}"
    end
  end
end
