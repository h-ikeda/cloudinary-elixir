defmodule Cloudinary.Transformation.Expression do
  @moduledoc """
  The expression representation for conditional transformation, using user-defined variables
  and/or giving values with arithmetic expression.

  See `Cloudinary.Transformation.expression/1` to know the usage.
  """
  @type t :: %__MODULE__{
          source: String.t(),
          booleanable: boolean,
          numerable: boolean,
          stringable: boolean,
          mappable: boolean,
          settable: boolean
        }
  @type as_boolean :: %__MODULE__{
          source: String.t(),
          booleanable: true,
          numerable: boolean,
          stringable: boolean,
          mappable: boolean,
          settable: boolean
        }
  defstruct source: nil,
            booleanable: false,
            numerable: false,
            stringable: false,
            mappable: false,
            settable: false

  @predefined_numeric_variable_mappings %{
    aspect_ratio: "ar",
    current_page: "cp",
    duration: "du",
    face_count: "fc",
    height: "h",
    illustrative_likelihood: "ils",
    initial_aspect_ratio: "iar",
    initial_duration: "idu",
    initial_height: "ih",
    initial_width: "iw",
    page_count: "pc",
    page_x: "px",
    page_y: "py",
    trimmed_aspect_ratio: "tar",
    width: "w"
  }
  @predefined_numeric_variables Map.keys(@predefined_numeric_variable_mappings)
  @predefined_set_variable_mappings %{
    page_names: "pgnames",
    tags: "tags"
  }
  @predefined_set_variables Map.keys(@predefined_set_variable_mappings)
  @predefined_map_variable_mappings %{
    context: "ctx"
  }
  @predefined_map_variables Map.keys(@predefined_map_variable_mappings)
  @comparison_operator_mappings %{
    ==: "eq",
    !=: "ne",
    <: "lt",
    >: "gt",
    <=: "lte",
    >=: "gte",
    &&: "and",
    ||: "or"
  }
  @comparison_operators Map.keys(@comparison_operator_mappings)
  @set_operator_mappings %{
    in: "in",
    notin: "nin"
  }
  @set_operators Map.keys(@set_operator_mappings)
  @map_operator_mappings %{
    "Access.get": ":"
  }
  @map_operators Map.keys(@map_operator_mappings)
  @arithmetic_operator_mappings %{
    *: "mul",
    /: "div",
    +: "add",
    -: "sub",
    pow: "pow",
    mod: "mod"
  }
  @arithmetic_operators Map.keys(@arithmetic_operator_mappings)
  @doc """
  Convert AST(abstract syntax tree) into another AST that results in a URL string.
  """
  @spec traverse(Macro.t()) :: Macro.t()
  def traverse(ast) do
    ast
    |> Macro.traverse(
      0,
      fn
        {:^, _meta, _args} = ast, acc -> {ast, acc + 1}
        list, acc when is_list(list) -> {list, acc + 1}
        {:not, _meta1, [{:in, _meta2, args}]}, 0 -> {{:notin, [], args}, 0}
        {{:., _meta, [Access, :get]}, meta, args}, 0 -> {{:"Access.get", meta, args}, 0}
        ast, acc -> {ast, acc}
      end,
      fn
        {:^, _meta, [arg]}, 1 -> {build_quoted(arg), 0}
        {:^, _meta, _args} = ast, acc -> {ast, acc - 1}
        list, 1 when is_list(list) -> {build_quoted(list), 0}
        list, acc when is_list(list) -> {list, acc - 1}
        {identifier, _meta, args}, 0 -> {build_quoted(identifier, args), 0}
        identifier, 0 -> {build_quoted(identifier), 0}
        ast, acc -> {ast, acc}
      end
    )
    |> elem(0)
  end

  defp build_quoted(identifier) do
    quote do: unquote(__MODULE__).build(unquote(identifier))
  end

  defp build_quoted(identifier, args) do
    quote do: unquote(__MODULE__).build(unquote(identifier), unquote(args))
  end

  @doc """
  Generate an expression with an atom representing operator and expressions as arguments.
  """
  @spec build(atom, [__MODULE__.t()] | nil) :: __MODULE__.t()
  def build(operator, [%__MODULE__{numerable: true}, %__MODULE__{numerable: true}] = args)
      when operator in @arithmetic_operators do
    %__MODULE__{
      source: Enum.join(args, "_#{@arithmetic_operator_mappings[operator]}_"),
      numerable: true
    }
  end

  def build(operator, [%__MODULE__{numerable: true}, %__MODULE__{numerable: true}] = args)
      when operator in @comparison_operators do
    %__MODULE__{
      source: Enum.join(args, "_#{@comparison_operator_mappings[operator]}_"),
      booleanable: true
    }
  end

  def build(operator, [%__MODULE__{stringable: true}, %__MODULE__{stringable: true}] = args)
      when operator in @comparison_operators do
    %__MODULE__{
      source: Enum.join(args, "_#{@comparison_operator_mappings[operator]}_"),
      booleanable: true
    }
  end

  def build(operator, [%__MODULE__{stringable: true}, %__MODULE__{settable: true}] = args)
      when operator in @set_operators do
    %__MODULE__{
      source: Enum.join(args, "_#{@set_operator_mappings[operator]}_"),
      booleanable: true
    }
  end

  def build(operator, [%__MODULE__{mappable: true}, %__MODULE__{stringable: true}] = args)
      when operator in @map_operators do
    %__MODULE__{
      source: Enum.join(args, @map_operator_mappings[operator]),
      stringable: true
    }
  end

  def build(variable, nil) do
    %__MODULE__{source: "$#{variable}", stringable: true, numerable: true}
  end

  @doc """
  Generate an expression with an atom representing predefined variable, or with a basic type of
  variable.
  """
  @spec build(atom) :: __MODULE__.t()
  @spec build(number|String.t|[String.t])::__MODULE__.t
  def build(variable) when variable in @predefined_numeric_variables do
    %__MODULE__{source: @predefined_numeric_variable_mappings[variable], numerable: true}
  end

  def build(variable) when variable in @predefined_set_variables do
    %__MODULE__{source: @predefined_set_variable_mappings[variable], settable: true}
  end

  def build(variable) when variable in @predefined_map_variables do
    %__MODULE__{source: @predefined_map_variable_mappings[variable], mappable: true}
  end

  def build(variable) when is_float(variable) or is_integer(variable) do
    %__MODULE__{source: "#{variable}", numerable: true}
  end

  def build(variable) when is_binary(variable) do
    %__MODULE__{source: "!#{variable}!", stringable: true}
  end

  def build(variable) when is_list(variable) do
    %__MODULE__{source: "!#{Enum.join(variable, ":")}!", stringable: true}
  end

  defimpl String.Chars do
    def to_string(%{source: source}) when is_binary(source), do: source
  end
end
