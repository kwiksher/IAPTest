require("extlib.Deferred")
require("extlib.Callbacks")
_W = display.contentWidth
_H = display.contentHeight
local composer = require("composer")
local command = require("command")

-- Grab info about the platform
local platform = system.getInfo( "environment" )
print(platform)
--[[
if ( platform == "simulator" ) then
    local buttons = { "OK" , "No"}
    local function onComplete(e)
        local button = buttons[e.index]
        if button == "OK" then
            command.copyFile("../build4/components/store/model.lua", system.ResourceDirectory, "components/store/model.lua", system.ResourceDirectory, true)
            command.copyFile("../build4/config.lua", system.ResourceDirectory, "config.lua", system.ResourceDirectory, true)
            command.copyFile("../build4/build.settings", system.ResourceDirectory, "build.settings", system.ResourceDirectory, true)
            command.copyFile("../build4/model.lua", system.ResourceDirectory, "model.lua", system.ResourceDirectory, true)
            return
        end
    end
    native.showAlert( "Initialization", "Copy your components/store/model.lua to unitTest automatically?", buttons, onComplete )
end
--]]
local model = require("components.store.model")

----------------------
-- widget to show the product list
-- then user to select one of which to test
--
local viewData = {
    {
        name   = "PRODUCT",
        apple = "APPLE",
        google = "GOOGLE"
    }
}
for bookName, product in pairs(model.catalogue.products) do
    local data = {
        name   = bookName,
        apple = product.productNames.apple,
        google = product.productNames.google
    }
    table.insert(viewData, data)
end
--
--
local controller = require("controller")
local view = require("view")
--
local radioButtons = view:createRadioButtons()
local tableView = view:createTableView(viewData, controller)
controller.onSelected = function (e)
    local data = {}
    if e.device == "apple" then
        if e.product.type == "non-consumable" then
            data.NonConsumableTier1 = e.product.apple
        else
            data.ConsumableTier1 = e.product.apple
        end
        -- "{{ConsumableTier1}}",
        -- "{{NonConsumableTier1}}",
        -- "{{SubscriptionTier1}}",
    elseif e.device == "google" then
        if e.product.type == "non-consumable" then
            data.managed = e.product.google
        else
            data.unmanaged = e.product.google
        end
        -- "iaptesting.managed",
        -- "iaptesting.unmanaged",
        -- "iaptesting.badid",
    end
    --
    for k, v in pairs (data) do print(k, v) end

    --require("units.testDownload").run(e.product.name)
    tableView.alpha = 0
    radioButtons.alpha = 0
    require("units.testDialogView").run(e.product.name)
    -- composer.showOverlay("units.infoPage", {params ={product = e.product.name}})
   -- command.renderLua("InAppPurchase/productData.tmpl",  "InAppPurchase/productData.lua", data)
end

