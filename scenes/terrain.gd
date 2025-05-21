extends Node2D

func _ready() -> void:
	$Destructible/CollisionPolygon2D.polygon = $Destructible/Polygon2D.polygon
	
func clip(poly):
	var offset_poly = Polygon2D.new()
	
	# Transform the polygon values to take into account the transform
	offset_poly.polygon = poly.global_transform * (poly.polygon)
	var res = Geometry2D.clip_polygons($Destructible/Polygon2D.polygon, offset_poly.polygon)
	
	#Problem when hit by bullet, isnt clipped out
	if res.size() > 1:
		print(self.name, "New Island")
		var new_destructible := StaticBody2D.new()
		add_child(new_destructible)
		new_destructible.add_to_group("Destructible")
		
		var island := Polygon2D.new()
		island.polygon = res[1]
		new_destructible.add_child(island)
		
		var island_collision := CollisionPolygon2D.new()
		island_collision.set_deferred("polygon", res[1])
		new_destructible.add_child(island_collision)
		
		#$Destructible.add_child(island_collision)
		#add_child(island)
	
	$Destructible/Polygon2D.polygon = res[0]
	#for child in get_node("Destructible").get_children():
		#child.set_deferred("polygon", res[0])
	$Destructible/CollisionPolygon2D.set_deferred("polygon", res[0])
	#$Destructible/Polygon2D.set_deferred("polygon", $Destructible/CollisionPolygon2D.polygon)

	# Free the polygon to avoid memory leak
	offset_poly.queue_free()
	
	#print(self.name, ">$Destructible/Polygon2D.polygon: ", $Destructible/Polygon2D.polygon)
	#print(self.name, ">$Destructible/CollisionPolygon2D.polygon: ", $Destructible/CollisionPolygon2D.polygon)
