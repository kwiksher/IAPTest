local lustache = require "extlib.lustache"
local _M = {}

function doesFileExist(fname, path)
    local filePath = system.pathForFile(fname, path)
    if filePath then
        filePath = io.open(filePath, "r")
    end
    if filePath then
        print("File found ->"..fname)
        filePath:close()
        return true
    else
        print("File does not exists ->"..fname)
    end
    return false
end

function _M.copyFile(srcName, srcPath, dstName, dstPath, overwrite)
    if doesFileExist(srcName, srcPath) == false then
        return nil
    end
    if not overwrite then
        if doesFileExist(dstName, dstPath) then
            return 1
        end
    end
    local rfilePath = system.pathForFile(srcName, srcPath)
    local wfilePath = system.pathForFile("", system.ResourceDirectory)
    local rfh = io.open(rfilePath, "rb")
    local wfh = io.open(wfilePath .."/"..dstName, "wb")
    if not wfh then
        print("write error")
        return false
    else
        local data = rfh:read("*a")
        if not data then
            print("read error")
            return false
        else
            if not wfh:write(data) then
                print("writing error")
                return false
            end
        end
    end
    rfh:close()
    wfh:close()
    return 2
end

function _M.renderLua(tmplt, dst, data)
    local path = system.pathForFile( tmplt, system.ResourceDirectory )
    local file, errorString = io.open( path, "r" )
    if not file then
        print( "File error: " .. errorString )
    else
        local contents = file:read( "*a" )
        io.close( file )
        output = lustache:render(contents,  data)

        local file, errorString = io.open( dst, "w" )
        if not file then
            print( "File error: " .. errorString )
        else
            output = string.gsub(output, "\r\n", "\n")
            file:write( output )
            io.close( file )
        end
    end
end

return _M