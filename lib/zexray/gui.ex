defmodule Zexray.Gui do
  @moduledoc """
  Gui
  """

  alias Zexray.NIF

  use Zexray.Enum
  use Zexray.Type

  ########################################
  #  Global gui state control functions  #
  ########################################

  @doc """
  Enable gui controls (global state)
  """
  @doc group: :state_control
  @spec enable() :: :ok
  defdelegate enable(), to: NIF, as: :gui_enable

  @doc """
  Disable gui controls (global state)
  """
  @doc group: :state_control
  @spec disable() :: :ok
  defdelegate disable(), to: NIF, as: :gui_disable

  @doc """
  Lock gui controls (global state)
  """
  @doc group: :state_control
  @spec lock() :: :ok
  defdelegate lock(), to: NIF, as: :gui_lock

  @doc """
  Unlock gui controls (global state)
  """
  @doc group: :state_control
  @spec unlock() :: :ok
  defdelegate unlock(), to: NIF, as: :gui_unlock

  @doc """
  Check if gui is locked (global state)
  """
  @doc group: :state_control
  @spec locked?() :: boolean
  defdelegate locked?(), to: NIF, as: :gui_is_locked

  @doc """
  Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
  """
  @doc group: :state_control
  @spec set_alpha(alpha :: number) :: :ok
  defdelegate set_alpha(alpha), to: NIF, as: :gui_set_alpha

  @doc """
  Set gui state (global state)
  """
  @doc group: :state_control
  @spec set_state(state :: Zexray.Enum.GuiState.t()) :: :ok
  defdelegate set_state(state), to: NIF, as: :gui_set_state

  @doc """
  Get gui state (global state)
  """
  @doc group: :state_control
  @spec get_state() :: integer
  defdelegate get_state(), to: NIF, as: :gui_get_state

  ############################
  #  Font set/get functions  #
  ############################

  @doc """
  Set gui custom font (global state)
  """
  @doc group: :font
  @spec set_font(font :: Zexray.Type.Font.t_all()) :: :ok
  defdelegate set_font(font), to: NIF, as: :gui_set_font

  @doc """
  Get gui custom font (global state)
  """
  @doc group: :font
  @spec get_font(return :: :auto | :value | :resource) :: Zexray.Type.Font.t_nif()
  defdelegate get_font(return \\ :auto), to: NIF, as: :gui_get_font

  #############################
  #  Style set/get functions  #
  #############################

  @doc """
  Set one style property
  """
  @doc group: :style
  @spec set_style(
          control :: Zexray.Enum.GuiControl.t(),
          property :: integer,
          value :: integer
        ) :: :ok
  defdelegate set_style(
                control,
                property,
                value
              ),
              to: NIF,
              as: :gui_set_style

  @doc """
  Set one style property
  """
  @doc group: :style
  @spec set_style_color(
          control :: Zexray.Enum.GuiControl.t(),
          property :: integer,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate set_style_color(
                control,
                property,
                color
              ),
              to: NIF,
              as: :gui_set_style_color

  @doc """
  Get one style property
  """
  @doc group: :style
  @spec get_style(
          control :: Zexray.Enum.GuiControl.t(),
          property :: integer
        ) :: integer
  defdelegate get_style(
                control,
                property
              ),
              to: NIF,
              as: :gui_get_style

  @doc """
  Get one style property
  """
  @doc group: :style
  @spec get_style_color(
          control :: Zexray.Enum.GuiControl.t(),
          property :: integer,
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate get_style_color(
                control,
                property,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_get_style_color

  ##############################
  #  Styles loading functions  #
  ##############################

  @doc """
  Load style file over global style variable (.rgs)
  """
  @doc group: :style_loading
  @spec load_style(file_name :: binary) :: :ok
  defdelegate load_style(file_name), to: NIF, as: :gui_load_style

  @doc """
  Load style default over global style
  """
  @doc group: :style_loading
  @spec load_style_default() :: :ok
  defdelegate load_style_default(), to: NIF, as: :gui_load_style_default

  def load_style_default(:light) do
    load_style_default()
  end

  def load_style_default(:dark) do
    load_style_default()

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:border_color_normal),
      type_color(r: 0x87, g: 0x87, b: 0x87, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:base_color_normal),
      type_color(r: 0x2C, g: 0x2C, b: 0x2C, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:text_color_normal),
      type_color(r: 0xC3, g: 0xC3, b: 0xC3, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:border_color_focused),
      type_color(r: 0xE1, g: 0xE1, b: 0xE1, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:base_color_focused),
      type_color(r: 0x84, g: 0x84, b: 0x84, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0x18, g: 0x18, b: 0x18, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:border_color_pressed),
      type_color(r: 0x00, g: 0x00, b: 0x00, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:base_color_pressed),
      type_color(r: 0xEF, g: 0xEF, b: 0xEF, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:text_color_pressed),
      type_color(r: 0x20, g: 0x20, b: 0x20, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:border_color_disabled),
      type_color(r: 0x6A, g: 0x6A, b: 0x6A, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:base_color_disabled),
      type_color(r: 0x81, g: 0x81, b: 0x81, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_control(:text_color_disabled),
      type_color(r: 0x60, g: 0x60, b: 0x60, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_default(:line_color),
      type_color(r: 0x9D, g: 0x9D, b: 0x9D, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:default),
      enum_gui_property_default(:background_color),
      type_color(r: 0x3C, g: 0x3C, b: 0x3C, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:label),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0xF7, g: 0xF7, b: 0xF7, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:label),
      enum_gui_property_control(:text_color_pressed),
      type_color(r: 0x89, g: 0x89, b: 0x89, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:slider),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0xB0, g: 0xB0, b: 0xB0, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:progressbar),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0x84, g: 0x84, b: 0x84, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:textbox),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0xF5, g: 0xF5, b: 0xF5, a: 0xFF)
    )

    set_style_color(
      enum_gui_control(:valuebox),
      enum_gui_property_control(:text_color_focused),
      type_color(r: 0xF6, g: 0xF6, b: 0xF6, a: 0xFF)
    )
  end

  ###################################
  #  Tooltips management functions  #
  ###################################

  @doc """
  Enable gui tooltips (global state)
  """
  @doc group: :tooltips
  @spec enable_tooltip() :: :ok
  defdelegate enable_tooltip(), to: NIF, as: :gui_enable_tooltip

  @doc """
  Disable gui tooltips (global state)
  """
  @doc group: :tooltips
  @spec disable_tooltip() :: :ok
  defdelegate disable_tooltip(), to: NIF, as: :gui_disable_tooltip

  @doc """
  Set tooltip string
  """
  @doc group: :tooltips
  @spec set_tooltip(tooltip :: binary) :: :ok
  defdelegate set_tooltip(tooltip), to: NIF, as: :gui_set_tooltip

  #########################
  #  Icons functionality  #
  #########################

  @doc """
  Get text with icon id prepended (if supported)
  """
  @doc group: :icons
  @spec icon_text(
          icon_id :: Zexray.Enum.GuiIcon.t(),
          text :: binary
        ) :: binary
  defdelegate icon_text(
                icon_id,
                text
              ),
              to: NIF,
              as: :gui_icon_text

  @doc """
  Set default icon drawing size
  """
  @doc group: :icons
  @spec set_icon_scale(scale :: number) :: :ok
  defdelegate set_icon_scale(scale), to: NIF, as: :gui_set_icon_scale

  @doc """
  Get raygui icons data pointer
  """
  @doc group: :icons
  @spec get_icons() :: [non_neg_integer]
  defdelegate get_icons(), to: NIF, as: :gui_get_icons

  @doc """
  Load raygui icons file (.rgi) into internal icons data
  """
  @doc group: :icons
  @spec load_icons(file_name :: binary) :: :ok
  defdelegate load_icons(file_name), to: NIF, as: :gui_load_icons

  @doc """
  Draw icon using pixel size at specified position
  """
  @doc group: :icons
  @spec draw_icon(
          icon_id :: Zexray.Enum.GuiIcon.t(),
          pox_x :: number,
          pox_y :: number,
          pixel_size :: number,
          color :: Zexray.Type.Color.t_all()
        ) :: :ok
  defdelegate draw_icon(
                icon_id,
                pox_x,
                pox_y,
                pixel_size,
                color
              ),
              to: NIF,
              as: :gui_draw_icon

  ##############
  #  Controls  #
  ##############

  @doc """
  Window Box control, shows a window that can be closed
  """
  @doc group: :controls
  @spec window_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          title :: binary
        ) :: boolean
  defdelegate window_box(
                bounds,
                title
              ),
              to: NIF,
              as: :gui_window_box

  @doc """
  Group Box control with text name
  """
  @doc group: :controls
  @spec group_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate group_box(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_group_box

  @doc """
  Line separator control, could contain text
  """
  @doc group: :controls
  @spec line(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate line(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_line

  @doc """
  Panel control, useful to group controls
  """
  @doc group: :controls
  @spec panel(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate panel(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_panel

  @doc """
  Tab Bar control, returns TAB to be closed or -1
  """
  @doc group: :controls
  @spec tab_bar(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: [binary],
          active :: integer
        ) :: {should_close :: false | integer, active :: integer}
  defdelegate tab_bar(
                bounds,
                text,
                active
              ),
              to: NIF,
              as: :gui_tab_bar

  @doc """
  Scroll Panel control
  """
  @doc group: :controls
  @spec scroll_panel(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          content :: Zexray.Type.Rectangle.t_all(),
          scroll :: Zexray.Type.Vector2.t_all(),
          view :: Zexray.Type.Rectangle.t_all(),
          return :: :auto | :value | :resource
        ) :: {scroll :: Zexray.Type.Vector2.t_nif(), view :: Zexray.Type.Rectangle.t_nif()}
  defdelegate scroll_panel(
                bounds,
                text,
                content,
                scroll,
                view,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_scroll_panel

  ########################
  #  Basic controls set  #
  ########################

  @doc """
  Label control
  """
  @doc group: :basic_controls
  @spec label(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate label(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_label

  @doc """
  Button control, returns true when clicked
  """
  @doc group: :basic_controls
  @spec button(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: boolean
  defdelegate button(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_button

  @doc """
  Label button control, returns true when clicked
  """
  @doc group: :basic_controls
  @spec label_button(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: boolean
  defdelegate label_button(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_label_button

  @doc """
  Toggle Button control
  """
  @doc group: :basic_controls
  @spec toggle(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          active :: boolean
        ) :: boolean
  defdelegate toggle(
                bounds,
                text,
                active
              ),
              to: NIF,
              as: :gui_toggle

  @doc """
  Toggle Group control
  """
  @doc group: :basic_controls
  @spec toggle_group(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          active :: integer
        ) :: integer
  defdelegate toggle_group(
                bounds,
                text,
                active
              ),
              to: NIF,
              as: :gui_toggle_group

  @doc """
  Toggle Slider control
  """
  @doc group: :basic_controls
  @spec toggle_slider(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          active :: integer
        ) :: integer
  defdelegate toggle_slider(
                bounds,
                text,
                active
              ),
              to: NIF,
              as: :gui_toggle_slider

  @doc """
  Check Box control, returns true when active
  """
  @doc group: :basic_controls
  @spec check_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          checked :: boolean
        ) :: {changed :: boolean, checked :: boolean}
  defdelegate check_box(
                bounds,
                text,
                checked
              ),
              to: NIF,
              as: :gui_check_box

  @doc """
  Combo Box control
  """
  @doc group: :basic_controls
  @spec combo_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          active :: integer
        ) :: integer
  defdelegate combo_box(
                bounds,
                text,
                active
              ),
              to: NIF,
              as: :gui_combo_box

  @doc """
  Dropdown Box control
  """
  @doc group: :basic_controls
  @spec dropdown_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          active :: integer,
          edit_mode :: boolean
        ) :: {pressed :: boolean, active :: integer}
  defdelegate dropdown_box(
                bounds,
                text,
                active,
                edit_mode
              ),
              to: NIF,
              as: :gui_dropdown_box

  @doc """
  Spinner control
  """
  @doc group: :basic_controls
  @spec spinner(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          value :: number,
          min_value :: number,
          max_value :: number,
          edit_mode :: boolean
        ) :: {changed :: boolean, value :: integer}
  defdelegate spinner(
                bounds,
                text,
                value,
                min_value,
                max_value,
                edit_mode
              ),
              to: NIF,
              as: :gui_spinner

  @doc """
  Value Box control, updates input text with numbers
  """
  @doc group: :basic_controls
  @spec value_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          value :: number,
          min_value :: number,
          max_value :: number,
          edit_mode :: boolean
        ) :: {changed :: boolean, value :: integer}
  defdelegate value_box(
                bounds,
                text,
                value,
                min_value,
                max_value,
                edit_mode
              ),
              to: NIF,
              as: :gui_value_box

  @doc """
  Value box control for float values
  """
  @doc group: :basic_controls
  @spec value_box_float(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          text_value :: binary,
          value :: number,
          edit_mode :: boolean
        ) :: {changed :: boolean, text_value :: binary, value :: float}
  defdelegate value_box_float(
                bounds,
                text,
                text_value,
                value,
                edit_mode
              ),
              to: NIF,
              as: :gui_value_box_float

  @doc """
  Text Box control, updates input text
  """
  @doc group: :basic_controls
  @spec text_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          text_max_size :: number,
          edit_mode :: boolean
        ) :: {changed :: boolean, text :: binary}
  defdelegate text_box(
                bounds,
                text,
                text_max_size,
                edit_mode
              ),
              to: NIF,
              as: :gui_text_box

  @doc """
  Slider control
  """
  @doc group: :basic_controls
  @spec slider(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text_left :: binary,
          text_right :: binary,
          value :: number,
          min_value :: number,
          max_value :: number
        ) :: {changed :: boolean, value :: float}
  defdelegate slider(
                bounds,
                text_left,
                text_right,
                value,
                min_value,
                max_value
              ),
              to: NIF,
              as: :gui_slider

  @doc """
  Slider Bar control
  """
  @doc group: :basic_controls
  @spec slider_bar(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text_left :: binary,
          text_right :: binary,
          value :: number,
          min_value :: number,
          max_value :: number
        ) :: {changed :: boolean, value :: float}
  defdelegate slider_bar(
                bounds,
                text_left,
                text_right,
                value,
                min_value,
                max_value
              ),
              to: NIF,
              as: :gui_slider_bar

  @doc """
  Progress Bar control
  """
  @doc group: :basic_controls
  @spec progress_bar(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text_left :: binary,
          text_right :: binary,
          value :: number,
          min_value :: number,
          max_value :: number
        ) :: float
  defdelegate progress_bar(
                bounds,
                text_left,
                text_right,
                value,
                min_value,
                max_value
              ),
              to: NIF,
              as: :gui_progress_bar

  @doc """
  Status Bar control, shows info text
  """
  @doc group: :basic_controls
  @spec status_bar(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate status_bar(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_status_bar

  @doc """
  Dummy control for placeholders
  """
  @doc group: :basic_controls
  @spec dummy_rec(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary
        ) :: :ok
  defdelegate dummy_rec(
                bounds,
                text
              ),
              to: NIF,
              as: :gui_dummy_rec

  @doc """
  Grid control
  """
  @doc group: :basic_controls
  @spec grid(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          spacing :: number,
          subdivs :: number,
          mouse_cell :: Zexray.Type.Vector2.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector2.t_nif()
  defdelegate grid(
                bounds,
                text,
                spacing,
                subdivs,
                mouse_cell,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_grid

  ##########################
  #  Advance controls set  #
  ##########################

  @doc """
  List View control
  """
  @doc group: :advance_controls
  @spec list_view(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          scroll_index :: integer,
          active :: integer
        ) :: {scroll_index :: integer, active :: integer}
  defdelegate list_view(
                bounds,
                text,
                scroll_index,
                active
              ),
              to: NIF,
              as: :gui_list_view

  @doc """
  List View with extended parameters
  """
  @doc group: :advance_controls
  @spec list_view_ex(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: [binary],
          scroll_index :: integer,
          active :: integer,
          focus :: integer
        ) :: {scroll_index :: integer, active :: integer, focus :: integer}
  defdelegate list_view_ex(
                bounds,
                text,
                scroll_index,
                active,
                focus
              ),
              to: NIF,
              as: :gui_list_view_ex

  @doc """
  Message Box control, displays a message
  """
  @doc group: :advance_controls
  @spec message_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          title :: binary,
          message :: binary,
          buttons :: binary
        ) :: {should_close :: boolean, button_pressed :: false | integer}
  defdelegate message_box(
                bounds,
                title,
                message,
                buttons
              ),
              to: NIF,
              as: :gui_message_box

  @doc """
  Text Input Box control, ask for text, supports secret
  """
  @doc group: :advance_controls
  @spec text_input_box(
          bounds :: Zexray.Type.Rectangle.t_all(),
          title :: binary,
          message :: binary,
          buttons :: binary,
          text :: binary,
          text_max_size :: number,
          secret_view_active :: nil | boolean
        ) ::
          {should_close :: boolean, button_pressed :: false | integer, text :: binary,
           secret_view_active :: nil | boolean}
  defdelegate text_input_box(
                bounds,
                title,
                message,
                buttons,
                text,
                text_max_size,
                secret_view_active
              ),
              to: NIF,
              as: :gui_text_input_box

  @doc """
  Color Picker control (multiple color controls)
  """
  @doc group: :advance_controls
  @spec color_picker(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          color :: Zexray.Type.Color.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate color_picker(
                bounds,
                text,
                color,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_color_picker

  @doc """
  Color Panel control
  """
  @doc group: :advance_controls
  @spec color_panel(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          color :: Zexray.Type.Color.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Color.t_nif()
  defdelegate color_panel(
                bounds,
                text,
                color,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_color_panel

  @doc """
  Color Bar Alpha control
  """
  @doc group: :advance_controls
  @spec color_bar_alpha(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          alpha :: number
        ) :: float
  defdelegate color_bar_alpha(
                bounds,
                text,
                alpha
              ),
              to: NIF,
              as: :gui_color_bar_alpha

  @doc """
  Color Bar Hue control
  """
  @doc group: :advance_controls
  @spec color_bar_hue(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          value :: number
        ) :: float
  defdelegate color_bar_hue(
                bounds,
                text,
                value
              ),
              to: NIF,
              as: :gui_color_bar_hue

  @doc """
  Color Picker control that avoids conversion to RGB on each call (multiple color controls)
  """
  @doc group: :advance_controls
  @spec color_picker_hsv(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          color_hsv :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate color_picker_hsv(
                bounds,
                text,
                color_hsv,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_color_picker_hsv

  @doc """
  Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()
  """
  @doc group: :advance_controls
  @spec color_panel_hsv(
          bounds :: Zexray.Type.Rectangle.t_all(),
          text :: binary,
          color_hsv :: Zexray.Type.Vector3.t_all(),
          return :: :auto | :value | :resource
        ) :: Zexray.Type.Vector3.t_nif()
  defdelegate color_panel_hsv(
                bounds,
                text,
                color_hsv,
                return \\ :auto
              ),
              to: NIF,
              as: :gui_color_panel_hsv
end
