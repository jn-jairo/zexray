defmodule Zexray.NIF.Constant do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_constant [
        # AutomationEvent
        get_automation_event_max_params: 0,

        # AutomationEventList
        get_automation_event_list_max_automation_events: 0,

        # BoneInfo
        get_bone_info_max_name: 0,

        # FilePathList
        get_file_path_list_max_filepath_capacity: 0,
        get_file_path_list_max_filepath_length: 0,

        # Gui
        get_gui_icon_max_icons: 0,
        get_gui_icon_size: 0,
        get_gui_icon_data_elements: 0,
        get_gui_valuebox_max_chars: 0,

        # Material
        get_material_max_maps: 0,
        get_material_max_params: 0,

        # Mesh
        get_mesh_max_vertex_buffers: 0,

        # ModelAnimation
        get_model_animation_max_name: 0,

        # Shader
        get_shader_max_locations: 0,

        # VrDeviceInfo
        get_vr_device_info_max_lens_distortion_values: 0,
        get_vr_device_info_max_chroma_ab_correction: 0,

        # VrStereoConfig
        get_vr_stereo_config_max_projection: 0,
        get_vr_stereo_config_max_view_offset: 0,
        get_vr_stereo_config_max_left_lens_center: 0,
        get_vr_stereo_config_max_right_lens_center: 0,
        get_vr_stereo_config_max_left_screen_center: 0,
        get_vr_stereo_config_max_right_screen_center: 0,
        get_vr_stereo_config_max_scale: 0,
        get_vr_stereo_config_max_scale_in: 0
      ]

      #####################
      #  AutomationEvent  #
      #####################

      @doc """
      Get automation event max params for AutomationEvent.params
      """
      @doc group: :automation_event
      @spec get_automation_event_max_params() :: non_neg_integer
      def get_automation_event_max_params(), do: :erlang.nif_error(:undef)

      #########################
      #  AutomationEventList  #
      #########################

      @doc """
      Get automation event list max automation events for AutomationEventList.events
      """
      @doc group: :automation_event
      @spec get_automation_event_list_max_automation_events() :: non_neg_integer
      def get_automation_event_list_max_automation_events(), do: :erlang.nif_error(:undef)

      ##############
      #  BoneInfo  #
      ##############

      @doc """
      Get bone info max name for BoneInfo.name
      """
      @doc group: :model
      @spec get_bone_info_max_name() :: non_neg_integer
      def get_bone_info_max_name(), do: :erlang.nif_error(:undef)

      ##################
      #  FilePathList  #
      ##################

      @doc """
      Get file path list max filepath capacity for FilePathList.paths
      """
      @doc group: :file_system
      @spec get_file_path_list_max_filepath_capacity() :: non_neg_integer
      def get_file_path_list_max_filepath_capacity(), do: :erlang.nif_error(:undef)

      @doc """
      Get file path list max filepath length for FilePathList.paths
      """
      @doc group: :file_system
      @spec get_file_path_list_max_filepath_length() :: non_neg_integer
      def get_file_path_list_max_filepath_length(), do: :erlang.nif_error(:undef)

      #########
      #  Gui  #
      #########

      @doc """
      Maximum number of icons
      """
      @doc group: :file_system
      @spec get_gui_icon_max_icons() :: non_neg_integer
      def get_gui_icon_max_icons(), do: :erlang.nif_error(:undef)

      @doc """
      Size of icons in pixels (squared)
      """
      @doc group: :file_system
      @spec get_gui_icon_size() :: non_neg_integer
      def get_gui_icon_size(), do: :erlang.nif_error(:undef)

      @doc """
      Icons data is defined by bit array (every bit represents one pixel)

      Those arrays are stored as unsigned int data arrays, so,
      every array element defines 32 pixels (bits) of information

      One icon is defined by 8 int, (8 int * 32 bit = 256 bit = 16*16 pixels)

      NOTE: Number of elemens depend on RAYGUI_ICON_SIZE (by default 16x16 pixels)
      """
      @doc group: :file_system
      @spec get_gui_icon_data_elements() :: non_neg_integer
      def get_gui_icon_data_elements(), do: :erlang.nif_error(:undef)

      @doc """
      Value box max chars
      """
      @doc group: :file_system
      @spec get_gui_valuebox_max_chars() :: non_neg_integer
      def get_gui_valuebox_max_chars(), do: :erlang.nif_error(:undef)

      ##############
      #  Material  #
      ##############

      @doc """
      Get material max maps for Material.maps

      ```c
      // config.h
      MAX_MATERIAL_MAPS
      ```
      """
      @doc group: :material
      @spec get_material_max_maps() :: non_neg_integer
      def get_material_max_maps(), do: :erlang.nif_error(:undef)

      @doc """
      Get material max params for Material.params
      """
      @doc group: :material
      @spec get_material_max_params() :: non_neg_integer
      def get_material_max_params(), do: :erlang.nif_error(:undef)

      ##########
      #  Mesh  #
      ##########

      @doc """
      Get mesh max vertex buffers for Mesh.vbo_id

      ```c
      // config.h
      MAX_MESH_VERTEX_BUFFERS
      ```
      """
      @doc group: :mesh
      @spec get_mesh_max_vertex_buffers() :: non_neg_integer
      def get_mesh_max_vertex_buffers(), do: :erlang.nif_error(:undef)

      ####################
      #  ModelAnimation  #
      ####################

      @doc """
      Get model animation max name for ModelAnimation.name
      """
      @doc group: :model
      @spec get_model_animation_max_name() :: non_neg_integer
      def get_model_animation_max_name(), do: :erlang.nif_error(:undef)

      ############
      #  Shader  #
      ############

      @doc """
      Get shader max locations for Shader.locs

      ```c
      // config.h
      RL_MAX_SHADER_LOCATIONS
      ```
      """
      @doc group: :shader
      @spec get_shader_max_locations() :: non_neg_integer
      def get_shader_max_locations(), do: :erlang.nif_error(:undef)

      ##################
      #  VrDeviceInfo  #
      ##################

      @doc """
      Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
      """
      @doc group: :vr
      @spec get_vr_device_info_max_lens_distortion_values() :: non_neg_integer
      def get_vr_device_info_max_lens_distortion_values(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
      """
      @doc group: :vr
      @spec get_vr_device_info_max_chroma_ab_correction() :: non_neg_integer
      def get_vr_device_info_max_chroma_ab_correction(), do: :erlang.nif_error(:undef)

      ####################
      #  VrStereoConfig  #
      ####################

      @doc """
      Get vr stereo config max projection for VrStereoConfig.projection
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_projection() :: non_neg_integer
      def get_vr_stereo_config_max_projection(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max view offset for VrStereoConfig.viewOffset
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_view_offset() :: non_neg_integer
      def get_vr_stereo_config_max_view_offset(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_left_lens_center() :: non_neg_integer
      def get_vr_stereo_config_max_left_lens_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_right_lens_center() :: non_neg_integer
      def get_vr_stereo_config_max_right_lens_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_left_screen_center() :: non_neg_integer
      def get_vr_stereo_config_max_left_screen_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_right_screen_center() :: non_neg_integer
      def get_vr_stereo_config_max_right_screen_center(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max scale for VrStereoConfig.scale
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_scale() :: non_neg_integer
      def get_vr_stereo_config_max_scale(), do: :erlang.nif_error(:undef)

      @doc """
      Get vr stereo config max scale in for VrStereoConfig.scaleIn
      """
      @doc group: :vr
      @spec get_vr_stereo_config_max_scale_in() :: non_neg_integer
      def get_vr_stereo_config_max_scale_in(), do: :erlang.nif_error(:undef)
    end
  end
end
