local _M = {}
-------------------------------------
-- Download test
-------------------------------------
local model           = require("components.store.model")

local storeFSM   = require("components.store.storeFSM").getInstance()
local view = require("components.store.view").new()


local sceneName = ...
local composer  = require( "composer" )
local scene     = composer.newScene(sceneName)
------------------------------------------------------------
local layer = {}
local selectedPurchase
------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view
    selectedPurchase = event.params.selectedPurchase

    layer.bookXXIcon = display.newRoundedRect(sceneGroup, _W/4, _H/2, _W*0.2, _H*0.2, 12 )
    layer.bookXXIcon.strokeWidth = 3
    layer.bookXXIcon:setFillColor( 0.5 )
    layer.bookXXIcon:setStrokeColor( 1, 0, 0 )
    layer.bookXXIcon.imagePath = "button.png"
    layer.bookXXIcon.name      ="button"

    layer.purchaseBtn = display.newText(sceneGroup, "Purchase", _W/2, _H/2-50, nil, 14)
    layer.purchaseBtn.imagePath = "button.png"
    layer.downloadBtn = display.newText(sceneGroup, "Download", _W/2, _H/2, nil, 14)
    layer.downloadBtn.imagePath = "button.png"
    layer.savedBtn     = display.newText(sceneGroup, "Saved", _W/2, _H/2+50, nil, 14)
    layer.savedBtn.imagePath = "button.png"
    local versions = model.epsodes[selectedPurchase].versions
    for k, ver in pairs(versions) do
        layer["version_"..ver] = display.newText(sceneGroup, ver, _W/2, _H/2+50+50*k, nil, 14)
        layer["version_"..ver].imagePath = "button.png"
    end
end
--
function scene:show( event )
  local sceneGroup = self.view
  if event.phase == "did" then
    view:init(sceneGroup, layer, storeFSM.fsm)
    storeFSM.view = view
  end
end
--
function scene:hide( event )
   if event.phase == "will" then
   elseif event.phase == "did" then
   end
end
--
function scene:destroy( event )
end
--
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene