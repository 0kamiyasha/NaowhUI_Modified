local NUI = unpack(NaowhUI)
local I = NUI:GetModule("Installer")

-- Initialize the installer module
function I:OnInitialize()
    -- This will be set by the game-specific installer files
    self.installer = nil
end

function I:OnEnable()
    -- Set up the installer frame reference after it's been created
    if NaowhUIInstaller then
        self.InstallerFrame = NaowhUIInstaller
    end
end
