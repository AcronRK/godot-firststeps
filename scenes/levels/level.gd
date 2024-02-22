extends Node2D
class_name LevelParent

# load laser and grenade scene
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
	
func _on_player_laser(pos, direction):
	# create scene
	var laser = laser_scene.instantiate() as Area2D
	# update laser position
	laser.position = pos
	laser.direction = direction
	laser.rotation = (direction.angle())
	# add scene to node tree
	$Projectiles.add_child(laser)


func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)	

