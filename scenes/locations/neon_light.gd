extends PointLight2D

@export var flicker_animation_player : AnimationPlayer
@export var timer : Timer

var possible_flicker_animations := [
	"bar_light_flicker_1"
]

func _ready():
	timer.start(randi() % 10)

func flicker_bar_light():
	print("flickered")
	flicker_animation_player.play(possible_flicker_animations.pick_random())
	timer.start(randi() % 10)
