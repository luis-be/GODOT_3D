extends MeshInstance3D

func _ready() -> void:
	var material = mesh.surface_get_material(0)
	material.albedo_color = Color.BLUE
	
	mesh.outer_radius = 1

func _physics_process(delta: float) -> void:
	rotation_degrees += Vector3(0,10,0)
	position += Vector3(2,0,0) * delta
	scale += Vector3(1,1,1) * delta
