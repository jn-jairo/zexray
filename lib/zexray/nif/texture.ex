defmodule Zexray.NIF.Texture do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @nifs_texture [
        # Texture loading
        load_texture: 1,
        load_texture: 2,
        load_texture_from_image: 1,
        load_texture_from_image: 2,
        load_texture_cubemap: 2,
        load_texture_cubemap: 3,
        load_render_texture: 2,
        load_render_texture: 3,
        is_texture_valid: 1,
        is_render_texture_valid: 1,
        update_texture: 2,
        update_texture_rec: 3,

        # Texture configuration
        gen_texture_mipmaps: 1,
        gen_texture_mipmaps: 2,
        set_texture_filter: 2,
        set_texture_wrap: 2,

        # Texture drawing
        draw_texture: 4,
        draw_texture_v: 3,
        draw_texture_ex: 5,
        draw_texture_rec: 4,
        draw_texture_pro: 6,
        draw_texture_n_patch: 6
      ]

      #####################
      #  Texture loading  #
      #####################

      @doc """
      Load texture from file into GPU memory (VRAM)

      ```c
      // raylib.h
      RLAPI Texture2D LoadTexture(const char *fileName);
      ```
      """
      @doc group: :texture_loading
      @spec load_texture(
              file_name :: binary,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_texture(
            _file_name,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load texture from image data

      ```c
      // raylib.h
      RLAPI Texture2D LoadTextureFromImage(Image image);
      ```
      """
      @doc group: :texture_loading
      @spec load_texture_from_image(
              image :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_texture_from_image(
            _image,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load cubemap from image, multiple image cubemap layouts supported

      ```c
      // raylib.h
      RLAPI TextureCubemap LoadTextureCubemap(Image image, int layout);
      ```
      """
      @doc group: :texture_loading
      @spec load_texture_cubemap(
              image :: tuple,
              layout :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_texture_cubemap(
            _image,
            _layout,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Load texture for rendering (framebuffer)

      ```c
      // raylib.h
      RLAPI RenderTexture2D LoadRenderTexture(int width, int height);
      ```
      """
      @doc group: :texture_loading
      @spec load_render_texture(
              width :: integer,
              height :: integer,
              return :: :auto | :value | :resource
            ) :: tuple
      def load_render_texture(
            _width,
            _height,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Check if a texture is valid (loaded in GPU)

      ```c
      // raylib.h
      RLAPI bool IsTextureValid(Texture2D texture);
      ```
      """
      @doc group: :texture_loading
      @spec is_texture_valid(texture :: tuple) :: boolean
      def is_texture_valid(_texture), do: :erlang.nif_error(:undef)

      @doc """
      Check if a render texture is valid (loaded in GPU)

      ```c
      // raylib.h
      RLAPI bool IsRenderTextureValid(RenderTexture2D target);
      ```
      """
      @doc group: :texture_loading
      @spec is_render_texture_valid(target :: tuple) :: boolean
      def is_render_texture_valid(_target), do: :erlang.nif_error(:undef)

      @doc """
      Update GPU texture with new data

      ```c
      // raylib.h
      RLAPI void UpdateTexture(Texture2D texture, const void *pixels);
      ```
      """
      @doc group: :texture_loading
      @spec update_texture(
              texture :: tuple,
              pixels :: binary
            ) :: :ok
      def update_texture(
            _texture,
            _pixels
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Update GPU texture rectangle with new data

      ```c
      // raylib.h
      RLAPI void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);
      ```
      """
      @doc group: :texture_loading
      @spec update_texture_rec(
              texture :: tuple,
              rec :: tuple,
              pixels :: binary
            ) :: :ok
      def update_texture_rec(
            _texture,
            _rec,
            _pixels
          ),
          do: :erlang.nif_error(:undef)

      ###########################
      #  Texture configuration  #
      ###########################

      @doc """
      Generate GPU mipmaps for a texture

      ```c
      // raylib.h
      RLAPI void GenTextureMipmaps(Texture2D *texture);
      ```
      """
      @doc group: :texture_configuration
      @spec gen_texture_mipmaps(
              texture :: tuple,
              return :: :auto | :value | :resource
            ) :: tuple
      def gen_texture_mipmaps(
            _texture,
            _return \\ :auto
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set texture scaling filter mode

      ```c
      // raylib.h
      RLAPI void SetTextureFilter(Texture2D texture, int filter);
      ```
      """
      @doc group: :texture_configuration
      @spec set_texture_filter(
              texture :: tuple,
              filter :: integer
            ) :: :ok
      def set_texture_filter(
            _texture,
            _filter
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Set texture wrapping mode

      ```c
      // raylib.h
      RLAPI void SetTextureWrap(Texture2D texture, int wrap);
      ```
      """
      @doc group: :texture_configuration
      @spec set_texture_wrap(
              texture :: tuple,
              wrap :: integer
            ) :: :ok
      def set_texture_wrap(
            _texture,
            _wrap
          ),
          do: :erlang.nif_error(:undef)

      #####################
      #  Texture drawing  #
      #####################

      @doc """
      Draw a Texture2D

      ```c
      // raylib.h
      RLAPI void DrawTexture(Texture2D texture, int posX, int posY, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture(
              texture :: tuple,
              pos_x :: integer,
              pos_y :: integer,
              tint :: tuple
            ) :: :ok
      def draw_texture(
            _texture,
            _pos_x,
            _pos_y,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a Texture2D with position defined as Vector2

      ```c
      // raylib.h
      RLAPI void DrawTextureV(Texture2D texture, Vector2 position, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture_v(
              texture :: tuple,
              position :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_texture_v(
            _texture,
            _position,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a Texture2D with extended parameters

      ```c
      // raylib.h
      RLAPI void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture_ex(
              texture :: tuple,
              position :: tuple,
              rotation :: number,
              scale :: number,
              tint :: tuple
            ) :: :ok
      def draw_texture_ex(
            _texture,
            _position,
            _rotation,
            _scale,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a part of a texture defined by a rectangle

      ```c
      // raylib.h
      RLAPI void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture_rec(
              texture :: tuple,
              source :: tuple,
              position :: tuple,
              tint :: tuple
            ) :: :ok
      def draw_texture_rec(
            _texture,
            _source,
            _position,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draw a part of a texture defined by a rectangle with 'pro' parameters

      ```c
      // raylib.h
      RLAPI void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture_pro(
              texture :: tuple,
              source :: tuple,
              dest :: tuple,
              origin :: tuple,
              rotation :: number,
              tint :: tuple
            ) :: :ok
      def draw_texture_pro(
            _texture,
            _source,
            _dest,
            _origin,
            _rotation,
            _tint
          ),
          do: :erlang.nif_error(:undef)

      @doc """
      Draws a texture (or part of it) that stretches or shrinks nicely

      ```c
      // raylib.h
      RLAPI void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint);
      ```
      """
      @doc group: :texture_drawing
      @spec draw_texture_n_patch(
              texture :: tuple,
              n_patch_info :: tuple,
              dest :: tuple,
              origin :: tuple,
              rotation :: number,
              tint :: tuple
            ) :: :ok
      def draw_texture_n_patch(
            _texture,
            _n_patch_info,
            _dest,
            _origin,
            _rotation,
            _tint
          ),
          do: :erlang.nif_error(:undef)
    end
  end
end
