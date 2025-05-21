extends StaticBody2D

var myPolygon2D : Polygon2D
var myCollsionPolygon2D : CollisionPolygon2D

func _ready() -> void:
	get_Polygons()

func get_Polygons() -> void:
	for child in get_children():
		if is_instance_of(child, Polygon2D):
			print(self.name, ">Polygon2D created")
			myPolygon2D = child
		if is_instance_of(child, CollisionPolygon2D):
			print(self.name, ">CollisionPolygon2D created")
			myCollsionPolygon2D = child
	if myPolygon2D != null and myCollsionPolygon2D != null:
		myCollsionPolygon2D.set_deferred("polygon", myPolygon2D.polygon)
	
func clip(poly):
	print(self.name, ">Clipped")
	if myPolygon2D == null or myCollsionPolygon2D == null:
		get_Polygons()
	
	var offset_poly = Polygon2D.new()
	
	# Transform the polygon values to take into account the transform
	offset_poly.polygon = poly.global_transform * (poly.polygon)
	var res = Geometry2D.clip_polygons(myPolygon2D.polygon, offset_poly.polygon)
	
	if res.size() > 1: #Check if there is more than 1 polygon2D after clipping
		#If there is create a new StaticBody2D with a polygon2D and collisionpolygon2D
		#Basically a duplicate of this node along with this script
		print(self.name, "New Segment")
		
		var new_destructible := StaticBody2D.new() #New Static Body
		get_parent().add_child(new_destructible)
		new_destructible.add_to_group("Destructibles") #To let the bullet know this is destructible
		new_destructible.set_script(self.get_script()) #Attach this script to the new node
		
		var segment := Polygon2D.new() #Polygon2D(Texture) of Static Body
		segment.polygon = res[1]
		new_destructible.add_child(segment)
		
		var segment_collision := CollisionPolygon2D.new() #CollisionPolygon2D of Static Body
		segment_collision.set_deferred("polygon", res[1])
		new_destructible.add_child(segment_collision)
	
	if res.is_empty(): #Res becomes empty when there is no more polygons to erase
		print(self.name, " Segment Deleted")
		self.queue_free()
		return

	myPolygon2D.polygon = res[0]
	myCollsionPolygon2D.set_deferred("polygon", res[0])

	# Free the polygon to avoid memory leak
	offset_poly.queue_free()
