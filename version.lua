dofile(path .. "functions.lua")
core.register_on_joinplayer(function(player)
    core.after(0.1, function()
        local hudid = 0
        local all = player:hud_get_all()
        for num, hud in ipairs(all)
        do
        if all[num] then
        if hud.text == "BackToAlpha Alpha 1.0.17_04" then
            hudid = num
        end
        end
        end
        playername = player:get_player_name()
        if playername == "singleplayer" then
        		playername = core.settings:get("name")
        end
        local placeholders = {
        		["@name_lower"] = playername:lower(),
        		["@name_upper"] = playername:upper(),
        		["@name"] = playername,
        		["@id"] = hudid
        }
        version = core.settings:get("sp_versionum") or "BackToAlpha a1.0.16_05 Sapphire"
        for ph, nm in pairs(placeholders)
        do
          version = version:gsub(ph, nm)
        end
        player:hud_change(hudid, "text", version)
        version = nil
    end)
end)