defmodule Cloudinary.Uploader do
  @moduledoc """
  The API functions used to upload assets to the cloud.
  """
  use Tesla, only: [:post]
  import Cloudinary.Format

  @doc """
  Uploads assets to the cloud.
  """
  @spec upload(String.t(), keyword | map, keyword | map) :: Tesla.Env.result()
  def upload(file, params, options) do
    mp = build_params(file, params, options)
    Tesla.post(upload_url(options), mp)
  end

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
      "https://api.cloudinary.com/v1_1/abcd1234/image/upload"

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", resource_type: :video})
      "https://api.cloudinary.com/v1_1/abcd1234/video/upload"

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", upload_prefix: "https://example.com/api"})
      "https://example.com/api/v1_1/abcd1234/image/upload"

      iex> #{__MODULE__}.upload_url(%{cloud_name: "abcd1234", resource_type: :auto, upload_prefix: "https://example.com/api"})
      "https://example.com/api/v1_1/abcd1234/auto/upload"
  """
  @spec upload_url(%{
          required(:cloud_name) => String.t(),
          optional(:upload_prefix) => String.t(),
          optional(:resource_type) => :auto | :image | :video | :raw
        }) :: String.t()
  def upload_url(%{cloud_name: cloud_name, upload_prefix: prefix, resource_type: type})
      when is_binary(cloud_name) and is_binary(prefix) and type in [:auto, :image, :video, :raw] do
    "#{prefix}/v1_1/#{cloud_name}/#{type}/upload"
  end

  def upload_url(%{cloud_name: cloud_name, upload_prefix: prefix})
      when is_binary(cloud_name) and is_binary(prefix) do
    "#{prefix}/v1_1/#{cloud_name}/image/upload"
  end

  def upload_url(%{cloud_name: cloud_name, resource_type: type})
      when is_binary(cloud_name) and type in [:auto, :image, :video, :raw] do
    "https://api.cloudinary.com/v1_1/#{cloud_name}/#{type}/upload"
  end

  def upload_url(%{cloud_name: cloud_name}) when is_binary(cloud_name) do
    "https://api.cloudinary.com/v1_1/#{cloud_name}/image/upload"
  end

  @doc """
  Builds an upload option parameters.
  """
  @spec build_params(String.t(), map | keyword, map) :: Tesla.Multipart.t()
  def build_params(file, params, options) when is_binary(file) do
    params = params |> put_timestamp() |> convert_params()

    mp =
      params
      |> Enum.reduce(Tesla.Multipart.new(), fn {name, value}, mp ->
        mp |> Tesla.Multipart.add_field(Atom.to_string(name), to_string(value))
      end)
      |> Tesla.Multipart.add_field("signature", signature(params, options[:api_secret]))
      |> Tesla.Multipart.add_field("api_key", options[:api_key])

    if Cloudinary.is_remote_url?(file) do
      mp |> Tesla.Multipart.add_field("file", file)
    else
      mp |> Tesla.Multipart.add_file(file)
    end
  end

  @spec put_timestamp(map | keyword) :: map | keyword
  defp put_timestamp(params) when is_list(params) do
    Keyword.put_new(params, :timestamp, DateTime.utc_now())
  end

  defp put_timestamp(params) when is_map(params) do
    Map.put_new(params, :timestamp, DateTime.utc_now())
  end

  @doc """
  Generates an authentication signature.

  ## Example
      iex> #{__MODULE__}.signature([allowed_formats: "jpg,txt", timestamp: 1597596436], "abcd1234")
      "8debfc9edf705cec8a424c246a6ba57cbd3e9d5a"

      iex> #{__MODULE__}.signature([api_key: 01234567, timestamp: 1597596436, allowed_formats: "jpg,txt"], "abcd1234")
      "8debfc9edf705cec8a424c246a6ba57cbd3e9d5a"
  """
  @spec signature(keyword(String.Chars.t()), binary) :: binary
  def signature(params, api_secret) when is_binary(api_secret) do
    params =
      params
      |> Enum.filter(&(elem(&1, 0) not in [:api_key, :cloud_name, :file, :resource_type]))
      |> Enum.sort()
      |> Enum.map_intersperse("&", fn {k, v} -> "#{k}=#{v}" end)

    :crypto.hash(:sha, [params | api_secret]) |> Base.encode16() |> String.downcase()
  end

  @doc """
  Converts upload option parameters to form field strings.

  ## Example
      iex> #{__MODULE__}.convert_params(%{async: true})
      [async: 1]

      iex> #{__MODULE__}.convert_params(%{backup: false})
      [backup: 0]

      iex> #{__MODULE__}.convert_params(%{auto_tagging: 0.88})
      [auto_tagging: 0.88]

      iex> #{__MODULE__}.convert_params(%{public_id: "flower"})
      [public_id: "flower"]

      iex> #{__MODULE__}.convert_params(%{tags: ["dog", "cat"]})
      [tags: "dog,cat"]

      iex> #{__MODULE__}.convert_params(%{tags: ["dog", :not_a_string]})
      ** (ArgumentError) expected a string or a list of strings

      iex> #{__MODULE__}.convert_params(%{format: :jpg})
      [format: :jpg]

      iex> #{__MODULE__}.convert_params(%{
      ...>   transformation: [
      ...>     [width: 600, crop: :fill, effect: {:art, :frost}],
      ...>     [effect: :tint]
      ...>   ]
      ...> })
      [transformation: "w_600,c_fill,e_art:frost/e_tint"]

      iex> #{__MODULE__}.convert_params(%{timestamp: 1592061121})
      [timestamp: 1592061121]

      iex> #{__MODULE__}.convert_params(%{timestamp: #{
    if Version.match?(System.version(), ">= 1.9.0") do
      "~U[2019-12-22 06:27:03Z]"
    else
      "DateTime.from_unix!(1576996023)"
    end
  }})
      [timestamp: 1576996023]
  """
  @spec convert_params(%{
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
        }) :: keyword(String.Chars.t())
  def convert_params(params) when is_map(params) or is_list(params) do
    params |> Enum.map(&convert_param/1)
  end

  defguardp is_boolean_option(key)
            when key in [
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

  @spec convert_param({atom, any}) :: {atom, iodata}
  defp convert_param({key, true}) when is_boolean_option(key), do: {key, 1}
  defp convert_param({key, false}) when is_boolean_option(key), do: {key, 0}

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
      {:tags, Enum.join(tags, ",")}
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
      iex> #{__MODULE__}.convert_params(%{allowed_formats: "txt"})
      [allowed_formats: "txt"]

      iex> #{__MODULE__}.convert_params(%{allowed_formats: [:jpg, "txt"]})
      [allowed_formats: "jpg,txt"]

      iex> #{__MODULE__}.convert_params(%{allowed_formats: [:jww]})
      ** (ArgumentError) expected an atom of supported format, a string or a list of them
  """
  @type allowed_format :: Cloudinary.Format.t() | String.t()
  defp convert_param({:allowed_formats, f} = param) when is_supported(f) or is_binary(f) do
    param
  end

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
      iex> #{__MODULE__}.convert_params(%{custom_coordinates: {85, 120, 220, 310}})
      [custom_coordinates: "85,120,220,310"]

      iex> #{__MODULE__}.convert_params(%{face_coordinates: {85, 120, 220, 310}})
      [face_coordinates: "85,120,220,310"]

      iex> #{__MODULE__}.convert_params(%{face_coordinates: [{10, 20, 150, 130}, {213, 345, 82, 61}]})
      [face_coordinates: "10,20,150,130,213,345,82,61"]
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
      iex> #{__MODULE__}.convert_params(%{access_mode: :authenticated})
      [access_mode: :authenticated]
  """
  @type access_mode :: :public | :authenticated
  defp convert_param({:access_mode, access_mode} = param)
       when access_mode in [:public, :authenticated] do
    param
  end

  @typedoc """
  A background removal specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{background_removal: :pixelz})
      [background_removal: :pixelz]
  """
  @type background_removal :: :cloudinary_ai | :pixelz
  defp convert_param({:background_removal, background_removal} = param)
       when background_removal in [:cloudinary_ai, :pixelz] do
    param
  end

  @typedoc """
  A face detection specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{detection: :aws_rek_face})
      [detection: :aws_rek_face]
  """
  @type detection :: :adv_face | :aws_rek_face
  defp convert_param({:detection, detection} = param)
       when detection in [:adv_face, :aws_rek_face] do
    param
  end

  @typedoc """
  A moderation specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{moderation: :webpurify})
      [moderation: :webpurify]
  """
  @type moderation :: :manual | :metascan | :webpurify | :aws_rek
  defp convert_param({:moderation, moderation} = param)
       when moderation in [:manual, :metascan, :webpurify, :aws_rek] do
    param
  end

  @typedoc """
  A ocr specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{ocr: :adv_ocr})
      [ocr: :adv_ocr]
  """
  @type ocr :: :adv_ocr
  defp convert_param({:ocr, ocr} = param) when ocr in [:adv_ocr] do
    param
  end

  @typedoc """
  A raw convert specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{raw_convert: :aspose})
      [raw_convert: :aspose]
  """
  @type raw_convert :: :aspose | :google_speech | :extract_text
  defp convert_param({:raw_convert, raw_convert} = param)
       when raw_convert in [:aspose, :google_speech, :extract_text] do
    param
  end

  @typedoc """
  A delivery type specification.
  ## Example
      iex> #{__MODULE__}.convert_params(%{type: :private})
      [type: :private]
  """
  @type type :: :upload | :private | :authenticated
  defp convert_param({:type, type} = param) when type in [:upload, :private, :authenticated] do
    param
  end

  @typedoc """
  A categorization add-ons.
  ## Example
      iex> #{__MODULE__}.convert_params(%{categorization: :google_tagging})
      [categorization: :google_tagging]

      iex> #{__MODULE__}.convert_params(%{categorization: [:imagga_tagging, :aws_rek_tagging]})
      [categorization: "imagga_tagging,aws_rek_tagging"]
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
      iex> #{__MODULE__}.convert_params(%{access_control: [access_type: :token]})
      [access_control: "{\"access_type\":\"anonymous\"}"]
      
      iex> #{__MODULE__}.convert_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     end: ~U[2018-01-20 13:30:00Z]
      ...>   ]
      ...> })
      [access_control: "{\"access_type\":\"anonymous\",\"end\":\"2018-01-20T13:30:00Z\"}"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     start: ~U[2017-12-15 12:00:00Z]
      ...>   ]
      ...> })
      [access_control: "{\"access_type\":\"anonymous\",\"start\":\"2017-12-15T12:00:00Z\"}"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   access_control: [
      ...>     access_type: :anonymous,
      ...>     start: ~U[2017-12-15 12:00:00Z],
      ...>     end: ~U[2018-01-20 13:30:00Z]
      ...>   ]
      ...> })
      [access_control: "{\"access_type\":\"anonymous\",\"start\":\"2017-12-15T12:00:00Z\",\"end\":\"2018-01-20T13:30:00Z\"}"]
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
      iex> #{__MODULE__}.convert_params(%{
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
      [responsive_breakpoints: "[{\"create_derived\":true,\"transformation\":\"c_fill,ar_16:9,g_face\",\"max_width\":1000,\"min_width\":200,\"bytes_step\":20000,\"max_images\":20},{\"create_derived\":false,\"format\":\"jpg\",\"transformation\":\"c_fill,w_0.75,e_sharpen\":\"max_width\":2000,\"min_width\":350,\"max_images\":18}]"]
  """
  @type responsive_breakpoint :: keyword | map
  defp convert_param({:responsive_breakpoints, breakpoint}) when is_map(breakpoint) do
    {:responsive_breakpoints, "[#{__MODULE__.ResponsiveBreakpoint.to_string(breakpoint)}]"}
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
  ## Example
      iex> #{__MODULE__}.convert_params(%{
      ...>   context: [alt: "My image", caption: "Profile image"]
      ...> })
      [context: "alt=My image|caption=Profile image"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   context: %{"alt" => "My=image", "caption" => "Profile|image"}
      ...> })
      [context: "alt=My\=image|caption=Profile\|image"]
  """
  @type context :: Enum.t()
  defp convert_param({:context, context}) when is_list(context) or is_map(context) do
    context =
      Enum.map_join(context, "|", fn {key, value} ->
        "#{key}=#{String.replace("#{value}", ~r/[=|]/, "\\\\\\0")}"
      end)

    {:context, context}
  end

  @typedoc """
  A `t:list/0` of two element `t:tuple/0`s or a`t:map/0` representing key-value pairs.

  Each key and value can be any types `String.Chars` protocol implementation.
  ## Example
      iex> #{__MODULE__}.convert_params(%{
      ...>   metadata: [in_stock_id: 50, color_id: "[\"green\",\"red\"]"]
      ...> })
      [metadata: "in_stock_id=50|color_id=[\\\"green\\\",\\\"red\\\"]"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   metadata: %{"in_stock_id" => 50, "color_id" => "[\"green\",\"red\"]"}
      ...> })
      [metadata: "in_stock_id=50|color_id=[\\\"green\\\",\\\"red\\\"]"]
  """
  @type metadata :: Enum.t()
  defp convert_param({:metadata, metadata}) when is_list(metadata) or is_map(metadata) do
    metadata =
      Enum.map_join(metadata, "|", fn {key, value} ->
        "#{key}=#{String.replace("#{value}", ~r/[=|"]/, "\\\\\\0")}"
      end)

    {:metadata, metadata}
  end

  @typedoc """
  An `t:keyword/0` or a `t:map/0` representing the eager transformation.

  Options:
  * `:transformation` - A `t:Cloudinaty.Transformation.t/0` or a list of transformations.
  * `:format` - An optional `t:Cloudinary.Format.t/0` the asset will be converted to.
  ## Example
      iex> #{__MODULE__}.convert_params(%{
      ...>   eager: [transformation: [crop: :fit, angle: 6, effect: :auto_contrast]]  
      ...> })
      [eager: "c_fit,a_6,e_auto_contrast"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   eager: [[
      ...>     transformation: [crop: :fit, angle: 6, effect: :auto_contrast],
      ...>     format: :png
      ...>   ], [
      ...>     transformation: [[effect: {:art, :audrey}], [effect: {:art, :zorro}]]
      ...>   ]]
      ...> })
      [eager: "c_fit,a_6,e_auto_contrast/png|e_art:audrey/e_art:zorro"]
  """
  @type eager :: keyword | map
  defp convert_param({:eager, eager}) when is_map(eager) do
    {:eager, __MODULE__.Eager.to_string(eager)}
  end

  defp convert_param({:eager, eager}) when is_list(eager) do
    if Keyword.keyword?(eager) do
      convert_param({:eager, Enum.into(eager, %{})})
    else
      eager =
        Enum.map_join(eager, "|", fn
          eager when is_map(eager) -> eager |> __MODULE__.Eager.to_string()
          eager when is_list(eager) -> eager |> Enum.into(%{}) |> __MODULE__.Eager.to_string()
        end)

      {:eager, eager}
    end
  end

  @typedoc """
  A `t:tuple/0` with two elements, the header name and the header value.
  ## Example
      iex> #{__MODULE__}.convert_params(%{headers: {"x-robots-tag", "noindex"}})
      [headers: "x-robots-tag: noindex"]

      iex> #{__MODULE__}.convert_params(%{
      ...>   headers: [
      ...>     {"x-robots-tag", "noindex"},
      ...>     {"link", "<https://example.com>; rel=\"preconnect\""}
      ...>   ]
      ...> })
      [headers: "x-robots-tag: noindex\nlink: <https://example.com>; rel=\"preconnect\""]
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
