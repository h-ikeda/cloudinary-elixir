defmodule Cloudinary.Transformation.Effect.Vectorize do
  @moduledoc """
  Representing the vectorizing an image.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{colors: 3, detail: 0.5} |> to_string()
      "e_vectorize:3:0.5:2:100:25"

      iex> %#{__MODULE__}{detail: 550, despeckle: 0.3, paths: 20, corners: 40} |> to_string()
      "e_vectorize:10:550:0.3:20:40"
  """
  @type t :: %__MODULE__{
          colors: 2..30,
          detail: float | 0..1000,
          despeckle: float | 0..100,
          paths: 0..100,
          corners: 0..100
        }
  defstruct colors: 10, detail: 300, despeckle: 2, paths: 100, corners: 25

  defimpl String.Chars do
    def to_string(%{
          colors: colors,
          detail: detail,
          despeckle: despeckle,
          paths: paths,
          corners: corners
        })
        when colors in 2..30 and paths in 0..100 and corners in 0..100 and
               (detail in 0..1000 or (is_float(detail) and detail >= 0.0 and detail <= 1.0)) and
               (despeckle in 0..100 or
                  (is_float(despeckle) and despeckle >= 0.0 and despeckle <= 1.0)) do
      "e_vectorize:#{colors}:#{detail}:#{despeckle}:#{paths}:#{corners}"
    end
  end
end
