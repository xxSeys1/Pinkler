class_name Pinggla extends MarginContainer

@export var _label: RichTextLabel
# if it should outputed to the runtime output as well
# this is usefull if you want to log the stuff the pinkler pisses
@export var _stack_same: bool = true
@export var _pinkler_to_output: bool = true
# pinkler will not recieve piss() calls when hidden
@export var _hide_disables_pinkler: bool
# disables the Pinkler to save on memory in non dev builds
@export var _release_mode: bool
@export_group("Formating")
@export var _default_color: Color = Color(1, 0.16, 0.286, 1)
@export_range(1, 25, 1, "hide_slider", "or_greater") var _indent_amount: int = 4
@export var _stacked_is_bold: bool = true
@export_group("Threading")
# label threading is disabled by default because it leads to flickering
# enable only if you notice Pinkler related performance problems
@export var _label_is_threaded: bool = false
#@export var _pinkler_is_threaded: bool = true
@export_group("PankuConsole")
# set this to true when using the Panku console
@export var _use_panku_console: bool #= true
@export_group("Debug")
# this is (mostly) useless but makes it very ✨fancy✨
@export var _debug_mode: bool
@export var _debug_label: Label

var _pinkler_version: String = "v.1.1.0.stable"
var _is_visible: bool = true
var _label_buffer_history: Array[String]
var _color_history: Array[Color]
var _last_was_stacked: bool 
var _last_stacked: String
var _stack_amount: int
var _last_stacked_with_number: String


func _ready() -> void:
	if _use_panku_console:
		Console.register_env("Pinkler", self)
	
	_init_pinkler()

func _process(_delta: float) -> void:
	if _is_visible:
		show()
	else:
		hide()
	
	_label.tab_size = _indent_amount

func _init_pinkler():
	if _debug_label is Label:
		_debug_label.visible = _debug_mode
	
	_label.clear()
	
	var _welcome_color: Color = Color.DARK_BLUE
	piss(_welcome_color, true, "------------------------------")
	piss(_welcome_color, true, "|    Pinkler ", _pinkler_version, "   |")
	piss(_welcome_color, true, "| Made with love by Saas_1 <3 |")
	piss(_welcome_color, true, "------------------------------")
	new_line()
	
	_label.bbcode_enabled = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	_label.threaded = _label_is_threaded
	_label.progress_bar_delay = -1

# You can add more arguments by just adding more as function arguments (Don't forget
# to add them to the arg_emtpy_filter.append(argxy) list as well or they simply do nothing)
# sorry for this multiline function declaration btw. :/
const _HELP_piss = "Prints something to the pinkler"
func piss(colorarg1 = "", inlinearg2 = "", arg3 = "", arg4 = "", arg5 = "", arg6 = "",
	arg7 = "", arg8 = "", arg9 = "", arg10 = "", arg11 = "", arg12 = "", arg13 = ""):
	
	if not _release_mode && not (not _is_visible && _hide_disables_pinkler):
		var _has_printed: bool = false
		
		# add the args to an array to make processing easier
		var arg_empty_filter: Array = []
		
		var text_color: Color = _default_color
		var is_inline: bool = false
		
		# handle the input of custom color
		if colorarg1 is Color:
			text_color = colorarg1
		# handle the input of if the text should be inlined
		elif colorarg1 is bool:
			is_inline = colorarg1
		else:
			arg_empty_filter.append(colorarg1)
		
		# handle the input of if the text should be inlined
		if inlinearg2 is bool and not is_inline:
			is_inline = inlinearg2
		else:
			arg_empty_filter.append(inlinearg2)
		
		# append everything into an array
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
			# if valid (not erased) argument -> add it to the buffer
			else:
				label_buffer += str(argument)
		
		if is_inline:
			label_buffer = "\t" + label_buffer + "\t"
		
		# prevent printing of empty lines when nothing was parsed as arg
		if not label_buffer.is_empty():
			
			if _stack_same:
				# do checks if _label_buffer_history has contents 
				if _label_buffer_history.size() > 0 && _color_history.size() > 0:
					var l_buf_his_lenght: int = _label_buffer_history.size() - 1
					# check if the last element in history is current label buffer
					if _label_buffer_history[l_buf_his_lenght] == label_buffer:
						_last_was_stacked = true
						_label.clear()
						
						# figure out if this is a new stack or if it is recuring
						if label_buffer == _last_stacked:
							_stack_amount += 1
						else:
							_stack_amount = 2
						
						# save the last stacked line
						_last_stacked = label_buffer
						
						var line_itt_number: int = 0
						for line in _label_buffer_history:
							# check if this is the last line and add number to it
							if line_itt_number == l_buf_his_lenght:
								if _stacked_is_bold:
									var amount_str: String = str("[b]", _stack_amount, "[/b]")
									line = "[b]([/b]" + amount_str + "[b]x) [/b]" + line
								else:
									line = str("(", _stack_amount, "x) ", line)
								_last_stacked_with_number = line
							
							# adds the text to the label
							var new_line_color: Color = Color(_color_history[line_itt_number])
							_label.push_color(new_line_color)
							_label.append_text(line)
							_label.newline()
							_has_printed = true
							
							line_itt_number += 1
		
		if not _has_printed:
			_last_stacked = ""
			# modifies the history so later stacks will use the already stacked lines
			# instead of old buffer
			if _last_was_stacked:
				_label_buffer_history.remove_at(_label_buffer_history.size() - 1)
				_label_buffer_history.append(_last_stacked_with_number)
				_last_was_stacked = false
			
			_label.push_color(text_color)
			# prints the buffer to the label
			_label.append_text(label_buffer)
			# and adds a new line
			_label.newline()
			
			# adds the buffer to the history
			if _stack_same:
				_label_buffer_history.append(label_buffer)
				_color_history.append(text_color)
		
		if _pinkler_to_output:
				print(str("Pinkler: ", label_buffer))

const _HELP_new_line = "Creates a new line (same as Pinkler.piss(` `))"
func new_line():
	piss(" ")

const _HELP_toggle_pinkler_to_output = "Toggles if every piss() call should also be printed to the Godot runtime output"
func toggle_pinkler_to_output() -> String:
	_pinkler_to_output = not _pinkler_to_output
	return str("Set Pinkler to output: ", _pinkler_to_output)

const _HELP_toggle_visible = "Toggles the visibility of the Pinkler"
func toggle_visible() -> String:
	_is_visible = not _is_visible
	if _hide_disables_pinkler:
		return str("Set Pinkler visible: ", _is_visible, " !Pinkler will no longer piss()!")
	else:
		return str("Set Pinkler visible: ", _is_visible)

const _HELP_set_indent_amount = "Sets the amount of spaces used for indentation"
func set_indent_amount(amount: int) -> String:
	_indent_amount = amount
	return str("Set indent amount: ", _indent_amount)

const _HELP_set_default_color = "Sets the default color for text printed"
func set_default_color(color: Color) -> String:
	_default_color = color
	return str("Set default color: ", _default_color)

const _HELP_toggle_release_mode = "Toggles release mode of the Pinkler"
func toggle_release_mode() -> String:
	_release_mode = not _release_mode
	if _release_mode:
		var state: String = str("Set release mode: ", _release_mode)
		var warning: String = " !Pinkler will no longer piss()!"
		return state + warning
	else:
		return str("Set release mode: ", _release_mode)

const _HELP_clear_pinkler = "Clears the Pinkler (WARNING: No undo, also clears history)"
func clear_pinkler() -> String:
	_label.clear()
	_color_history.clear()
	_label_buffer_history.clear()
	var message: String = "Pinkler cleared ("
	return str(message, _label.get_parsed_text(), _color_history, _label_buffer_history, ")")

const _HELP_toggle_hide_disables = "Toggles if hiding the Pinkler disables it"
func toggle_hide_disables() -> String:
	_hide_disables_pinkler = not _hide_disables_pinkler
	return str("Set hide disables Pinkler: ", _hide_disables_pinkler)

# for testing purposes and a easteregg when using a debug console :P
const _HELP_pee_test = "for testing purposes and a easteregg when using a debug console :P"
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
	
	piss(Color.GREEN_YELLOW, true, ":eyes: inlined text")
	
	new_line()
	
	piss(Color.ORANGE_RED, "This is something that's printed two times")
	piss(Color.ORANGE_RED, "This is something that's printed two times")
	
	piss(Color.ORANGE_RED, "And this four times")
	piss(Color.ORANGE_RED, "And this four times")
	piss(Color.ORANGE_RED, "And this four times")
	piss(Color.ORANGE_RED, "And this four times")
	
	return "ChadGPT wrote a wonderfull poem <3 See it now in PinklerTV"

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

# congrats if you have read trough the whole thing and tried to understand it (:
