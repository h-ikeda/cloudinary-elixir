defmodule Cloudinary.Transformation.Effect.Cartoonify do
  @moduledoc """
  Representing the cartoonify effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{line_strength: 40} |> to_string()
      "e_cartoonify:40"
      
      iex> %#{__MODULE__}{line_strength: 20, color_reduction: 60} |> to_string()
      "e_cartoonify:20:60"

      iex> %#{__MODULE__}{line_strength: 30, color_reduction: :black_white} |> to_string()
      "e_cartoonify:30:bw"
  """
  @type t :: %__MODULE__{line_strength: 0..100, color_reduction: 0..100 | :black_white | nil}
  defstruct line_strength: 50, color_reduction: nil

  defimpl String.Chars do
    def to_string(%{line_strength: line_strength, color_reduction: nil})
        when line_strength in 0..100 do
      "e_cartoonify:#{line_strength}"
    end

    def to_string(%{color_reduction: reduction} = cartoonify) when reduction in 0..100 do
      "#{%{cartoonify | color_reduction: nil}}:#{reduction}"
    end

    def to_string(%{color_reduction: :black_white} = cartoonify) do
      "#{%{cartoonify | color_reduction: nil}}:bw"
    end
  end
end
