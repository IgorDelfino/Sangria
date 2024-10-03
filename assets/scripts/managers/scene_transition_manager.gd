extends CanvasLayer

class_name SceneTransition

@export var current_scene_BG : TextureRect
@export var animation_player : AnimationPlayer

func replace_current_screen():
	await RenderingServer.frame_post_draw
	
	var capture_image = get_viewport().get_texture().get_image()
	
	var image_texture = ImageTexture.create_from_image(capture_image)
	
	current_scene_BG.texture = image_texture
	

func play_transition_animation():
	animation_player.play("paper_tear_transition")
