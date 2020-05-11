defmodule Cloudinary.Transformation.Overlay.Fetch do
  @moduledoc """
  Representing `overlay` parameter of transformation which image comes from remote server.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#overlay_parameter
  ## Example
      iex> %#{__MODULE__}{url: "http://example.com/path/to/remote/image.jpg"} |> to_string()
      "l_fetch:aHR0cDovL2V4YW1wbGUuY29tL3BhdGgvdG8vcmVtb3RlL2ltYWdlLmpwZw=="
  """
  @type t :: %__MODULE__{url: String.t()}
  defstruct [:url]

  defimpl String.Chars do
    def to_string(%{url: url}) when is_binary(url), do: "l_fetch:#{Base.url_encode64(url)}"
  end
end
