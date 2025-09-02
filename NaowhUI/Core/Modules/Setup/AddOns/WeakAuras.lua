local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.WeakAuras(_, _, _, frame, strata, weakaura)
	local weakauraData = NUI[weakaura]

	if frame and strata then
		NUI.SetFrameStrata(frame, strata)
	end

	if weakauraData and weakauraData ~= "" then
		WeakAuras.Import(weakauraData)
	else
		if NUI.LoadData then
			NUI:LoadData()
			C_Timer.After(0.5, function()
				local retryData = NUI[weakaura]
				if retryData and retryData ~= "" then
					WeakAuras.Import(retryData)
				else
					print("NaowhUI: WeakAura data '" .. tostring(weakaura) .. "' not found after loading data")
				end
			end)
		else
			print("NaowhUI: WeakAura data '" .. tostring(weakaura) .. "' not available")
		end
	end
end