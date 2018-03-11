local model = require("components.store.model")

local _M = {}

function _M.tableViewListener( event )
    local phase = event.phase
    --print( "Event.phase is:", event.phase )
end
-- Handle row updates
function _M.onRowUpdate( event )
    local phase = event.phase
    local row = event.row
    --print( row.index, ": is now onscreen" )
end
-- Handle touches on the row
function _M.onRowTouch( event )
    local phase = event.phase
    local row = event.target
    if ( "release" == phase ) then
        if row.index == 1 then return end
        local prod = model.catalogue.products[row.params.name]
        local device = row.params.device
        local function onComplete(e)
            if e.index == 1 then
                _M.onSelected({
                    device=device,
                    product={
                        name = row.params.name,
                        apple = prod.productNames.apple,
                        google = prod.productNames.google,
                        type = prod.productType
                }})
            end
        end
        --
        local alert = native.showAlert( "UniTest",
            row.params.name, { "OK", "Cancel"},
            onComplete)
    end
end

return _M