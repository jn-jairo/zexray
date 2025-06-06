defmodule Zexray.Enum.Color do
  @moduledoc """
  4 components, R8G8B8A8 (32bit)

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

  use Zexray.Enum.EnumBase,
    prefix: "color",
    value_type: {:color, byte, byte, byte, byte},
    values: %{
      beige: {:color, 211, 176, 131, 255},
      black: {:color, 0, 0, 0, 255},
      blank: {:color, 0, 0, 0, 0},
      blue: {:color, 0, 121, 241, 255},
      brown: {:color, 127, 106, 79, 255},
      darkblue: {:color, 0, 82, 172, 255},
      darkbrown: {:color, 76, 63, 47, 255},
      darkgray: {:color, 80, 80, 80, 255},
      darkgreen: {:color, 0, 117, 44, 255},
      darkpurple: {:color, 112, 31, 126, 255},
      gold: {:color, 255, 203, 0, 255},
      gray: {:color, 130, 130, 130, 255},
      green: {:color, 0, 228, 48, 255},
      lightgray: {:color, 200, 200, 200, 255},
      lime: {:color, 0, 158, 47, 255},
      magenta: {:color, 255, 0, 255, 255},
      maroon: {:color, 190, 33, 55, 255},
      orange: {:color, 255, 161, 0, 255},
      pink: {:color, 255, 109, 194, 255},
      purple: {:color, 200, 122, 255, 255},
      raywhite: {:color, 245, 245, 245, 255},
      red: {:color, 230, 41, 55, 255},
      skyblue: {:color, 102, 191, 255, 255},
      violet: {:color, 135, 60, 190, 255},
      white: {:color, 255, 255, 255, 255},
      yellow: {:color, 253, 249, 0, 255}
    }
end
