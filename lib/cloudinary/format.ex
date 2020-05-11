defmodule Cloudinary.Format do
  @moduledoc """
  Defining atoms representing supported image, video or audio formats.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#supported_image_formats
  https://cloudinary.com/documentation/video_manipulation_and_delivery#supported_video_formats
  https://cloudinary.com/documentation/audio_transformations#supported_audio_formats
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
  Returns true if image, video or audio format is supported by cloudinary.

  ## Example
      iex> Cloudinary.Format.supported?(:png)
      true

      iex> Cloudinary.Format.supported?(:txt)
      false
  """
  @spec supported?(Macro.t()) :: Macro.t()
  defguard supported?(format)
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
