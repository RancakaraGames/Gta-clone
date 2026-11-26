extends Control

const BG_TOP := Color("#180b43")
const BG_BOTTOM := Color("#090d2a")
const GOLD := Color("#ffd76a")
const WHITE := Color("#fff8ed")
const MUTED := Color("#c8c3e8")

var status_label: Label

func _ready() -> void:
	_build_lobby()

func _build_lobby() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var gradient := Gradient.new()
	gradient.colors = [BG_TOP, Color("#31105b"), BG_BOTTOM]
	gradient.offsets = [0.0, 0.48, 1.0]
	var tex := GradientTexture2D.new()
	tex.gradient = gradient
	tex.fill_from = Vector2(0.0, 0.0)
	tex.fill_to = Vector2(1.0, 1.0)
	var background := TextureRect.new()
	background.texture = tex
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	_add_glow_orb(Vector2(1090, 135), 175, Color("#7136d6", 0.22))
	_add_glow_orb(Vector2(190, 590), 210, Color("#e33eaa", 0.12))

	var header := _panel(self, Vector2(34, 26), Vector2(1212, 78), Color("#251451"), Color("#7254b8"))
	_add_label(header, "ROYAL", Vector2(24, 10), 29, GOLD, true)
	_add_label(header, "PLAY", Vector2(129, 10), 29, WHITE, true)
	_add_label(header, "ARCADE • MAIN LOBBY", Vector2(25, 47), 11, MUTED, false)
	_pill(header, "12.500 COIN", Vector2(870, 18), Vector2(145, 42))
	_pill(header, "250 DIAMOND", Vector2(1025, 18), Vector2(160, 42))

	_add_label(self, "PILIH PERMAINAN", Vector2(48, 132), 25, WHITE, true)
	_add_label(self, "Mainkan bersama teman dan raih kemenanganmu", Vector2(50, 166), 14, MUTED, false)

	_make_game_card("DOMINO", "Strategi klasik • 4 pemain", "♟", Vector2(48, 218), Color("#6135bd"), "DOMINO")
	_make_game_card("2 PLAYER FISHING", "Berburu ikan bersama", "🐠", Vector2(350, 218), Color("#087eaa"), "FISHING")
	_make_game_card("BANDAR QIU QIU", "Adu kombinasi kartu", "🀄", Vector2(652, 218), Color("#a33d75"), "QIU QIU")
	_make_game_card("FISH ROYALE", "Petualangan bawah laut", "🐟", Vector2(954, 218), Color("#167c78"), "FISH ROYALE")

	var promo := _panel(self, Vector2(48, 485), Vector2(1184, 105), Color("#211449"), Color("#4d3b86"))
	_add_label(promo, "ROYAL CLUB", Vector2(24, 16), 19, GOLD, true)
	_add_label(promo, "Bergabung, bermain, dan nikmati pengalaman arcade seru.", Vector2(24, 49), 14, MUTED, false)
	var daily := _button(promo, "HADIAH HARIAN", Vector2(925, 29), Vector2(220, 48), Color("#e8ad45"))
	daily.pressed.connect(func(): _show_status("Hadiah harian segera hadir!"))

	var nav := _panel(self, Vector2(48, 615), Vector2(1184, 72), Color("#191039"), Color("#493879"))
	_add_nav_item(nav, "⌂", "BERANDA", 70, true)
	_add_nav_item(nav, "♛", "TURNAMEN", 340, false)
	_add_nav_item(nav, "✉", "PESAN", 610, false)
	_add_nav_item(nav, "☻", "PROFIL", 880, false)
	status_label = _add_label(self, "Pilih permainan untuk mulai", Vector2(48, 695), 11, MUTED, false)

func _panel(parent: Control, pos: Vector2, size: Vector2, fill: Color, border_color: Color) -> Panel:
	var p := Panel.new()
	p.position = pos
	p.size = size
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border_color
	style.set_border_width_all(1)
	style.set_corner_radius_all(18)
	style.shadow_color = Color(0, 0, 0, 0.28)
	style.shadow_size = 12
	style.shadow_offset = Vector2(0, 5)
	p.add_theme_stylebox_override("panel", style)
	parent.add_child(p)
	return p

func _add_label(parent: Control, value: String, pos: Vector2, font_size: int, color: Color, bold: bool) -> Label:
	var l := Label.new()
	l.text = value
	l.position = pos
	l.add_theme_font_size_override("font_size", font_size)
	l.add_theme_color_override("font_color", color)
	if bold:
		l.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.3))
		l.add_theme_constant_override("shadow_offset_x", 1)
		l.add_theme_constant_override("shadow_offset_y", 2)
	parent.add_child(l)
	return l

func _pill(parent: Control, value: String, pos: Vector2, size: Vector2) -> Panel:
	var p := _panel(parent, pos, size, Color("#38256b"), Color("#8b70c8"))
	_add_label(p, value, Vector2(13, 10), 14, WHITE, true)
	return p

func _make_game_card(title: String, subtitle: String, art: String, pos: Vector2, accent: Color, game_id: String) -> void:
	var card := _panel(self, pos, Vector2(278, 235), Color("#211744"), accent)
	var art_panel := _panel(card, Vector2(10, 10), Vector2(258, 135), accent.darkened(0.22), accent.lightened(0.3))
	var art_label := _add_label(art_panel, art, Vector2(0, 15), 67, WHITE, true)
	art_label.size = Vector2(258, 95)
	art_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	art_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_add_label(card, title, Vector2(15, 151), 16, WHITE, true)
	_add_label(card, subtitle, Vector2(15, 178), 11, MUTED, false)
	var play := _button(card, "MAIN", Vector2(174, 190), Vector2(88, 34), GOLD)
	play.pressed.connect(func(): _show_status("Memilih " + game_id + " — modul permainan akan ditambahkan."))

func _button(parent: Control, text_value: String, pos: Vector2, size: Vector2, color: Color) -> Button:
	var b := Button.new()
	b.text = text_value
	b.position = pos
	b.size = size
	b.add_theme_font_size_override("font_size", 13)
	b.add_theme_color_override("font_color", Color("#24143e"))
	var normal := StyleBoxFlat.new()
	normal.bg_color = color
	normal.set_corner_radius_all(12)
	var hover := normal.duplicate()
	hover.bg_color = color.lightened(0.13)
	b.add_theme_stylebox_override("normal", normal)
	b.add_theme_stylebox_override("hover", hover)
	b.add_theme_stylebox_override("pressed", hover)
	parent.add_child(b)
	return b

func _add_nav_item(parent: Control, symbol: String, caption: String, x: float, active: bool) -> void:
	var c := GOLD if active else MUTED
	var l := _add_label(parent, symbol + "   " + caption, Vector2(x, 24), 14, c, active)
	l.size = Vector2(230, 28)

func _add_glow_orb(pos: Vector2, radius: float, color: Color) -> void:
	var orb := Panel.new()
	orb.position = pos - Vector2(radius, radius)
	orb.size = Vector2(radius * 2.0, radius * 2.0)
	orb.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.set_corner_radius_all(int(radius))
	orb.add_theme_stylebox_override("panel", style)
	add_child(orb)

func _show_status(message: String) -> void:
	if is_instance_valid(status_label):
		status_label.text = message
