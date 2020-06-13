defmodule Cloudinary.Uploader do
  @moduledoc """
  The API functions used to upload assets to the cloud.
  """
  import Cloudinary.Format

  @doc """
  Returns an URL for the uploads.

  The `:cloud_name` option is required. Others are optional.

  Options:
  * `:cloud_name` - The cloudinary cloud name to identify the account.
  * `:resource_type` - The type of the uploading file. One of `:auto`, `:image`, `:video` and
    `:raw`.
  * `:upload_prefix` - Overrides the API base URL.
  ## Example
      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234"})
      %URI{
        host: "api.cloudinary.com",
        path: "/v1_1/abcd1234/image/upload",
        port: 443,
        scheme: "https",
        authority: "api.cloudinary.com"
      }

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", resource_type: :video})
      %URI{
        host: "api.cloudinary.com",
        path: "/v1_1/abcd1234/video/upload",
        port: 443,
        scheme: "https",
        authority: "api.cloudinary.com"
      }

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", upload_prefix: "https://example.com/api"})
      %URI{
        host: "example.com",
        path: "/api/v1_1/abcd1234/image/upload",
        port: 443,
        scheme: "https",
        authority: "example.com"
      }

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", resource_type: :auto, upload_prefix: "https://example.com/api"})
      %URI{
        host: "example.com",
        path: "/api/v1_1/abcd1234/auto/upload",
        port: 443,
        scheme: "https",
        authority: "example.com"
      }
  """
  @spec upload_url(%{
          required(:cloud_name) => String.t(),
          optional(:upload_prefix) => String.t(),
          optional(:resource_type) => :auto | :image | :video | :raw
        }) :: URI.t()
  def upload_url(%{cloud_name: cloud_name, upload_prefix: prefix, resource_type: type})
      when is_binary(cloud_name) and is_binary(prefix) and type in [:auto, :image, :video, :raw] do
    URI.parse("#{prefix}/v1_1/#{cloud_name}/#{type}/upload")
  end

  def upload_url(%{cloud_name: cloud_name, upload_prefix: prefix})
      when is_binary(cloud_name) and is_binary(prefix) do
    URI.parse("#{prefix}/v1_1/#{cloud_name}/image/upload")
  end

  def upload_url(%{cloud_name: cloud_name, resource_type: type})
      when is_binary(cloud_name) and type in [:auto, :image, :video, :raw] do
    URI.parse("https://api.cloudinary.com/v1_1/#{cloud_name}/#{type}/upload")
  end

  def upload_url(%{cloud_name: cloud_name}) when is_binary(cloud_name) do
    URI.parse("https://api.cloudinary.com/v1_1/#{cloud_name}/image/upload")
  end

  @doc """
  Encodes upload option parameters to a form string.

  ## Example
      iex> #{__MODULE__}.encode_params(%{async: true})
      "async=1"

      iex> #{__MODULE__}.encode_params(%{backup: false})
      "backup=0"

      iex> #{__MODULE__}.encode_params(%{auto_tagging: 0.88})
      "auto_tagging=0.88"

      iex> #{__MODULE__}.encode_params(%{public_id: "flower"})
      "public_id=flower"

      iex> #{__MODULE__}.encode_params(%{format: :jpg})
      "format=jpg"

      iex> #{__MODULE__}.encode_params(%{
      ...>   transformation: [
      ...>     [width: 600, crop: :fill, effect: {:art, :frost}],
      ...>     [effect: :tint]
      ...>   ]
      ...> })
      "transformation=w_600%2Cc_fill%2Ce_art%3Afrost%2Fe_tint"

      iex> #{__MODULE__}.encode_params(%{timestamp: 1592061121})
      "timestamp=1592061121"

      iex> #{__MODULE__}.encode_params(%{timestamp: ~U[2019-12-22 06:27:03.549Z]})
      "timestamp=1576996023"
  """
  @spec encode_params(%{
          optional(:async) => boolean,
          optional(:backup) => boolean,
          optional(:cinemagraph_analysis) => boolean,
          optional(:colors) => boolean,
          optional(:discard_original_filename) => boolean,
          optional(:eager_async) => boolean,
          optional(:exif) => boolean,
          optional(:faces) => boolean,
          optional(:image_metadata) => boolean,
          optional(:invalidate) => boolean,
          optional(:overwrite) => boolean,
          optional(:phash) => boolean,
          optional(:quality_analysis) => boolean,
          optional(:return_delete_token) => boolean,
          optional(:unique_filename) => boolean,
          optional(:use_filename) => boolean,
          optional(:callback) => String.t(),
          optional(:eager_notification_url) => String.t(),
          optional(:folder) => String.t(),
          optional(:notification_url) => String.t(),
          optional(:proxy) => String.t(),
          optional(:public_id) => String.t(),
          optional(:quality_override) => String.t(),
          optional(:upload_preset) => String.t(),
          optional(:tags) => String.t() | [String.t()],
          optional(:auto_tagging) => 0..1 | float,
          optional(:format) => Cloudinary.Format.t(),
          optional(:transformation) =>
            Cloudinary.Transformation.t() | [Cloudinary.Transformation.t()],
          optional(:timestamp) => Calendar.datetime() | integer,
          optional(:allowed_formats) => allowed_format | [allowed_format],
          optional(:custom_coordinates) => coordinates,
          optional(:face_coordinates) => coordinates | [coordinates],
          optional(:access_control) => access_control,
          optional(:responsive_breakpoints) => responsive_breakpoint | [responsive_breakpoint],
          optional(:context) => context,
          optional(:metadata) => metadata,
          optional(:access_mode) => access_mode,
          optional(:background_removal) => background_removal,
          optional(:detection) => detection,
          optional(:moderation) => moderation,
          optional(:ocr) => ocr,
          optional(:raw_convert) => raw_convert,
          optional(:type) => type,
          optional(:categorization) => categorization | [categorization],
          optional(:eager) => eager | [eager],
          optional(:headers) => header | [header]
        }) :: binary
  def encode_params(params) when is_map(params) or is_list(params) do
    params |> Enum.map(&convert_param/1) |> URI.encode_query()
  end

  @spec convert_param({atom, any}) :: {atom, String.Chars.t()}
  @boolean_options [
    :async,
    :backup,
    :cinemagraph_analysis,
    :colors,
    :discard_original_filename,
    :eager_async,
    :exif,
    :faces,
    :image_metadata,
    :invalidate,
    :overwrite,
    :phash,
    :quality_analysis,
    :return_delete_token,
    :unique_filename,
    :use_filename
  ]
  defp convert_param({key, true}) when key in @boolean_options, do: {key, 1}
  defp convert_param({key, false}) when key in @boolean_options, do: {key, 0}

  defp convert_param({key, string} = param)
       when is_binary(string) and
              key in [
                :callback,
                :eager_notification_url,
                :folder,
                :notification_url,
                :proxy,
                :public_id,
                :quality_override,
                :upload_preset,
                :tags
              ] do
    param
  end

  defp convert_param({:tags, tags}) when is_list(tags) do
    if Enum.all?(tags, &is_binary/1) do
      Enum.join(tags, ",")
    else
      raise ArgumentError, "expected a string or a list of strings"
    end
  end

  defp convert_param({:transformation, transformation}) do
    {:transformation, Cloudinary.Transformation.to_url_string(transformation)}
  end

  defp convert_param({:auto_tagging, score} = param) when score <= 1 and score >= 0, do: param
  defp convert_param({:format, format} = param) when is_supported(format), do: param
  defp convert_param({:timestamp, timestamp} = param) when is_integer(timestamp), do: param
  defp convert_param({:timestamp, timestamp}), do: {:timestamp, DateTime.to_unix(timestamp)}

  @typedoc """
  The `t:atom/0` of cloudinary supported format or the `t:String.t/0` for ohter raw formats.
  ## Example
      iex> #{__MODULE__}.encode_params(%{allowed_formats: "txt"})
      "allowed_formats=txt"

      iex> #{__MODULE__}.encode_params(%{allowed_formats: [:jpg, "txt"]})
      "allowed_formats=jpg%2Ctxt"

      iex> #{__MODULE__}.encode_params(%{allowed_formats: [:jww]})
      ** (ArgumentError) expected an atom of supported format, a string or a list of them
  """
  @type allowed_format :: Cloudinary.Format.t() | String.t()
  defp convert_param({:allowed_formats, f} = param) when is_supported(f) or is_binary(f),
    do: param

  defp convert_param({:allowed_formats, formats}) when is_list(formats) do
    if Enum.all?(formats, fn format -> is_supported(format) || is_binary(format) end) do
      {:allowed_formats, Enum.join(formats, ",")}
    else
      raise ArgumentError, "expected an atom of supported format, a string or a list of them"
    end
  end

  @typedoc """
  A `t:tuple/0` with four elements representing x, y, width and height.
  ## Example
      iex> #{__MODULE__}.encode_params(%{custom_coordinates: {85, 120, 220, 310}})
      "custom_coordinates=85%2C120%2C220%2C310"

      iex> #{__MODULE__}.encode_params(%{face_coordinates: {85, 120, 220, 310}})
      "custom_coordinates=85%2C120%2C220%2C310"

      iex> #{__MODULE__}.encode_params(%{face_coordinates: [{10, 20, 150, 130}, {213, 345, 82, 61}]})
      "custom_coordinates=10%2C20%2C150%2C130%7C213%2C345%2C82%2C61"
  """
  @type coordinates :: {number, number, number, number}
  defp convert_param({key, {x, y, width, height}})
       when key in [:custom_coordinates, :face_coordinates] and
              is_number(x) and is_number(y) and is_number(width) and is_number(height) do
    {key, "#{x},#{y},#{width},#{height}"}
  end

  defp convert_param({:face_coordinates, coordinates}) when is_list(coordinates) do
    coordinates =
      Enum.map_join(coordinates, "|", fn
        {x, y, width, height}
        when is_number(x) and is_number(y) and is_number(width) and is_number(height) ->
          "#{x},#{y},#{width},#{height}"
      end)

    {:face_coordinates, coordinates}
  end

  @typedoc """
  An access mode specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{access_mode: :authenticated})
      "access_mode=authenticated"
  """
  @type access_mode :: :public | :authenticated
  defp convert_param({:access_mode, access_mode} = param)
       when access_mode in [:public, :authenticated] do
    param
  end

  @typedoc """
  A background removal specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{background_removal: :pixelz})
      "background_removal=pixelz"
  """
  @type background_removal :: :cloudinary_ai | :pixelz
  defp convert_param({:background_removal, background_removal} = param)
       when background_removal in [:cloudinary_ai, :pixelz] do
    param
  end

  @typedoc """
  A face detection specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{detection: :aws_rek_face})
      "detection=aws_rek_face"
  """
  @type detection :: :adv_face | :aws_rek_face
  defp convert_param({:detection, detection} = param)
       when detection in [:adv_face, :aws_rek_face] do
    param
  end

  @typedoc """
  A moderation specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{moderation: :webpurify})
      "moderation=webpurify"
  """
  @type moderation :: :manual | :metascan | :webpurify | :aws_rek
  defp convert_param({:moderation, moderation} = param)
       when moderation in [:manual, :metascan, :webpurify, :aws_rek] do
    param
  end

  @typedoc """
  A ocr specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{ocr: :adv_ocr})
      "ocr=adv_ocr"
  """
  @type ocr :: :adv_ocr
  defp convert_param({:ocr, ocr} = param) when ocr in [:adv_ocr] do
    param
  end

  @typedoc """
  A raw convert specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{raw_convert: :aspose})
      "raw_convert=aspose"
  """
  @type raw_convert :: :aspose | :google_speech | :extract_text
  defp convert_param({:raw_convert, raw_convert} = param)
       when raw_convert in [:aspose, :google_speech, :extract_text] do
    param
  end

  @typedoc """
  A delivery type specification.
  ## Example
      iex> #{__MODULE__}.encode_params(%{type: :private})
      "type=private"
  """
  @type type :: :upload | :private | :authenticated
  defp convert_param({:type, type} = param) when type in [:upload, :private, :authenticated] do
    param
  end

  @typedoc """
  A categorization add-ons.
  ## Example
      iex> #{__MODULE__}.encode_params(%{categorization: :google_tagging})
      "categorization=google_tagging"

      iex> #{__MODULE__}.encode_params(%{categorization: [:imagga_tagging, :aws_rek_tagging]})
      "categorization=imagga_tagging%2Caws_rek_tagging"
  """
  @type categorization ::
          :google_tagging | :google_video_tagging | :imagga_tagging | :aws_rek_tagging
  @addons [:google_tagging, :google_video_tagging, :imagga_tagging, :aws_rek_tagging]
  defp convert_param({:categorization, categorization} = param) when categorization in @addons do
    param
  end

  defp convert_param({:categorization, categorizations}) when is_list(categorizations) do
    if Enum.all?(categorizations, &(&1 in @addons)) do
      {:categorization, Enum.join(categorizations, ",")}
    else
      raise ArgumentError, "expected one of tagging add-on names or a list of them"
    end
  end

  @typedoc """
  A `t:keyword/0` or a `t:map/0` of the access control representation.

  Options:
  * `:access_type` - Required. `:token` or `:anonymous`.
  * `:start` - When to start the asset publically available. It can be optionally specified if the
    access_type is `:anonymous`.
  * `:end` - When to end the asset publically available. It can be optionally specified if the
    access_type is `:anonymous`.
  ## Example
      iex> #{__MODULE__}.encode_params(%{access_control: [access_type: :token]})
      "access_control=%7B%22access_type%22%3A%22anonymous%22%7D"
      
      iex> #{__MODULE__}.encode_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     end: ~U[2018-01-20 13:30:00Z]
      ...>   ]
      ...> })
      "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22end%22%3A%222018-01-20T13%3A30%3A00Z%22%7D"

      iex> #{__MODULE__}.encode_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     start: ~U[2017-12-15 12:00:00Z]
      ...>   ]
      ...> })
      "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22start%22%3A%222017-12-15T12%3A00%3A00Z%22%7D"

      iex> #{__MODULE__}.encode_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     start: ~U[2017-12-15 12:00:00Z],
      ...>     end: ~U[2018-01-20 13:30:00Z]
      ...>   ]
      ...> })
      "access_control=%7B%22access_type%22%3A%22anonymous%22%2C%22start%22%3A%222017-12-15T12%3A00%3A00Z%22%2C%22end%22%3A%222018-01-20T13%3A30%3A00Z%22%7D"
  """
  @type access_control :: keyword | map
  defp convert_param({:access_control, options}) when is_list(options) do
    convert_param({:access_control, Enum.into(options, %{})})
  end

  defp convert_param({:access_control, options}) when is_map(options) do
    {:access_control, __MODULE__.AccessType.to_string(options)}
  end

  @typedoc """
  A `t:keyword/0` or a `t:map/0` of the breakpoint request settings representation.

  Options:
  * `:create_derived` - Required `t:boolean/0`.
  * `:format` - A `t:Cloudinary.Format.t/0`.
  * `:transformation` - A `t:Cloudinary.Transformation.t/0` or a list of transformations
    representing the chained transformations.
  * `:max_width` - An integer greater than or equal to 0.
  * `:min_width` - An integer greater than or equal to 0.
  * `:bytes_step` - A positive integer.
  * `:max_images` - An integer between from 3 to 200.
  ## Example
      iex> #{__MODULE__}.encode_params(%{
      ...>   responsive_breakpoints: [
      ...>     [ 
      ...>       create_derived: true, 
      ...>       bytes_step: 20000, 
      ...>       min_width: 200, 
      ...>       max_width: 1000,
      ...>       max_images: 20,
      ...>       transformation: [crop: :fill, aspect_ratio: {16, 9}, gravity: :face]
      ...>     ], [ 
      ...>       create_derived: false,
      ...>       format: :jpg,
      ...>       min_width: 350, 
      ...>       max_width: 2000,
      ...>       max_images: 18,
      ...>       transformation: [crop: :fill, width: 0.75, effect: :sharpen]
      ...>     ] 
      ...>   ]
      ...> })
      "responsive_breakpoints=%5B%7B%22create_derived%22%3Atrue%2C%22transformation%22%3A%22c_fill%2Car_16%3A9%2Cg_face%22%2C%22max_width%22%3A1000%2C%22min_width%22%3A200%2C%22bytes_step%22%3A20000%2C%22max_images%22%3A20%7D%2C%7B%22create_derived%22%3Afalse%2C%22format%22%3A%22jpg%22%2C%22transformation%22%3A%22c_fill%2Cw_0.75%2Ce_sharpen%22%2C%22max_width%22%3A2000%2C%22min_width%22%3A350%2C%22max_images%22%3A18%7D%5D"
  """
  @type responsive_breakpoint :: keyword | map
  defp convert_param({:responsive_breakpoints, breakpoint}) when is_map(breakpoint) do
    "[#{__MODULE__.ResponsiveBreakpoint.to_string(breakpoint)}]"
  end

  defp convert_param({:responsive_breakpoints, breakpoints}) when is_list(breakpoints) do
    if Keyword.keyword?(breakpoints) do
      convert_param({:responsive_breakpoints, Enum.into(breakpoints, %{})})
    else
      breakpoints =
        Enum.map(breakpoints, fn
          breakpoint when is_list(breakpoint) ->
            breakpoint |> Enum.into(%{}) |> __MODULE__.ResponsiveBreakpoint.to_string()

          breakpoint when is_map(breakpoint) ->
            breakpoint |> __MODULE__.ResponsiveBreakpoint.to_string()
        end)

      {:responsive_breakpoints, "[#{Enum.join(breakpoints, ",")}]"}
    end
  end

  @typedoc """
  A `t:list/0` of two element `t:tuple/0`s or a`t:map/0` representing key-value pairs.

  Each key and value can be any types `String.Chars` protocol implementation.
  """
  @type context :: Enum.t()
  defp convert_param({:context, context}) when is_list(context) or is_map(context) do
    context =
      Enum.map_join(context, "|", fn {key, value} ->
        "#{key}=#{String.replace("#{value}", ~r/[=|]/, "\\\\0")}"
      end)

    {:context, context}
  end

  @typedoc """
  A `t:list/0` of two element `t:tuple/0`s or a`t:map/0` representing key-value pairs.

  Each key and value can be any types `String.Chars` protocol implementation.
  """
  @type metadata :: Enum.t()
  defp convert_param({:metadata, metadata}) when is_list(metadata) or is_map(metadata) do
    metadata =
      Enum.map_join(metadata, "|", fn {key, value} ->
        "#{key}=#{String.replace("#{value}", ~r/[=|"]/, "\\\\0")}"
      end)

    {:metadata, metadata}
  end

  @typedoc """
  An `t:keyword/0` or a `t:map/0` representing the eager transformation.

  Options:
  * `:transformation` - A `t:Cloudinaty.Transformation.t/0` or a list of transformations.
  * `:format` - An optional `t:Cloudinary.Format.t/0` the asset will be converted to.
  ## Example
      iex> #{__MODULE__}.encode_params(%{
      ...>   eager: [transformation: [crop: :fit, angle: 6, effect: :auto_contrast]]  
      ...> })
      "eager=c_fit%2Ca_6%2Ce_auto_contrast"

      iex> #{__MODULE__}.encode_params(%{
      ...>   eager: [[
      ...>     transformation: [crop: :fit, angle: 6, effect: :auto_contrast],
      ...>     format: :png
      ...>   ], [
      ...>     transformation: [[effect: {:art, :audrey}], [effect: {:art, :zorro}]]
      ...>   ]]
      ...> })
      "eager=c_fit%2Ca_6%2Ce_auto_contrast%2Fpng%7Ce_art%3Aaudrey%2Fe_art%3Azorro"
  """
  @type eager :: keyword | map
  defp convert_param({:eager, eager}) when is_map(eager), do: __MODULE__.Eager.to_string(eager)

  defp convert_param({:eager, eager}) when is_list(eager) do
    if Keyword.keyword?(eager) do
      __MODULE__.Eager.to_string(Enum.into(eager, %{}))
    else
      Enum.map_join(eager, "|", fn
        eager when is_map(eager) -> __MODULE__.Eager.to_string(eager)
        eager when is_list(eager) -> __MODULE__.Eager.to_string(Enum.into(eager, %{}))
      end)
    end
  end

  @typedoc """
  A `t:tuple/0` with two elements, the header name and the header value.
  ## Example
      iex> #{__MODULE__}.encode_params(%{headers: {"x-robots-tag", "noindex"}})
      "headers=x-robotes-tag%3A%20noindex"

      iex> #{__MODULE__}.encode_params(%{
      ...>   headers: [
      ...>     {"x-robots-tag", "noindex"},
      ...>     {"link", "<https://example.com>; rel=\"preconnect\""}
      ...>   ]
      ...> })
      "headers=x-robotes-tag%3A%20noindex%0Alink%3A%20%3Chttps%3A%2F%2Fexample.com%3E%3B%20rel%3D%22preconnect%22"
  """
  @type header :: {String.t(), String.t()}
  defp convert_param({:headers, {name, value}}) when is_binary(name) and is_binary(value) do
    {:headers, "#{name}: #{value}"}
  end

  defp convert_param({:headers, headers}) when is_list(headers) do
    headers =
      Enum.map_join(headers, "\n", fn
        {name, value} when is_binary(name) and is_binary(value) -> "#{name}: #{value}"
      end)

    {:headers, headers}
  end
end
