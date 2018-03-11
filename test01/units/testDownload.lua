local _M = {}
-------------------------------------
-- Download test
-------------------------------------
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")

local function onSuccess (selectedPurchase, version)

    local path = system.pathForFile(selectedPurchase..version.."/model.json", system.ApplicationSupportDirectory)
    print(path)
    local fh, reason = io.open( path, "r" )
    if fh then
        local alert = native.showAlert( "UniTest",
        "Success "..selectedPurchase .." " ..version, { "Close"})
    else
        local alert = native.showAlert( "UniTest",
        "Fail "..selectedPurchase .." " ..version.."is not found in the assets.zip", { "Close"})
    end
end

local function onError(selectedPurchase,version, message)
    local alert = native.showAlert( "UniTest",
    "Fail " ..selectedPurchase, { "Close"})
end

function _M.run(selectedPurchase)
    print(selectedPurchase)
    local buttons = { "Cancel"}

    for k,  v in pairs( model.epsodes[selectedPurchase].versions) do
        table.insert(buttons, v)
    end

    local function onComplete(e)
        local version = buttons[e.index]
        if version ~="Cancel" then
            downloadManager:init(onSuccess, onError)
            downloadManager:startDownload(selectedPurchase, version)
        else
            return
        end
    end

    local alert = native.showAlert( "unitTest",
    "Download "..selectedPurchase, buttons,  onComplete)
end


return _M