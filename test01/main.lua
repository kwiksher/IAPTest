local command = require("command")

-- Grab info about the platform
local platform = system.getInfo( "platformName" )
if ( platform == "simulator" ) then
    native.showAlert( "Notice", "In-app purchases are not supported in the Corona Simulator.", { "OK" } )

    command.copyFile("../build4/components/store/model.lua", system.ResourceDirectory, "model.lua", system.ResourceDirectory, true)

    command.copyFile("../build4/config.lua", system.ResourceDirectory, "model.lua", system.ResourceDirectory, true)

    command.copyFile("../build4/build.settings", system.ResourceDirectory, "model.lua", system.ResourceDirectory, true)
end

local model = require("model")
-----------------------
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
view:createRadioButtons()
view:createTableView(viewData, controller)
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
    command.renderLua("InAppPurchase/productData.tmpl",  "InAppPurchase/productData.lua", data)
end