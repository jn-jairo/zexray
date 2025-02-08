defmodule Zexray.Type.Color do
  @moduledoc """
  4 components, R8G8B8A8 (32bit)

  ## Fields

  |     |                   |
  | --- | ----------------- |
  | `r` | Color red value   |
  | `g` | Color green value |
  | `b` | Color blue value  |
  | `a` | Color alpha value |

  ## Values

  <table>
    <tr> <th><b>name</b></th> <th><b>rgba</b></th> <th><b>description</b></th>      <th><b>example</b></th>                  </tr>

    <tr> <td>:beige</td>      <td>0xD3B083FF</td>  <td>Beige</td>                   <td style="background: #D3B083FF;"></td> </tr>
    <tr> <td>:black</td>      <td>0x000000FF</td>  <td>Black</td>                   <td style="background: #000000FF;"></td> </tr>
    <tr> <td>:blank</td>      <td>0x00000000</td>  <td>Blank (Transparent)</td>     <td style="background: #00000000;"></td> </tr>
    <tr> <td>:blue</td>       <td>0x0079F1FF</td>  <td>Blue</td>                    <td style="background: #0079F1FF;"></td> </tr>
    <tr> <td>:brown</td>      <td>0x7F6A4FFF</td>  <td>Brown</td>                   <td style="background: #7F6A4FFF;"></td> </tr>
    <tr> <td>:darkblue</td>   <td>0x0052ACFF</td>  <td>Dark Blue</td>               <td style="background: #0052ACFF;"></td> </tr>
    <tr> <td>:darkbrown</td>  <td>0x4C3F2FFF</td>  <td>Dark Brown</td>              <td style="background: #4C3F2FFF;"></td> </tr>
    <tr> <td>:darkgray</td>   <td>0x505050FF</td>  <td>Dark Gray</td>               <td style="background: #505050FF;"></td> </tr>
    <tr> <td>:darkgreen</td>  <td>0x00752CFF</td>  <td>Dark Green</td>              <td style="background: #00752CFF;"></td> </tr>
    <tr> <td>:darkpurple</td> <td>0x701F7EFF</td>  <td>Dark Purple</td>             <td style="background: #701F7EFF;"></td> </tr>
    <tr> <td>:gold</td>       <td>0xFFCB00FF</td>  <td>Gold</td>                    <td style="background: #FFCB00FF;"></td> </tr>
    <tr> <td>:gray</td>       <td>0x828282FF</td>  <td>Gray</td>                    <td style="background: #828282FF;"></td> </tr>
    <tr> <td>:green</td>      <td>0x00E430FF</td>  <td>Green</td>                   <td style="background: #00E430FF;"></td> </tr>
    <tr> <td>:lightgray</td>  <td>0xC8C8C8FF</td>  <td>Light Gray</td>              <td style="background: #C8C8C8FF;"></td> </tr>
    <tr> <td>:lime</td>       <td>0x009E2FFF</td>  <td>Lime</td>                    <td style="background: #009E2FFF;"></td> </tr>
    <tr> <td>:magenta</td>    <td>0xFF00FFFF</td>  <td>Magenta</td>                 <td style="background: #FF00FFFF;"></td> </tr>
    <tr> <td>:maroon</td>     <td>0xBE2137FF</td>  <td>Maroon</td>                  <td style="background: #BE2137FF;"></td> </tr>
    <tr> <td>:orange</td>     <td>0xFFA100FF</td>  <td>Orange</td>                  <td style="background: #FFA100FF;"></td> </tr>
    <tr> <td>:pink</td>       <td>0xFF6DC2FF</td>  <td>Pink</td>                    <td style="background: #FF6DC2FF;"></td> </tr>
    <tr> <td>:purple</td>     <td>0xC87AFFFF</td>  <td>Purple</td>                  <td style="background: #C87AFFFF;"></td> </tr>
    <tr> <td>:raywhite</td>   <td>0xF5F5F5FF</td>  <td>Ray White (raylib logo)</td> <td style="background: #F5F5F5FF;"></td> </tr>
    <tr> <td>:red</td>        <td>0xE62937FF</td>  <td>Red</td>                     <td style="background: #E62937FF;"></td> </tr>
    <tr> <td>:skyblue</td>    <td>0x66BFFFFF</td>  <td>Sky Blue</td>                <td style="background: #66BFFFFF;"></td> </tr>
    <tr> <td>:violet</td>     <td>0x873CBEFF</td>  <td>Violet</td>                  <td style="background: #873CBEFF;"></td> </tr>
    <tr> <td>:white</td>      <td>0xFFFFFFFF</td>  <td>White</td>                   <td style="background: #FFFFFFFF;"></td> </tr>
    <tr> <td>:yellow</td>     <td>0xFDF900FF</td>  <td>Yellow</td>                  <td style="background: #FDF900FF;"></td> </tr>
  </table>
  """

  defstruct r: 0,
            g: 0,
            b: 0,
            a: 0xFF

  use Zexray.Type.TypeBase, prefix: "color"

  @type t ::
          %__MODULE__{
            r: byte,
            g: byte,
            b: byte,
            a: byte
          }

  @type t_name ::
          :beige
          | :black
          | :blank
          | :blue
          | :brown
          | :darkblue
          | :darkbrown
          | :darkgray
          | :darkgreen
          | :darkpurple
          | :gold
          | :gray
          | :green
          | :lightgray
          | :lime
          | :magenta
          | :maroon
          | :orange
          | :pink
          | :purple
          | :raywhite
          | :red
          | :skyblue
          | :violet
          | :white
          | :yellow

  @type t_all ::
          t
          | t_name
          | <<_::24>>
          | <<_::32>>
          | integer
          | {:rgba, integer}
          | {:rgb, integer}
          | {byte, byte, byte}
          | {byte, byte, byte, byte}
          | map
          | keyword
          | Resource.t()

  @colors %{
    beige: {211, 176, 131, 255},
    black: {0, 0, 0, 255},
    blank: {0, 0, 0, 0},
    blue: {0, 121, 241, 255},
    brown: {127, 106, 79, 255},
    darkblue: {0, 82, 172, 255},
    darkbrown: {76, 63, 47, 255},
    darkgray: {80, 80, 80, 255},
    darkgreen: {0, 117, 44, 255},
    darkpurple: {112, 31, 126, 255},
    gold: {255, 203, 0, 255},
    gray: {130, 130, 130, 255},
    green: {0, 228, 48, 255},
    lightgray: {200, 200, 200, 255},
    lime: {0, 158, 47, 255},
    magenta: {255, 0, 255, 255},
    maroon: {190, 33, 55, 255},
    orange: {255, 161, 0, 255},
    pink: {255, 109, 194, 255},
    purple: {200, 122, 255, 255},
    raywhite: {245, 245, 245, 255},
    red: {230, 41, 55, 255},
    skyblue: {102, 191, 255, 255},
    violet: {135, 60, 190, 255},
    white: {255, 255, 255, 255},
    yellow: {253, 249, 0, 255}
  }

  import Bitwise

  @doc """
  Creates a new `t:t/0`.
  """
  def new(color)

  @spec new(name :: t_name) :: t()
  def new(name) when is_atom(name) do
    if Map.has_key?(@colors, name) do
      @colors[name]
      |> new()
    else
      raise_invalid_color(name)
    end
  end

  @spec new(rgba :: <<_::32>>) :: t()
  def new(<<r::8, g::8, b::8, a::8>>) do
    %__MODULE__{
      r: r,
      g: g,
      b: b,
      a: a
    }
  end

  @spec new(rgb :: <<_::24>>) :: t()
  def new(<<r::8, g::8, b::8>>) do
    %__MODULE__{
      r: r,
      g: g,
      b: b
    }
  end

  @spec new(rgba :: integer) :: t()
  def new(rgba) when is_integer(rgba) do
    new({:rgba, rgba})
  end

  @spec new({:rgba, rgba :: integer}) :: t()
  def new({:rgba, rgba}) when is_integer(rgba) do
    %__MODULE__{
      r: rgba >>> 24 &&& 0xFF,
      g: rgba >>> 16 &&& 0xFF,
      b: rgba >>> 8 &&& 0xFF,
      a: rgba &&& 0xFF
    }
  end

  @spec new({:rgb, rgb :: integer}) :: t()
  def new({:rgb, rgb}) when is_integer(rgb) do
    %__MODULE__{
      r: rgb >>> 16 &&& 0xFF,
      g: rgb >>> 8 &&& 0xFF,
      b: rgb &&& 0xFF
    }
  end

  @spec new({
          r :: byte,
          g :: byte,
          b :: byte
        }) :: t()
  def new({r, g, b})
      when is_integer(r) and
             is_integer(g) and
             is_integer(b) do
    new(
      r: r,
      g: g,
      b: b
    )
  end

  @spec new({
          r :: byte,
          g :: byte,
          b :: byte,
          a :: byte
        }) :: t()
  def new({r, g, b, a})
      when is_integer(r) and
             is_integer(g) and
             is_integer(b) and
             is_integer(a) do
    new(
      r: r,
      g: g,
      b: b,
      a: a
    )
  end

  @spec new(color :: struct) :: t()
  def new(color) when is_struct(color) do
    color =
      if String.ends_with?(Atom.to_string(color.__struct__), ".Resource") do
        apply(color.__struct__, :content, [color])
      else
        color
      end

    case color do
      %__MODULE__{} = color -> color
      _ -> new(Map.from_struct(color))
    end
  end

  @spec new(fields :: Enumerable.t()) :: t()
  def new(fields) do
    if Enumerable.impl_for(fields) != nil do
      struct!(
        __MODULE__,
        fields
        |> Enum.map(fn {key, value} ->
          {key, value &&& 0xFF}
        end)
      )
    else
      raise_invalid_color(fields)
    end
  end

  @spec raise_invalid_color(color :: any) :: no_return
  defp raise_invalid_color(color) do
    raise ArgumentError,
          "Invalid color: #{inspect(color)}\nAvailable color names: #{inspect(@colors |> Map.keys())}"
  end
end
