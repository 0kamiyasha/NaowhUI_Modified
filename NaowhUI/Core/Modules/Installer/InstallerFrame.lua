local NUI = unpack(NaowhUI)
local I = NUI:GetModule("Installer")

local NaowhUIInstaller = {}
I.InstallerFrame = NaowhUIInstaller

_G.NaowhUIInstaller = NaowhUIInstaller

local FRAME_WIDTH = 800
local FRAME_HEIGHT = 600
local STEP_PANEL_WIDTH = 200
local CONTENT_PANEL_WIDTH = FRAME_WIDTH - STEP_PANEL_WIDTH

local NaowhUIInstaller = {}

function NaowhUIInstaller:CreateModernButton(parent, text, width, height, buttonType)
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width or 120, height or 32)

    btn:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Rock",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })

    if buttonType == "class" then
        btn:SetBackdropColor(0.12, 0.12, 0.18, 0.95)
        btn:SetBackdropBorderColor(0, 0, 0, 0.8)

        local fontString = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fontString:SetPoint("CENTER")
        fontString:SetText(text or "Button")
        fontString:SetTextColor(0.9, 0.9, 0.9, 1)
        btn:SetFontString(fontString)

        btn:SetScript("OnEnter", function()
            btn:SetBackdropColor(0.2, 0.25, 0.35, 0.95)
            btn:SetBackdropBorderColor(0, 0, 0, 1)
            fontString:SetTextColor(1, 1, 1, 1)
        end)

        btn:SetScript("OnLeave", function()
            btn:SetBackdropColor(0.12, 0.12, 0.18, 0.95)
            btn:SetBackdropBorderColor(0, 0, 0, 0.8)
            fontString:SetTextColor(0.9, 0.9, 0.9, 1)
        end)
    else
        btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
        btn:SetBackdropBorderColor(0, 0, 0, 0.8)

        local fontString = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fontString:SetPoint("CENTER")
        fontString:SetText(text or "Button")
        fontString:SetTextColor(0.9, 0.9, 0.9, 1)
        btn:SetFontString(fontString)

        btn:SetScript("OnEnter", function()
            btn:SetBackdropColor(0.25, 0.3, 0.45, 0.95)
            btn:SetBackdropBorderColor(0, 0, 0, 1)
            fontString:SetTextColor(1, 1, 1, 1)
        end)

        btn:SetScript("OnLeave", function()
            btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
            btn:SetBackdropBorderColor(0, 0, 0, 0.8)
            fontString:SetTextColor(0.9, 0.9, 0.9, 1)
        end)
    end

    return btn
end

function NaowhUIInstaller:CountRecentlyInstalled()
    if not self.recentlyInstalled then return 0 end
    local count = 0
    for _ in pairs(self.recentlyInstalled) do
        count = count + 1
    end
    return count
end

function NaowhUIInstaller:GetVersionStatusForStep(stepTitle, stepIndex)

    if stepIndex == 1 then
        return "default"
    end

    if stepTitle == "General WeakAuras" or stepTitle == "Class WeakAuras" then
        return "default"
    end

    local addonMap = {
        ["ElvUI"] = "ElvUI",
        ["BigWigs"] = "BigWigs",
        ["Details"] = "Details",
        ["HidingBar"] = "HidingBar",
        ["NameplateAuras"] = "NameplateAuras",
        ["OmniCD"] = "OmniCD",
        ["Plater"] = "Plater",
        ["WarpDeplete"] = "WarpDeplete"
    }

    local addonName = addonMap[stepTitle]
    if not addonName then
        return "default"
    end

    if self.recentlyInstalled and self.recentlyInstalled[addonName] then
        return "uptodate"
    end

    local currentVersion = NUI.version

    if NUI.db and NUI.db.global and NUI.db.global.profiles then
        local installedVersion = NUI.db.global.profiles[addonName]

        if installedVersion then

            if installedVersion == currentVersion then
                return "uptodate"
            else

                return "outdated"
            end
        else
            return "notinstalled"
        end
    else
        return "notinstalled"
    end
end

function NaowhUIInstaller:CreateFrame()
    if self.frame then
        return self.frame
    end

    if not self.recentlyInstalled then
        self.recentlyInstalled = {}
    end

    local frame = CreateFrame("Frame", "NaowhUIInstallerFrame", UIParent, "BackdropTemplate")
    frame:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata("DIALOG")
    frame:SetToplevel(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Rock",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    frame:SetBackdropColor(0.1, 0.1, 0.15, 0.95)
    frame:SetBackdropBorderColor(0, 0, 0, 0.8)

    local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    header:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -8)
    header:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -8)
    header:SetHeight(70)
    header:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Marble",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    header:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
    header:SetBackdropBorderColor(0, 0, 0, 0.8)

    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", header, "LEFT", 20, 0)
    title:SetText(NUI.title .. " Installer")
    title:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 48, "OUTLINE")

    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(32, 32)
    closeBtn:SetPoint("TOPRIGHT", header, "TOPRIGHT", -8, -8)

    closeBtn:SetNormalTexture("Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetDisabledTexture("Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Panel-MinimizeButton-Disabled")

    closeBtn:GetHighlightTexture():SetBlendMode("ADD")
    closeBtn:GetHighlightTexture():SetAlpha(0.3)

    closeBtn:SetScript("OnClick", function() self:Hide() end)

    local stepPanel = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    stepPanel:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -8)
    stepPanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 8, 8)
    stepPanel:SetWidth(STEP_PANEL_WIDTH)
    stepPanel:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Rock",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    stepPanel:SetBackdropColor(0.08, 0.08, 0.12, 0.95)
    stepPanel:SetBackdropBorderColor(0, 0, 0, 0.8)

    local contentPanel = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    contentPanel:SetPoint("TOPLEFT", stepPanel, "TOPRIGHT", 8, 0)
    contentPanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 8)
    contentPanel:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Marble",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    contentPanel:SetBackdropColor(0.12, 0.12, 0.18, 0.95)
    contentPanel:SetBackdropBorderColor(0, 0, 0, 0.8)

    local stepList = CreateFrame("ScrollFrame", nil, stepPanel, "BackdropTemplate")
    stepList:SetPoint("TOPLEFT", stepPanel, "TOPLEFT", 10, -10)
    stepList:SetPoint("BOTTOMRIGHT", stepPanel, "BOTTOMRIGHT", -30, 50)

    local scrollBar = CreateFrame("Slider", nil, stepList, "BackdropTemplate")
    scrollBar:SetPoint("TOPRIGHT", stepList, "TOPRIGHT", 20, 0)
    scrollBar:SetPoint("BOTTOMRIGHT", stepList, "BOTTOMRIGHT", 20, 0)
    scrollBar:SetWidth(16)
    scrollBar:SetBackdrop({
        bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\minimalscrollbarvertical",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        tileSize = 16,
        edgeSize = 4,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    scrollBar:SetBackdropColor(0.1, 0.1, 0.15, 0.8)
    scrollBar:SetBackdropBorderColor(0, 0, 0, 0.6)
    scrollBar:SetOrientation("VERTICAL")
    scrollBar:SetValueStep(1)
    scrollBar:SetObeyStepOnDrag(true)

    local thumb = scrollBar:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\minimalscrollbarproportional")
    thumb:SetVertexColor(0.4, 0.5, 0.7, 0.9)
    scrollBar:SetThumbTexture(thumb)

    stepList.scrollBar = scrollBar
    stepList:EnableMouseWheel(true)

    stepList:SetScript("OnMouseWheel", function(_, delta)
        local current = scrollBar:GetValue()
        local min, max = scrollBar:GetMinMaxValues()
        if delta > 0 then
            scrollBar:SetValue(math.max(min, current - 20))
        else
            scrollBar:SetValue(math.min(max, current + 20))
        end
    end)

    scrollBar:SetScript("OnValueChanged", function(_, value)
        stepList:SetVerticalScroll(value)
    end)

    local stepContent = CreateFrame("Frame", nil, stepList)
    stepContent:SetSize(STEP_PANEL_WIDTH - 40, 1)
    stepList:SetScrollChild(stepContent)

    local stepContentRegion = CreateFrame("Frame", nil, contentPanel)
    stepContentRegion:SetSize(CONTENT_PANEL_WIDTH - 64, FRAME_HEIGHT - 220)
    stepContentRegion:SetPoint("TOP", contentPanel, "TOP", 0, -30)
    stepContentRegion:SetPoint("LEFT", contentPanel, "LEFT", 32, 0)
    stepContentRegion:SetPoint("RIGHT", contentPanel, "RIGHT", -32, 0)

    local subtitle = stepContentRegion:CreateFontString(nil, "OVERLAY")
    subtitle:SetPoint("TOP", stepContentRegion, "TOP", 0, 0)
    subtitle:SetWidth(CONTENT_PANEL_WIDTH - 96)
    subtitle:SetWordWrap(true)
    subtitle:SetJustifyH("CENTER")
    subtitle:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 24, "OUTLINE")

    local tutorialImage = stepContentRegion:CreateTexture(nil, "ARTWORK")
    tutorialImage:SetSize(400, 171)
    tutorialImage:SetPoint("TOP", subtitle, "BOTTOM", 0, -20)
    tutorialImage:Hide()

    local desc1 = stepContentRegion:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    desc1:SetPoint("TOP", subtitle, "BOTTOM", 0, -20)
    desc1:SetWordWrap(true)
    desc1:SetWidth(CONTENT_PANEL_WIDTH - 96)
    desc1:SetJustifyH("CENTER")
    desc1:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 16, "OUTLINE")

    local desc2 = stepContentRegion:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    desc2:SetPoint("TOP", desc1, "BOTTOM", 0, -15)
    desc2:SetWordWrap(true)
    desc2:SetWidth(CONTENT_PANEL_WIDTH - 96)
    desc2:SetJustifyH("CENTER")
    desc2:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 14, "OUTLINE")

    local desc3 = stepContentRegion:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    desc3:SetPoint("TOP", desc2, "BOTTOM", 0, -15)
    desc3:SetWordWrap(true)
    desc3:SetWidth(CONTENT_PANEL_WIDTH - 96)
    desc3:SetJustifyH("CENTER")
    desc3:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 14, "OUTLINE")

    local option1 = self:CreateModernButton(stepContentRegion, "Option 1", 180, 40)
    option1:SetPoint("TOP", desc3, "BOTTOM", 0, -30)
    option1:Hide()

    local option2 = self:CreateModernButton(stepContentRegion, "Option 2", 180, 40)
    option2:SetPoint("TOP", option1, "BOTTOM", 0, -15)
    option2:Hide()

    local option3 = self:CreateModernButton(stepContentRegion, "Option 3", 180, 40)
    option3:SetPoint("TOP", option2, "BOTTOM", 0, -15)
    option3:Hide()

    local option4 = self:CreateModernButton(stepContentRegion, "Option 4", 180, 40)
    option4:SetPoint("TOP", option3, "BOTTOM", 0, -15)
    option4:Hide()

    local option1Alt = self:CreateModernButton(contentPanel, "Option 1", 180, 40)
    option1Alt:Hide()

    local option2Alt = self:CreateModernButton(contentPanel, "Option 2", 180, 40)
    option2Alt:Hide()

    local option3Alt = self:CreateModernButton(contentPanel, "Option 3", 180, 40)
    option3Alt:Hide()

    local option4Alt = self:CreateModernButton(contentPanel, "Option 4", 180, 40)
    option4Alt:Hide()

    local dynamicOptionsFrame = CreateFrame("Frame", nil, stepContentRegion)
    dynamicOptionsFrame:SetPoint("TOP", desc3, "BOTTOM", 0, -80)
    dynamicOptionsFrame:SetSize(CONTENT_PANEL_WIDTH - 64, 250)
    dynamicOptionsFrame:Hide()

    local navPanel = CreateFrame("Frame", nil, frame)
    navPanel:SetPoint("BOTTOMLEFT", stepPanel, "BOTTOMLEFT", 0, 0)
    navPanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -8, 8)
    navPanel:SetHeight(50)

    local prevBtn = self:CreateModernButton(navPanel, "Previous", 100, 32)
    prevBtn:SetPoint("BOTTOMLEFT", navPanel, "BOTTOMLEFT", 10, 5)
    prevBtn:SetScript("OnClick", function() self:PreviousStep() end)

    local nextBtn = self:CreateModernButton(navPanel, "Continue", 100, 32)
    nextBtn:SetPoint("BOTTOMRIGHT", navPanel, "BOTTOMRIGHT", -10, 5)
    nextBtn:SetScript("OnClick", function() self:NextStep() end)

    local skipBtn = self:CreateModernButton(navPanel, "Skip", 80, 32)
    skipBtn:SetPoint("BOTTOMRIGHT", nextBtn, "BOTTOMLEFT", -5, 0)
    skipBtn:SetScript("OnClick", function() self:NextStep() end)

    self.frame = frame
    self.header = header
    self.stepPanel = stepPanel
    self.contentPanel = contentPanel
    self.stepList = stepList
    self.stepContent = stepContent
    self.stepContentRegion = stepContentRegion
    self.subtitle = subtitle
    self.tutorialImage = tutorialImage
    self.desc1 = desc1
    self.desc2 = desc2
    self.desc3 = desc3
    self.option1 = option1
    self.option2 = option2
    self.option3 = option3
    self.option4 = option4
    self.option1Alt = option1Alt
    self.option2Alt = option2Alt
    self.option3Alt = option3Alt
    self.option4Alt = option4Alt
    self.dynamicOptionsFrame = dynamicOptionsFrame
    self.prevBtn = prevBtn
    self.nextBtn = nextBtn
    self.skipBtn = skipBtn

    self.currentStep = 1
    self.stepButtons = {}

    frame:Hide()

    return frame
end

function NaowhUIInstaller:CreateStepButtons(installer)
    if not installer or not installer.StepTitles then
        return
    end

    for _, btn in pairs(self.stepButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    self.stepButtons = {}

    for i, title in ipairs(installer.StepTitles) do
        local btn = CreateFrame("Button", nil, self.stepContent, "BackdropTemplate")
        btn:SetSize(STEP_PANEL_WIDTH - 40, 30)
        btn:SetPoint("TOPLEFT", self.stepContent, "TOPLEFT", 0, -(i-1) * 35)

        btn:SetBackdrop({
            bgFile = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\UI-Background-Marble",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 4,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })

        local versionStatus = self:GetVersionStatusForStep(title, i)
        if versionStatus == "uptodate" then
            btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95)
            btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9)
        elseif versionStatus == "outdated" then
            btn:SetBackdropColor(0.4, 0.0, 0.05, 0.95)
            btn:SetBackdropBorderColor(0.8, 0.0, 0.1, 0.9)
        elseif versionStatus == "notinstalled" then
            btn:SetBackdropColor(0.2, 0.2, 0.2, 0.95)
            btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)
        else
            btn:SetBackdropColor(0.0, 0.0, 0.0, 0.4)
            btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
        end

        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("CENTER")
        text:SetText(title)
        btn:SetFontString(text)  

        if versionStatus == "uptodate" then
            text:SetTextColor(0.0, 1.0, 0.0, 1)
        elseif versionStatus == "outdated" then
            text:SetTextColor(1.0, 0.2, 0.2, 1)
        elseif versionStatus == "notinstalled" then
            text:SetTextColor(1.0, 1.0, 1.0, 1)
        else
            text:SetTextColor(0.9, 0.9, 0.9, 1)
        end

        btn.stepIndex = i
        btn.versionStatus = versionStatus
        btn:SetScript("OnClick", function() self:GoToStep(i) end)
        btn:SetScript("OnEnter", function()
            if btn.versionStatus == "uptodate" then
                btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95)
                btn:SetBackdropBorderColor(0.2, 1.0, 0.2, 1.0)
                text:SetTextColor(0.0, 1.0, 0.0, 1)
            elseif btn.versionStatus == "outdated" then
                btn:SetBackdropColor(0.5, 0.1, 0.15, 0.95)
                btn:SetBackdropBorderColor(1.0, 0.2, 0.3, 1.0)
                text:SetTextColor(1.0, 0.2, 0.2, 1)
            elseif btn.versionStatus == "notinstalled" then
                btn:SetBackdropColor(0.3, 0.3, 0.3, 0.95)
                btn:SetBackdropBorderColor(0.8, 0.8, 0.8, 1.0)
                text:SetTextColor(1.0, 1.0, 1.0, 1)
            else
                btn:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
                btn:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8)
                text:SetTextColor(1, 1, 1, 1)
            end
        end)
        btn:SetScript("OnLeave", function()
            if i == self.currentStep then
                if btn.versionStatus == "uptodate" then
                    btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95)
                    btn:SetBackdropBorderColor(0.4, 1.0, 0.4, 1.0)
                elseif btn.versionStatus == "outdated" then
                    btn:SetBackdropColor(0.5, 0.1, 0.15, 0.95)
                    btn:SetBackdropBorderColor(1.0, 0.4, 0.4, 1.0)
                elseif btn.versionStatus == "notinstalled" then
                    btn:SetBackdropColor(0.3, 0.3, 0.3, 0.95)
                    btn:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0)
                else
                    btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
                    btn:SetBackdropBorderColor(0.5, 0.7, 1.0, 1.0)
                end
                text:SetTextColor(1.0, 1.0, 1.0, 1)
            else
                if btn.versionStatus == "uptodate" then
                    btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95)
                    btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9)
                    text:SetTextColor(0.0, 1.0, 0.0, 1)
                elseif btn.versionStatus == "outdated" then
                    btn:SetBackdropColor(0.4, 0.0, 0.05, 0.95)
                    btn:SetBackdropBorderColor(0.8, 0.0, 0.1, 0.9)
                    text:SetTextColor(1.0, 0.2, 0.2, 1)
                elseif btn.versionStatus == "notinstalled" then
                    btn:SetBackdropColor(0.2, 0.2, 0.2, 0.95)
                    btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)
                    text:SetTextColor(1.0, 1.0, 1.0, 1)
                else
                    btn:SetBackdropColor(0.0, 0.0, 0.0, 0.4)
                    btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
                    text:SetTextColor(0.9, 0.9, 0.9, 1)
                end
            end
        end)

        self.stepButtons[i] = btn
    end

    self.stepContent:SetHeight(#installer.StepTitles * 35)
end

function NaowhUIInstaller:UpdateStepButtons()
    if not self.stepButtons then
        return
    end

    for i, btn in pairs(self.stepButtons) do

        if self.installer and self.installer.StepTitles then
            local stepTitle = self.installer.StepTitles[i]
            if stepTitle then
                local newStatus = self:GetVersionStatusForStep(stepTitle, i)
                btn.versionStatus = newStatus
            end
        end

        local text = btn:GetFontString()

        if i == self.currentStep then
            if btn.versionStatus == "uptodate" then
                btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95)
                btn:SetBackdropBorderColor(0.4, 1.0, 0.4, 1.0)
            elseif btn.versionStatus == "outdated" then
                btn:SetBackdropColor(0.5, 0.1, 0.15, 0.95)
                btn:SetBackdropBorderColor(1.0, 0.4, 0.4, 1.0)
            elseif btn.versionStatus == "notinstalled" then
                btn:SetBackdropColor(0.3, 0.3, 0.3, 0.95)
                btn:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0)
            else
                btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
                btn:SetBackdropBorderColor(0.5, 0.7, 1.0, 1.0)
            end
            if text then text:SetTextColor(1.0, 1.0, 1.0, 1) end
        else
            if btn.versionStatus == "uptodate" then
                btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95)
                btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9)
                if text then text:SetTextColor(0.0, 1.0, 0.0, 1) end
            elseif btn.versionStatus == "outdated" then
                btn:SetBackdropColor(0.4, 0.0, 0.05, 0.95)
                btn:SetBackdropBorderColor(0.8, 0.0, 0.1, 0.9)
                if text then text:SetTextColor(1.0, 0.2, 0.2, 1) end
            elseif btn.versionStatus == "notinstalled" then
                btn:SetBackdropColor(0.2, 0.2, 0.2, 0.95)
                btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)
                if text then text:SetTextColor(1.0, 1.0, 1.0, 1) end
            else
                btn:SetBackdropColor(0.0, 0.0, 0.0, 0.4)
                btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
                if text then text:SetTextColor(0.9, 0.9, 0.9, 1) end
            end
        end
    end
end

function NaowhUIInstaller:RefreshAllStepButtons()
    if not self or not self.stepButtons or not self.installer or not self.installer.StepTitles then
        return
    end

    for i, btn in pairs(self.stepButtons) do
        local stepTitle = self.installer.StepTitles[i]
        if stepTitle then
            local versionStatus = self:GetVersionStatusForStep(stepTitle, i)
            btn.versionStatus = versionStatus

            local text = btn:GetFontString()

            if versionStatus == "uptodate" then
                btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95)
                btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9)
                if text then text:SetTextColor(0.0, 1.0, 0.0, 1) end
            elseif versionStatus == "outdated" then
                btn:SetBackdropColor(0.4, 0.0, 0.05, 0.95)
                btn:SetBackdropBorderColor(0.8, 0.0, 0.1, 0.9)
                if text then text:SetTextColor(1.0, 0.2, 0.2, 1) end
            elseif versionStatus == "notinstalled" then
                btn:SetBackdropColor(0.2, 0.2, 0.2, 0.95)
                btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)
                if text then text:SetTextColor(1.0, 1.0, 1.0, 1) end
            else
                btn:SetBackdropColor(0.0, 0.0, 0.0, 0.4)
                btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
                if text then text:SetTextColor(0.9, 0.9, 0.9, 1) end
            end

            if i == self.currentStep then
                if versionStatus == "uptodate" then
                    btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95)
                    btn:SetBackdropBorderColor(0.4, 1.0, 0.4, 1.0)
                elseif versionStatus == "outdated" then
                    btn:SetBackdropColor(0.5, 0.1, 0.15, 0.95)
                    btn:SetBackdropBorderColor(1.0, 0.4, 0.4, 1.0)
                elseif versionStatus == "notinstalled" then
                    btn:SetBackdropColor(0.3, 0.3, 0.3, 0.95)
                    btn:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0)
                else
                    btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
                    btn:SetBackdropBorderColor(0.5, 0.7, 1.0, 1.0)
                end
                if text then text:SetTextColor(1.0, 1.0, 1.0, 1) end
            end
        end
    end
end

function NaowhUIInstaller:Show(installer)
    if not installer then
        return
    end

    self:CreateFrame()
    self.installer = installer

    self:CreateStepButtons(installer)

    self.frame:Show()

    self:GoToStep(1)
end

function NaowhUIInstaller:Hide()
    if self.frame then
        self.frame:Hide()
    end
end

function NaowhUIInstaller:GoToStep(step)
    if not self.installer or not self.installer.Pages or not self.installer.Pages[step] then
        return
    end

    self.currentStep = step

    self:ClearContent()
    self:UpdateStepButtons()

    if self.prevBtn then
        self.prevBtn:SetEnabled(step > 1)
    end

    if self.nextBtn and self.installer.StepTitles then
        self.nextBtn:SetEnabled(step < #self.installer.StepTitles)

        if step >= #self.installer.StepTitles then
            self.nextBtn:SetText("Finish")
        else
            self.nextBtn:SetText("Continue")
        end
    end

    _G.PluginInstallFrame = {
        Title = self.subtitle,
        SubTitle = self.subtitle,  
        Desc1 = self.desc1,
        Desc2 = self.desc2,
        Desc3 = self.desc3,
        Option1 = self.option1,
        Option2 = self.option2,
        Option3 = self.option3,
        Option4 = self.option4,
        Next = self.nextBtn,
        Prev = self.prevBtn,
        Skip = self.skipBtn,
        CreateClassButtons = function() return self:CreateClassButtons() end,
        ShowTutorialImage = function(imagePath) return self:ShowTutorialImage(imagePath) end
    }

    local SE = NUI:GetModule("Setup")
    if SE and SE.Setup then
        local originalSetup = SE.Setup
        local installerSelf = self  
        SE.Setup = function(setupModule, addonName, ...)
            local result = originalSetup(setupModule, addonName, ...)

            if addonName and installerSelf.recentlyInstalled then

                if addonName ~= "WeakAuras" then
                    installerSelf.recentlyInstalled[addonName] = true
                end

                if installerSelf and installerSelf.RefreshAllStepButtons then
                    installerSelf:RefreshAllStepButtons()
                end
            end

            return result
        end
    end

    self.installer.Pages[step]()

    if step == 1 then
        self.desc2:SetText("If updating, click addons highlighted in red and 'Setup'")
    end

    self:RepositionOptionButtons()
    self:SetSubtitleFont()
end

function NaowhUIInstaller:RepositionOptionButtons()
    local visibleButtons = {}
    if self.option1:IsShown() then table.insert(visibleButtons, self.option1) end
    if self.option2:IsShown() then table.insert(visibleButtons, self.option2) end
    if self.option3:IsShown() then table.insert(visibleButtons, self.option3) end
    if self.option4:IsShown() then table.insert(visibleButtons, self.option4) end

    local buttonCount = #visibleButtons
    if buttonCount == 0 then return end

    for _, btn in ipairs(visibleButtons) do
        btn:ClearAllPoints()
    end

    local buttonWidth = 180
    local spacing = 20
    local contentPadding = 60
    local usableWidth = CONTENT_PANEL_WIDTH - contentPadding

    if buttonCount == 1 then
        visibleButtons[1]:SetPoint("TOP", self.desc3, "BOTTOM", 0, -40)
    elseif buttonCount == 2 then

        local totalWidth = (buttonWidth * 2) + spacing
        local startOffset = -(totalWidth / 2) + (buttonWidth / 2)
        visibleButtons[1]:SetPoint("TOP", self.desc3, "BOTTOM", startOffset, -40)
        visibleButtons[2]:SetPoint("TOP", self.desc3, "BOTTOM", startOffset + buttonWidth + spacing, -40)
    elseif buttonCount == 3 then

        local totalWidth = (buttonWidth * 3) + (spacing * 2)
        if totalWidth > usableWidth then

            visibleButtons[1]:SetPoint("TOP", self.desc3, "BOTTOM", 0, -40)
            visibleButtons[2]:SetPoint("TOP", visibleButtons[1], "BOTTOM", 0, -10)
            visibleButtons[3]:SetPoint("TOP", visibleButtons[2], "BOTTOM", 0, -10)
        else

            local startOffset = -(totalWidth / 2) + (buttonWidth / 2)
            visibleButtons[1]:SetPoint("TOP", self.desc3, "BOTTOM", startOffset, -40)
            visibleButtons[2]:SetPoint("TOP", self.desc3, "BOTTOM", startOffset + buttonWidth + spacing, -40)
            visibleButtons[3]:SetPoint("TOP", self.desc3, "BOTTOM", startOffset + (buttonWidth + spacing) * 2, -40)
        end
    elseif buttonCount == 4 then

        visibleButtons[1]:SetPoint("TOP", self.desc3, "BOTTOM", 0, -40)
        visibleButtons[2]:SetPoint("TOP", visibleButtons[1], "BOTTOM", 0, -10)
        visibleButtons[3]:SetPoint("TOP", visibleButtons[2], "BOTTOM", 0, -10)
        visibleButtons[4]:SetPoint("TOP", visibleButtons[3], "BOTTOM", 0, -10)
    end
end

function NaowhUIInstaller:NextStep()
    if not self.installer or not self.installer.StepTitles then
        self:Hide()
        return
    end

    if self.currentStep >= #self.installer.StepTitles then
        self:Hide()
        return
    end

    self:GoToStep(self.currentStep + 1)
end

function NaowhUIInstaller:PreviousStep()
    if self.currentStep > 1 then
        self:GoToStep(self.currentStep - 1)
    end
end

function NaowhUIInstaller:SetSubtitleFont()

    if self.subtitle then
        self.subtitle:SetFont("Interface\\AddOns\\NaowhUI\\Core\\Media\\Fonts\\Naowh.ttf", 24, "OUTLINE")
        self.subtitle:SetTextColor(1, 1, 1, 1) 
    end
end

function NaowhUIInstaller:ClearContent()

    self.subtitle:SetText("")
    self.desc1:SetText("")
    self.desc2:SetText("")
    self.desc3:SetText("")

    self.subtitle:ClearAllPoints()
    if self.currentStep == 1 then

        self.subtitle:SetPoint("TOP", self.stepContentRegion, "TOP", 0, -50)
    else

        self.subtitle:SetPoint("TOP", self.stepContentRegion, "TOP", 0, 0)
    end

    self.subtitle:SetWidth(CONTENT_PANEL_WIDTH - 96)
    self.desc1:SetWidth(CONTENT_PANEL_WIDTH - 96)
    self.desc2:SetWidth(CONTENT_PANEL_WIDTH - 96)
    self.desc3:SetWidth(CONTENT_PANEL_WIDTH - 96)

    self:SetSubtitleFont()

    self.tutorialImage:Hide()
    self.desc1:ClearAllPoints()
    self.desc1:SetPoint("TOP", self.subtitle, "BOTTOM", 0, -20)

    self.option1:Hide()
    self.option1:SetScript("OnClick", nil)
    self.option2:Hide()
    self.option2:SetScript("OnClick", nil)
    self.option3:Hide()
    self.option3:SetScript("OnClick", nil)
    self.option4:Hide()
    self.option4:SetScript("OnClick", nil)

    self.dynamicOptionsFrame:Hide()
    self:ClearDynamicOptions()
end

function NaowhUIInstaller:ClearDynamicOptions()
    if not self.dynamicButtons then
        self.dynamicButtons = {}
        return
    end

    for _, btn in pairs(self.dynamicButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    self.dynamicButtons = {}
end

function NaowhUIInstaller:ShowTutorialImage(imagePath)
    if imagePath and self.tutorialImage then
        self.tutorialImage:SetTexture(imagePath)
        self.tutorialImage:Show()

        if self.currentStep == 1 then

            self.subtitle:ClearAllPoints()
            self.subtitle:SetPoint("TOP", self.stepContentRegion, "TOP", 0, -45)
            self.subtitle:SetWidth(CONTENT_PANEL_WIDTH - 96) 

            self.tutorialImage:ClearAllPoints()
            self.tutorialImage:SetPoint("TOP", self.subtitle, "BOTTOM", 0, -30)

            self.desc1:ClearAllPoints()
            self.desc1:SetPoint("TOP", self.tutorialImage, "BOTTOM", 0, -30)
            self.desc1:SetWidth(CONTENT_PANEL_WIDTH - 96) 
        else

            self.tutorialImage:ClearAllPoints()
            self.tutorialImage:SetPoint("TOP", self.subtitle, "BOTTOM", 0, -20)

            self.desc1:ClearAllPoints()
            self.desc1:SetPoint("TOP", self.tutorialImage, "BOTTOM", 0, -20)
            self.desc1:SetWidth(CONTENT_PANEL_WIDTH - 96) 
        end
    else

        self.tutorialImage:Hide()

        if self.currentStep ~= 1 then
            self.subtitle:ClearAllPoints()
            self.subtitle:SetPoint("TOP", self.stepContentRegion, "TOP", 0, 0)
            self.subtitle:SetWidth(CONTENT_PANEL_WIDTH - 96) 
        end

        self.desc1:ClearAllPoints()
        self.desc1:SetPoint("TOP", self.subtitle, "BOTTOM", 0, -20)
        self.desc1:SetWidth(CONTENT_PANEL_WIDTH - 96) 
    end
end

function NaowhUIInstaller:CreateClassButtons()
    self:ClearDynamicOptions()

    self.dynamicOptionsFrame:Show()

    local playerClass = select(2, UnitClass("player"))

    local classes = {
        {name = "Death Knight", file = "DeathKnight", class = "DEATHKNIGHT"},
        {name = "Demon Hunter", file = "DemonHunter", class = "DEMONHUNTER"},
        {name = "Druid", file = "Druid", class = "DRUID"},
        {name = "Evoker", file = "Evoker", class = "EVOKER"},
        {name = "Hunter", file = "Hunter", class = "HUNTER"},
        {name = "Mage", file = "Mage", class = "MAGE"},
        {name = "Monk", file = "Monk", class = "MONK"},
        {name = "Paladin", file = "Paladin", class = "PALADIN"},
        {name = "Priest", file = "Priest", class = "PRIEST"},
        {name = "Rogue", file = "Rogue", class = "ROGUE"},
        {name = "Shaman", file = "Shaman", class = "SHAMAN"},
        {name = "Warlock", file = "Warlock", class = "WARLOCK"},
        {name = "Warrior", file = "Warrior", class = "WARRIOR"}
    }

    self.dynamicButtons = {}
    local buttonsPerRow = 3
    local buttonWidth = 150  
    local buttonHeight = 45  
    local horizontalSpacing = 20  
    local verticalSpacing = 12   

    local totalGridWidth = (buttonWidth * buttonsPerRow) + (horizontalSpacing * (buttonsPerRow - 1))

    local frameWidth = self.dynamicOptionsFrame:GetWidth()
    local gridStartX = (frameWidth - totalGridWidth) / 2

    local minMargin = 20
    if gridStartX < minMargin then
        gridStartX = minMargin

        local availableWidth = frameWidth - (2 * minMargin)
        local newButtonWidth = (availableWidth - (horizontalSpacing * (buttonsPerRow - 1))) / buttonsPerRow
        if newButtonWidth < buttonWidth then
            buttonWidth = math.max(newButtonWidth, 120) 
            totalGridWidth = (buttonWidth * buttonsPerRow) + (horizontalSpacing * (buttonsPerRow - 1))
            gridStartX = (frameWidth - totalGridWidth) / 2
        end
    end

    for i, classData in ipairs(classes) do
        local row = math.floor((i - 1) / buttonsPerRow)
        local col = (i - 1) % buttonsPerRow

        local btn = self:CreateModernButton(self.dynamicOptionsFrame, classData.name,
                                           buttonWidth, buttonHeight, "class")

        local xOffset = gridStartX + col * (buttonWidth + horizontalSpacing)
        local yOffset = -row * (buttonHeight + verticalSpacing)

        btn:SetPoint("TOPLEFT", self.dynamicOptionsFrame, "TOPLEFT", xOffset, yOffset)

        if classData.class == playerClass then
            btn:SetText(classData.name .. " (Current)")

            btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95) 
            btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9) 
            btn:GetFontString():SetTextColor(0.0, 1.0, 0.0, 1) 

            btn:SetScript("OnEnter", function()
                btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95) 
                btn:SetBackdropBorderColor(0.2, 1.0, 0.2, 1.0) 
                btn:GetFontString():SetTextColor(0.0, 1.0, 0.0, 1)
            end)

            btn:SetScript("OnLeave", function()
                btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95) 
                btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9) 
                btn:GetFontString():SetTextColor(0.0, 1.0, 0.0, 1)
            end)
        end

        btn:SetScript("OnClick", function()
            self:InstallClassWeakAuras(classData.file)
        end)

        btn:Show()
        self.dynamicButtons[i] = btn
    end
end

function NaowhUIInstaller:ExtractAddonNameFromCurrentStep()
    if not self.installer or not self.installer.StepTitles or not self.currentStep then
        return nil
    end

    local stepTitle = self.installer.StepTitles[self.currentStep]
    if not stepTitle then
        return nil
    end

    local addonMap = {
        ["ElvUI"] = "ElvUI",
        ["BigWigs"] = "BigWigs",
        ["Details"] = "Details",
        ["HidingBar"] = "HidingBar",
        ["NameplateAuras"] = "NameplateAuras",
        ["OmniCD"] = "OmniCD",
        ["Plater"] = "Plater",
        ["WarpDeplete"] = "WarpDeplete",
        ["General WeakAuras"] = "General WeakAuras",
        ["Class WeakAuras"] = "Class WeakAuras"
    }

    return addonMap[stepTitle]
end

function NaowhUIInstaller:MarkAsRecentlyInstalled(addonName)
    if not self.recentlyInstalled then
        self.recentlyInstalled = {}
    end
    self.recentlyInstalled[addonName] = true
end

function NaowhUIInstaller:RefreshStepButtonStatus(stepTitle)

    if not self.installer or not self.installer.StepTitles then
        return
    end

    for i, title in ipairs(self.installer.StepTitles) do
        if title == stepTitle then
            local btn = self.stepButtons[i]
            if btn then
                local newStatus = self:GetVersionStatusForStep(title, i)
                btn.versionStatus = newStatus

                local text = btn:GetFontString()

                if i == self.currentStep then

                    if newStatus == "uptodate" then
                        btn:SetBackdropColor(0.1, 0.5, 0.1, 0.95)
                        btn:SetBackdropBorderColor(0.4, 1.0, 0.4, 1.0)  
                    elseif newStatus == "outdated" then
                        btn:SetBackdropColor(0.5, 0.1, 0.15, 0.95)
                        btn:SetBackdropBorderColor(1.0, 0.4, 0.4, 1.0)  
                    elseif newStatus == "notinstalled" then
                        btn:SetBackdropColor(0.3, 0.3, 0.3, 0.95)
                        btn:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0)  
                    else
                        btn:SetBackdropColor(0.15, 0.2, 0.35, 0.95)
                        btn:SetBackdropBorderColor(0.5, 0.7, 1.0, 1.0)  
                    end
                    text:SetTextColor(1.0, 1.0, 1.0, 1)
                else
                    if newStatus == "uptodate" then
                        btn:SetBackdropColor(0.0, 0.4, 0.0, 0.95)
                        btn:SetBackdropBorderColor(0.0, 0.8, 0.0, 0.9)
                        text:SetTextColor(0.0, 1.0, 0.0, 1)
                    elseif newStatus == "outdated" then
                        btn:SetBackdropColor(0.4, 0.0, 0.05, 0.95)
                        btn:SetBackdropBorderColor(0.8, 0.0, 0.1, 0.9)
                        text:SetTextColor(1.0, 0.2, 0.2, 1)
                    elseif newStatus == "notinstalled" then
                        btn:SetBackdropColor(0.2, 0.2, 0.2, 0.95)
                        btn:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)
                        text:SetTextColor(1.0, 1.0, 1.0, 1)
                    else
                        btn:SetBackdropColor(0.0, 0.0, 0.0, 0.4)
                        btn:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6)
                        text:SetTextColor(0.9, 0.9, 0.9, 1)
                    end
                end
            end
            break
        end
    end
end

function NaowhUIInstaller:SetupAddonAndRefreshStatus(addonName, ...)
    local SE = NUI:GetModule("Setup")
    if SE and SE.Setup then
        SE:Setup(addonName, ...)
        self:MarkAsRecentlyInstalled(addonName)
        self:RefreshStepButtonStatus(addonName)
        C_Timer.After(0.2, function()
            self:RefreshStepButtonStatus(addonName)
        end)
    end
end

function NaowhUIInstaller:InstallClassWeakAuras(className)
    local SE = NUI:GetModule("Setup")

    if SE and SE.Setup then
        NUI:LoadData()

        C_Timer.After(0.1, function()
            if NUI[className] then
                SE:Setup("WeakAuras", nil, nil, nil, nil, className)

                self:RefreshStepButtonStatus("Class WeakAuras")

                C_Timer.After(0.2, function()
                    self:RefreshStepButtonStatus("Class WeakAuras")
                end)
            else
                print("NaowhUI: Error - " .. className .. " data not found. " ..
                      "Please ensure NaowhUI_Data addon is properly installed.")
            end
        end)
    end
end

function NaowhUIInstaller:CreateCompatibilityLayer()

    _G.PluginInstallFrame = {
        SubTitle = self.subtitle,  
        Desc1 = self.desc1,
        Desc2 = self.desc2,
        Desc3 = self.desc3,
        Option1 = self.option1,
        Option2 = self.option2,
        Option3 = self.option3,
        IsShown = function() return self.frame and self.frame:IsShown() end,

        Show = function() end,
        Hide = function() end,

        CreateClassButtons = function() return self:CreateClassButtons() end
    }
end

local installerFrame = NaowhUIInstaller
installerFrame:CreateFrame()
installerFrame:CreateCompatibilityLayer()

_G.NaowhUIInstaller = installerFrame
