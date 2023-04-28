local M = {}
local package_token = "$package"
local element_token = "$element"

local function get_package(file_path)
    local package_delimter_length = 4
    local file_separator = package.config:sub(1, 1)
    local dir = string.match(file_path, "(.*)" .. file_separator)
    local package_path_subbed = string.gsub(dir, file_separator, '.')
    local prej_idx = string.find(package_path_subbed, 'java.')
    if prej_idx == nil then
        print("ERR: Not a java file")
        return
    end
    local package_idx = prej_idx + package_delimter_length
    local package_name = string.sub(package_path_subbed, package_idx + 1)
    return package_name
end

local function get_element_name(file_path)
    local file_separator = package.config:sub(1, 1)
    local filename = string.match(file_path, "[^" .. file_separator .. "]+$")
    local element_name = string.match(filename, '(.-).java')
    return element_name
end

local function create_file(content, file_path)
    local package = get_package(file_path)
    if package ~= nil then
        local element = get_element_name(file_path)
        if element ~= nil then
            local file = io.open(file_path, "w")
            if file == nil then
                print("ERR: File doesn't exist")
                return
            end
            for _, value in pairs(content) do
                if file ~= nil then
                    local p_subbed_value = string.gsub(value, package_token, package)
                    local e_subbed_value = string.gsub(p_subbed_value, element_token, element)
                    file:write(e_subbed_value .. "\n")
                end
            end
            file:close()
        end
    end
end

function M.create_class(file_path)
    create_file({
        "package " .. package_token .. ";",
        "public class " .. element_token .. " {",
        "\t",
        "}"
    }, file_path)
end

function M.create_record(file_path)
    create_file({
        "package " .. package_token .. ";",
        "public record " .. element_token .. "() {",
        "\t",
        "}"
    }, file_path)
end

function M.create_enum(file_path)
    create_file({
        "package " .. package_token .. ";",
        "public enum " .. element_token .. " {",
        "\t",
        "}"
    }, file_path)
end

function M.create_interface(file_path)
    create_file({
        "package " .. package_token .. ";",
        "public inteface " .. element_token .. " {",
        "\t",
        "}"
    }, file_path)
end

return M
