mods["ReturnsAPI-ReturnsAPI"].auto{
    namespace   = "noeq",
    mp          = true
}

function init()
    local lootpools = LootPool.find_all()
    local equipments = Equipment.find_all()
    for _, lootpool in pairs(lootpools) do
        local lp = LootPool.wrap(lootpool)
        if lp.namespace == "ror" and lp.identifier ~= equipment then
            lp:remove_equipment(equipments)
        end
    end
end

Initialize.add(Callback.Priority.AFTER, init)