extends Control

const TITLE_FONT = "res://Assets/Images/Tiles/BitcountGridDouble-VariableFont_CRSV,ELSH,ELXP,slnt,wght.ttf-fe5c14b20e62db767ede6d5f37f39902.fontdata"
const UI_FONT = "res://Assets(SIDDAK)/fonts/PixelOperator8-Bold.ttf"

var starting = false
var t = 0.0
var screen: Vector2
var ground_y: float
var busy = false

var bg: Sprite2D
var ground: Sprite2D
var pango: AnimatedSprite2D
var tiger: AnimatedSprite2D
var title: Label
var fade: ColorRect
var music: AudioStreamPlayer
var tap: AudioStreamPlayer


func _ready():
	for c in get_children():
		c.queue_free()

	screen = get_viewport_rect().size
	ground_y = screen.y - 110

	# desert in the back, scrolls slow
	bg = Sprite2D.new()
	bg.texture = load("res://Assets/Images/background.png")
	bg.centered = false
	bg.region_enabled = true
	bg.texture_repeat = CanvasItem.TEXTURE_REPEAT_MIRROR
	var s = screen.y / bg.texture.get_height()
	bg.scale = Vector2(s, s)
	bg.region_rect = Rect2(0, 0, screen.x / s + 2, bg.texture.get_height())
	add_child(bg)

	# ground = top tile + dirt tile from our tilemap
	var tiles = load("res://Assets/Images/new tile map.png").get_image()
	tiles.decompress()
	var img = Image.create_empty(18, 36, false, tiles.get_format())
	img.blit_rect(tiles, Rect2i(18, 0, 18, 18), Vector2i(0, 0))
	img.blit_rect(tiles, Rect2i(0, 18, 18, 18), Vector2i(0, 18))
	ground = Sprite2D.new()
	ground.texture = ImageTexture.create_from_image(img)
	ground.centered = false
	ground.region_enabled = true
	ground.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	ground.scale = Vector2(4, 4)
	ground.region_rect = Rect2(0, 0, screen.x / 4 + 2, 36)
	ground.position.y = ground_y
	add_child(ground)

	var sheet = "res://Assets(SIDDAK)/sprites/shush.png"
	pango = make_anim(sheet, [Rect2(72, 39, 36, 39), Rect2(108, 39, 36, 39), Rect2(144, 39, 36, 39)], 12)
	pango.scale = Vector2(4.5, 4.5)
	pango.position = Vector2(screen.x * 0.25, ground_y - 12)

	var tsheet = "res://Assets(SIDDAK)/sprites/1.png"
	tiger = make_anim(tsheet, [Rect2(17, 252, 70, 42), Rect2(88, 252, 70, 42), Rect2(161, 252, 70, 42)], 9)
	tiger.scale = Vector2(2.8, 2.8)
	tiger.position = Vector2(screen.x * 0.08, ground_y - 36)

	title = Label.new()
	title.text = "PANGOLIN RUN"
	var ls = LabelSettings.new()
	ls.font = load(TITLE_FONT)
	ls.font_size = 100
	ls.font_color = Color("ffc93c")
	ls.outline_size = 16
	ls.outline_color = Color("2a140a")
	ls.shadow_color = Color(0, 0, 0, 0.4)
	ls.shadow_offset = Vector2(6, 6)
	title.label_settings = ls
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.size = Vector2(screen.x, 130)
	add_child(title)

	var box = VBoxContainer.new()
	box.add_theme_constant_override("separation", 14)
	add_child(box)
	for item in [["PLAY", "res://main.tscn"], ["LEVEL 2", "res://level_2.tscn"], ["LEVEL 3", "res://level_3.tscn"], ["QUIT", ""]]:
		var b = Button.new()
		b.text = item[0]
		b.custom_minimum_size = Vector2(300, 52)
		b.add_theme_font_override("font", load(UI_FONT))
		b.add_theme_font_size_override("font_size", 24)
		b.add_theme_color_override("font_color", Color("fff4d6"))
		b.add_theme_color_override("font_focus_color", Color("2a140a"))
		b.add_theme_color_override("font_hover_color", Color("2a140a"))
		b.add_theme_stylebox_override("normal", style(Color(0.16, 0.08, 0.04, 0.8)))
		b.add_theme_stylebox_override("hover", style(Color("ffc93c")))
		b.add_theme_stylebox_override("pressed", style(Color("ffc93c")))
		b.add_theme_stylebox_override("focus", style(Color("ffc93c")))
		b.mouse_entered.connect(b.grab_focus)
		b.focus_entered.connect(on_focus.bind(b))
		b.focus_exited.connect(func(): b.scale = Vector2.ONE)
		b.pressed.connect(go.bind(item[1]))
		box.add_child(b)
	box.position = Vector2((screen.x - 300) / 2, screen.y * 0.4)

	fade = ColorRect.new()
	fade.color = Color.BLACK
	fade.size = screen
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fade)
	create_tween().tween_property(fade, "color:a", 0.0, 0.6)

	tap = AudioStreamPlayer.new()
	tap.stream = load("res://Assets(SIDDAK)/sounds/tap.wav")
	add_child(tap)

	music = AudioStreamPlayer.new()
	music.stream = load("res://Assets(SIDDAK)/music/time_for_adventure.mp3")
	music.stream.loop = true
	music.volume_db = -30
	add_child(music)
	music.play()
	create_tween().tween_property(music, "volume_db", -8.0, 2.0)

	box.get_child(0).grab_focus.call_deferred()


func _process(delta):
	t += delta
	bg.region_rect.position.x += 8 * delta
	ground.region_rect.position.x = fmod(ground.region_rect.position.x + 70 * delta, 18)

	pango.position.y = ground_y - 12 - abs(sin(t * 14)) * 5
	tiger.position.x = screen.x * 0.08 + sin(t) * 40
	title.position.y = 50 + sin(t * 2.5) * 8

	if not starting and not busy and Input.is_action_just_pressed("jump"):
		starting = true
		tap.play()
		go("res://main.tscn")


func make_anim(path, rects, fps):
	var frames = SpriteFrames.new()
	frames.set_animation_speed("default", fps)
	for r in rects:
		var a = AtlasTexture.new()
		a.atlas = load(path)
		a.region = r
		frames.add_frame("default", a)
	var spr = AnimatedSprite2D.new()
	spr.sprite_frames = frames
	spr.flip_h = true
	add_child(spr)
	spr.play()
	return spr


func style(col):
	var sb = StyleBoxFlat.new()
	sb.bg_color = col
	sb.border_color = Color("ffc93c")
	sb.set_border_width_all(3)
	sb.set_corner_radius_all(6)
	return sb


func on_focus(b):
	tap.play()
	b.pivot_offset = b.size / 2
	b.scale = Vector2(1.08, 1.08)


func go(path):
	if busy:
		return
	busy = true
	var tw = create_tween()
	tw.tween_property(fade, "color:a", 1.0, 0.4)
	tw.parallel().tween_property(music, "volume_db", -40.0, 0.4)
	if path == "":
		tw.tween_callback(get_tree().quit)
	else:
		tw.tween_callback(get_tree().change_scene_to_file.bind(path))
