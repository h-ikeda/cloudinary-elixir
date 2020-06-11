defmodule Cloudinary.Format do
  @moduledoc """
  The cloudinary supported formats of images, videos and audios.
  ## Official documentation
  * https://cloudinary.com/documentation/image_transformations#supported_image_formats
  * https://cloudinary.com/documentation/video_manipulation_and_delivery#supported_video_formats
  * https://cloudinary.com/documentation/audio_transformations#supported_audio_formats
  """
  @typedoc """
  The cloudinary supported formats of images, videos and audios.
  """
  @type t ::
          :ai
          | :gif
          | :webp
          | :bmp
          | :djvu
          | :ps
          | :ept
          | :eps
          | :eps3
          | :fbx
          | :flif
          | :gltf
          | :heif
          | :heic
          | :ico
          | :indd
          | :jpg
          | :jpe
          | :jpeg
          | :jp2
          | :wdp
          | :jxr
          | :hdp
          | :pdf
          | :png
          | :psd
          | :arw
          | :cr2
          | :svg
          | :tga
          | :tif
          | :tiff
          | :"3g2"
          | :"3gp"
          | :avi
          | :flv
          | :m3u8
          | :ts
          | :m2ts
          | :mts
          | :mov
          | :mkv
          | :mp4
          | :mpeg
          | :mpd
          | :mxf
          | :ogv
          | :webm
          | :wmv
          | :aac
          | :aiff
          | :amr
          | :flac
          | :m4a
          | :mp3
          | :ogg
          | :opus
          | :wav

  @doc """
  Returns true if the format of the image, video or audio is supported by the cloudinary.
  ## Example
      iex> Cloudinary.Format.is_supported(:png)
      true

      iex> Cloudinary.Format.is_supported(:txt)
      false
  """
  defguard is_supported(format)
           when format in [
                  :ai,
                  :gif,
                  :webp,
                  :bmp,
                  :djvu,
                  :ps,
                  :ept,
                  :eps,
                  :eps3,
                  :fbx,
                  :flif,
                  :gltf,
                  :heif,
                  :heic,
                  :ico,
                  :indd,
                  :jpg,
                  :jpe,
                  :jpeg,
                  :jp2,
                  :wdp,
                  :jxr,
                  :hdp,
                  :pdf,
                  :png,
                  :psd,
                  :arw,
                  :cr2,
                  :svg,
                  :tga,
                  :tif,
                  :tiff,
                  :"3g2",
                  :"3gp",
                  :avi,
                  :flv,
                  :m3u8,
                  :ts,
                  :m2ts,
                  :mts,
                  :mov,
                  :mkv,
                  :mp4,
                  :mpeg,
                  :mpd,
                  :mxf,
                  :ogv,
                  :webm,
                  :wmv,
                  :aac,
                  :aiff,
                  :amr,
                  :flac,
                  :m4a,
                  :mp3,
                  :ogg,
                  :opus,
                  :wav
                ]
end
