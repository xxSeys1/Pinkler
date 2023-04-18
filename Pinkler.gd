extends Control

@onready var label: RichTextLabel = $RichTextLabel
# if it should outputed to the runtime output as well
# this is usefull if you want to log the stuff the pinkler pisses
@export var _pinkler_to_output: bool = true
# set this to true when using the Panku console
@export var _using_panku_console: bool #= true

var _pinkler_version: String = "v.1.0.1.stable"
var is_visible: bool = true
var default_color: Color = Color(0.8555, 0.2742, 0.3575, 1)


func _ready() -> void:
	if _using_panku_console:
		Console.register_env("Pinkler", self)
	process_mode = Node.PROCESS_MODE_ALWAYS
	_init_pinkler()

func _init_pinkler():
	var _welcome_color: Color = Color.DARK_BLUE
	piss(Color.REBECCA_PURPLE, "------------------------------")
	piss(_welcome_color, "| Pinkler ", _pinkler_version, "        |")
	piss(_welcome_color, "| Made with love by Saas_1 <3 |")
	piss(Color.REBECCA_PURPLE, "------------------------------")
	new_line()

# You can add more arguments by just adding more as function arguments (Don't forget
# to add them to the arg_emtpy_filter.append(argxy) list as well or they simply do nothing)
# sorry for this multiline function declaration btw. :/
func piss(colorarg1 = "", arg2 = "", arg3 = "", arg4 = "", arg5 = "", arg6 = "",
	arg7 = "", arg8 = "", arg9 = "", arg10 = "", arg11 = "", arg12 = "", arg13 = ""):
	# add the args to an array to make processing easier
	var arg_empty_filter: Array = []
	
	# handle the input of custom color
	var text_color: Color = default_color
	if colorarg1 is Color:
		text_color = colorarg1
	else:
		arg_empty_filter.append(colorarg1)
	
	arg_empty_filter.append(arg2)
	arg_empty_filter.append(arg3)
	arg_empty_filter.append(arg4)
	arg_empty_filter.append(arg5)
	arg_empty_filter.append(arg6)
	arg_empty_filter.append(arg7)
	arg_empty_filter.append(arg8)
	arg_empty_filter.append(arg9)
	arg_empty_filter.append(arg10)
	arg_empty_filter.append(arg11)
	arg_empty_filter.append(arg12)
	arg_empty_filter.append(arg13)
	
	# buffers a new line for printing
	var label_buffer: String = ""
	
	# filter and add to buffer if not filtered out
	for argument in arg_empty_filter:
		# removes all empty strings (=> unused arguments)
		if argument is String and argument == "":
			arg_empty_filter.erase(argument)
		# if valid argument -> add it to the buffer
		else:
			label_buffer += str(argument)
	
	# prevent printing of empty lines when nothing was parsed as arg
	if not label_buffer.is_empty():
		label.push_color(text_color)
		# prints the buffer to the label
		label.add_text(label_buffer)
		# and adds a new line
		label.newline()
		
		if _pinkler_to_output:
			print(str("Pinkler: ", label_buffer))

func new_line():
	piss(" ")

func toogle_pinkler_to_output() -> String:
	_pinkler_to_output = not _pinkler_to_output
	return str("Set Pinkler to output: ", _pinkler_to_output)

# for testing purposes and a easteregg when using a debug console :P
func pee_test() -> String:
	new_line()
	
	piss(Color.RED, "Red is the color of passion and love,")
	piss(Color.RED, "A hue that shines like the sun above.")
	piss(Color.CYAN, "Cyan, a cool and tranquil hue,")
	piss(Color.CYAN, "Like the ocean's depths, so vast and blue.")
	
	piss(Color.BLACK, "Black, a shade of mystery and night,")
	piss(Color.BLACK, "A color that conceals and hides from sight.")
	piss(Color.WHITE, "White, a hue of purity and light,")
	piss(Color.WHITE, "Like a blank canvas, ready for insight.")
	
	piss(Color.BLUE, "Blue, a color that echoes the sky,")
	piss(Color.BLUE, "A shade that brings calm and peace nearby.")
	piss(Color.GREEN, "Green, a hue of life and growth,")
	piss(Color.GREEN, "Like the leaves of trees, reaching forth.")
	
	piss(Color.YELLOW, "Yellow, a color of warmth and cheer,")
	piss(Color.YELLOW, "Like the sun's rays that brighten the year.")
	piss(Color.DARK_GRAY, "Grey, a shade that's neither black nor white,")
	piss(Color.DARK_GRAY, "A hue that brings balance to the sight.")
	
	new_line()
	
	piss(Color.BLACK, "This is a poem ChadGPT wrote.")
	piss(Color.BLACK, "You can find the full poem in the Pinkler code!")
	
	new_line()
	
	return "ChadGPT wrote a wonderfull poem <3 See it now in PinklerTV"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pinkler"):
		is_visible = not is_visible
	
	if is_visible:
		show()
	else:
		hide()

"""
Red is the color of passion and love,
A hue that shines like the sun above.
Cyan, a cool and tranquil hue,
Like the ocean's depths, so vast and blue.

Black, a shade of mystery and night,
A color that conceals and hides from sight.
White, a hue of purity and light,
Like a blank canvas, ready for insight.

Blue, a color that echoes the sky,
A shade that brings calm and peace nearby.
Green, a hue of life and growth,
Like the leaves of trees, reaching forth.

Yellow, a color of warmth and cheer,
Like the sun's rays that brighten the year.
Grey, a shade that's neither black nor white,
A hue that brings balance to the sight.

Each color brings its own special hue,
A rainbow of shades, both old and new.
Together, they make a world so bright,
A tapestry of colors, shining with light.
"""
