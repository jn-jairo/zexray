defmodule Zexray.Enum.PixelFormat do
  @moduledoc """
  Pixel values

  NOTE: Support depends on OpenGL version and platform

  ## Values

  | id | name                       | bpp | description                        |
  | -- | -------------------------- | --- | ---------------------------------- |
  |  1 | :uncompressed_grayscale    |   8 | 8 bit per pixel (no alpha)         |
  |  2 | :uncompressed_gray_alpha   |  16 | 8*2 bpp (2 channels)               |
  |  3 | :uncompressed_r5g6b5       |  16 | 16 bpp                             |
  |  4 | :uncompressed_r8g8b8       |  24 | 24 bpp                             |
  |  5 | :uncompressed_r5g5b5a1     |  16 | 16 bpp (1 bit alpha)               |
  |  6 | :uncompressed_r4g4b4a4     |  16 | 16 bpp (4 bit alpha)               |
  |  7 | :uncompressed_r8g8b8a8     |  32 | 32 bpp                             |
  |  8 | :uncompressed_r32          |  32 | 32 bpp (1 channel - float)         |
  |  9 | :uncompressed_r32g32b32    |  96 | 32*3 bpp (3 channels - float)      |
  | 10 | :uncompressed_r32g32b32a32 | 128 | 32*4 bpp (4 channels - float)      |
  | 11 | :uncompressed_r16          |  16 | 16 bpp (1 channel - half float)    |
  | 12 | :uncompressed_r16g16b16    |  48 | 16*3 bpp (3 channels - half float) |
  | 13 | :uncompressed_r16g16b16a16 |  64 | 16*4 bpp (4 channels - half float) |
  | 14 | :compressed_dxt1_rgb       |   4 | 4 bpp (no alpha)                   |
  | 15 | :compressed_dxt1_rgba      |   4 | 4 bpp (1 bit alpha)                |
  | 16 | :compressed_dxt3_rgba      |   8 | 8 bpp                              |
  | 17 | :compressed_dxt5_rgba      |   8 | 8 bpp                              |
  | 18 | :compressed_etc1_rgb       |   4 | 4 bpp                              |
  | 19 | :compressed_etc2_rgb       |   4 | 4 bpp                              |
  | 20 | :compressed_etc2_eac_rgba  |   8 | 8 bpp                              |
  | 21 | :compressed_pvrt_rgb       |   4 | 4 bpp                              |
  | 22 | :compressed_pvrt_rgba      |   4 | 4 bpp                              |
  | 23 | :compressed_astc_4x4_rgba  |   8 | 8 bpp                              |
  | 24 | :compressed_astc_8x8_rgba  |   2 | 2 bpp                              |
  """

  use Zexray.Enum.EnumBase,
    prefix: "pixel_format",
    values: %{
      uncompressed_grayscale: 1,
      uncompressed_gray_alpha: 2,
      uncompressed_r5g6b5: 3,
      uncompressed_r8g8b8: 4,
      uncompressed_r5g5b5a1: 5,
      uncompressed_r4g4b4a4: 6,
      uncompressed_r8g8b8a8: 7,
      uncompressed_r32: 8,
      uncompressed_r32g32b32: 9,
      uncompressed_r32g32b32a32: 10,
      uncompressed_r16: 11,
      uncompressed_r16g16b16: 12,
      uncompressed_r16g16b16a16: 13,
      compressed_dxt1_rgb: 14,
      compressed_dxt1_rgba: 15,
      compressed_dxt3_rgba: 16,
      compressed_dxt5_rgba: 17,
      compressed_etc1_rgb: 18,
      compressed_etc2_rgb: 19,
      compressed_etc2_eac_rgba: 20,
      compressed_pvrt_rgb: 21,
      compressed_pvrt_rgba: 22,
      compressed_astc_4x4_rgba: 23,
      compressed_astc_8x8_rgba: 24
    }
end
