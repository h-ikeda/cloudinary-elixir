defmodule Cloudinary.Transformation.Effect.SimulateColorblind do
  @moduledoc """
  Representing the effect that generates an image simulating appearance to the people with color
  blind condition.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{condition: :tritanomaly} |> to_string()
      "e_simulate_colorblind:tritanomaly"
  """
  @type t :: %__MODULE__{
          condition:
            :deuteranopia
            | :protanopia
            | :tritanopia
            | :tritanomaly
            | :deuteranomaly
            | :cone_monochromacy
            | :rod_monochromacy
        }
  defstruct condition: :deuteranopia

  defimpl String.Chars do
    def to_string(%{condition: condition})
        when condition in [
               :deuteranopia,
               :protanopia,
               :tritanopia,
               :tritanomaly,
               :deuteranomaly,
               :cone_monochromacy,
               :rod_monochromacy
             ] do
      "e_simulate_colorblind:#{condition}"
    end
  end
end
