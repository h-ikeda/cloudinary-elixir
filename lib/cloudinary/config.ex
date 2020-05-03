defmodule Cloudinary.Config do
  @moduledoc """
  """
  @type t :: %__MODULE__{
          cloud_name: String.t(),
          api_key: String.t() | nil,
          api_secret: String.t() | nil,
          secure: boolean,
          cdn_subdomain: boolean,
          secure_distribution: String.t() | nil,
          private_cdn: boolean,
          cname: String.t() | nil,
          upload_preset: String.t() | nil
        }
  defstruct cloud_name: nil,
            api_key: nil,
            api_secret: nil,
            secure: false,
            cdn_subdomain: false,
            secure_distribution: nil,
            private_cdn: false,
            cname: nil,
            upload_preset: nil

  @doc """
  Parses cloudinary configuration URL. You can find cloudinary URL in the dashboard page of the
  cloudinary console.

  Details of configuration parameters are documented here.
  https://cloudinary.com/documentation/cloudinary_sdks#configuration_parameters

  ## Example
      iex> Cloudinary.Config.parse_url("cloudinary://abc123:def456@ghk789?secure")
      %Cloudinary.Config{
        cloud_name: "ghk789",
        api_key: "abc123",
        api_secret: "def456",
        secure: false,
        cdn_subdomain: false,
        secure_distribution: nil,
        private_cdn: false,
        cname: nil,
        upload_preset: nil
      }
  """
  @spec parse_url(String.t()) :: t
  def parse_url("cloudinary:" <> url) do
    %URI{
      host: cloud_name,
      userinfo: userinfo,
      path: path,
      query: query
    } = URI.parse(url)

    %__MODULE__{
      cloud_name: cloud_name
    }
    |> put_userinfo(userinfo)
    |> put_secure_distribution(path)
    |> put_optional_configs(query)
    |> Map.merge(if query, do: URI.decode_query(query), else: %{})
  end

  @spec put_userinfo(t, String.t() | nil) :: t
  defp put_userinfo(%__MODULE__{} = config, nil), do: config

  defp put_userinfo(%__MODULE__{} = config, userinfo) when is_binary(userinfo) do
    [api_key, api_secret] = String.split(userinfo, ":")
    %{config | api_key: api_key, api_secret: api_secret}
  end

  @spec put_secure_distribution(t, String.t() | nil) :: t
  defp put_secure_distribution(%__MODULE__{} = config, nil), do: config
  defp put_secure_distribution(%__MODULE__{} = config, "/"), do: config

  defp put_secure_distribution(%__MODULE__{} = config, "/" <> secure_distribution) do
    %{config | secure_distribution: secure_distribution, private_cdn: true}
  end

  @spec put_optional_configs(t, String.t() | nil) :: t
  defp put_optional_configs(%__MODULE__{} = config, nil), do: config

  defp put_optional_configs(%__MODULE__{} = config, query) when is_binary(query) do
    URI.query_decoder(query)
    |> Enum.reduce(config, fn
      {"secure", secure}, c -> %{c | secure: query_is_truthy?(secure)}
      {"cdn_subdomain", cdn_subdomain}, c -> %{c | cdn_subdomain: query_is_truthy?(cdn_subdomain)}
      {"cname", cname}, c -> %{c | cname: cname}
      {"upload_preset", upload_preset}, c -> %{c | upload_preset: upload_preset}
      _, c -> c
    end)
  end

  @spec query_is_truthy?(String.t() | nil) :: boolean
  defp query_is_truthy?(""), do: false
  defp query_is_truthy?("false"), do: false
  defp query_is_truthy?("0"), do: false
  defp query_is_truthy?(_), do: true
end
