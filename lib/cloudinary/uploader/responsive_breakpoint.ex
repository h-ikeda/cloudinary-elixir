defmodule Cloudinary.Uploader.ResponsiveBreakpoint do
  @moduledoc false
  import Cloudinary.Format
  defguardp is_non_neg_integer(number) when is_integer(number) and number >= 0
  defguardp is_pos_integer(number) when is_integer(number) and number > 0

  @spec to_string(%{
          required(:create_derived) => boolean,
          optional(:format) => Cloudinary.Format.t(),
          optional(:transformation) =>
            Cloudinary.Transformation.t() | [Cloudinary.Transformation.t()],
          optional(:max_width) => non_neg_integer,
          optional(:min_width) => non_neg_integer,
          optional(:bytes_step) => pos_integer,
          optional(:max_images) => 3..200
        }) :: String.t()
  def to_string(%{create_derived: create_derived} = options) when is_boolean(create_derived) do
    []
    |> prepend_max_images(options)
    |> prepend_bytes_step(options)
    |> prepend_min_width(options)
    |> prepend_max_width(options)
    |> prepend_transformation(options)
    |> prepend_format(options)
    |> prepend_create_derived(create_derived)
    |> encode()
  end

  @spec prepend_create_derived([String.t()], boolean) :: [String.t()]
  defp prepend_create_derived(acc, create_derived) do
    ["\"create_derived\":#{create_derived}" | acc]
  end

  @spec prepend_format([String.t()], %{
          optional(:format) => Cloudinary.Format.t()
        }) :: [String.t()]
  defp prepend_format(acc, %{format: format}) when is_supported(format) do
    ["\"format\":\"#{format}\"" | acc]
  end

  defp prepend_format(_, %{format: _}) do
    raise ArgumentError, "expected an atom of the cloudinary supported format"
  end

  defp prepend_format(acc, _), do: acc

  @spec prepend_transformation([String.t()], %{
          optional(:transformation) =>
            Cloudinary.Transformation.t() | [Cloudinary.Transformation.t()]
        }) :: [String.t()]
  defp prepend_transformation(acc, %{transformation: transformation}) do
    ["\"transformation\":\"#{Cloudinary.Transformation.to_url_string(transformation)}\"" | acc]
  end

  defp prepend_transformation(acc, _), do: acc

  @spec prepend_max_width([String.t()], %{
          optional(:max_width) => non_neg_integer
        }) :: [String.t()]
  defp prepend_max_width(acc, %{max_width: max_width}) when is_non_neg_integer(max_width) do
    ["\"max_width\":#{max_width}" | acc]
  end

  defp prepend_max_width(_, %{max_width: _}) do
    raise ArgumentError, "expected an integer greater than or equal to 0"
  end

  defp prepend_max_width(acc, _), do: acc

  @spec prepend_min_width([String.t()], %{
          optional(:min_width) => non_neg_integer
        }) :: [String.t()]
  defp prepend_min_width(acc, %{min_width: min_width}) when is_non_neg_integer(min_width) do
    ["\"min_width\":#{min_width}" | acc]
  end

  defp prepend_min_width(_, %{min_width: _}) do
    raise ArgumentError, "expected an integer greater than or equal to 0"
  end

  defp prepend_min_width(acc, _), do: acc

  @spec prepend_bytes_step([String.t()], %{optional(:bytes_step) => pos_integer}) :: [String.t()]
  defp prepend_bytes_step(acc, %{bytes_step: bytes_step}) when is_pos_integer(bytes_step) do
    ["\"bytes_step\":#{bytes_step}" | acc]
  end

  defp prepend_bytes_step(_, %{bytes_step: _}) do
    raise ArgumentError, "expected an integer greater than 0"
  end

  defp prepend_bytes_step(acc, _), do: acc

  @spec prepend_max_images([String.t()], %{optional(:max_images) => 3..200}) :: [String.t()]
  defp prepend_max_images(acc, %{max_images: max_images}) when max_images in 3..200 do
    ["\"max_images\":#{max_images}" | acc]
  end

  defp prepend_max_images(_, %{max_images: _}) do
    raise ArgumentError, "expected an integer between from 3 to 200"
  end

  defp prepend_max_images(acc, _), do: acc

  @spec encode([String.t()]) :: String.t()
  defp encode(options), do: "{#{Enum.join(options, ",")}}"
end
