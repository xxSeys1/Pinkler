# Pinkler
A script for displaying debug messages in Godot. 

**USAGE**

1. Add this to a Control node and add a `RichTextLabel` as a Child.

2. Set that `RichTextLabel` as `label` in the script.

3. Save the Scene and set it as an Autoload

4. Now you can do `Pinkler.piss(line_color, arguments)`
This will print something to the `RichTextLabel`
`line_color` can be used to color the line by passing a `Color`. This argument is optional, if no color is provided the `default_color` will be used
`arguments` can be anything except `""`, because this is already used to filter out unused arguments.

5. There is also `Pinkler.new_line()`
This will print an emtpy line
