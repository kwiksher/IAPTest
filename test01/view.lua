local widget = require( "widget" )
local _M = {}

local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
local tabBarHeight = 20
local themeID = "widget_theme_android_holo_dark"

-- Set color variables depending on theme
local tableViewColors = {
    rowColor = { default = { 1 }, over = { 30/255, 144/255, 1 } },
    lineColor = { 220/255 },
    catColor = { default = { 150/255, 160/255, 180/255, 200/255 }, over = { 150/255, 160/255, 180/255, 200/255 } },
    defaultLabelColor = { 0, 0, 0, 0.6 },
    catLabelColor = { 0 }
}
if ( themeID == "widget_theme_android_holo_dark" ) then
    tableViewColors.rowColor.default = { 48/255 }
    tableViewColors.rowColor.over = { 72/255 }
    tableViewColors.lineColor = { 36/255 }
    tableViewColors.catColor.default = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.catColor.over = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.defaultLabelColor = { 1, 1, 1, 0.6 }
    tableViewColors.catLabelColor = { 1 }
elseif ( themeID == "widget_theme_android_holo_light" ) then
    tableViewColors.rowColor.default = { 250/255 }
    tableViewColors.rowColor.over = { 240/255 }
    tableViewColors.lineColor = { 215/255 }
    tableViewColors.catColor.default = { 220/255, 220/255, 220/255, 0.9 }
    tableViewColors.catColor.over = { 220/255, 220/255, 220/255, 0.9 }
    tableViewColors.defaultLabelColor = { 0, 0, 0, 0.6 }
    tableViewColors.catLabelColor = { 0 }
end

-- Forward reference for the tableView
local tableView
local fontSize = 20
-- Handle row rendering
local function onRowRender( event )
    local phase = event.phase
    local row = event.row
    local groupContentHeight = row.contentHeight
    local data = row.params
    --
    local name = display.newText( row, data.name, 0, 0, nil, fontSize )
    name.x = 10
    name.anchorX = 0
    name.y = groupContentHeight * 0.5
    --
    local apple = display.newText( row, data.apple, row.contentWidth/3, 0, nil, fontSize )
    apple.anchorX = 0
    apple.y = groupContentHeight * 0.5
    --
    local google = display.newText( row, data.google, row.contentWidth/3*2, 0, nil, fontSize )
    google.anchorX = 0
    google.y = groupContentHeight * 0.5

    if _M.device =="Apple" then
        row.params.device = "apple"
        google.alpha = 0.5
    else
        row.params.device = "google"
        apple.alpha = 0.5
    end
end

function _M:createTableView(data, controller)
    _M.device = "Apple"
    -- Create a tableView
    tableView = widget.newTableView
    {
        top = 100-oy,
        left = -ox,
        width = display.contentWidth+ox+ox,
        height = display.contentHeight-tabBarHeight+oy+oy-32,
        hideBackground = true,
        listener = controller.tableViewListener,
        onRowRender = onRowRender,
        onRowUpdate = controller.onRowUpdate,
        onRowTouch = controller.onRowTouch,
    }

    -- Insert the row into the tableView
    for i=1, #data do
        print("--------", data[i].name)
        local rowHeight = 50
        local rowColor = {
            default = tableViewColors.rowColor.default,
            over = tableViewColors.rowColor.over,
        }

        tableView:insertRow
        {
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = tableViewColors.lineColor,
            params = data[i]
        }
    end
    return tableView
end

-- Handle press events for the buttons
local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    _M.device = switch.id
    tableView:reloadData()
end
--
function _M:createRadioButtons()
    -- Create a group for the radio button set
    local radioGroup = display.newGroup()
    local text = display.newText(radioGroup, "Choose Device", -display.contentWidth/2+50 , 20, nil, 14)
    radioGroup.x  = display.contentWidth/2
    radioGroup.y = 50

    -- Create two associated radio buttons (inserted into the same display group)
    local radioButton1 = widget.newSwitch(
        {
            left = -100,
            top = 0,
            style = "radio",
            id = "Apple",
            initialSwitchState = true,
            onPress = onSwitchPress
        }
    )
    radioGroup:insert( radioButton1 )

    local radioButton2 = widget.newSwitch(
        {
            left = 100,
            top = 0,
            style = "radio",
            id = "Google",
            onPress = onSwitchPress
        }
    )
    radioGroup:insert(text)
    radioGroup:insert( radioButton2 )
    return radioGroup
end

return _M