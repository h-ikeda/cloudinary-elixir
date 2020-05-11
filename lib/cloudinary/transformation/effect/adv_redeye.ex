defmodule Cloudinary.Transformation.Effect.AdvRedeye do
  @moduledoc """
  Representing the removing red eyes filter.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  https://cloudinary.com/documentation/advanced_facial_attributes_detection_addon
  ## Example
      iex> %#{__MODULE__}{} |> to_string()
      "e_adv_redeye"
  """
  @type t :: %__MODULE__{}
  defstruct []

  defimpl String.Chars do
    def to_string(_), do: "e_adv_redeye"
  end
end
