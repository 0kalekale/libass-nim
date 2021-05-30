##
##  Copyright (C) 2006 Evgeniy Stepanov <eugeni.stepanov@gmail.com>
##  Copyright (C) 2011 Grigori Goronzy <greg@chown.ath.cx>
##
##  This file is part of libass.
##
##  Permission to use, copy, modify, and distribute this software for any
##  purpose with or without fee is hereby granted, provided that the above
##  copyright notice and this permission notice appear in all copies.
##
##  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
##  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
##  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
##  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
##  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
##  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
##  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
##

## !!!Ignored construct:  # LIBASS_ASS_H [NewLine] # LIBASS_ASS_H [NewLine] # < stdio . h > [NewLine] # < stdarg . h > [NewLine] # ass_types.h [NewLine] # LIBASS_VERSION 0x01501000 [NewLine]
##  A linked list of images produced by an ass renderer.
##
##  These images have to be rendered in-order for the correct screen
##  composition.  The libass renderer clips these bitmaps to the frame size.
##  w/h can be zero, in this case the bitmap should not be rendered at all.
##  The last bitmap row is not guaranteed to be padded up to stride size,
##  e.g. in the worst case a bitmap has the size stride * (h - 1) + w.
##  typedef struct ass_image { int w , h ;  Bitmap width/height int stride ;  Bitmap stride unsigned char * bitmap ;  1bpp stride*h alpha buffer
##  Note: the last row may not be padded to
##  bitmap stride! uint32_t color ;  Bitmap color and alpha, RGBA int dst_x , dst_y ;  Bitmap placement inside the video frame struct ass_image * next ;  Next image, or NULL enum { IMAGE_TYPE_CHARACTER , IMAGE_TYPE_OUTLINE , IMAGE_TYPE_SHADOW } type ;  New fields can be added here in new ABI-compatible library releases. } ASS_Image ;
## Error: identifier expected, but got: {!!!

##
##  Hinting type. (see ass_set_hinting below)
##
##  Setting hinting to anything but ASS_HINTING_NONE will put libass in a mode
##  that reduces compatibility with vsfilter and many ASS scripts. The main
##  problem is that hinting conflicts with smooth scaling, which precludes
##  animations and precise positioning.
##
##  In other words, enabling hinting might break some scripts severely.
##
##  FreeType's native hinter is still buggy sometimes and it is recommended
##  to use the light autohinter, ASS_HINTING_LIGHT, instead.  For best
##  compatibility with problematic fonts, disable hinting.
##

type
  ass_imageASS_Hinting* {.size: sizeof(cint).} = enum
    ASS_HINTING_NONE = 0, ASS_HINTING_LIGHT, ASS_HINTING_NORMAL, ASS_HINTING_NATIVE


## *
##  \brief Text shaping levels.
##
##  SIMPLE is a fast, font-agnostic shaper that can do only substitutions.
##  COMPLEX is a slower shaper using OpenType for substitutions and positioning.
##
##  libass uses the best shaper available by default.
##

type
  ass_imageASS_ShapingLevel* {.size: sizeof(cint).} = enum
    ASS_SHAPING_SIMPLE = 0, ASS_SHAPING_COMPLEX


## *
##  \brief Style override options. See
##  ass_set_selective_style_override_enabled() for details.
##

## !!!Ignored construct:  typedef enum { *
##  Default mode (with no other bits set). All selective override features
##  as well as the style set with ass_set_selective_style_override() are
##  disabled, but traditional overrides like ass_set_font_scale() are
##  applied unconditionally.
##  ASS_OVERRIDE_DEFAULT = 0 , *
##  Apply the style as set with ass_set_selective_style_override() on events
##  which look like dialogue. Other style overrides are also applied this
##  way, except ass_set_font_scale(). How ass_set_font_scale() is applied
##  depends on the ASS_OVERRIDE_BIT_SELECTIVE_FONT_SCALE flag.
##
##  This is equivalent to setting all of the following bits:
##
##  ASS_OVERRIDE_BIT_FONT_NAME
##  ASS_OVERRIDE_BIT_FONT_SIZE_FIELDS
##  ASS_OVERRIDE_BIT_COLORS
##  ASS_OVERRIDE_BIT_BORDER
##  ASS_OVERRIDE_BIT_ATTRIBUTES
##  ASS_OVERRIDE_BIT_STYLE = 1 << 0 , *
##  Apply ass_set_font_scale() only on events which look like dialogue.
##  If not set, the font scale is applied to all events. (The behavior and
##  name of this flag are unintuitive, but exist for compatibility)
##  ASS_OVERRIDE_BIT_SELECTIVE_FONT_SCALE = 1 << 1 , *
##  Old alias for ASS_OVERRIDE_BIT_SELECTIVE_FONT_SCALE. Deprecated. Do not use.
##  ASS_OVERRIDE_BIT_FONT_SIZE ASS_DEPRECATED_ENUM ( replaced by ASS_OVERRIDE_BIT_SELECTIVE_FONT_SCALE ) = 1 << 1 , *
##  On dialogue events override: FontSize, Spacing, Blur, ScaleX, ScaleY
##  ASS_OVERRIDE_BIT_FONT_SIZE_FIELDS = 1 << 2 , *
##  On dialogue events override: FontName, treat_fontname_as_pattern
##  ASS_OVERRIDE_BIT_FONT_NAME = 1 << 3 , *
##  On dialogue events override: PrimaryColour, SecondaryColour, OutlineColour, BackColour
##  ASS_OVERRIDE_BIT_COLORS = 1 << 4 , *
##  On dialogue events override: Bold, Italic, Underline, StrikeOut
##  ASS_OVERRIDE_BIT_ATTRIBUTES = 1 << 5 , *
##  On dialogue events override: BorderStyle, Outline, Shadow
##  ASS_OVERRIDE_BIT_BORDER = 1 << 6 , *
##  On dialogue events override: Alignment
##  ASS_OVERRIDE_BIT_ALIGNMENT = 1 << 7 , *
##  On dialogue events override: MarginL, MarginR, MarginV
##  ASS_OVERRIDE_BIT_MARGINS = 1 << 8 , *
##  Unconditionally replace all fields of all styles with the one provided
##  with ass_set_selective_style_override().
##  Does not apply ASS_OVERRIDE_BIT_SELECTIVE_FONT_SCALE.
##  Add ASS_OVERRIDE_BIT_FONT_SIZE_FIELDS and ASS_OVERRIDE_BIT_BORDER if
##  you want FontSize, Spacing, Outline, Shadow to be scaled to the script
##  resolution given by the ASS_Track.
##  ASS_OVERRIDE_FULL_STYLE = 1 << 9 , *
##  On dialogue events override: Justify
##  ASS_OVERRIDE_BIT_JUSTIFY = 1 << 10 ,  New enum values can be added here in new ABI-compatible library releases. } ASS_OverrideBits ;
## Error: expected '}'!!!

## *
##  \brief Return the version of library. This returns the value LIBASS_VERSION
##  was set to when the library was compiled.
##  \return library version
##

proc ass_library_version*(): cint {.importc: "ass_library_version", header: "ass.h".}
## *
##  \brief Default Font provider to load fonts in libass' database
##
##  NONE don't use any default font provider for font lookup
##  AUTODETECT use the first available font provider
##  CORETEXT force a CoreText based font provider (OS X only)
##  FONTCONFIG force a Fontconfig based font provider
##
##  libass uses the best shaper available by default.
##

type ## *
    ##  Enable libass extensions that would display ASS subtitles incorrectly.
    ##  These may be useful for applications, which use libass as renderer for
    ##  subtitles converted from another format, or which use libass for other
    ##  purposes that do not involve actual ASS subtitles authored for
    ##  distribution.
    ##
  ass_imageASS_DefaultFontProvider* {.size: sizeof(cint).} = enum
    ASS_FONTPROVIDER_NONE = 0, ASS_FONTPROVIDER_AUTODETECT = 1,
    ASS_FONTPROVIDER_CORETEXT, ASS_FONTPROVIDER_FONTCONFIG,
    ASS_FONTPROVIDER_DIRECTWRITE
  ass_imageASS_Feature* {.size: sizeof(cint).} = enum
    ASS_FEATURE_INCOMPATIBLE_EXTENSIONS, ## *
                                        ##  Match bracket pairs in bidirectional text according to the revised
                                        ##  Unicode Bidirectional Algorithm introduced in Unicode 6.3.
                                        ##  This is incompatible with VSFilter and disabled by default.
                                        ##
                                        ##  (Directional isolates, also introduced in Unicode 6.3,
                                        ##  are unconditionally processed when FriBidi is new enough.)
                                        ##
                                        ##  This feature may be unavailable at runtime (ass_track_set_feature
                                        ##  may return -1) if libass was compiled against old FriBidi.
                                        ##
    ASS_FEATURE_BIDI_BRACKETS ##  New enum values can be added here in new ABI-compatible library releases.



## *
##  \brief Initialize the library.
##  \return library handle or NULL if failed
##

proc ass_library_init*(): ptr ASS_Library {.importc: "ass_library_init",
                                        header: "ass.h".}
## *
##  \brief Finalize the library
##  \param priv library handle
##

proc ass_library_done*(priv: ptr ASS_Library) {.importc: "ass_library_done",
    header: "ass.h".}
## *
##  \brief Set additional fonts directory.
##  Optional directory that will be scanned for fonts recursively.  The fonts
##  found are used for font lookup.
##  NOTE: A valid font directory is not needed to support embedded fonts.
##
##  \param priv library handle
##  \param fonts_dir directory with additional fonts
##

proc ass_set_fonts_dir*(priv: ptr ASS_Library; fonts_dir: cstring) {.
    importc: "ass_set_fonts_dir", header: "ass.h".}
## *
##  \brief Whether fonts should be extracted from track data.
##  \param priv library handle
##  \param extract whether to extract fonts
##

proc ass_set_extract_fonts*(priv: ptr ASS_Library; extract: cint) {.
    importc: "ass_set_extract_fonts", header: "ass.h".}
## *
##  \brief Register style overrides with a library instance.
##  The overrides should have the form [Style.]Param=Value, e.g.
##    SomeStyle.Font=Arial
##    ScaledBorderAndShadow=yes
##
##  \param priv library handle
##  \param list NULL-terminated list of strings
##

proc ass_set_style_overrides*(priv: ptr ASS_Library; list: cstringArray) {.
    importc: "ass_set_style_overrides", header: "ass.h".}
## *
##  \brief Explicitly process style overrides for a track.
##  \param track track handle
##

proc ass_process_force_style*(track: ptr ASS_Track) {.
    importc: "ass_process_force_style", header: "ass.h".}
## *
##  \brief Register a callback for debug/info messages.
##  If a callback is registered, it is called for every message emitted by
##  libass.  The callback receives a format string and a list of arguments,
##  to be used for the printf family of functions. Additionally, a log level
##  from 0 (FATAL errors) to 7 (verbose DEBUG) is passed.  Usually, level 5
##  should be used by applications.
##  If no callback is set, all messages level < 5 are printed to stderr,
##  prefixed with [ass].
##
##  \param priv library handle
##  \param msg_cb pointer to callback function
##  \param data additional data, will be passed to callback
##

proc ass_set_message_cb*(priv: ptr ASS_Library; msg_cb: proc (level: cint; fmt: cstring;
    args: va_list; data: pointer); data: pointer) {.importc: "ass_set_message_cb",
    header: "ass.h".}
## *
##  \brief Initialize the renderer.
##  \param priv library handle
##  \return renderer handle or NULL if failed
##

proc ass_renderer_init*(a1: ptr ASS_Library): ptr ASS_Renderer {.
    importc: "ass_renderer_init", header: "ass.h".}
## *
##  \brief Finalize the renderer.
##  \param priv renderer handle
##

proc ass_renderer_done*(priv: ptr ASS_Renderer) {.importc: "ass_renderer_done",
    header: "ass.h".}
## *
##  \brief Set the frame size in pixels, including margins.
##  The renderer will never return images that are outside of the frame area.
##  The value set with this function can influence the pixel aspect ratio used
##  for rendering. If the frame size doesn't equal to the video size, you may
##  have to use ass_set_pixel_aspect().
##  @see ass_set_pixel_aspect()
##  @see ass_set_margins()
##  \param priv renderer handle
##  \param w width
##  \param h height
##

proc ass_set_frame_size*(priv: ptr ASS_Renderer; w: cint; h: cint) {.
    importc: "ass_set_frame_size", header: "ass.h".}
## *
##  \brief Set the source image size in pixels.
##  This is used to calculate the source aspect ratio and the blur scale.
##  The source image size can be reset to default by setting w and h to 0.
##  The value set with this function can influence the pixel aspect ratio used
##  for rendering.
##  @see ass_set_pixel_aspect()
##  \param priv renderer handle
##  \param w width
##  \param h height
##

proc ass_set_storage_size*(priv: ptr ASS_Renderer; w: cint; h: cint) {.
    importc: "ass_set_storage_size", header: "ass.h".}
## *
##  \brief Set shaping level. This is merely a hint, the renderer will use
##  whatever is available if the request cannot be fulfilled.
##  \param level shaping level
##

proc ass_set_shaper*(priv: ptr ASS_Renderer; level: ass_imageASS_ShapingLevel) {.
    importc: "ass_set_shaper", header: "ass.h".}
## *
##  \brief Set frame margins.  These values may be negative if pan-and-scan
##  is used. The margins are in pixels. Each value specifies the distance from
##  the video rectangle to the renderer frame. If a given margin value is
##  positive, there will be free space between renderer frame and video area.
##  If a given margin value is negative, the frame is inside the video, i.e.
##  the video has been cropped.
##
##  The renderer will try to keep subtitles inside the frame area. If possible,
##  text is layout so that it is inside the cropped area. Subtitle events
##  that can't be moved are cropped against the frame area.
##
##  ass_set_use_margins() can be used to allow libass to render subtitles into
##  the empty areas if margins are positive, i.e. the video area is smaller than
##  the frame. (Traditionally, this has been used to show subtitles in
##  the bottom "black bar" between video bottom screen border when playing 16:9
##  video on a 4:3 screen.)
##
##  When using this function, it is recommended to calculate and set your own
##  aspect ratio with ass_set_pixel_aspect(), as the defaults won't make any
##  sense.
##  @see ass_set_pixel_aspect()
##  \param priv renderer handle
##  \param t top margin
##  \param b bottom margin
##  \param l left margin
##  \param r right margin
##

proc ass_set_margins*(priv: ptr ASS_Renderer; t: cint; b: cint; l: cint; r: cint) {.
    importc: "ass_set_margins", header: "ass.h".}
## *
##  \brief Whether margins should be used for placing regular events.
##  \param priv renderer handle
##  \param use whether to use the margins
##

proc ass_set_use_margins*(priv: ptr ASS_Renderer; use: cint) {.
    importc: "ass_set_use_margins", header: "ass.h".}
## *
##  \brief Set pixel aspect ratio correction.
##  This is the ratio of pixel width to pixel height.
##
##  Generally, this is (s_w / s_h) / (d_w / d_h), where s_w and s_h is the
##  video storage size, and d_w and d_h is the video display size. (Display
##  and storage size can be different for anamorphic video, such as DVDs.)
##
##  If the pixel aspect ratio is 0, or if the aspect ratio has never been set
##  by calling this function, libass will calculate a default pixel aspect ratio
##  out of values set with ass_set_frame_size() and ass_set_storage_size(). Note
##  that this is useful only if the frame size corresponds to the video display
##  size. Keep in mind that the margins set with ass_set_margins() are ignored
##  for aspect ratio calculations as well.
##  If the storage size has not been set, a pixel aspect ratio of 1 is assumed.
##  \param priv renderer handle
##  \param par pixel aspect ratio (1.0 means square pixels, 0 means default)
##

proc ass_set_pixel_aspect*(priv: ptr ASS_Renderer; par: cdouble) {.
    importc: "ass_set_pixel_aspect", header: "ass.h".}
## *
##  \brief Set aspect ratio parameters.
##  This calls ass_set_pixel_aspect(priv, dar / sar).
##  @deprecated New code should use ass_set_pixel_aspect().
##  \param priv renderer handle
##  \param dar display aspect ratio (DAR), prescaled for output PAR
##  \param sar storage aspect ratio (SAR)
##

## !!!Ignored construct:  ASS_DEPRECATED ( use 'ass_set_pixel_aspect' instead ) void ass_set_aspect_ratio ( ASS_Renderer * priv , double dar , double sar ) ;
## Error: expected ';'!!!

## *
##  \brief Set a fixed font scaling factor.
##  \param priv renderer handle
##  \param font_scale scaling factor, default is 1.0
##

proc ass_set_font_scale*(priv: ptr ASS_Renderer; font_scale: cdouble) {.
    importc: "ass_set_font_scale", header: "ass.h".}
## *
##  \brief Set font hinting method.
##  \param priv renderer handle
##  \param ht hinting method
##

proc ass_set_hinting*(priv: ptr ASS_Renderer; ht: ass_imageASS_Hinting) {.
    importc: "ass_set_hinting", header: "ass.h".}
## *
##  \brief Set line spacing. Will not be scaled with frame size.
##  \param priv renderer handle
##  \param line_spacing line spacing in pixels
##

proc ass_set_line_spacing*(priv: ptr ASS_Renderer; line_spacing: cdouble) {.
    importc: "ass_set_line_spacing", header: "ass.h".}
## *
##  \brief Set vertical line position.
##  \param priv renderer handle
##  \param line_position vertical line position of subtitles in percent
##  (0-100: 0 = on the bottom (default), 100 = on top)
##

proc ass_set_line_position*(priv: ptr ASS_Renderer; line_position: cdouble) {.
    importc: "ass_set_line_position", header: "ass.h".}
## *
##  \brief Get the list of available font providers. The output array
##  is allocated with malloc and can be released with free(). If an
##  allocation error occurs, size is set to (size_t)-1.
##  \param priv library handle
##  \param providers output, list of default providers (malloc'ed array)
##  \param size output, number of providers
##  \return list of available font providers (user owns the returned array)
##

proc ass_get_available_font_providers*(priv: ptr ASS_Library; providers: ptr ptr ass_imageASS_DefaultFontProvider;
                                      size: ptr csize_t) {.
    importc: "ass_get_available_font_providers", header: "ass.h".}
## *
##  \brief Set font lookup defaults.
##  \param default_font path to default font to use. Must be supplied if
##  fontconfig is disabled or unavailable.
##  \param default_family fallback font family for fontconfig, or NULL
##  \param dfp which font provider to use (one of ASS_DefaultFontProvider). In
##  older libass version, this could be 0 or 1, where 1 enabled fontconfig.
##  Newer relases also accept 0 (ASS_FONTPROVIDER_NONE) and 1
##  (ASS_FONTPROVIDER_AUTODETECT), which is almost backward-compatible.
##  If the requested fontprovider does not exist or fails to initialize, the
##  behavior is the same as when ASS_FONTPROVIDER_NONE was passed.
##  \param config path to fontconfig configuration file, or NULL.  Only relevant
##  if fontconfig is used.
##  \param update whether fontconfig cache should be built/updated now.  Only
##  relevant if fontconfig is used.
##
##  NOTE: font lookup must be configured before an ASS_Renderer can be used.
##

proc ass_set_fonts*(priv: ptr ASS_Renderer; default_font: cstring;
                   default_family: cstring; dfp: cint; config: cstring; update: cint) {.
    importc: "ass_set_fonts", header: "ass.h".}
## *
##  \brief Set selective style override mode.
##  If enabled, the renderer attempts to override the ASS script's styling of
##  normal subtitles, without affecting explicitly positioned text. If an event
##  looks like a normal subtitle, parts of the font style are copied from the
##  user style set with ass_set_selective_style_override().
##  Warning: the heuristic used for deciding when to override the style is rather
##           rough, and enabling this option can lead to incorrectly rendered
##           subtitles. Since the ASS format doesn't have any support for
##           allowing end-users to customize subtitle styling, this feature can
##           only be implemented on "best effort" basis, and has to rely on
##           heuristics that can easily break.
##  \param priv renderer handle
##  \param bits bit mask comprised of ASS_OverrideBits values.
##

proc ass_set_selective_style_override_enabled*(priv: ptr ASS_Renderer; bits: cint) {.
    importc: "ass_set_selective_style_override_enabled", header: "ass.h".}
## *
##  \brief Set style for selective style override.
##  See ass_set_selective_style_override_enabled().
##  \param style style settings to use if override is enabled. Applications
##  should initialize it with {0} before setting fields. Strings will be copied
##  by the function.
##

proc ass_set_selective_style_override*(priv: ptr ASS_Renderer; style: ptr ASS_Style) {.
    importc: "ass_set_selective_style_override", header: "ass.h".}
## *
##  \brief This is a stub and does nothing. Old documentation: Update/build font
##  cache.  This needs to be called if it was disabled when ass_set_fonts was set.
##
##  \param priv renderer handle
##  \return success
##

## !!!Ignored construct:  ASS_DEPRECATED ( it does nothing ) int ass_fonts_update ( ASS_Renderer * priv ) ;
## Error: expected ';'!!!

## *
##  \brief Set hard cache limits.  Do not set, or set to zero, for reasonable
##  defaults.
##
##  \param priv renderer handle
##  \param glyph_max maximum number of cached glyphs
##  \param bitmap_max_size maximum bitmap cache size (in MB)
##

proc ass_set_cache_limits*(priv: ptr ASS_Renderer; glyph_max: cint;
                          bitmap_max_size: cint) {.
    importc: "ass_set_cache_limits", header: "ass.h".}
## *
##  \brief Render a frame, producing a list of ASS_Image.
##  \param priv renderer handle
##  \param track subtitle track
##  \param now video timestamp in milliseconds
##  \param detect_change compare to the previous call and set to 1
##  if positions changed, or set to 2 if content changed.
##

proc ass_render_frame*(priv: ptr ASS_Renderer; track: ptr ASS_Track; now: clonglong;
                      detect_change: ptr cint): ptr ASS_Image {.
    importc: "ass_render_frame", header: "ass.h".}
##
##  The following functions operate on track objects and do not need
##  an ass_renderer
##
## *
##  \brief Allocate a new empty track object.
##  \param library handle
##  \return pointer to empty track or NULL on failure
##

proc ass_new_track*(a1: ptr ASS_Library): ptr ASS_Track {.importc: "ass_new_track",
    header: "ass.h".}
## *
##  \brief Enable or disable certain features
##  This manages flags that control the behavior of the renderer and how certain
##  tags etc. within the track are interpreted. The defaults on a newly created
##  ASS_Track are such that rendering is compatible with traditional renderers
##  like VSFilter, and/or old versions of libass. Calling ass_process_data() or
##  ass_process_codec_private() may change some of these flags according to file
##  headers. (ass_process_chunk() will not change any of the flags.)
##  Additions to ASS_Feature are backward compatible to old libass releases (ABI
##  compatibility).
##  \param track track
##  \param feature the specific feature to enable or disable
##  \param enable 0 for disable, any non-0 value for enable
##  \return 0 if feature set, -1 if feature is unknown
##

proc ass_track_set_feature*(track: ptr ASS_Track; feature: ass_imageASS_Feature;
                           enable: cint): cint {.importc: "ass_track_set_feature",
    header: "ass.h".}
## *
##  \brief Deallocate track and all its child objects (styles and events).
##  \param track track to deallocate or NULL
##

proc ass_free_track*(track: ptr ASS_Track) {.importc: "ass_free_track",
    header: "ass.h".}
## *
##  \brief Allocate new style.
##  \param track track
##  \return newly allocated style id >= 0, or a value < 0 on failure
##

proc ass_alloc_style*(track: ptr ASS_Track): cint {.importc: "ass_alloc_style",
    header: "ass.h".}
## *
##  \brief Allocate new event.
##  \param track track
##  \return newly allocated event id >= 0, or a value < 0 on failure
##

proc ass_alloc_event*(track: ptr ASS_Track): cint {.importc: "ass_alloc_event",
    header: "ass.h".}
## *
##  \brief Delete a style.
##  \param track track
##  \param sid style id
##  Deallocates style data. Does not modify track->n_styles.
##

proc ass_free_style*(track: ptr ASS_Track; sid: cint) {.importc: "ass_free_style",
    header: "ass.h".}
## *
##  \brief Delete an event.
##  \param track track
##  \param eid event id
##  Deallocates event data. Does not modify track->n_events.
##

proc ass_free_event*(track: ptr ASS_Track; eid: cint) {.importc: "ass_free_event",
    header: "ass.h".}
## *
##  \brief Parse a chunk of subtitle stream data.
##  \param track track
##  \param data string to parse
##  \param size length of data
##

proc ass_process_data*(track: ptr ASS_Track; data: cstring; size: cint) {.
    importc: "ass_process_data", header: "ass.h".}
## *
##  \brief Parse Codec Private section of the subtitle stream, in Matroska
##  format.  See the Matroska specification for details.
##  \param track target track
##  \param data string to parse
##  \param size length of data
##

proc ass_process_codec_private*(track: ptr ASS_Track; data: cstring; size: cint) {.
    importc: "ass_process_codec_private", header: "ass.h".}
## *
##  \brief Parse a chunk of subtitle stream data. A chunk contains exactly one
##  event in Matroska format.  See the Matroska specification for details.
##  In later libass versions (since LIBASS_VERSION==0x01300001), using this
##  function means you agree not to modify events manually, or using other
##  functions manipulating the event list like ass_process_data(). If you do
##  anyway, the internal duplicate checking might break. Calling
##  ass_flush_events() is still allowed.
##  \param track track
##  \param data string to parse
##  \param size length of data
##  \param timecode starting time of the event (milliseconds)
##  \param duration duration of the event (milliseconds)
##

proc ass_process_chunk*(track: ptr ASS_Track; data: cstring; size: cint;
                       timecode: clonglong; duration: clonglong) {.
    importc: "ass_process_chunk", header: "ass.h".}
## *
##  \brief Set whether the ReadOrder field when processing a packet with
##  ass_process_chunk() should be used for eliminating duplicates.
##  \param check_readorder 0 means do not try to eliminate duplicates; 1 means
##  use the ReadOrder field embedded in the packet as unique identifier, and
##  discard the packet if there was already a packet with the same ReadOrder.
##  Other values are undefined.
##  If this function is not called, the default value is 1.
##

proc ass_set_check_readorder*(track: ptr ASS_Track; check_readorder: cint) {.
    importc: "ass_set_check_readorder", header: "ass.h".}
## *
##  \brief Flush buffered events.
##  \param track track
##

proc ass_flush_events*(track: ptr ASS_Track) {.importc: "ass_flush_events",
    header: "ass.h".}
## *
##  \brief Read subtitles from file.
##  \param library library handle
##  \param fname file name
##  \param codepage encoding (iconv format)
##  \return newly allocated track or NULL on failure
##

proc ass_read_file*(library: ptr ASS_Library; fname: cstring; codepage: cstring): ptr ASS_Track {.
    importc: "ass_read_file", header: "ass.h".}
## *
##  \brief Read subtitles from memory.
##  \param library library handle
##  \param buf pointer to subtitles text
##  \param bufsize size of buffer
##  \param codepage encoding (iconv format)
##  \return newly allocated track or NULL on failure
##

proc ass_read_memory*(library: ptr ASS_Library; buf: cstring; bufsize: csize_t;
                     codepage: cstring): ptr ASS_Track {.importc: "ass_read_memory",
    header: "ass.h".}
## *
##  \brief Read styles from file into already initialized track.
##  \param fname file name
##  \param codepage encoding (iconv format)
##  \return 0 on success
##

proc ass_read_styles*(track: ptr ASS_Track; fname: cstring; codepage: cstring): cint {.
    importc: "ass_read_styles", header: "ass.h".}
## *
##  \brief Add a memory font.
##  \param library library handle
##  \param name attachment name
##  \param data binary font data
##  \param data_size data size
##

proc ass_add_font*(library: ptr ASS_Library; name: cstring; data: cstring;
                  data_size: cint) {.importc: "ass_add_font", header: "ass.h".}
## *
##  \brief Remove all fonts stored in an ass_library object.
##  This can only be called safely if all ASS_Track and ASS_Renderer instances
##  associated with the library handle have been released first.
##  \param library library handle
##

proc ass_clear_fonts*(library: ptr ASS_Library) {.importc: "ass_clear_fonts",
    header: "ass.h".}
## *
##  \brief Calculates timeshift from now to the start of some other subtitle
##  event, depending on movement parameter.
##  \param track subtitle track
##  \param now current time in milliseconds
##  \param movement how many events to skip from the one currently displayed
##  +2 means "the one after the next", -1 means "previous"
##  \return timeshift in milliseconds
##

proc ass_step_sub*(track: ptr ASS_Track; now: clonglong; movement: cint): clonglong {.
    importc: "ass_step_sub", header: "ass.h".}