local vim = vim
local M = {}

local function get_package(file_path)
    local package_delimter_length = 5
    local file_separator = package.config:sub(1, 1)
    local package_path_subbed = file_path:gsup(file_separator, '.')
    local package_idx = string.find(package_path_subbed, 'java.') + package_delimter_length
    local package_name = string.sub(file_path, package_idx + 1)
    return package_name
end

local function create_file(file_path)
    local file = io.open(file_path, "w")
end

function M.create_class(file_path)
    print(M.get_package("src/java/main/com/example/hello/Init.java"))
end

function M.create_record(file_path)

end

function M.create_enum(file_path)

end

function M.create_interface(file_path)

end

return M
