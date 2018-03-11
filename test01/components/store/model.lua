local M = {}--local IAP             = require("components.store.IAP")--M.bookShelfType  = 2 --{none = -1, pages = 0, embedded = 1, tmplt=2}--M.debug     = true------------------------------------ M.URL = nil means simple IAP store without network download like Kwik3 IAP-- downloadBtn, savingTxt won'T be used. You don't need to create them.--M.downloadable  = true--M.URL           = "https://bookmen.000webhostapp.com/bookshelf/" -- YourHost.."/BookShelf/"M.URL           = "http://localhost:8081/bookshelf/" -- YourHost.."/BookShelf/"M.backgroundImg = "bg.png"--------------------M.TOC_PAGE = "views.page0".."1".."Scene"M.INFO_PAGE = "views.page0".."2".."Scene" -- "views.page02Scene" -- for bookshelf embedded and tmplt--M.epsodes = {            book01  ={name = "book01", dir = "book01", numOfPages = 6, info = "book 01", versions ={ "jp", "en", "sp" }},            book02  ={name = "book02", dir = "book02", numOfPages = 3, info = "book 02", versions ={ "jp", "en" }},            book03  ={name = "book03", dir = "book03", numOfPages = 16, info = "book03", versions ={ "xh" }},    }--M.catalogue = {    products = {            book01 = {            productNames = { apple="a0", google="", amazon=""},            productType  = "non-consumable",            onPurchase   = function() IAP.setInventoryValue("unlock_book01") end,            onRefund     = function() IAP.removeFromInventory("unlock_book01") end,        },            book02 = {            productNames = { apple="a02", google="", amazon=""},            productType  = "non-consumable",            onPurchase   = function() IAP.setInventoryValue("unlock_book02") end,            onRefund     = function() IAP.removeFromInventory("unlock_book02") end,        },            book03 = {            productNames = { apple="book03", google="book03", amazon="book03"},            productType  = "non-consumable",            onPurchase   = function() IAP.setInventoryValue("unlock_book03") end,            onRefund     = function() IAP.removeFromInventory("unlock_book03") end,        },    },    inventoryItems = {            unlock_book01 = { productType="non-consumable" },            unlock_book02 = { productType="non-consumable" },            unlock_book03 = { productType="non-consumable" },    }}--M.purchaseAlertMessage = "Your purchase was successful"M.restoreAlertMessage  = "Your items are being restored"M.downloadErrorMessage = "Check network alive to download the content"--M.gotoSceneEffect   = "slideRight"M.showOverlayEffect = "slideBottom"--M.getPageNum = function(epsode)    local pNum = M.epsodes[epsode].startPage    pNum = pNum:sub(16)    return pNumend----local _K = require("Application")----M.getPageName = function (epsode)    local pNum = M.epsodes[epsode].dir    pNum = pNum:sub(16)    return "views.page0"..pNum.."Scene"end----M.getPageInfo = function (epsode)    print(epsode)    local pNum = M.epsodes[epsode].info    if string.len(pNum) > 0 then        return "views.page0"..pNum.."Scene"    else        return nil    endend----return M