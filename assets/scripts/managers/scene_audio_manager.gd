extends Node

class_name SceneAudioManager

@export var ambience_audio_track : AudioStreamPlayer2D
@export var soundtrack_audio_track : AudioStreamPlayer2D

var last_audio_container : SceneAudioContainer

func _ready():
	GAMEMANAGER.scene_audio_manager = self
	
	soundtrack_audio_track.connect("finished", play_song_loop)
	
	
	
func play_song_loop():
	print("+++++++++ intro has finished +++++++++")
	soundtrack_audio_track.stream = last_audio_container.soundtrack[1]
	soundtrack_audio_track.play()

func overwrite_current_soundtrack(scene_audio_container : SceneAudioContainer):
	if scene_audio_container.ambience != null:
		ambience_audio_track.bus = "Ambience"
		ambience_audio_track.stream = scene_audio_container.ambience
		ambience_audio_track.play()
		
	else:
		#ambience_audio_track.bus = "MuffledAmbience"
		#ambience_audio_track.play()
		ambience_audio_track.stop()
		
	if scene_audio_container.soundtrack.size() != 0:
		if scene_audio_container.has_song_intro:
			last_audio_container = scene_audio_container
		
		if scene_audio_container.soundtrack.size() != 0:
			soundtrack_audio_track.stream = scene_audio_container.soundtrack[0]
			soundtrack_audio_track.play()

	elif !scene_audio_container.should_play_music_if_null:
		soundtrack_audio_track.stop()
