defmodule Zexray.Enum.GuiIcon do
  @moduledoc """
  Icons

  ## Values

  |  id | name                     | description             |
  | --- | ------------------------ | ----------------------- |
  |   0 | :none                    | none                    |
  |   1 | :folder_file_open        | folder_file_open        |
  |   2 | :file_save_classic       | file_save_classic       |
  |   3 | :folder_open             | folder_open             |
  |   4 | :folder_save             | folder_save             |
  |   5 | :file_open               | file_open               |
  |   6 | :file_save               | file_save               |
  |   7 | :file_export             | file_export             |
  |   8 | :file_add                | file_add                |
  |   9 | :file_delete             | file_delete             |
  |  10 | :filetype_text           | filetype_text           |
  |  11 | :filetype_audio          | filetype_audio          |
  |  12 | :filetype_image          | filetype_image          |
  |  13 | :filetype_play           | filetype_play           |
  |  14 | :filetype_video          | filetype_video          |
  |  15 | :filetype_info           | filetype_info           |
  |  16 | :file_copy               | file_copy               |
  |  17 | :file_cut                | file_cut                |
  |  18 | :file_paste              | file_paste              |
  |  19 | :cursor_hand             | cursor_hand             |
  |  20 | :cursor_pointer          | cursor_pointer          |
  |  21 | :cursor_classic          | cursor_classic          |
  |  22 | :pencil                  | pencil                  |
  |  23 | :pencil_big              | pencil_big              |
  |  24 | :brush_classic           | brush_classic           |
  |  25 | :brush_painter           | brush_painter           |
  |  26 | :water_drop              | water_drop              |
  |  27 | :color_picker            | color_picker            |
  |  28 | :rubber                  | rubber                  |
  |  29 | :color_bucket            | color_bucket            |
  |  30 | :text_t                  | text_t                  |
  |  31 | :text_a                  | text_a                  |
  |  32 | :scale                   | scale                   |
  |  33 | :resize                  | resize                  |
  |  34 | :filter_point            | filter_point            |
  |  35 | :filter_bilinear         | filter_bilinear         |
  |  36 | :crop                    | crop                    |
  |  37 | :crop_alpha              | crop_alpha              |
  |  38 | :square_toggle           | square_toggle           |
  |  39 | :symmetry                | symmetry                |
  |  40 | :symmetry_horizontal     | symmetry_horizontal     |
  |  41 | :symmetry_vertical       | symmetry_vertical       |
  |  42 | :lens                    | lens                    |
  |  43 | :lens_big                | lens_big                |
  |  44 | :eye_on                  | eye_on                  |
  |  45 | :eye_off                 | eye_off                 |
  |  46 | :filter_top              | filter_top              |
  |  47 | :filter                  | filter                  |
  |  48 | :target_point            | target_point            |
  |  49 | :target_small            | target_small            |
  |  50 | :target_big              | target_big              |
  |  51 | :target_move             | target_move             |
  |  52 | :cursor_move             | cursor_move             |
  |  53 | :cursor_scale            | cursor_scale            |
  |  54 | :cursor_scale_right      | cursor_scale_right      |
  |  55 | :cursor_scale_left       | cursor_scale_left       |
  |  56 | :undo                    | undo                    |
  |  57 | :redo                    | redo                    |
  |  58 | :reredo                  | reredo                  |
  |  59 | :mutate                  | mutate                  |
  |  60 | :rotate                  | rotate                  |
  |  61 | :repeat                  | repeat                  |
  |  62 | :shuffle                 | shuffle                 |
  |  63 | :emptybox                | emptybox                |
  |  64 | :target                  | target                  |
  |  65 | :target_small_fill       | target_small_fill       |
  |  66 | :target_big_fill         | target_big_fill         |
  |  67 | :target_move_fill        | target_move_fill        |
  |  68 | :cursor_move_fill        | cursor_move_fill        |
  |  69 | :cursor_scale_fill       | cursor_scale_fill       |
  |  70 | :cursor_scale_right_fill | cursor_scale_right_fill |
  |  71 | :cursor_scale_left_fill  | cursor_scale_left_fill  |
  |  72 | :undo_fill               | undo_fill               |
  |  73 | :redo_fill               | redo_fill               |
  |  74 | :reredo_fill             | reredo_fill             |
  |  75 | :mutate_fill             | mutate_fill             |
  |  76 | :rotate_fill             | rotate_fill             |
  |  77 | :repeat_fill             | repeat_fill             |
  |  78 | :shuffle_fill            | shuffle_fill            |
  |  79 | :emptybox_small          | emptybox_small          |
  |  80 | :box                     | box                     |
  |  81 | :box_top                 | box_top                 |
  |  82 | :box_top_right           | box_top_right           |
  |  83 | :box_right               | box_right               |
  |  84 | :box_bottom_right        | box_bottom_right        |
  |  85 | :box_bottom              | box_bottom              |
  |  86 | :box_bottom_left         | box_bottom_left         |
  |  87 | :box_left                | box_left                |
  |  88 | :box_top_left            | box_top_left            |
  |  89 | :box_center              | box_center              |
  |  90 | :box_circle_mask         | box_circle_mask         |
  |  91 | :pot                     | pot                     |
  |  92 | :alpha_multiply          | alpha_multiply          |
  |  93 | :alpha_clear             | alpha_clear             |
  |  94 | :dithering               | dithering               |
  |  95 | :mipmaps                 | mipmaps                 |
  |  96 | :box_grid                | box_grid                |
  |  97 | :grid                    | grid                    |
  |  98 | :box_corners_small       | box_corners_small       |
  |  99 | :box_corners_big         | box_corners_big         |
  | 100 | :four_boxes              | four_boxes              |
  | 101 | :grid_fill               | grid_fill               |
  | 102 | :box_multisize           | box_multisize           |
  | 103 | :zoom_small              | zoom_small              |
  | 104 | :zoom_medium             | zoom_medium             |
  | 105 | :zoom_big                | zoom_big                |
  | 106 | :zoom_all                | zoom_all                |
  | 107 | :zoom_center             | zoom_center             |
  | 108 | :box_dots_small          | box_dots_small          |
  | 109 | :box_dots_big            | box_dots_big            |
  | 110 | :box_concentric          | box_concentric          |
  | 111 | :box_grid_big            | box_grid_big            |
  | 112 | :ok_tick                 | ok_tick                 |
  | 113 | :cross                   | cross                   |
  | 114 | :arrow_left              | arrow_left              |
  | 115 | :arrow_right             | arrow_right             |
  | 116 | :arrow_down              | arrow_down              |
  | 117 | :arrow_up                | arrow_up                |
  | 118 | :arrow_left_fill         | arrow_left_fill         |
  | 119 | :arrow_right_fill        | arrow_right_fill        |
  | 120 | :arrow_down_fill         | arrow_down_fill         |
  | 121 | :arrow_up_fill           | arrow_up_fill           |
  | 122 | :audio                   | audio                   |
  | 123 | :fx                      | fx                      |
  | 124 | :wave                    | wave                    |
  | 125 | :wave_sinus              | wave_sinus              |
  | 126 | :wave_square             | wave_square             |
  | 127 | :wave_triangular         | wave_triangular         |
  | 128 | :cross_small             | cross_small             |
  | 129 | :player_previous         | player_previous         |
  | 130 | :player_play_back        | player_play_back        |
  | 131 | :player_play             | player_play             |
  | 132 | :player_pause            | player_pause            |
  | 133 | :player_stop             | player_stop             |
  | 134 | :player_next             | player_next             |
  | 135 | :player_record           | player_record           |
  | 136 | :magnet                  | magnet                  |
  | 137 | :lock_close              | lock_close              |
  | 138 | :lock_open               | lock_open               |
  | 139 | :clock                   | clock                   |
  | 140 | :tools                   | tools                   |
  | 141 | :gear                    | gear                    |
  | 142 | :gear_big                | gear_big                |
  | 143 | :bin                     | bin                     |
  | 144 | :hand_pointer            | hand_pointer            |
  | 145 | :laser                   | laser                   |
  | 146 | :coin                    | coin                    |
  | 147 | :explosion               | explosion               |
  | 148 | :one_up                  | one_up                  |
  | 149 | :player                  | player                  |
  | 150 | :player_jump             | player_jump             |
  | 151 | :key                     | key                     |
  | 152 | :demon                   | demon                   |
  | 153 | :text_popup              | text_popup              |
  | 154 | :gear_ex                 | gear_ex                 |
  | 155 | :crack                   | crack                   |
  | 156 | :crack_points            | crack_points            |
  | 157 | :star                    | star                    |
  | 158 | :door                    | door                    |
  | 159 | :exit                    | exit                    |
  | 160 | :mode_2d                 | mode_2d                 |
  | 161 | :mode_3d                 | mode_3d                 |
  | 162 | :cube                    | cube                    |
  | 163 | :cube_face_top           | cube_face_top           |
  | 164 | :cube_face_left          | cube_face_left          |
  | 165 | :cube_face_front         | cube_face_front         |
  | 166 | :cube_face_bottom        | cube_face_bottom        |
  | 167 | :cube_face_right         | cube_face_right         |
  | 168 | :cube_face_back          | cube_face_back          |
  | 169 | :camera                  | camera                  |
  | 170 | :special                 | special                 |
  | 171 | :link_net                | link_net                |
  | 172 | :link_boxes              | link_boxes              |
  | 173 | :link_multi              | link_multi              |
  | 174 | :link                    | link                    |
  | 175 | :link_broke              | link_broke              |
  | 176 | :text_notes              | text_notes              |
  | 177 | :notebook                | notebook                |
  | 178 | :suitcase                | suitcase                |
  | 179 | :suitcase_zip            | suitcase_zip            |
  | 180 | :mailbox                 | mailbox                 |
  | 181 | :monitor                 | monitor                 |
  | 182 | :printer                 | printer                 |
  | 183 | :photo_camera            | photo_camera            |
  | 184 | :photo_camera_flash      | photo_camera_flash      |
  | 185 | :house                   | house                   |
  | 186 | :heart                   | heart                   |
  | 187 | :corner                  | corner                  |
  | 188 | :vertical_bars           | vertical_bars           |
  | 189 | :vertical_bars_fill      | vertical_bars_fill      |
  | 190 | :life_bars               | life_bars               |
  | 191 | :info                    | info                    |
  | 192 | :crossline               | crossline               |
  | 193 | :help                    | help                    |
  | 194 | :filetype_alpha          | filetype_alpha          |
  | 195 | :filetype_home           | filetype_home           |
  | 196 | :layers_visible          | layers_visible          |
  | 197 | :layers                  | layers                  |
  | 198 | :window                  | window                  |
  | 199 | :hidpi                   | hidpi                   |
  | 200 | :filetype_binary         | filetype_binary         |
  | 201 | :hex                     | hex                     |
  | 202 | :shield                  | shield                  |
  | 203 | :file_new                | file_new                |
  | 204 | :folder_add              | folder_add              |
  | 205 | :alarm                   | alarm                   |
  | 206 | :cpu                     | cpu                     |
  | 207 | :rom                     | rom                     |
  | 208 | :step_over               | step_over               |
  | 209 | :step_into               | step_into               |
  | 210 | :step_out                | step_out                |
  | 211 | :restart                 | restart                 |
  | 212 | :breakpoint_on           | breakpoint_on           |
  | 213 | :breakpoint_off          | breakpoint_off          |
  | 214 | :burger_menu             | burger_menu             |
  | 215 | :case_sensitive          | case_sensitive          |
  | 216 | :reg_exp                 | reg_exp                 |
  | 217 | :folder                  | folder                  |
  | 218 | :file                    | file                    |
  | 219 | :sand_timer              | sand_timer              |
  | 220 | :warning                 | warning                 |
  | 221 | :help_box                | help_box                |
  | 222 | :info_box                | info_box                |
  | 223 | :priority                | priority                |
  | 224 | :layers_iso              | layers_iso              |
  | 225 | :layers2                 | layers2                 |
  | 226 | :mlayers                 | mlayers                 |
  | 227 | :maps                    | maps                    |
  | 228 | :hot                     | hot                     |
  | 229 | :label                   | label                   |
  | 230 | :name_id                 | name_id                 |
  | 231 | :slicing                 | slicing                 |
  | 232 | :manual_control          | manual_control          |
  | 233 | :collision               | collision               |
  | 234 | :icon_234                | icon_234                |
  | 235 | :icon_235                | icon_235                |
  | 236 | :icon_236                | icon_236                |
  | 237 | :icon_237                | icon_237                |
  | 238 | :icon_238                | icon_238                |
  | 239 | :icon_239                | icon_239                |
  | 240 | :icon_240                | icon_240                |
  | 241 | :icon_241                | icon_241                |
  | 242 | :icon_242                | icon_242                |
  | 243 | :icon_243                | icon_243                |
  | 244 | :icon_244                | icon_244                |
  | 245 | :icon_245                | icon_245                |
  | 246 | :icon_246                | icon_246                |
  | 247 | :icon_247                | icon_247                |
  | 248 | :icon_248                | icon_248                |
  | 249 | :icon_249                | icon_249                |
  | 250 | :icon_250                | icon_250                |
  | 251 | :icon_251                | icon_251                |
  | 252 | :icon_252                | icon_252                |
  | 253 | :icon_253                | icon_253                |
  | 254 | :icon_254                | icon_254                |
  | 255 | :icon_255                | icon_255                |
  """

  use Zexray.Enum.EnumBase,
    prefix: "gui_icon",
    values: %{
      none: 0,
      folder_file_open: 1,
      file_save_classic: 2,
      folder_open: 3,
      folder_save: 4,
      file_open: 5,
      file_save: 6,
      file_export: 7,
      file_add: 8,
      file_delete: 9,
      filetype_text: 10,
      filetype_audio: 11,
      filetype_image: 12,
      filetype_play: 13,
      filetype_video: 14,
      filetype_info: 15,
      file_copy: 16,
      file_cut: 17,
      file_paste: 18,
      cursor_hand: 19,
      cursor_pointer: 20,
      cursor_classic: 21,
      pencil: 22,
      pencil_big: 23,
      brush_classic: 24,
      brush_painter: 25,
      water_drop: 26,
      color_picker: 27,
      rubber: 28,
      color_bucket: 29,
      text_t: 30,
      text_a: 31,
      scale: 32,
      resize: 33,
      filter_point: 34,
      filter_bilinear: 35,
      crop: 36,
      crop_alpha: 37,
      square_toggle: 38,
      symmetry: 39,
      symmetry_horizontal: 40,
      symmetry_vertical: 41,
      lens: 42,
      lens_big: 43,
      eye_on: 44,
      eye_off: 45,
      filter_top: 46,
      filter: 47,
      target_point: 48,
      target_small: 49,
      target_big: 50,
      target_move: 51,
      cursor_move: 52,
      cursor_scale: 53,
      cursor_scale_right: 54,
      cursor_scale_left: 55,
      undo: 56,
      redo: 57,
      reredo: 58,
      mutate: 59,
      rotate: 60,
      repeat: 61,
      shuffle: 62,
      emptybox: 63,
      target: 64,
      target_small_fill: 65,
      target_big_fill: 66,
      target_move_fill: 67,
      cursor_move_fill: 68,
      cursor_scale_fill: 69,
      cursor_scale_right_fill: 70,
      cursor_scale_left_fill: 71,
      undo_fill: 72,
      redo_fill: 73,
      reredo_fill: 74,
      mutate_fill: 75,
      rotate_fill: 76,
      repeat_fill: 77,
      shuffle_fill: 78,
      emptybox_small: 79,
      box: 80,
      box_top: 81,
      box_top_right: 82,
      box_right: 83,
      box_bottom_right: 84,
      box_bottom: 85,
      box_bottom_left: 86,
      box_left: 87,
      box_top_left: 88,
      box_center: 89,
      box_circle_mask: 90,
      pot: 91,
      alpha_multiply: 92,
      alpha_clear: 93,
      dithering: 94,
      mipmaps: 95,
      box_grid: 96,
      grid: 97,
      box_corners_small: 98,
      box_corners_big: 99,
      four_boxes: 100,
      grid_fill: 101,
      box_multisize: 102,
      zoom_small: 103,
      zoom_medium: 104,
      zoom_big: 105,
      zoom_all: 106,
      zoom_center: 107,
      box_dots_small: 108,
      box_dots_big: 109,
      box_concentric: 110,
      box_grid_big: 111,
      ok_tick: 112,
      cross: 113,
      arrow_left: 114,
      arrow_right: 115,
      arrow_down: 116,
      arrow_up: 117,
      arrow_left_fill: 118,
      arrow_right_fill: 119,
      arrow_down_fill: 120,
      arrow_up_fill: 121,
      audio: 122,
      fx: 123,
      wave: 124,
      wave_sinus: 125,
      wave_square: 126,
      wave_triangular: 127,
      cross_small: 128,
      player_previous: 129,
      player_play_back: 130,
      player_play: 131,
      player_pause: 132,
      player_stop: 133,
      player_next: 134,
      player_record: 135,
      magnet: 136,
      lock_close: 137,
      lock_open: 138,
      clock: 139,
      tools: 140,
      gear: 141,
      gear_big: 142,
      bin: 143,
      hand_pointer: 144,
      laser: 145,
      coin: 146,
      explosion: 147,
      one_up: 148,
      player: 149,
      player_jump: 150,
      key: 151,
      demon: 152,
      text_popup: 153,
      gear_ex: 154,
      crack: 155,
      crack_points: 156,
      star: 157,
      door: 158,
      exit: 159,
      mode_2d: 160,
      mode_3d: 161,
      cube: 162,
      cube_face_top: 163,
      cube_face_left: 164,
      cube_face_front: 165,
      cube_face_bottom: 166,
      cube_face_right: 167,
      cube_face_back: 168,
      camera: 169,
      special: 170,
      link_net: 171,
      link_boxes: 172,
      link_multi: 173,
      link: 174,
      link_broke: 175,
      text_notes: 176,
      notebook: 177,
      suitcase: 178,
      suitcase_zip: 179,
      mailbox: 180,
      monitor: 181,
      printer: 182,
      photo_camera: 183,
      photo_camera_flash: 184,
      house: 185,
      heart: 186,
      corner: 187,
      vertical_bars: 188,
      vertical_bars_fill: 189,
      life_bars: 190,
      info: 191,
      crossline: 192,
      help: 193,
      filetype_alpha: 194,
      filetype_home: 195,
      layers_visible: 196,
      layers: 197,
      window: 198,
      hidpi: 199,
      filetype_binary: 200,
      hex: 201,
      shield: 202,
      file_new: 203,
      folder_add: 204,
      alarm: 205,
      cpu: 206,
      rom: 207,
      step_over: 208,
      step_into: 209,
      step_out: 210,
      restart: 211,
      breakpoint_on: 212,
      breakpoint_off: 213,
      burger_menu: 214,
      case_sensitive: 215,
      reg_exp: 216,
      folder: 217,
      file: 218,
      sand_timer: 219,
      warning: 220,
      help_box: 221,
      info_box: 222,
      priority: 223,
      layers_iso: 224,
      layers2: 225,
      mlayers: 226,
      maps: 227,
      hot: 228,
      label: 229,
      name_id: 230,
      slicing: 231,
      manual_control: 232,
      collision: 233,
      icon_234: 234,
      icon_235: 235,
      icon_236: 236,
      icon_237: 237,
      icon_238: 238,
      icon_239: 239,
      icon_240: 240,
      icon_241: 241,
      icon_242: 242,
      icon_243: 243,
      icon_244: 244,
      icon_245: 245,
      icon_246: 246,
      icon_247: 247,
      icon_248: 248,
      icon_249: 249,
      icon_250: 250,
      icon_251: 251,
      icon_252: 252,
      icon_253: 253,
      icon_254: 254,
      icon_255: 255
    }
end
