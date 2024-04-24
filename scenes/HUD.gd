extends GridContainer

var item_list: Array

func _ready():
	SignalManager.connect("item_grabbed", self, "_on_item_grabbed")
	
func _on_item_grabbed(item_name):
	item_list.append(item_name)
	if item_list.size() > 4:
		pass
	else:
		for i in len(item_list):
			var panel_container = get_child(i)
			var label: Label = panel_container.get_child(1)
			label.text = item_list[i]
