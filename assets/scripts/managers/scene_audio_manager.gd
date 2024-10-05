extends Node

class_name SceneAudioManager

@export var ambience_audio_track : AudioStreamPlayer2D
@export var soundtrack_audio_track : AudioStreamPlayer2D

func overwrite_current_soundtrack(scene_audio_container : SceneAudioContainer):
	if scene_audio_container.ambience != null:
		ambience_audio_track.bus = "Ambience"
		ambience_audio_track.stream = scene_audio_container.ambience
		ambience_audio_track.play()
		
	else:
		ambience_audio_track.bus = "MuffledAmbience"
		ambience_audio_track.play()
		
	if scene_audio_container.soundtrack != null:
		soundtrack_audio_track.stream = scene_audio_container.soundtrack
		soundtrack_audio_track.play()
	elif !scene_audio_container.should_play_music_if_null:
		soundtrack_audio_track.stop()
