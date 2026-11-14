local oldlog = core.log
function core.log(kind, name)
	if not (name:find("not found for HUD update") and kind == "error") then
		oldlog(kind, name)
	end
end