defmodule Zexray.Constant do
  @moduledoc """
  Constant
  """

  alias Zexray.NIF

  #####################
  #  AutomationEvent  #
  #####################

  @doc """
  Get automation event max params for AutomationEvent.params
  """
  @spec automation_event_max_params() :: non_neg_integer
  defdelegate automation_event_max_params(), to: NIF, as: :get_automation_event_max_params

  #########################
  #  AutomationEventList  #
  #########################

  @doc """
  Get automation event list max automation events for AutomationEventList.events
  """
  @spec automation_event_list_max_automation_events() :: non_neg_integer
  defdelegate automation_event_list_max_automation_events(),
    to: NIF,
    as: :get_automation_event_list_max_automation_events

  ##############
  #  BoneInfo  #
  ##############

  @doc """
  Get bone info max name for BoneInfo.name
  """
  @spec bone_info_max_name() :: non_neg_integer
  defdelegate bone_info_max_name(), to: NIF, as: :get_bone_info_max_name

  ##################
  #  FilePathList  #
  ##################

  @doc """
  Get file path list max filepath capacity for FilePathList.paths
  """
  @spec file_path_list_max_filepath_capacity() :: non_neg_integer
  defdelegate file_path_list_max_filepath_capacity(),
    to: NIF,
    as: :get_file_path_list_max_filepath_capacity

  @doc """
  Get file path list max filepath length for FilePathList.paths
  """
  @spec file_path_list_max_filepath_length() :: non_neg_integer
  defdelegate file_path_list_max_filepath_length(),
    to: NIF,
    as: :get_file_path_list_max_filepath_length

  #########
  #  Gui  #
  #########

  @doc """
  Maximum number of icons
  """
  @spec gui_icon_max_icons() :: non_neg_integer
  defdelegate gui_icon_max_icons(),
    to: NIF,
    as: :get_gui_icon_max_icons

  @doc """
  Size of icons in pixels (squared)
  """
  @spec gui_icon_size() :: non_neg_integer
  defdelegate gui_icon_size(),
    to: NIF,
    as: :get_gui_icon_size

  @doc """
  Icons data is defined by bit array (every bit represents one pixel)

  Those arrays are stored as unsigned int data arrays, so,
  every array element defines 32 pixels (bits) of information

  One icon is defined by 8 int, (8 int * 32 bit = 256 bit = 16*16 pixels)

  NOTE: Number of elemens depend on gui_icon_size (by default 16x16 pixels)
  """
  @spec gui_icon_data_elements() :: non_neg_integer
  defdelegate gui_icon_data_elements(),
    to: NIF,
    as: :get_gui_icon_data_elements

  @doc """
  Maximum number of chars for value box (number as text)
  """
  @spec gui_valuebox_max_chars() :: non_neg_integer
  defdelegate gui_valuebox_max_chars(),
    to: NIF,
    as: :get_gui_valuebox_max_chars

  ##############
  #  Material  #
  ##############

  @doc """
  Get material max maps for Material.maps
  """
  @spec material_max_maps() :: non_neg_integer
  defdelegate material_max_maps(), to: NIF, as: :get_material_max_maps

  @doc """
  Get material max params for Material.params
  """
  @spec material_max_params() :: non_neg_integer
  defdelegate material_max_params(), to: NIF, as: :get_material_max_params

  ##########
  #  Mesh  #
  ##########

  @doc """
  Get mesh max vertex buffers for Mesh.vbo_id
  """
  @spec mesh_max_vertex_buffers() :: non_neg_integer
  defdelegate mesh_max_vertex_buffers(), to: NIF, as: :get_mesh_max_vertex_buffers

  ####################
  #  ModelAnimation  #
  ####################

  @doc """
  Get model animation max name for ModelAnimation.name
  """
  @spec model_animation_max_name() :: non_neg_integer
  defdelegate model_animation_max_name(), to: NIF, as: :get_model_animation_max_name

  ############
  #  Shader  #
  ############

  @doc """
  Get shader max locations for Shader.locs
  """
  @spec shader_max_locations() :: non_neg_integer
  defdelegate shader_max_locations(), to: NIF, as: :get_shader_max_locations

  #################
  #  SoundStream  #
  #################

  @doc """
  Get sound stream max position state for SoundStream.position_state
  """
  @spec sound_stream_max_position_state() :: non_neg_integer
  defdelegate sound_stream_max_position_state(), to: NIF, as: :get_sound_stream_max_position_state

  ##################
  #  VrDeviceInfo  #
  ##################

  @doc """
  Get vr device info max lens distortion values for VrDeviceInfo.lensDistortionValues
  """
  @spec vr_device_info_max_lens_distortion_values() :: non_neg_integer
  defdelegate vr_device_info_max_lens_distortion_values(),
    to: NIF,
    as: :get_vr_device_info_max_lens_distortion_values

  @doc """
  Get vr device info max chroma ab correction for VrDeviceInfo.chromaAbCorrection
  """
  @spec vr_device_info_max_chroma_ab_correction() :: non_neg_integer
  defdelegate vr_device_info_max_chroma_ab_correction(),
    to: NIF,
    as: :get_vr_device_info_max_chroma_ab_correction

  ####################
  #  VrStereoConfig  #
  ####################

  @doc """
  Get vr stereo config max projection for VrStereoConfig.projection
  """
  @spec vr_stereo_config_max_projection() :: non_neg_integer
  defdelegate vr_stereo_config_max_projection(), to: NIF, as: :get_vr_stereo_config_max_projection

  @doc """
  Get vr stereo config max view offset for VrStereoConfig.viewOffset
  """
  @spec vr_stereo_config_max_view_offset() :: non_neg_integer
  defdelegate vr_stereo_config_max_view_offset(),
    to: NIF,
    as: :get_vr_stereo_config_max_view_offset

  @doc """
  Get vr stereo config max left lens center for VrStereoConfig.leftLensCenter
  """
  @spec vr_stereo_config_max_left_lens_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_left_lens_center(),
    to: NIF,
    as: :get_vr_stereo_config_max_left_lens_center

  @doc """
  Get vr stereo config max right lens center for VrStereoConfig.rightLensCenter
  """
  @spec vr_stereo_config_max_right_lens_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_right_lens_center(),
    to: NIF,
    as: :get_vr_stereo_config_max_right_lens_center

  @doc """
  Get vr stereo config max left screen center for VrStereoConfig.leftScreenCenter
  """
  @spec vr_stereo_config_max_left_screen_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_left_screen_center(),
    to: NIF,
    as: :get_vr_stereo_config_max_left_screen_center

  @doc """
  Get vr stereo config max right screen center for VrStereoConfig.rightScreenCenter
  """
  @spec vr_stereo_config_max_right_screen_center() :: non_neg_integer
  defdelegate vr_stereo_config_max_right_screen_center(),
    to: NIF,
    as: :get_vr_stereo_config_max_right_screen_center

  @doc """
  Get vr stereo config max scale for VrStereoConfig.scale
  """
  @spec vr_stereo_config_max_scale() :: non_neg_integer
  defdelegate vr_stereo_config_max_scale(), to: NIF, as: :get_vr_stereo_config_max_scale

  @doc """
  Get vr stereo config max scale in for VrStereoConfig.scaleIn
  """
  @spec vr_stereo_config_max_scale_in() :: non_neg_integer
  defdelegate vr_stereo_config_max_scale_in(), to: NIF, as: :get_vr_stereo_config_max_scale_in
end
