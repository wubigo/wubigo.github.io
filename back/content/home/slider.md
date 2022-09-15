+++
# Slider widget.
widget = "slider"  # Do not modify this line!
active = false  # Activate this widget? true/false

# Order that this section will appear in.
weight = 1

# Slide interval.
# Use `false` to disable animation or enter a time in ms, e.g. `5000` (5s).
interval = false

# Minimum slide height.
# Specify a height to ensure a consistent height for each slide.
# height = "300px"
height = "100px"

# Slides.
# Duplicate an `[[item]]` block to add more slides.
[[item]]
  title = "毅力"
  content = "From Home screen, swipe up from the bottom and pause slightly in the middle of the screen"
  align = "center"  # Choose `center`, `left`, or `right`.

  # Overlay a color or image (optional).
  #   Deactivate an option by commenting out the line, prefixing it with `#`.
  overlay_color = "#666"  # An HTML color value.
  # overlay_img = "headers/bubbles-wide.jpg"  # Image path relative to your `static/img/` folder.
  overlay_img = "bubbles-wide.jpg"
  # overlay_filter = 0.3  # Darken the image. Value in range 0-1.

  # Call to action button (optional).
  #   Activate the button by specifying a URL and button label below.
  #   Deactivate by commenting out parameters, prefixing lines with `#`.
  cta_label = "Go"
  cta_url = "#posts"
  cta_icon_pack = "fas"
  cta_icon = "dragon"

[[item]]
  title = "乐观"
  content = ""
  align = "left"

  overlay_color = "#555"  # An HTML color value.
  overlay_img = ""  # Image path relative to your `static/img/` folder.
  overlay_filter = 0.5  # Darken the image. Value in range 0-1.

[[item]]
  title = "进取"
  content = ""
  align = "right"

  overlay_color = "#333"  # An HTML color value.
  overlay_img = ""  # Image path relative to your `static/img/` folder.
  overlay_filter = 0.5  # Darken the image. Value in range 0-1.
+++
