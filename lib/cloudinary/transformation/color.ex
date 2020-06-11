defmodule Cloudinary.Transformation.Color do
  @moduledoc """
  The color type definition for transformation parameters.
  """
  @typedoc """
  The color represented by a RGB/RGBA hex triplet or a color name string.

  It treats a `t:charlist/0` (like `'a0fc72'`) as a hex triplet and a `t:String.t/0` (like
  `"green"`) as a color name.
  """
  @type t :: charlist | String.t()
  defguardp is_hex_digit(d) when d in '0123456789ABCDEFabcdef'

  @doc """
  Whether the argument is a charlist of the RGB hex tripet or not.
  ## Example
      iex> #{__MODULE__}.is_rgb('e876f3')
      true

      iex> #{__MODULE__}.is_rgb('g680a7')
      false

      iex> #{__MODULE__}.is_rgb('12E34BA5')
      false

      iex> #{__MODULE__}.is_rgb('aab')
      true
  """
  defguard is_rgb(rgb)
           when is_list(rgb) and
                  ((length(rgb) == 6 and
                      is_hex_digit(hd(rgb)) and is_hex_digit(hd(tl(rgb))) and
                      is_hex_digit(hd(tl(tl(rgb)))) and is_hex_digit(hd(tl(tl(tl(rgb))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(rgb)))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(tl(rgb)))))))) or
                     (length(rgb) == 3 and
                        is_hex_digit(hd(rgb)) and is_hex_digit(hd(tl(rgb))) and
                        is_hex_digit(hd(tl(tl(rgb))))))

  @doc """
  Whether the argument is a charlist of the RGBA hex tripet or not.
  ## Example
      iex> #{__MODULE__}.is_rgba('e876f3f0')
      true

      iex> #{__MODULE__}.is_rgba('g680a75d')
      false

      iex> #{__MODULE__}.is_rgba('12E34B')
      false

      iex> #{__MODULE__}.is_rgba('abfd')
      true
  """
  defguard is_rgba(rgba)
           when is_list(rgba) and
                  ((length(rgba) == 8 and
                      is_hex_digit(hd(rgba)) and is_hex_digit(hd(tl(rgba))) and
                      is_hex_digit(hd(tl(tl(rgba)))) and is_hex_digit(hd(tl(tl(tl(rgba))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(rgba)))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(tl(rgba))))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(tl(tl(rgba)))))))) and
                      is_hex_digit(hd(tl(tl(tl(tl(tl(tl(tl(rgba)))))))))) or
                     (length(rgba) == 4 and
                        is_hex_digit(hd(rgba)) and is_hex_digit(hd(tl(rgba))) and
                        is_hex_digit(hd(tl(tl(rgba)))) and is_hex_digit(hd(tl(tl(tl(rgba)))))))
end
