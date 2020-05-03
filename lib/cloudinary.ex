defmodule Cloudinary do
  @moduledoc """
  Includes common functions.
  """
  @config (case Application.compile_env(:cloudinary, :url) do
             nil ->
               []

             url ->
               %URI{
                 scheme: "cloudinary",
                 host: cloud_name,
                 userinfo: auth,
                 path: secure_distribution,
                 query: query
               } = URI.parse(url)

               [api_key, api_secret] = if auth, do: String.split(auth, ":"), else: [nil, nil]

               %{
                 "cloud_name" => cloud_name,
                 "api_key" => api_key,
                 "api_secret" => api_secret,
                 "secure_distribution" =>
                   secure_distribution && String.slice(secure_distribution, 1..-1),
                 "private_cdn" => secure_distribution not in [nil, "/"]
               }
               |> Map.merge(if query, do: URI.decode_query(query), else: %{})
               |> Enum.filter(&(elem(&1, 1) != nil))
           end)
          |> Enum.into(%{
            "cloud_name" => Application.compile_env(:cloudinary, :cloud_name),
            "api_key" => Application.compile_env(:cloudinary, :api_key),
            "api_secret" => Application.compile_env(:cloudinary, :api_secret),
            "secure_distribution" => Application.compile_env(:cloudinary, :secure_distribution),
            "private_cdn" => Application.compile_env(:cloudinary, :private_cdn),
            "secure" => Application.compile_env(:cloudinary, :secure)
          })
          |> Enum.flat_map(fn
            {_k, nil} -> []
            {k, v} -> [{String.to_atom(k), v}]
          end)
          |> Enum.into(%{})
  @doc """
  Returns the configuration map.
  """
  @spec config() :: map
  def config, do: @config

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
