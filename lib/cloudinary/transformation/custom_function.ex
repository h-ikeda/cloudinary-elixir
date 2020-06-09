defmodule Cloudinary.Transformation.CustomFunction do
  @moduledoc false
  @spec to_url_string(%{type: :remote | :wasm, source: String.t()}) :: String.t()
  def to_url_string(%{type: :wasm, source: id}) when is_binary(id), do: "wasm:#{id}"

  def to_url_string(%{type: :remote, source: url}) when is_binary(url) do
    "remote:#{Base.url_encode64(url)}"
  end
end
