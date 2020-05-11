defmodule Cloudinary.Transformation.StreamingProfile do
  @moduledoc """
  Representing the `streaming_profile` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/video_transformation_reference#video_settings
  https://cloudinary.com/documentation/video_manipulation_and_delivery#predefined_streaming_profiles
  https://cloudinary.com/documentation/admin_api#get_adaptive_streaming_profiles
  https://cloudinary.com/documentation/admin_api#create_a_streaming_profile
  ## Example
      iex> %#{__MODULE__}{name: "full_hd"} |> to_string()
      "sp_full_hd"
  """
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]

  defimpl String.Chars do
    def to_string(%{name: name}) when is_binary(name), do: "sp_#{name}"
  end
end
