return {
    runScript = function(filename, docDir)
        if package.loaded[filename .. '_deploy'] then
            return package.loaded[filename .. '_deploy']
        end

        local path = system.pathForFile(filename, docDir or system.DocumentsDirectory)
        local file = io.open(path, 'r')

        if file then
            local data = file:read('*a')

            pcall(function()
                package.loaded[filename .. '_deploy'] = loadstring(data)()
            end)

            io.close(file)
        end

        return package.loaded[filename .. '_deploy']
    end
}
