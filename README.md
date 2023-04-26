# ✨ Pinkler ✨
A script for displaying debug messages in Godot at runtime. 

**🤔 HOW TO USE THIS**

1. Add this to a Control node (or a node that inhertis a Control node) and add a *RichTextLabel* as a Child. You may have to change `extends` to whatever node type you are using

2. Set the *RichTextLabel* as *label* in the script.

3. Save the scene and set it as an Autoload named *Pinkler*

4. Now you can do `Pinkler.piss(line_color, is_inline, arguments)`
This will print whatever you pass as arguments

**📜 FUNCTION ARGUMENTS** 

**line_color:** A `Color` to color the text you want to output. This argument is optional, if no color is provided the *default_color* will be used.

**is_inline:** A `bool` defining if the output should be inlined. This argument is optional. **IMPORTANT** when using a *bool* as the second argument, you need to convert it to a *String* first by doing `str(bool)`. Else the text will be inlined and the bool will be not outputted.

**arguments:** The text you want to output. Can be anything except *""* (an emtpy String), because this is already used to filter out unused arguments.
