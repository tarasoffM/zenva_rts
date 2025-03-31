extends Node

@export var detect_range : float = 1000.0
@export var detect_rate : float = 0.2
var last_detect_time : float
var enemy_list : Array[Unit] = []

@onready var unit : Unit = get_parent()

func _process(delta):
	var time = Time.get_unix_time_from_system()
	
	if time - last_detect_time > detect_rate:
		last_detect_time = time
		_update_enemy_list()
		_detect()
	
func _update_enemy_list ():
	enemy_list.clear()
	
	var raw_list = get_tree().get_nodes_in_group("UnitPlayer")
	
	for node in raw_list:
		if node is not Unit:
			continue
		else:
			enemy_list.append(node)
	
func _detect ():
	var closest_enemy = null
	var closest_dist = 999999
	
	for enemy in enemy_list:
		var dist = unit.global_position.distance_to(enemy.global_position)
		
		if dist < closest_dist:
			closest_enemy = enemy
			closest_dist = dist
			
	if closest_enemy != null:
		unit.set_attack_target(closest_enemy)
			
			
			
			
			
