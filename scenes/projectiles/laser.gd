extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready():
	# start timer when sprite created
	$SelfDestructTimer.start()
	
func _process(delta):
	# rotate laser direction
	position += direction * speed * delta

func _on_body_entered(body):
	if "hit" in body: # check if body has attribute or function with the name "hit"
		body.hit()
	queue_free()

func _on_self_destruct_timer_timeout():
	queue_free()


