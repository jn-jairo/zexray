defmodule Zexray.NIF.Gui do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_gui [
        # Global gui state control functions
        gui_enable: 0,
        gui_disable: 0,
        gui_lock: 0,
        gui_unlock: 0,
        gui_is_locked: 0,
        gui_set_alpha: 1,
        gui_set_state: 1,
        gui_get_state: 0,

        # Font set/get functions
        gui_set_font: 1,
        gui_get_font: 0,
        gui_get_font: 1,

        # Style set/get functions
        gui_set_style: 3,
        gui_set_style_color: 3,
        gui_get_style: 2,
        gui_get_style_color: 2,
        gui_get_style_color: 3,

        # Styles loading functions
        gui_load_style: 1,
        gui_load_style_default: 0,

        # Tooltips management functions
        gui_enable_tooltip: 0,
        gui_disable_tooltip: 0,
        gui_set_tooltip: 1,

        # Icons functionality
        gui_icon_text: 2,
        gui_set_icon_scale: 1,
        gui_get_icons: 0,
        gui_load_icons: 1,
        gui_draw_icon: 5,

        # Controls
        gui_window_box: 2,
        gui_group_box: 2,
        gui_line: 2,
        gui_panel: 2,
        gui_tab_bar: 3,
        gui_scroll_panel: 5,
        gui_scroll_panel: 6,

        # Basic controls set
        gui_label: 2,
        gui_button: 2,
        gui_label_button: 2,
        gui_toggle: 3,
        gui_toggle_group: 3,
        gui_toggle_slider: 3,
        gui_check_box: 3,
        gui_combo_box: 3,
        gui_dropdown_box: 4,
        gui_spinner: 6,
        gui_value_box: 6,
        gui_value_box_float: 5,
        gui_text_box: 4,
        gui_slider: 6,
        gui_slider_bar: 6,
        gui_progress_bar: 6,
        gui_status_bar: 2,
        gui_dummy_rec: 2,
        gui_grid: 5,
        gui_grid: 6,

        # Advance controls set
        gui_list_view: 4,
        gui_list_view_ex: 5,
        gui_message_box: 4,
        gui_text_input_box: 7,
        gui_color_picker: 3,
        gui_color_picker: 4,
        gui_color_panel: 3,
        gui_color_panel: 4,
        gui_color_bar_alpha: 3,
        gui_color_bar_hue: 3,
        gui_color_picker_hsv: 3,
        gui_color_picker_hsv: 4,
        gui_color_panel_hsv: 3,
        gui_color_panel_hsv: 4
      ]

      ########################################
      #  Global gui state control functions  #
      ########################################

      @doc """
      Enable gui controls (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiEnable(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_enable() :: :ok
      def gui_enable(), do: :erlang.nif_error(:undef)

      @doc """
      Disable gui controls (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiDisable(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_disable() :: :ok
      def gui_disable(), do: :erlang.nif_error(:undef)

      @doc """
      Lock gui controls (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiLock(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_lock() :: :ok
      def gui_lock(), do: :erlang.nif_error(:undef)

      @doc """
      Unlock gui controls (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiUnlock(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_unlock() :: :ok
      def gui_unlock(), do: :erlang.nif_error(:undef)

      @doc """
      Check if gui is locked (global state)

      ```c
      // raygui.h
      RAYGUIAPI bool GuiIsLocked(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_is_locked() :: boolean
      def gui_is_locked(), do: :erlang.nif_error(:undef)

      @doc """
      Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetAlpha(float alpha);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_set_alpha(alpha :: number) :: :ok
      def gui_set_alpha(_alpha), do: :erlang.nif_error(:undef)

      @doc """
      Set gui state (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetState(int state);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_set_state(state :: integer) :: :ok
      def gui_set_state(_state), do: :erlang.nif_error(:undef)

      @doc """
      Get gui state (global state)

      ```c
      // raygui.h
      RAYGUIAPI int GuiGetState(void);
      ```
      """
      @doc group: :gui_state_control
      @spec gui_get_state() :: integer
      def gui_get_state(), do: :erlang.nif_error(:undef)

      ############################
      #  Font set/get functions  #
      ############################

      @doc """
      Set gui custom font (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetFont(Font font);
      ```
      """
      @doc group: :gui_font
      @spec gui_set_font(font :: tuple) :: :ok
      def gui_set_font(_font), do: :erlang.nif_error(:undef)

      @doc """
      Get gui custom font (global state)

      ```c
      // raygui.h
      RAYGUIAPI Font GuiGetFont(void);
      ```
      """
      @doc group: :gui_font
      @spec gui_get_font(return :: :auto | :value | :resource) :: tuple
      def gui_get_font(_return \\ :auto), do: :erlang.nif_error(:undef)

      #############################
      #  Style set/get functions  #
      #############################

      @doc """
      Set one style property

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetStyle(int control, int property, int value);
      ```
      """
      @doc group: :gui_style
      @spec gui_set_style(
              control :: integer,
              property :: integer,
              value :: integer
            ) :: :ok
      def gui_set_style(
            _control,
            _property,
            _value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set one style property

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetStyle(int control, int property, int value);
      ```
      """
      @doc group: :gui_style
      @spec gui_set_style_color(
              control :: integer,
              property :: integer,
              color :: tuple
            ) :: :ok
      def gui_set_style_color(
            _control,
            _property,
            _color
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get one style property

      ```c
      // raygui.h
      RAYGUIAPI int GuiGetStyle(int control, int property);
      ```
      """
      @doc group: :gui_style
      @spec gui_get_style(
              control :: integer,
              property :: integer
            ) :: integer
      def gui_get_style(
            _control,
            _property
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Get one style property

      ```c
      // raygui.h
      RAYGUIAPI int GuiGetStyle(int control, int property);
      ```
      """
      @doc group: :gui_style
      @spec gui_get_style_color(
              control :: integer,
              property :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_get_style_color(
            _control,
            _property,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      ##############################
      #  Styles loading functions  #
      ##############################

      @doc """
      Load style file over global style variable (.rgs)

      ```c
      // raygui.h
      RAYGUIAPI void GuiLoadStyle(const char *fileName);
      ```
      """
      @doc group: :gui_style_loading
      @spec gui_load_style(file_name :: binary) :: :ok
      def gui_load_style(_file_name), do: :erlang.nif_error(:undef)

      @doc """
      Load style default over global style

      ```c
      // raygui.h
      RAYGUIAPI void GuiLoadStyleDefault(void);
      ```
      """
      @doc group: :gui_style_loading
      @spec gui_load_style_default() :: :ok
      def gui_load_style_default(), do: :erlang.nif_error(:undef)

      ###################################
      #  Tooltips management functions  #
      ###################################

      @doc """
      Enable gui tooltips (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiEnableTooltip(void);
      ```
      """
      @doc group: :gui_tooltips
      @spec gui_enable_tooltip() :: :ok
      def gui_enable_tooltip(), do: :erlang.nif_error(:undef)

      @doc """
      Disable gui tooltips (global state)

      ```c
      // raygui.h
      RAYGUIAPI void GuiDisableTooltip(void);
      ```
      """
      @doc group: :gui_tooltips
      @spec gui_disable_tooltip() :: :ok
      def gui_disable_tooltip(), do: :erlang.nif_error(:undef)

      @doc """
      Set tooltip string

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetTooltip(const char *tooltip);
      ```
      """
      @doc group: :gui_tooltips
      @spec gui_set_tooltip(tooltip :: binary) :: :ok
      def gui_set_tooltip(_tooltip), do: :erlang.nif_error(:undef)

      #########################
      #  Icons functionality  #
      #########################

      @doc """
      Get text with icon id prepended (if supported)

      ```c
      // raygui.h
      RAYGUIAPI const char *GuiIconText(int iconId, const char *text);
      ```
      """
      @doc group: :gui_icons
      @spec gui_icon_text(
              icon_id :: integer,
              text :: binary
            ) :: binary
      def gui_icon_text(
            _icon_id,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set default icon drawing size

      ```c
      // raygui.h
      RAYGUIAPI void GuiSetIconScale(int scale);
      ```
      """
      @doc group: :gui_icons
      @spec gui_set_icon_scale(scale :: number) :: :ok
      def gui_set_icon_scale(_scale), do: :erlang.nif_error(:undef)

      @doc """
      Get raygui icons data pointer

      ```c
      // raygui.h
      RAYGUIAPI unsigned int *GuiGetIcons(void);
      ```
      """
      @doc group: :gui_icons
      @spec gui_get_icons() :: [non_neg_integer]
      def gui_get_icons(), do: :erlang.nif_error(:undef)

      @doc """
      Load raygui icons file (.rgi) into internal icons data

      ```c
      // raygui.h
      RAYGUIAPI char **GuiLoadIcons(const char *fileName, bool loadIconsName);
      ```
      """
      @doc group: :gui_icons
      @spec gui_load_icons(file_name :: binary) :: :ok
      def gui_load_icons(_file_name), do: :erlang.nif_error(:undef)

      @doc """
      Draw icon using pixel size at specified position

      ```c
      // raygui.h
      RAYGUIAPI void GuiDrawIcon(int iconId, int posX, int posY, int pixelSize, Color color);
      ```
      """
      @doc group: :gui_icons
      @spec gui_draw_icon(
              icon_id :: integer,
              pox_x :: number,
              pox_y :: number,
              pixel_size :: number,
              color :: tuple
            ) :: :ok
      def gui_draw_icon(
            _icon_id,
            _pox_x,
            _pox_y,
            _pixel_size,
            _color
          ),
          do: :erlang.nif_error(:undef)

      ##############
      #  Controls  #
      ##############

      @doc """
      Window Box control, shows a window that can be closed

      ```c
      // raygui.h
      RAYGUIAPI int GuiWindowBox(Rectangle bounds, const char *title);
      ```
      """
      @doc group: :gui_controls
      @spec gui_window_box(
              bounds :: tuple,
              title :: binary
            ) :: boolean
      def gui_window_box(
            _bounds,
            _title
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Group Box control with text name

      ```c
      // raygui.h
      RAYGUIAPI int GuiGroupBox(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_controls
      @spec gui_group_box(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_group_box(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Line separator control, could contain text

      ```c
      // raygui.h
      RAYGUIAPI int GuiLine(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_controls
      @spec gui_line(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_line(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Panel control, useful to group controls

      ```c
      // raygui.h
      RAYGUIAPI int GuiPanel(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_controls
      @spec gui_panel(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_panel(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Tab Bar control, returns TAB to be closed or -1

      ```c
      // raygui.h
      RAYGUIAPI int GuiTabBar(Rectangle bounds, const char **text, int count, int *active);
      ```
      """
      @doc group: :gui_controls
      @spec gui_tab_bar(
              bounds :: tuple,
              text :: [binary],
              active :: integer
            ) :: {should_close :: false | integer, active :: integer}
      def gui_tab_bar(
            _bounds,
            _text,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Scroll Panel control

      ```c
      // raygui.h
      RAYGUIAPI int GuiScrollPanel(Rectangle bounds, const char *text, Rectangle content, Vector2 *scroll, Rectangle *view);
      ```
      """
      @doc group: :gui_controls
      @spec gui_scroll_panel(
              bounds :: tuple,
              text :: binary,
              content :: tuple,
              scroll :: tuple,
              view :: tuple,
              return :: :auto | :value | :resource
            ) :: {scroll :: tuple, view :: tuple}
      def gui_scroll_panel(
            _bounds,
            _text,
            _content,
            _scroll,
            _view,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      ########################
      #  Basic controls set  #
      ########################

      @doc """
      Label control

      ```c
      // raygui.h
      RAYGUIAPI int GuiLabel(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_label(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_label(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Button control, returns true when clicked

      ```c
      // raygui.h
      RAYGUIAPI int GuiButton(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_button(
              bounds :: tuple,
              text :: binary
            ) :: boolean
      def gui_button(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Label button control, returns true when clicked

      ```c
      // raygui.h
      RAYGUIAPI int GuiLabelButton(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_label_button(
              bounds :: tuple,
              text :: binary
            ) :: boolean
      def gui_label_button(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Toggle Button control

      ```c
      // raygui.h
      RAYGUIAPI int GuiToggle(Rectangle bounds, const char *text, bool *active);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_toggle(
              bounds :: tuple,
              text :: binary,
              active :: boolean
            ) :: boolean
      def gui_toggle(
            _bounds,
            _text,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Toggle Group control

      ```c
      // raygui.h
      RAYGUIAPI int GuiToggleGroup(Rectangle bounds, const char *text, int *active);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_toggle_group(
              bounds :: tuple,
              text :: binary,
              active :: integer
            ) :: integer
      def gui_toggle_group(
            _bounds,
            _text,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Toggle Slider control

      ```c
      // raygui.h
      RAYGUIAPI int GuiToggleSlider(Rectangle bounds, const char *text, int *active);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_toggle_slider(
              bounds :: tuple,
              text :: binary,
              active :: integer
            ) :: integer
      def gui_toggle_slider(
            _bounds,
            _text,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check Box control, returns true when active

      ```c
      // raygui.h
      RAYGUIAPI int GuiCheckBox(Rectangle bounds, const char *text, bool *checked);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_check_box(
              bounds :: tuple,
              text :: binary,
              checked :: boolean
            ) :: {changed :: boolean, checked :: boolean}
      def gui_check_box(
            _bounds,
            _text,
            _checked
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Combo Box control

      ```c
      // raygui.h
      RAYGUIAPI int GuiComboBox(Rectangle bounds, const char *text, int *active);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_combo_box(
              bounds :: tuple,
              text :: binary,
              active :: integer
            ) :: integer
      def gui_combo_box(
            _bounds,
            _text,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Dropdown Box control

      ```c
      // raygui.h
      RAYGUIAPI int GuiDropdownBox(Rectangle bounds, const char *text, int *active, bool editMode);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_dropdown_box(
              bounds :: tuple,
              text :: binary,
              active :: integer,
              edit_mode :: boolean
            ) :: {pressed :: boolean, active :: integer}
      def gui_dropdown_box(
            _bounds,
            _text,
            _active,
            _edit_mode
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Spinner control

      ```c
      // raygui.h
      RAYGUIAPI int GuiSpinner(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_spinner(
              bounds :: tuple,
              text :: binary,
              value :: number,
              min_value :: number,
              max_value :: number,
              edit_mode :: boolean
            ) :: {changed :: boolean, value :: integer}
      def gui_spinner(
            _bounds,
            _text,
            _value,
            _min_value,
            _max_value,
            _edit_mode
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Value Box control, updates input text with numbers

      ```c
      // raygui.h
      RAYGUIAPI int GuiValueBox(Rectangle bounds, const char *text, int *value, int minValue, int maxValue, bool editMode);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_value_box(
              bounds :: tuple,
              text :: binary,
              value :: number,
              min_value :: number,
              max_value :: number,
              edit_mode :: boolean
            ) :: {changed :: boolean, value :: integer}
      def gui_value_box(
            _bounds,
            _text,
            _value,
            _min_value,
            _max_value,
            _edit_mode
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Value box control for float values

      ```c
      // raygui.h
      RAYGUIAPI int GuiValueBoxFloat(Rectangle bounds, const char *text, char *textValue, float *value, bool editMode);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_value_box_float(
              bounds :: tuple,
              text :: binary,
              text_value :: binary,
              value :: number,
              edit_mode :: boolean
            ) :: {changed :: boolean, text_value :: binary, value :: float}
      def gui_value_box_float(
            _bounds,
            _text,
            _text_value,
            _value,
            _edit_mode
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Text Box control, updates input text

      ```c
      // raygui.h
      RAYGUIAPI int GuiTextBox(Rectangle bounds, char *text, int textSize, bool editMode);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_text_box(
              bounds :: tuple,
              text :: binary,
              text_max_size :: number,
              edit_mode :: boolean
            ) :: {changed :: boolean, text :: binary}
      def gui_text_box(
            _bounds,
            _text,
            _text_max_size,
            _edit_mode
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Slider control

      ```c
      // raygui.h
      RAYGUIAPI int GuiSlider(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_slider(
              bounds :: tuple,
              text_left :: binary,
              text_right :: binary,
              value :: number,
              min_value :: number,
              max_value :: number
            ) :: {changed :: boolean, value :: float}
      def gui_slider(
            _bounds,
            _text_left,
            _text_right,
            _value,
            _min_value,
            _max_value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Slider Bar control

      ```c
      // raygui.h
      RAYGUIAPI int GuiSliderBar(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_slider_bar(
              bounds :: tuple,
              text_left :: binary,
              text_right :: binary,
              value :: number,
              min_value :: number,
              max_value :: number
            ) :: {changed :: boolean, value :: float}
      def gui_slider_bar(
            _bounds,
            _text_left,
            _text_right,
            _value,
            _min_value,
            _max_value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Progress Bar control

      ```c
      // raygui.h
      RAYGUIAPI int GuiProgressBar(Rectangle bounds, const char *textLeft, const char *textRight, float *value, float minValue, float maxValue);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_progress_bar(
              bounds :: tuple,
              text_left :: binary,
              text_right :: binary,
              value :: number,
              min_value :: number,
              max_value :: number
            ) :: float
      def gui_progress_bar(
            _bounds,
            _text_left,
            _text_right,
            _value,
            _min_value,
            _max_value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Status Bar control, shows info text

      ```c
      // raygui.h
      RAYGUIAPI int GuiStatusBar(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_status_bar(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_status_bar(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Dummy control for placeholders

      ```c
      // raygui.h
      RAYGUIAPI int GuiDummyRec(Rectangle bounds, const char *text);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_dummy_rec(
              bounds :: tuple,
              text :: binary
            ) :: :ok
      def gui_dummy_rec(
            _bounds,
            _text
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Grid control

      ```c
      // raygui.h
      RAYGUIAPI int GuiGrid(Rectangle bounds, const char *text, float spacing, int subdivs, Vector2 *mouseCell);
      ```
      """
      @doc group: :gui_basic_controls
      @spec gui_grid(
              bounds :: tuple,
              text :: binary,
              spacing :: number,
              subdivs :: number,
              mouse_cell :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_grid(
            _bounds,
            _text,
            _spacing,
            _subdivs,
            _mouse_cell,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      ##########################
      #  Advance controls set  #
      ##########################

      @doc """
      List View control

      ```c
      // raygui.h
      RAYGUIAPI int GuiListView(Rectangle bounds, const char *text, int *scrollIndex, int *active);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_list_view(
              bounds :: tuple,
              text :: binary,
              scroll_index :: integer,
              active :: integer
            ) :: {scroll_index :: integer, active :: integer}
      def gui_list_view(
            _bounds,
            _text,
            _scroll_index,
            _active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      List View with extended parameters

      ```c
      // raygui.h
      RAYGUIAPI int GuiListViewEx(Rectangle bounds, const char **text, int count, int *scrollIndex, int *active, int *focus);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_list_view_ex(
              bounds :: tuple,
              text :: [binary],
              scroll_index :: integer,
              active :: integer,
              focus :: integer
            ) :: {scroll_index :: integer, active :: integer, focus :: integer}
      def gui_list_view_ex(
            _bounds,
            _text,
            _scroll_index,
            _active,
            _focus
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Message Box control, displays a message

      ```c
      // raygui.h
      RAYGUIAPI int GuiMessageBox(Rectangle bounds, const char *title, const char *message, const char *buttons);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_message_box(
              bounds :: tuple,
              title :: binary,
              message :: binary,
              buttons :: binary
            ) :: {should_close :: boolean, button_pressed :: false | integer}
      def gui_message_box(
            _bounds,
            _title,
            _message,
            _buttons
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Text Input Box control, ask for text, supports secret

      ```c
      // raygui.h
      RAYGUIAPI int GuiTextInputBox(Rectangle bounds, const char *title, const char *message, const char *buttons, char *text, int textMaxSize, bool *secretViewActive);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_text_input_box(
              bounds :: tuple,
              title :: binary,
              message :: binary,
              buttons :: binary,
              text :: binary,
              text_max_size :: number,
              secret_view_active :: nil | boolean
            ) ::
              {should_close :: boolean, button_pressed :: false | integer, text :: binary,
               secret_view_active :: nil | boolean}
      def gui_text_input_box(
            _bounds,
            _title,
            _message,
            _buttons,
            _text,
            _text_max_size,
            _secret_view_active
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Picker control (multiple color controls)

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorPicker(Rectangle bounds, const char *text, Color *color);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_picker(
              bounds :: tuple,
              text :: binary,
              color :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_color_picker(
            _bounds,
            _text,
            _color,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Panel control

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorPanel(Rectangle bounds, const char *text, Color *color);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_panel(
              bounds :: tuple,
              text :: binary,
              color :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_color_panel(
            _bounds,
            _text,
            _color,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Bar Alpha control

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorBarAlpha(Rectangle bounds, const char *text, float *alpha);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_bar_alpha(
              bounds :: tuple,
              text :: binary,
              alpha :: number
            ) :: float
      def gui_color_bar_alpha(
            _bounds,
            _text,
            _alpha
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Bar Hue control

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorBarHue(Rectangle bounds, const char *text, float *value);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_bar_hue(
              bounds :: tuple,
              text :: binary,
              value :: number
            ) :: float
      def gui_color_bar_hue(
            _bounds,
            _text,
            _value
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Picker control that avoids conversion to RGB on each call (multiple color controls)

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorPickerHSV(Rectangle bounds, const char *text, Vector3 *colorHsv);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_picker_hsv(
              bounds :: tuple,
              text :: binary,
              color_hsv :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_color_picker_hsv(
            _bounds,
            _text,
            _color_hsv,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Color Panel control that updates Hue-Saturation-Value color value, used by GuiColorPickerHSV()

      ```c
      // raygui.h
      RAYGUIAPI int GuiColorPanelHSV(Rectangle bounds, const char *text, Vector3 *colorHsv);
      ```
      """
      @doc group: :gui_advance_controls
      @spec gui_color_panel_hsv(
              bounds :: tuple,
              text :: binary,
              color_hsv :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gui_color_panel_hsv(
            _bounds,
            _text,
            _color_hsv,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
