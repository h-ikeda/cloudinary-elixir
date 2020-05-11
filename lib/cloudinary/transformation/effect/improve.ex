defmodule Cloudinary.Transformation.Effect.Improve do
  @moduledoc """
  Representing the automatic image improvement.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{mode: :indoor, blend: 50} |> to_string()
      "e_improve:indoor:50"
  """
  @type t :: %__MODULE__{mode: :outdoor | :indoor, blend: 0..100}
  defstruct mode: :outdoor, blend: 100

  defimpl String.Chars do
    def to_string(%{mode: mode, blend: blend})
        when mode in [:outdoor, :indoor] and blend in 0..100 do
      "e_improve:#{mode}:#{blend}"
    end
  end
end
