local M = {}
local vim = vim

local function get_package(file_path)
    local package_delimter_length = 4
    local file_separator = package.config:sub(1, 1)
    if file_path == nil then
        return
    end
    local dir = string.match(file_path, "(.*)" .. file_separator)
    if dir == nil then
        return
    end
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


local function write(content)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_put(content, "", true, false)
    vim.api.nvim_win_set_cursor(0, pos)
end

local function token_builder(file_path, cb)
    local package = get_package(file_path)
    if package ~= nil then
        local element = get_element_name(file_path)
        if element ~= nil then
            cb(package, element)
        end
    end
end

function M.create_class(file_path)
    token_builder(file_path, function(package_name, element_name)
        write({
            "package " .. package_name .. ";",
            "",
            "public class " .. element_name .. " {",
            "\t",
            "}"
        })
    end)
end

function M.create_record(file_path)
    token_builder(file_path, function(package_name, element_name)
        write({
            "package " .. package_name .. ";",
            "",
            "public record " .. element_name .. "() {",
            "\t",
            "}"
        })
    end)
end

function M.create_enum(file_path)
    token_builder(file_path, function(package_name, element_name)
        write({
            "package " .. package_name .. ";",
            "",
            "public enum " .. element_name .. " {",
            "\t",
            "}"
        })
    end)
end

function M.create_interface(file_path)
    token_builder(file_path, function(package_name, element_name)
        write({
            "package " .. package_name .. ";",
            "",
            "public interface " .. element_name .. " {",
            "\t",
            "}"
        })
    end)
end

function M.create_element()
    local filepath = vim.fn.expand(vim.api.nvim_buf_get_name(0))
    local opts = { M.create_class, M.create_interface, M.create_enum, M.create_record }
    vim.ui.select({
        "Class",
        "Interface",
        "Enum",
        "Record"
    }, { prompt = 'Create Java Element: ' }, function(_, idx)
        opts[idx](filepath)
    end)
end

return M
