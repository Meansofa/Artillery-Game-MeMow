extends Line2D

func _physics_process(delta: float) -> void:
	update_trajectory(delta)
	
func update_trajectory(delta):
	clear_points()
	var pos : Vector2
	for i in 20:
		pos.x += 50
		pos.y -= 5
		
		#pos.x =  get_parent().velocity.x * delta
		#pos += get_parent().get_gravity() * delta
		add_point(pos)
		#print(self.name, "> pos", pos)
	#clear_points()
	#var pos : Vector2
	#var vel : Vector2
	#vel
	#print(self.name, vel)
	#for i in 50:
		#add_point(pos)
		#vel.y += get_parent().get_gravity() * delta
		#pos += vel * delta
