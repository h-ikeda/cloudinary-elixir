defmodule Cloudinary.Uploader.AccessType do
  @moduledoc false
  defguardp is_access_type(access_type) when access_type in [:token, :anonymous]

  @spec to_string(%{
          required(:access_type) => :token | :anonymous,
          optional(:start) => Calendar.datetime(),
          optional(:end) => Calendar.datetime()
        }) :: String.t()
  def to_string(%{access_type: access_type, start: start_datetime, end: end_datetime})
      when is_access_type(access_type) do
    "{\"access_type\":\"#{access_type}\"," <>
      "\"start\":\"#{DateTime.to_iso8601(start_datetime)}\"," <>
      "\"end\":\"#{DateTime.to_iso8601(end_datetime)}\"}"
  end

  def to_string(%{access_type: access_type, start: start_datetime})
      when is_access_type(access_type) do
    "{\"access_type\":\"#{access_type}\",\"start\":\"#{DateTime.to_iso8601(start_datetime)}\"}"
  end

  def to_string(%{access_type: access_type, end: end_datetime})
      when is_access_type(access_type) do
    "{\"access_type\":\"#{access_type}\",\"end\":\"#{DateTime.to_iso8601(end_datetime)}\"}"
  end

  def to_string(%{access_type: access_type}) when is_access_type(access_type) do
    "{\"access_type\":\"#{access_type}\"}"
  end
end
