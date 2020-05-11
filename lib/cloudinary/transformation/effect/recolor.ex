defmodule Cloudinary.Transformation.Effect.Recolor do
  @moduledoc """
  Representing the replacing color filter with a rgb(a) matrix.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{matrix: [[0.3, 0.7, 0.1], [0.3, 0.6, 0.1], [0.2, 0.5, 0.1]]} |> to_string()
      "e_recolor:0.3:0.7:0.1:0.3:0.6:0.1:0.2:0.5:0.1"

      iex> %#{__MODULE__}{matrix: [[0.3, 0.7, 0.1, 0.4], [0.3, 0.6, 0.1, 0.2], [0.2, 0.5, 0.1, 0.6], [0.8, 0.7, 0.4, 0.3]]} |> to_string()
      "e_recolor:0.3:0.7:0.1:0.4:0.3:0.6:0.1:0.2:0.2:0.5:0.1:0.6:0.8:0.7:0.4:0.3"
  """
  @type t :: %__MODULE__{matrix: [[float]]}
  defstruct matrix: [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]

  defimpl String.Chars do
    def to_string(%{matrix: [[rr, rg, rb], [gr, gg, gb], [br, bg, bb]]})
        when is_float(rr) and is_float(rg) and is_float(rb) and
               is_float(gr) and is_float(gg) and is_float(gb) and
               is_float(br) and is_float(bg) and is_float(bb) do
      "e_recolor:#{rr}:#{rg}:#{rb}:#{gr}:#{gg}:#{gb}:#{br}:#{bg}:#{bb}"
    end

    def to_string(%{
          matrix: [[rr, rg, rb, ra], [gr, gg, gb, ga], [br, bg, bb, ba], [ar, ag, ab, aa]]
        })
        when is_float(rr) and is_float(rg) and is_float(rb) and is_float(ra) and
               is_float(gr) and is_float(gg) and is_float(gb) and is_float(ga) and
               is_float(br) and is_float(bg) and is_float(bb) and is_float(ba) and
               is_float(ar) and is_float(ag) and is_float(ab) and is_float(aa) do
      "e_recolor:" <>
        "#{rr}:#{rg}:#{rb}:#{ra}:#{gr}:#{gg}:#{gb}:#{ga}:" <>
        "#{br}:#{bg}:#{bb}:#{ba}:#{ar}:#{ag}:#{ab}:#{aa}"
    end
  end
end
