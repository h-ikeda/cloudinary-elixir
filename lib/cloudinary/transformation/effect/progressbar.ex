defmodule Cloudinary.Transformation.Effect.Progressbar do
  @moduledoc """
  Representing the effect that adds a progressbar on the video.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#adding_video_effects
  ## Example
      iex> %#{__MODULE__}{type: :frame, color: "blue", width: 5} |> to_string()
      "e_progressbar:frame:blue:5"
  """
  @type t :: %__MODULE__{type: :bar | :frame, color: 0..0xFFFFFF | String.t(), width: pos_integer}
  defstruct type: :bar, color: "red", width: 10

  defimpl String.Chars do
    def to_string(%{type: type, color: color, width: width})
        when type in [:bar, :frame] and is_binary(color) and is_integer(width) and width > 0 do
      "e_progressbar:#{type}:#{color}:#{width}"
    end

    def to_string(%{type: type, color: color, width: width})
        when type in [:bar, :frame] and color in 0..0xFFFFFF and is_integer(width) and width > 0 do
      "e_progressbar:#{type}:#{Integer.to_string(color, 16)}:#{width}"
    end
  end
end
