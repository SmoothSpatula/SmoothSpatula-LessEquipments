-- NoEquipmentsFromEnemies v1.0.0
-- SmoothSpatula

log.info("Successfully loaded ".._ENV["!guid"]..".")

local items = gm.variable_global_get("class_item")
-- Naive item picker, should improve with weightings, it does not have much impact regardless
function generate_item() 
    local item_id = nil
    repeat
        item_id = gm.irandom_range(1, #items)
    until items[item_id] ~= nil and items[item_id][9] ~= nil and items[item_id][7] <= 2 -- repeat until you find a suitable item
        and (items[item_id][11]== nil or gm.achievement_is_unlocked(items[item_id][11])) -- this condition checks for unlocked items
    return items[item_id][9] -- return item id
end
 
gm.pre_script_hook(gm.constants.instance_create, function(self, other, result, args) -- When an instance is created
    if self == nil or args[3].value == nil then return end
    if gm.object_get_parent(args[3].value) == 405 and -- created instance is an equipment pickup
        gm.object_get_parent(gm.object_get_parent(self.object_index)) == 305 -- item was created by an enemy instance
    then
        args[3].value = generate_item() -- change equipment id to an item id
    end
end)
