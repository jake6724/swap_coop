extends Node

func log(msg: String, log_level: String="debug"):
	print(log_level.to_upper() + " -> ", msg)