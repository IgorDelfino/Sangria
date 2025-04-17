extends Node

class_name SceneAudioContainer

@export var ambience : AudioStream
@export var soundtrack : Array[AudioStream]

@export var has_song_intro : bool = false
@export var should_play_music_if_null : bool = false
