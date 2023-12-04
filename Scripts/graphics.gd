extends Node

var environment : WorldEnvironment
var lights : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	lights = get_parent().find_children("", "Light3D") # no funciona :(
	set_low_graphics()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_low_graphics():
	ProjectSettings.set_setting("rendering/lights_and_shadows/directional_shadow/size", 4096)
	ProjectSettings.set_setting("rendering/lights_and_shadows/directional_shadow/soft_shadow_filter_quality", 2)
	ProjectSettings.set_setting("textures/default_filters/anisotropic_filtering_level", 2)
	ProjectSettings.set_setting("anti_aliasing/quality/msaa_3d", 0)
	#shadows(false)

func set_high_graphics():
	ProjectSettings.set_setting("rendering/lights_and_shadows/directional_shadow/size", 8192)
	ProjectSettings.set_setting("rendering/lights_and_shadows/directional_shadow/soft_shadow_filter_quality", 5)
	ProjectSettings.set_setting("textures/default_filters/anisotropic_filtering_level", 3)
	ProjectSettings.set_setting("anti_aliasing/quality/msaa_3d", 2)

func shadows(enabled: bool):
	for light: Light3D in lights:
		light.shadow_enabled = enabled
