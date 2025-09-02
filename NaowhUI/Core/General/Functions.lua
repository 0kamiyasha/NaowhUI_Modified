local NUI = unpack(NaowhUI)
local I = NUI:GetModule("Installer")
local SE = NUI:GetModule("Setup")

local C_AddOns, ReloadUI = C_AddOns, ReloadUI

local Commands = {}

function NUI.Notification(string, accept, decline)
	StaticPopupDialogs["Notification"] = {
		text = string,
		button1 = "Yes",
		button2 = "No",
		OnAccept = accept,
		OnCancel = decline,
	}

	StaticPopup_Show("Notification")
end

function NUI.SetFrameStrata(frame, strata)
	if frame and frame.SetFrameStrata then
		frame:SetFrameStrata(strata)
	end
end

function NUI:OpenSettings()
	if _G.NaowhUIInstaller and _G.NaowhUIInstaller.frame and _G.NaowhUIInstaller.frame:IsShown() then
		NUI.SetFrameStrata(_G.NaowhUIInstaller.frame, "MEDIUM")
	end

	Settings.OpenToCategory("NaowhUI")
end

function NUI:RunInstaller()
	if InCombatLockdown() then
		self:Print("This functionality is not available in combat")

		return
	end

	if not C_AddOns.DoesAddOnExist("NaowhUI_Data") then
		self:Print("Install the NaowhUI_Data AddOn to unlock this functionality")

		return
	end

	if self:IsAddOnEnabled("QuaziiUI") then
		self.Notification("This functionality is locked because the QuaziiUI AddOn is enabled. Do you wish to disable it?", function()
			C_AddOns.DisableAddOn("QuaziiUI")

			ReloadUI()
		end)

		return
	end

	-- Use our new standalone installer
	local InstallerModule = self:GetModule("Installer", true)
	if _G.NaowhUIInstaller and InstallerModule then
		-- Try multiple ways to get installer data
		local installerData = InstallerModule.installer or _G.NaowhUI_InstallerData
		
		if installerData then
			_G.NaowhUIInstaller:Show(installerData)
		else
			self:Print("Installer not available - no installer data found")
		end
	else
		if not _G.NaowhUIInstaller then
			self:Print("NaowhUIInstaller frame not available")
		elseif not InstallerModule then
			self:Print("Installer module not found")
		else
			self:Print("Installer not available")
		end
	end
end

function Commands.install()
	NUI:RunInstaller()
end

function NUI:HandleChatCommand(input)
	local command = Commands[input]

	if not command then
		self:Print(format("%s %q %s", "The command", input, "does not exist"))

		return
	end

	command()
end

function NUI:LoadProfiles()
	for k in pairs(self.db.global.profiles) do
		if self:IsAddOnEnabled(k) then
			SE:Setup(k)
		end
	end

	self.db.char.loaded = true

	ReloadUI()
end

function NUI:AreUpdatesAvailable()
end

function NUI:UpdateProfiles()
end

function NUI:ReplicateAnchor()
end

function NUI:IsInterruptAvailable()
end

function NUI:LoadData()
	if C_AddOns.LoadAddOn("NaowhUI_Data") then

		return
	end

	if not self:IsAddOnEnabled("NaowhUI_Data") then
		C_AddOns.EnableAddOn("NaowhUI_Data")
	end

	C_AddOns.LoadAddOn("NaowhUI_Data")
end