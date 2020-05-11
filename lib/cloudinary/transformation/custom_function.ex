defmodule Cloudinary.Transformation.CustomFunction do
  @moduledoc """
  Used to call a the custom function in the transformation.
  ## Official documentation
  https://cloudinary.com/documentation/custom_functions
  https://cloudinary.com/documentation/image_transformation_reference#custom_function_parameter
  
  ## Example
      iex> %#{__MODULE__}{type: :wasm, source: "example.wasm"} |> to_string()
      "fn_wasm:example.wasm"

      iex> %#{__MODULE__}{type: :remote, source: "https://example.com/fun"} |> to_string()
      "fn_remote:aHR0cHM6Ly9leGFtcGxlLmNvbS9mdW4="
  """
  @type t :: %__MODULE__{type: :remote | :wasm, source: String.t()}
  defstruct type: :wasm, source: nil

  defimpl String.Chars do
    def to_string(%{type: :wasm, source: public_id}) when is_binary(public_id) do
      "fn_wasm:#{public_id}"
    end

    def to_string(%{type: :remote, source: url}) when is_binary(url) do
      "fn_remote:#{Base.url_encode64(url)}"
    end
  end
end
