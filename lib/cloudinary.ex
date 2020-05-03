defmodule Cloudinary do
  @moduledoc """
  Includes common functions.
  """

  @doc """
  Returns true if given string is a remote or data URL.

  ## Examples

      iex> Cloudinary.is_remote_url?("path/to/local_file")
      false

      iex> Cloudinary.is_remote_url?("http://example.com/path/to/something")
      true
  """
  @spec is_remote_url?(String.t()) :: boolean
  def is_remote_url?(url) when is_binary(url) do
    %URI{scheme: scheme} = URI.parse(url)
    scheme in ["ftp", "http", "https", "gs", "s3", "data"]
  end
end
