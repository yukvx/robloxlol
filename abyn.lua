local Start = tick()
local LoadTime = tick()
local Secure = setmetatable({}, {
    __index = function(Idx, Val)
        return game:GetService(Val)
    end
})
--
local UserInput = Secure.UserInputService
local RunService = Secure.RunService
local CoreGui = Secure.CoreGui
local Players = Secure.Players
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local HttpService = Secure.HttpService
local Mouse = LocalPlayer:GetMouse()
local InputGUI = Instance.new("ScreenGui", CoreGui)
local Library = {
    Theme = {
        Accent = {
            Color3.fromHex("#7885f5"), -- Color3.fromHex("#a280d9"), -- Color3.fromRGB(255, 42, 10), Color3.fromHex("#3599d4")
            Color3.fromRGB(180, 156, 255),
            Color3.fromRGB(114, 0, 198),
            Color3.fromRGB(139, 130, 185),
            Color3.fromHex("#a83299")
        },
        Notification = {
            Error = Color3.fromHex("#c82828"),
            Warning = Color3.fromHex("#fc9803")
        },
        Hitbox = Color3.fromRGB(69, 69, 69),
        Friend = Color3.fromRGB(0, 200, 0),
        Outline = Color3.fromHex("#000005"),
        Inline = Color3.fromHex("#323232"),
        LightContrast = Color3.fromHex("#202020"),
        DarkContrast = Color3.fromHex("#191919"),
        Text = Color3.fromHex("#e8e8e8"),
        TextInactive = Color3.fromHex("#aaaaaa"),
        Font = Drawing.Fonts.Plex,
        TextSize = 13,
        UseOutline = false
    },
    Icons = {},
    Flags = {},
    Items = {},
    Drawings = {},
    Ignores = {},
    Keybind = {},
    Watermark = {},
    Connections = {},
    Keys = {
        KeyBoard = {["Q"] = "Q", ["W"] = "W", ["E"] = "E", ["R"] = "R", ["T"] = "T", ["Y"] = "Y", ["U"] = "U", ["I"] = "I", ["O"] = "O", ["P"] = "P", ["A"] = "A", ["S"] = "S", ["D"] = "D", ["F"] = "F", ["G"] = "G", ["H"] = "H", ["J"] = "J", ["K"] = "K", ["L"] = "L", ["Z"] = "Z", ["X"] = "X", ["C"] = "C", ["V"] = "V", ["B"] = "B", ["N"] = "N", ["M"] = "M", ["One"] = {"1", "!"}, ["Two"] = {"2", "\""}, ["Three"] = {"3", "£"}, ["Four"] = {"4", "$"}, ["Five"] = {"5", "%"}, ["Six"] = {"6", "^"}, ["Seven"] = {"7", "&"}, ["Eight"] = {"8", "*"}, ["Nine"] = {"9", "("}, ["Zero"] = {"0", ")"}, ["Space"] = " ", ["Slash"] = {"/", "?"}, ["BackSlash"] = {"\\", "|"}, ["Minus"] = {"-", "_"}, ["Equals"] = {"=", "+"}, ["RightBracket"] = {"]", "}"}, ["LeftBracket"] = {"[", "{"}, ["Semicolon"] = {";", ":"}, ["Quote"] = {"'", "@"}, ["Comma"] = {",", "<"}, ["Period"] = {".", ">"}},
        Letters = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"},
        KeyCodes = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen", "Eight", "Nine", "Zero", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift", "RightAlt", "RightControl", "RightShift", "CapsLock"},
        Inputs = {"MouseButton1", "MouseButton2", "MouseButton3"},
        Shortened = {["MouseButton1"] = "M1", ["MouseButton2"] = "M2", ["MouseButton3"] = "M3", ["Insert"] = "INS", ["LeftAlt"] = "LA", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RA", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "CL"}
    },
    Input = {
        Caplock = false,
        LeftShift = false
    },
    Images = {},
    WindowVisible = true,
    Communication = Instance.new("BindableEvent")
}
--
local Utility = {}
--
getgenv().Library = Library
getgenv().Utility = Utility
-----------------------------------------------------------------
do
    Utility.AddInstance = function(NewInstance, Properties)
        local NewInstance = Instance.new(NewInstance)
        --
        for Index, Value in pairs(Properties) do
            NewInstance[Index] = Value
        end
        --
        return NewInstance
    end
    --
    Utility.CLCheck = function()
        repeat task.wait() until iswindowactive()
        do
            local InputHandle = Utility.AddInstance("TextBox", {
                Position = UDim2.new(0, 0, 0, 0)
            })
            --
            InputHandle:CaptureFocus() task.wait() keypress(0x4E) task.wait() keyrelease(0x4E) InputHandle:ReleaseFocus()
            Library.Input.Caplock = InputHandle.Text == "N" and true or false
            InputHandle:Destroy()
        end
    end
    --
    Utility.Loop = function(Delay, Call)
        local Callback = typeof(Call) == "function" and Call or function() end
        --
        task.spawn(function()
            while task.wait(Delay) do
                local Success, Error = pcall(function()
                    Callback()
                end)
                --
                if Error then 
                    return 
                end
            end
        end)
    end
    --
    Utility.RemoveDrawing = function(Instance, Location)
        local SpecificDrawing = 0
        --
        Location = Location or Library.Drawings
        --
        for Index, Value in pairs(Location) do 
            if Value[1] == Instance then
                if Value[1] then
                    Value[1]:Remove()
                end
                if Value[2] then
                    Value[2] = nil
                end
                SpecificDrawing = Index
            end
        end
        --
        table.remove(Location, table.find(Location, Location[SpecificDrawing]))
    end
    --
    Utility.AddConnection = function(Type, Callback)
        local Connection = Type:Connect(Callback)
        --
        Library.Connections[#Library.Connections + 1] = Connection
        --
        return Connection
    end
    --
    Utility.Round = function(Num, Float)
        local Bracket = 1 / Float;
        return math.floor(Num * Bracket) / Bracket;
    end
    --
    Utility.AddDrawing = function(Instance, Properties, Location)
        local InstanceType = Instance
        local Instance = Drawing.new(Instance)
        --
        for Index, Value in pairs(Properties) do
            Instance[Index] = Value
            if InstanceType == "Text" then
                if Index == "Font" then
                    Instance.Font = Library.Theme.Font
                end
                if Index == "Size" then
                    Instance.Size = Library.Theme.TextSize
                end
            end
        end
        --
        if Properties.ZIndex ~= nil then
            Instance.ZIndex = Properties.ZIndex + 20
        else
            Instance.ZIndex = 20
        end
        --
        Location = Location or Library.Drawings
        if InstanceType == "Image" then
            Location[#Location + 1] = {Instance, true}
        else
            Location[#Location + 1] = {Instance}
        end
        --
        return Instance
    end
    --
        function Window.SendNotification(Type, Title, Duration)
            local Notification, Removed = Window.Notification, false
            --
            local NotificationInline = Utility.AddDrawing("Square", {
                Size = Vector2.new(0, 21),
                Position = Vector2.new(0, (Window.Notification * 25) + 100),
                Thickness = 0,
                Color = Library.Theme.Inline,
                Visible = true,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationOutline = Utility.AddDrawing("Square", {
                Size = Vector2.new(0, NotificationInline.Size.Y - 1),
                Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2),
                Thickness = 0,
                Color = Library.Theme.DarkContrast,
                Visible = true,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationOutlineBorder = Utility.AddDrawing("Square", {
                Size = Vector2.new(NotificationOutline.Size.X - 2, NotificationOutline.Size.Y + 5),
                Position = Vector2.new(NotificationOutline.Position.X + 1, NotificationOutline.Position.Y + 1),
                Thickness = 0,
                Color = Library.Theme.Accent[1],
                Visible = false,
                Filled = true
            }, Library.Ignores)
            --
            local NotificationTopline = Utility.AddDrawing("Square", {
                Size = Vector2.new(NotificationOutline.Size.X, 1),
                Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y),
                Thickness = 0,
                Color = Type == "Warning" and Library.Theme.Notification.Warning or Type == "Error" and Library.Theme.Notification.Error or Library.Theme.DarkContrast,
                Visible = Type == "Warning" or Type == "Error",
                Filled = true
            }, Library.Ignores)
            --
            local NotificationLeftline = Utility.AddDrawing("Square", {
                Size = Vector2.new(1, NotificationOutline.Size.Y),
                Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y),
                Thickness = 0,
                Color = Type == "Normal" and Library.Theme.Accent[1] or Library.Theme.DarkContrast,
                Visible = Type == "Normal",
                Filled = true
            }, Library.Ignores)
            --
            local NotificationImage = Utility.AddDrawing("Image", {
                Size = NotificationOutlineBorder.Size,
                Position = NotificationOutlineBorder.Position,
                Transparency = 1, 
                Visible = true,
                Data = Library.Theme.Gradient
            }, Library.Ignores)
            --
            local NotificationText = Utility.AddDrawing("Text", {
                Font = Library.Theme.Font,
                Size = Library.Theme.TextSize,
                Color = Library.Theme.Text,
                Text = Title,
                Position = Vector2.new(NotificationOutlineBorder.Position.X + 6, NotificationOutlineBorder.Position.Y + 3),
                Visible = true,
                Center = false,
                Outline = false
            }, Library.Ignores)
            --
            NotificationInline.Size = Vector2.new(NotificationText.TextBounds.X + 15, 21)
            --
            NotificationOutline.Size = Vector2.new(NotificationInline.Size.X - 1, NotificationInline.Size.Y - 1)
            NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
            --
            NotificationOutlineBorder.Size = Vector2.new(NotificationOutline.Size.X - 2, NotificationOutline.Size.Y - 2)
            NotificationOutlineBorder.Position = Vector2.new(NotificationOutline.Position.X + 1, NotificationOutline.Position.Y + 1)
            --
            NotificationLeftline.Size = Vector2.new(2, NotificationOutline.Size.Y)
            --
            NotificationTopline.Size = Vector2.new(NotificationOutline.Size.X, 1)
            --
            NotificationImage.Size = NotificationOutline.Size
            NotificationImage.Position = NotificationOutline.Position
            --
            task.spawn(function()
                for Index = -100, 0, 2 do
                    pcall(function()
                        NotificationInline.Position = Vector2.new(Index, (Notification * 25) + 100)
                        NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
                        NotificationOutlineBorder.Position = Vector2.new(NotificationOutline.Position.X + 2, NotificationOutline.Position.Y + 2)
                        NotificationText.Position = Vector2.new(NotificationOutline.Position.X + 6, NotificationOutline.Position.Y + 3)
                        NotificationTopline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                        NotificationImage.Position = NotificationOutline.Position
                        NotificationLeftline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                    end)
                    task.wait()
                end
            end)
            --
            Utility.AddConnection(Library.Communication.Event, function(Type)
                if Type == "UpdateNotification" then
                    Notification -= 1
                    pcall(function()
                        NotificationInline.Size = Vector2.new(Index, (Notification * 25) + 100)
                        NotificationOutline.Position = Vector2.new(NotificationInline.Position.X + 2, NotificationInline.Position.Y + 2)
                        NotificationText.Position = Vector2.new(NotificationOutline.Position.X + 6, NotificationOutline.Position.Y + 3)
                        NotificationTopline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                        NotificationImage.Position = NotificationOutline.Position
                        NotificationLeftline.Position = Vector2.new(NotificationOutline.Position.X, NotificationOutline.Position.Y)
                    end)
                end
            end)
            --
            Window.Notification += 1
            --
            task.spawn(function()
                task.wait(Duration)
                --
                pcall(function()
                    Utility.RemoveDrawing(NotificationInline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationLeftline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationOutline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationOutlineBorder, Library.Ignores)
                    Utility.RemoveDrawing(NotificationText, Library.Ignores)
                    Utility.RemoveDrawing(NotificationTopline, Library.Ignores)
                    Utility.RemoveDrawing(NotificationImage, Library.Ignores)
                end)
                --
                Library.Communication:Fire("UpdateNotification")
                --
                Window.Notification -= 1
            end)
        end
