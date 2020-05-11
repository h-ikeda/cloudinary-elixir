defmodule Cloudinary.Transformation.Page do
  @moduledoc """
  Representing the `page` parameter of transformation.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformation_reference#page_parameter
  https://cloudinary.com/documentation/animated_images#deliver_a_single_frame
  https://cloudinary.com/documentation/paged_and_layered_media#deliver_a_pdf_or_selected_pages_of_a_pdf
  https://cloudinary.com/documentation/paged_and_layered_media#delivering_photoshop_images
  ## Example
      iex> %#{__MODULE__}{pages: [2]} |> to_string()
      "pg_2"

      iex> %#{__MODULE__}{pages: [3, 5..7, "9-"]} |> to_string()
      "pg_3;5-7;9-"

      iex> %#{__MODULE__}{layers: ["record_cover", "Shadow"]} |> to_string()
      "pg_name:record_cover:Shadow"
  """
  @type t ::
          %__MODULE__{pages: [integer | Range.t() | String.t()], layers: []}
          | %__MODULE__{pages: [], layers: [String.t()]}
  defstruct pages: [], layers: []

  defimpl String.Chars do
    def to_string(%{pages: pages, layers: []}) when is_list(pages) and length(pages) > 0 do
      "pg_#{
        Enum.map_join(pages, ";", fn
          page when is_integer(page) or is_binary(page) -> page
          first..last -> "#{first}-#{last}"
        end)
      }"
    end

    def to_string(%{pages: [], layers: layers}) when is_list(layers) and length(layers) > 0 do
      "pg_name:#{Enum.join(layers, ":")}"
    end
  end
end
