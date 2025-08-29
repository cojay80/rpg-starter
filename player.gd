extends CharacterBody2D

@export var speed = 150
# AnimatedSprite2D 노드를 가져오기 위한 변수
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	update_animation(direction) # 애니메이션 업데이트 함수 호출

func update_animation(direction):
	if direction.length() > 0:
		# 이동 방향에 따라 애니메이션 재생
		if direction.y < 0:
			animated_sprite.play("walk_up")
		elif direction.y > 0:
			animated_sprite.play("walk_down")
		elif direction.x < 0:
			animated_sprite.play("walk_left")
		elif direction.x > 0:
			animated_sprite.play("walk_right")
	else:
		# 멈춰있을 때, 현재 재생 중인 애니메이션의 idle 버전 재생
		var current_anim = animated_sprite.animation
		if current_anim.begins_with("walk_"):
			animated_sprite.play(current_anim.replace("walk_", "idle_"))
