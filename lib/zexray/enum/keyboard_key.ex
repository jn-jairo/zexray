defmodule Zexray.Enum.KeyboardKey do
  @moduledoc """
  Keyboard keys (US keyboard layout)

  NOTE: Use GetKeyPressed() to allow redefining required keys for alternative layouts

  ## Values

  | id | name  | description                        |
  | -- | ----- | ---------------------------------- |
  | 0  | :null | Key: NULL, used for no key pressed |

  ### Values - Alphanumeric keys

  | id | name           | description |
  | -- | -------------- | ----------- |
  | 39 | :apostrophe    | Key: '      |
  | 44 | :comma         | Key: ,      |
  | 45 | :minus         | Key: -      |
  | 46 | :period        | Key: .      |
  | 47 | :slash         | Key: /      |
  | 48 | :zero          | Key: 0      |
  | 49 | :one           | Key: 1      |
  | 50 | :two           | Key: 2      |
  | 51 | :three         | Key: 3      |
  | 52 | :four          | Key: 4      |
  | 53 | :five          | Key: 5      |
  | 54 | :six           | Key: 6      |
  | 55 | :seven         | Key: 7      |
  | 56 | :eight         | Key: 8      |
  | 57 | :nine          | Key: 9      |
  | 59 | :semicolon     | Key: ;      |
  | 61 | :equal         | Key: =      |
  | 65 | :a             | Key: A  a   |
  | 66 | :b             | Key: B  b   |
  | 67 | :c             | Key: C  c   |
  | 68 | :d             | Key: D  d   |
  | 69 | :e             | Key: E  e   |
  | 70 | :f             | Key: F  f   |
  | 71 | :g             | Key: G  g   |
  | 72 | :h             | Key: H  h   |
  | 73 | :i             | Key: I  i   |
  | 74 | :j             | Key: J  j   |
  | 75 | :k             | Key: K  k   |
  | 76 | :l             | Key: L  l   |
  | 77 | :m             | Key: M  m   |
  | 78 | :n             | Key: N  n   |
  | 79 | :o             | Key: O  o   |
  | 80 | :p             | Key: P  p   |
  | 81 | :q             | Key: Q  q   |
  | 82 | :r             | Key: R  r   |
  | 83 | :s             | Key: S  s   |
  | 84 | :t             | Key: T  t   |
  | 85 | :u             | Key: U  u   |
  | 86 | :v             | Key: V  v   |
  | 87 | :w             | Key: W  w   |
  | 88 | :x             | Key: X  x   |
  | 89 | :y             | Key: Y  y   |
  | 90 | :z             | Key: Z  z   |
  | 91 | :left_bracket  | Key: [      |
  | 92 | :backslash     | Key: '\'    |
  | 93 | :right_bracket | Key: ]      |
  | 96 | :grave         | Key: `      |

  ### Values - Function keys

  | id  | name           | description        |
  | --- | -------------- | ------------------ |
  | 32  | :space         | Key: Space         |
  | 256 | :escape        | Key: Esc           |
  | 257 | :enter         | Key: Enter         |
  | 258 | :tab           | Key: Tab           |
  | 259 | :backspace     | Key: Backspace     |
  | 260 | :insert        | Key: Ins           |
  | 261 | :delete        | Key: Del           |
  | 262 | :right         | Key: Cursor right  |
  | 263 | :left          | Key: Cursor left   |
  | 264 | :down          | Key: Cursor down   |
  | 265 | :up            | Key: Cursor up     |
  | 266 | :page_up       | Key: Page up       |
  | 267 | :page_down     | Key: Page down     |
  | 268 | :home          | Key: Home          |
  | 269 | :end           | Key: End           |
  | 280 | :caps_lock     | Key: Caps lock     |
  | 281 | :scroll_lock   | Key: Scroll down   |
  | 282 | :num_lock      | Key: Num lock      |
  | 283 | :print_screen  | Key: Print screen  |
  | 284 | :pause         | Key: Pause         |
  | 290 | :f1            | Key: F1            |
  | 291 | :f2            | Key: F2            |
  | 292 | :f3            | Key: F3            |
  | 293 | :f4            | Key: F4            |
  | 294 | :f5            | Key: F5            |
  | 295 | :f6            | Key: F6            |
  | 296 | :f7            | Key: F7            |
  | 297 | :f8            | Key: F8            |
  | 298 | :f9            | Key: F9            |
  | 299 | :f10           | Key: F10           |
  | 300 | :f11           | Key: F11           |
  | 301 | :f12           | Key: F12           |
  | 340 | :left_shift    | Key: Shift left    |
  | 341 | :left_control  | Key: Control left  |
  | 342 | :left_alt      | Key: Alt left      |
  | 343 | :left_super    | Key: Super left    |
  | 344 | :right_shift   | Key: Shift right   |
  | 345 | :right_control | Key: Control right |
  | 346 | :right_alt     | Key: Alt right     |
  | 347 | :right_super   | Key: Super right   |
  | 348 | :kb_menu       | Key: KB menu       |

  ### Values - Keypad keys

  | id  | name         | description       |
  | --- | ------------ | ----------------- |
  | 320 | :kp_0        | Key: Keypad 0     |
  | 321 | :kp_1        | Key: Keypad 1     |
  | 322 | :kp_2        | Key: Keypad 2     |
  | 323 | :kp_3        | Key: Keypad 3     |
  | 324 | :kp_4        | Key: Keypad 4     |
  | 325 | :kp_5        | Key: Keypad 5     |
  | 326 | :kp_6        | Key: Keypad 6     |
  | 327 | :kp_7        | Key: Keypad 7     |
  | 328 | :kp_8        | Key: Keypad 8     |
  | 329 | :kp_9        | Key: Keypad 9     |
  | 330 | :kp_decimal  | Key: Keypad .     |
  | 331 | :kp_divide   | Key: Keypad /     |
  | 332 | :kp_multiply | Key: Keypad *     |
  | 333 | :kp_subtract | Key: Keypad -     |
  | 334 | :kp_add      | Key: Keypad +     |
  | 335 | :kp_enter    | Key: Keypad Enter |
  | 336 | :kp_equal    | Key: Keypad =     |

  ### Values - Android key buttons

  | id | name         | description                     |
  | -- | ------------ | ------------------------------- |
  | 4  | :back        | Key: Android back button        |
  | 5  | :menu        | Key: Android menu button        |
  | 24 | :volume_up   | Key: Android volume up button   |
  | 25 | :volume_down | Key: Android volume down button |
  """

  use Zexray.Enum.EnumBase,
    prefix: "keyboard_key",
    values: %{
      null: 0,

      # Alphanumeric keys
      apostrophe: 39,
      comma: 44,
      minus: 45,
      period: 46,
      slash: 47,
      zero: 48,
      one: 49,
      two: 50,
      three: 51,
      four: 52,
      five: 53,
      six: 54,
      seven: 55,
      eight: 56,
      nine: 57,
      semicolon: 59,
      equal: 61,
      a: 65,
      b: 66,
      c: 67,
      d: 68,
      e: 69,
      f: 70,
      g: 71,
      h: 72,
      i: 73,
      j: 74,
      k: 75,
      l: 76,
      m: 77,
      n: 78,
      o: 79,
      p: 80,
      q: 81,
      r: 82,
      s: 83,
      t: 84,
      u: 85,
      v: 86,
      w: 87,
      x: 88,
      y: 89,
      z: 90,
      left_bracket: 91,
      backslash: 92,
      right_bracket: 93,
      grave: 96,

      # Function keys
      space: 32,
      escape: 256,
      enter: 257,
      tab: 258,
      backspace: 259,
      insert: 260,
      delete: 261,
      right: 262,
      left: 263,
      down: 264,
      up: 265,
      page_up: 266,
      page_down: 267,
      home: 268,
      end: 269,
      caps_lock: 280,
      scroll_lock: 281,
      num_lock: 282,
      print_screen: 283,
      pause: 284,
      f1: 290,
      f2: 291,
      f3: 292,
      f4: 293,
      f5: 294,
      f6: 295,
      f7: 296,
      f8: 297,
      f9: 298,
      f10: 299,
      f11: 300,
      f12: 301,
      left_shift: 340,
      left_control: 341,
      left_alt: 342,
      left_super: 343,
      right_shift: 344,
      right_control: 345,
      right_alt: 346,
      right_super: 347,
      kb_menu: 348,

      # Keypad keys
      kp_0: 320,
      kp_1: 321,
      kp_2: 322,
      kp_3: 323,
      kp_4: 324,
      kp_5: 325,
      kp_6: 326,
      kp_7: 327,
      kp_8: 328,
      kp_9: 329,
      kp_decimal: 330,
      kp_divide: 331,
      kp_multiply: 332,
      kp_subtract: 333,
      kp_add: 334,
      kp_enter: 335,
      kp_equal: 336,

      # Android key buttons
      back: 4,
      menu: 5,
      volume_up: 24,
      volume_down: 25
    }
end
