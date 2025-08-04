--!nolint
--!nocheck
--!optimize 2

export type String = (typeof(''));
export type Function = (typeof(function() end));
export type Number = (typeof(721933));

local save_name: String = "isk":: String;
makefolder(save_name);
local time: Number = os.clock():: Number;

local services = {
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    StarterPlayerScripts = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"),
    ReplicatedFirst = game:GetService("ReplicatedFirst"),
}

for i, v in next, game:GetDescendants() do
    if table.find({ "LocalScript", "ModuleScript" }, v.ClassName) then
        for name, service in next, services do
            if v:IsDescendantOf(service) then
                local rel = v:GetFullName():gsub("^"..service:GetFullName().."%.?", "")
                local folder_path = string.format("%s/%s", save_name, rel:match("(.+)%.") or ""):gsub("%.", "/")
                local file_path = string.format("%s/%s.lua", folder_path, v.Name)

                if folder_path ~= "" and not isfolder(folder_path) then
                    makefolder(folder_path)
                end

                local src: String = decompile(v):: String;
                if typeof(src) == "string" then
                    writefile(file_path, string.format(
                        "--[[\nSrc: %s\nName: %s\nDate: %s \nDecompile time: %s \n]]\n",
                        v:GetFullName(), v.Name, os.date("%Y-%m-%d"), os.clock() - time
                    ) .. src);
                    print("saved", v.Name, '-->', file_path, 'in', math.floor(os.clock() - time)..'s');
                end

                break
            end
        end
    end
end

warn('Done!', math.floor(os.clock() - time)..'s');
