local _M = {}
-------------------------------------
-- Dialog Test
-------------------------------------
local downloadManager = require("components.store.downloadManager")
local model           = require("components.store.model")

local storeFSM   = require("components.store.storeFSM").getInstance()
local view = require("components.store.view").new()

function _M.run(selectedPurchase)
    model.INFO_PAGE = "units.infoPage"
    -- thumbnail view is default
    storeFSM:init(true, view)
    -- click an icon to open the dialog
    storeFSM.fsm:clickImage(model.epsodes[selectedPurchase])

    -- local isPurchased = false
    -- local isDownloaded = false
  -- view:createDialog(model.epsodes[selectedPurchase], isPurchased, isDownloaded)
  -- view:controlDialog(model.epsodes[selectedPurchase], isPurchased, isDownloaded)

end

return _M