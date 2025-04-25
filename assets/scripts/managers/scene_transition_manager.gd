extends CanvasLayer

class_name SceneTransitionManager

@export var current_scene_BG : TextureRect
@export var animation_player : AnimationPlayer

var valid_animation_names := [
	"paper_tear_transition_1",
	"paper_tear_transition_2"
	]
	
func _ready():
	GAMEMANAGER.scene_transition_manager = self

func replace_current_screen():
	await RenderingServer.frame_post_draw
	
	var capture_image = get_viewport().get_texture().get_image()
	
	var image_texture = ImageTexture.create_from_image(capture_image)
	
	current_scene_BG.texture = image_texture
	
func play_transition_animation():
	animation_player.play(valid_animation_names.pick_random())
	
func propagate_animation_finished(_anim_name):
	GAMEMANAGER.emit_signal("finished_scene_enter_transition")
