extends CharacterBody2D

var can_laser:bool = true 
var can_grenade:bool = true 

@export var max_speed: int = 500
var speed: int = max_speed

signal laser(pos, direction)
signal grenade(pos, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate player by directing to the mouse
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		# randomly select a marker2d for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers.pick_random()
		# emit the position we selected
		
		laser.emit(selected_laser.global_position, player_direction)
		
		can_laser = false
		$ShootDust.emitting = true
		$TimerLaser.start()
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		# get center marker
		var grenade_marker = $LaserStartPositions/Marker2D
		grenade.emit(grenade_marker.global_position, player_direction)
		
		can_grenade = false
		$TimerGrenade.start()

func _on_timer_laser_timeout():
	can_laser = true

func _on_timer_grenade_timeout():
	can_grenade = true


