defmodule Cloudinary.Transformation.Effect.Art do
  @moduledoc """
  Representing the art effect.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#effect_parameter
  ## Example
      iex> %#{__MODULE__}{filter: :frost} |> to_string()
      "e_art:frost"
  """
  @type t :: %__MODULE__{
          filter:
            :al_dente
            | :athena
            | :audrey
            | :aurora
            | :daguerre
            | :eucalyptus
            | :fes
            | :frost
            | :hairspray
            | :hokusai
            | :incognito
            | :linen
            | :peacock
            | :primavera
            | :quartz
            | :red_rock
            | :refresh
            | :sizzle
            | :sonnet
            | :ukulele
            | :zorro
        }
  defstruct [:filter]

  defimpl String.Chars do
    def to_string(%{filter: filter})
        when filter in [
               :al_dente,
               :athena,
               :audrey,
               :aurora,
               :daguerre,
               :eucalyptus,
               :fes,
               :frost,
               :hairspray,
               :hokusai,
               :incognito,
               :linen,
               :peacock,
               :primavera,
               :quartz,
               :red_rock,
               :refresh,
               :sizzle,
               :sonnet,
               :ukulele,
               :zorro
             ] do
      "e_art:#{filter}"
    end
  end
end
