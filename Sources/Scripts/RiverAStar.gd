class_name RiverAStar
extends AStar

func _compute_cost(from_id: int, to_id: int) -> float:
	return Vector3(get_point_position(from_id)-get_point_position(to_id)).length()*(1.0/(1.5+abs(get_point_position(from_id).z-get_point_position(to_id).z)))
func _estimate_cost(from_id: int, to_id: int) -> float:
	return  floor(Vector3(get_point_position(from_id)-get_point_position(to_id)).length()*(1.0/(1.5+abs(get_point_position(from_id).z-get_point_position(to_id).z))))
