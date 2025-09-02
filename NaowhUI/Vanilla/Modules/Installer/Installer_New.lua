local NUI = unpack(NaowhUI)
local I = NUI:GetModule("Installer")
local SE = NUI:GetModule("Setup")

I.installer = {
	Title = format("%s %s", NUI.title, "Installation"),
	Name = NUI.title,
	tutorialImage = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\NaowhUILogoVanilla.tga",
	Pages = {
		[1] = function()
			I.InstallerFrame.subtitle:SetFormattedText("Welcome to %s", NUI.title)

			if not NUI.db.global.profiles then
				I.InstallerFrame.desc1:SetText("To start the installation process, click on 'Continue'")

				return
			end

			--[[if NUI:AreUpdatesAvailable() then
				I.InstallerFrame.desc2:SetText("To update your installed profiles to their latest revision, click on 'Update Profiles'")
				I.InstallerFrame.option2:Show()
				I.InstallerFrame.option2:SetScript("OnClick", function() NUI:UpdateProfiles() end)
				I.InstallerFrame.option2:SetText("Update Profiles")
			end]]

			I.InstallerFrame.desc1:SetText("To load your installed profiles onto this character, click on 'Load Profiles'")
			I.InstallerFrame.desc3:SetText("To start the installation process again, click on 'Continue'")
			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() NUI:LoadProfiles() end)
			I.InstallerFrame.option1:SetText("Load Profiles")
		end,
		[2] = function()
			I.InstallerFrame.subtitle:SetText("ElvUI")
			I.InstallerFrame.desc1:SetText("You can choose between three different scaling options")
			I.InstallerFrame.desc2:SetText("Recommendation: 0.71 for 1080p, 0.53 or 0.62 for 1440p")
			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.5333333333333333) end)
			I.InstallerFrame.option1:SetText("0.53")
			I.InstallerFrame.option2:Show()
			I.InstallerFrame.option2:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.6222222222222222) end)
			I.InstallerFrame.option2:SetText("0.62")
			I.InstallerFrame.option3:Show()
			I.InstallerFrame.option3:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.7111111111111111) end)
			I.InstallerFrame.option3:SetText("0.71 (Default)")
		end,
		[3] = function()
			I.InstallerFrame.subtitle:SetText("BigWigs")

			if not NUI:IsAddOnEnabled("AddOnSkins") or not NUI:IsAddOnEnabled("BigWigs") then
				I.InstallerFrame.desc1:SetText("Enable AddOnSkins and BigWigs to unlock this functionality")

				return
			end

			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("BigWigs", true) end)
			I.InstallerFrame.option1:SetText("Setup BigWigs")
		end,
		[4] = function()
			I.InstallerFrame.subtitle:SetText("Details")

			if not NUI:IsAddOnEnabled("Details") then
				I.InstallerFrame.desc1:SetText("Enable Details to unlock this functionality")

				return
			end

			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("Details", true) end)
			I.InstallerFrame.option1:SetText("Setup Details")
		end,
		[5] = function()
			I.InstallerFrame.subtitle:SetText("HidingBar")

			if not NUI:IsAddOnEnabled("HidingBar") then
				I.InstallerFrame.desc1:SetText("Enable HidingBar to unlock this functionality")

				return
			end

			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("HidingBar", true) end)
			I.InstallerFrame.option1:SetText("Setup HidingBar")
		end,
		[6] = function()
			I.InstallerFrame.subtitle:SetText("Plater")

			if not NUI:IsAddOnEnabled("Plater") then
				I.InstallerFrame.desc1:SetText("Enable Plater to unlock this functionality")

				return
			end

			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("Plater", true) end)
			I.InstallerFrame.option1:SetText("Setup Plater")
		end,
		[7] = function()
			I.InstallerFrame.subtitle:SetText("General WeakAuras")

			if not NUI:IsAddOnEnabled("WeakAuras") then
				I.InstallerFrame.desc1:SetText("Enable WeakAuras to unlock this functionality")

				return
			end

			I.InstallerFrame.desc1:SetText("Select your General WeakAuras")
			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() SE:Setup("WeakAuras", nil, nil, I.InstallerFrame, "HIGH", "core") end)
			I.InstallerFrame.option1:SetText("Core")
		end,
		[8] = function()
			I.InstallerFrame.subtitle:SetText("Class WeakAuras")

			if not NUI:IsAddOnEnabled("WeakAuras") then
				I.InstallerFrame.desc1:SetText("Enable WeakAuras to unlock this functionality")

				return
			end

			I.InstallerFrame.desc1:SetText("Click on the button below to select your Class WeakAuras")
			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() NUI:OpenSettings() end)
			I.InstallerFrame.option1:SetText("Open Settings")
		end,
		[9] = function()
			I.InstallerFrame.subtitle:SetText("Installation Complete")
			I.InstallerFrame.desc1:SetText("You have completed the installation process")
			I.InstallerFrame.desc2:SetText("Please click on 'Finished' to reload your UI")
			I.InstallerFrame.option1:Show()
			I.InstallerFrame.option1:SetScript("OnClick", function() ReloadUI() end)
			I.InstallerFrame.option1:SetText("Finished")
		end
	},
	StepTitles = {
		[1] = "Welcome",
		[2] = "ElvUI",
		[3] = "BigWigs",
		[4] = "Details",
		[5] = "HidingBar",
		[6] = "Plater",
		[7] = "General WeakAuras",
		[8] = "Class WeakAuras",
		[9] = "Installation Complete"
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0, 179/255, 1},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "RIGHT"
}
