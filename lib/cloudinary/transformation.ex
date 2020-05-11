defmodule Cloudinary.Transformation do
  @moduledoc """
  The cloudinary transformation representation. Each parameter is a struct of the corresponding
  module.

  `#{__MODULE__}` and its child modules all implement `String.Chars` protocol. So that they are
  easily converted to URL strings.

  When `:if` field of `t:#{__MODULE__}.t/0` is an `t:#{__MODULE__}.Expression.t/0`, it will be
  converted to conditional transformation.

  The `:transformation` field is a list which has transformation parameters. Transformation
  parameter can be a struct defined in one of modules under the `#{__MODULE__}`.
  
  The list also can
  have a `t:keyword/0` or `t:map/0`, and/or `t:String.t/0`. When a `t:keyword/0` or `t:map/0` is
  given, it would be treated as a user-defined variables. When `t:String.t/0` is given, it will be
  treated as a raw transformation, just appended to the built transformation URL without
  processing.
  ## Official documentation
  https://cloudinary.com/documentation/image_transformations
  https://cloudinary.com/documentation/video_manipulation_and_delivery
  https://cloudinary.com/documentation/audio_transformations
  https://cloudinary.com/documentation/image_transformation_reference
  https://cloudinary.com/documentation/video_transformation_reference
  ## Example
      iex> alias #{__MODULE__}
      ...> %Transformation{
      ...>   transformation: [
      ...>     %Transformation.Width{value: 400},
      ...>     %Transformation.Height{value: 260},
      ...>     %Transformation.Crop{mode: :crop},
      ...>     %Transformation.Radius{pixels: [20]}
      ...>   ]
      ...> }
      ...> |> to_string()
      "w_400,h_260,c_crop,r_20"
      
      iex> alias #{__MODULE__}
      ...> %Transformation{
      ...>   transformation: [
      ...>     %Transformation.Overlay{public_id: "horses"},
      ...>     %Transformation.Width{value: 220},
      ...>     %Transformation.Height{value: 140},
      ...>     %Transformation.Crop{mode: :fill},
      ...>     %Transformation.Y{value: 140},
      ...>     %Transformation.X{value: -110}
      ...>   ]
      ...> }
      ...> |> to_string()
      "l_horses,w_220,h_140,c_fill,y_140,x_-110"
      
      iex> alias #{__MODULE__}
      ...> %Transformation{
      ...>   transformation: [
      ...>     %Transformation.Overlay.Text{
      ...>       text: "Memories from our trip",
      ...>       style: %Transformation.Layer.TextStyle{
      ...>         font_family: "Parisienne",
      ...>         font_size: 35,
      ...>         font_weight: :bold
      ...>       }
      ...>     },
      ...>     %Transformation.Color{color: 0x990C47},
      ...>     %Transformation.Y{value: 155}
      ...>   ]
      ...> }
      ...> |> to_string()
      "l_text:Parisienne_35_bold:Memories%20from%20our%20trip,co_rgb:990c47,y_155"
  """
  @type t :: %__MODULE__{
          if: __MODULE__.Expression.as_boolean() | nil,
          transformation: [
            keyword(String.t())
            | %{atom => String.t()}
            | __MODULE__.Angle.t()
            | __MODULE__.AspectRatio.t()
            | __MODULE__.AudioCodec.t()
            | __MODULE__.AudioFrequency.t()
            | __MODULE__.Background.t()
            | __MODULE__.BitRate.t()
            | __MODULE__.Border.t()
            | __MODULE__.Color.t()
            | __MODULE__.ColorSpace.t()
            | __MODULE__.Crop.t()
            | __MODULE__.CustomFunction.t()
            | __MODULE__.CustomPreFunction.t()
            | __MODULE__.DefaultImage.t()
            | __MODULE__.Delay.t()
            | __MODULE__.Density.t()
            | __MODULE__.DevicePixelRatio.t()
            | __MODULE__.Duration.t()
            | __MODULE__.Effect.t()
            | __MODULE__.EndOffset.t()
            | __MODULE__.Flags.t()
            | __MODULE__.FetchFormat.t()
            | __MODULE__.Fps.t()
            | __MODULE__.Gravity.t()
            | __MODULE__.Height.t()
            | __MODULE__.KeyframeInterval.t()
            | __MODULE__.Opacity.t()
            | __MODULE__.Overlay.t()
            | __MODULE__.Page.t()
            | __MODULE__.Quality.t()
            | __MODULE__.Radius.t()
            | __MODULE__.StartOffset.t()
            | __MODULE__.StreamingProfile.t()
            | __MODULE__.Transformation.t()
            | __MODULE__.Underlay.t()
            | __MODULE__.VideoCodec.t()
            | __MODULE__.VideoSampling.t()
            | __MODULE__.Width.t()
            | __MODULE__.X.t()
            | __MODULE__.Y.t()
            | __MODULE__.Zoom.t()
            | String.t()
          ]
        }
  defstruct if: nil, transformation: []

  defimpl String.Chars do
    def to_string(%{if: %@for.Expression{booleanable: true} = condition} = transformation) do
      "if_#{condition},#{%{transformation | if: nil}}"
    end

    def to_string(%{transformation: transformation})
        when is_list(transformation) and length(transformation) > 0 do
      transformation
      |> Enum.map(fn
        raw_transformation when is_binary(raw_transformation) -> raw_transformation
        %_{} = param -> param
        variables -> Enum.map(variables, fn {k, v} -> "$#{k}_#{v}" end)
      end)
      |> Enum.sort(fn
        raw_transformation, _ when is_binary(raw_transformation) -> false
        _, variables when is_list(variables) -> false
        _, _ -> true
      end)
      |> List.flatten()
      |> Enum.join(",")
    end
  end

  @doc """
  Builds an expression with operators and custom variables those are evaluated on the cloud.
  Expressions can be used in several transformation parameters.

  Atoms are treated as predefined values.
      #{__MODULE__}.expression(:initial_height / :initial_width)
  Variable names are treated as user defined variables.
      #{__MODULE__}.expression(smallsize * 2)
  If you want to use local variables, use the pin operator.
      #{__MODULE__}.expression(^local_variable * :initial_height)
  ## Official documentation
  https://cloudinary.com/documentation/conditional_transformations
  https://cloudinary.com/documentation/user_defined_variables
  https://cloudinary.com/documentation/video_conditional_expressions
  https://cloudinary.com/documentation/video_user_defined_variables
  ## Example
      iex> #{__MODULE__}.expression(:initial_width / :width)
      %#{__MODULE__}.Expression{numerable: true, source: "iw_div_w"}

      iex> #{__MODULE__}.expression(:face_count * unit)
      %#{__MODULE__}.Expression{numerable: true, source: "fc_mul_$unit"}

      iex> dynamic_height = 200 * 2
      ...> #{__MODULE__}.expression(^dynamic_height * :aspect_ratio)
      %#{__MODULE__}.Expression{numerable: true, source: "400_mul_ar"}

      iex> #{__MODULE__}.expression(:initial_width == 500)
      %#{__MODULE__}.Expression{booleanable: true, source: "iw_eq_500"}

      iex> #{__MODULE__}.expression(["tag1", "tag2"] in :tags)
      %#{__MODULE__}.Expression{booleanable: true, source: "!tag1:tag2!_in_tags"}

      iex> #{__MODULE__}.expression(:context["productType"] not in :page_names)
      %#{__MODULE__}.Expression{booleanable: true, source: "ctx:!productType!_nin_pgnames"}
  """
  @spec expression(Macro.t()) :: Macro.t()
  defmacro expression(ast) do
    __MODULE__.Expression.traverse(ast)
  end
end
