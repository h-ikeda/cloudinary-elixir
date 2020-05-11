defmodule Cloudinary.Transformation.Overlay.Text do
  @moduledoc """
  Representing `overlay` parameter of transformation which adds text captions.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations#adding_text_captions
  https://cloudinary.com/documentation/video_manipulation_and_delivery#adding_text_captions
  ## Example
      iex> %#{__MODULE__}{text: "Flowers", style: %Cloudinary.Transformation.Layer.TextStyle{font_family: "Arial", font_size: 80}} |> to_string()
      "l_text:Arial_80:Flowers"

      iex> %#{__MODULE__}{text: "Stylish Text/", style: "sample_text_style"} |> to_string()
      "l_text:sample_text_style:Stylish%20Text%2F"
  """
  alias Cloudinary.Transformation.Layer.TextStyle
  @type t :: %__MODULE__{text: String.t(), style: String.t() | TextStyle.t()}
  defstruct [:text, :style]

  defimpl String.Chars do
    def to_string(%{text: text, style: public_id})
        when is_binary(text) and is_binary(public_id) do
      "l_text:#{public_id}:#{escape(text)}"
    end

    def to_string(%{text: text, style: %TextStyle{} = style}) when is_binary(text) do
      "l_text:#{style}:#{escape(text)}"
    end

    @spec escape(String.t()) :: String.t()
    defp escape(text) do
      text |> URI.encode(&(&1 not in [?,, ?%])) |> URI.encode(&URI.char_unreserved?/1)
    end
  end
end
