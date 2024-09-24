--[[
Hello, I wanted to put out a "Fixed" Seere Ui cs I used to like this ui a lot so I just did this have fun with this ui Im still really bad at coding so have fun with this ui 
Also, The config system is broke and im too lazy to fix it sorryyy :sob:
Made On 9/20/24 On Wave Premium
]]





--[[>>Ui Settings/Theme>>]]






local Menu_Data = {
    Disabled_Colors = Color3.fromRGB(255, 0, 0);
    Cursor_Color = Color3.fromRGB(223, 158, 255);
    Colors = Color3.fromRGB(248, 214, 255);
    Drop_Downs = Color3.fromRGB(248, 214, 255);
    Drop_Down_BackGround = Color3.fromRGB(20, 20, 20);
}



local ColorPicker_Gradients = {
    Menu_Outline = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Menu_Data.Colors)},
    Tab_Underline = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(0.50, Menu_Data.Colors), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 34, 34))},
    GroupBoxs_Underline = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(0.10, Menu_Data.Colors), ColorSequenceKeypoint.new(0.50, Menu_Data.Colors), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 34, 34))},
    Slider = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(100, 100, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 75, 75))},
    ColorPicker = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 75)), ColorSequenceKeypoint.new(0.320, Color3.fromRGB(100, 100, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))},
    Toggle = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 75)), ColorSequenceKeypoint.new(0.320, Color3.fromRGB(100, 100, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))},
}





--[[>>End Of Ui Settings/Theme>>]]






--[[>>Variables>>]]
-- do wtv you want idc



local fps = string.format('%.0f', game:GetService("Stats").Workspace.Heartbeat:GetValue())
local ping = string.format('%.0f', game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local inputService   = game:GetService("UserInputService")
local runService     = game:GetService("RunService")
local tweenService   = game:GetService("TweenService")
local Tween = loadstring(game:HttpGet("https://raw.githubusercontent.com/yukvx/robloxlol/refs/heads/main/vozoidtween.lua"))()
local mouse          = localPlayer:GetMouse()
local menu           = game:GetObjects("rbxassetid://12702460854")[1]
local notifications1 = {}
local notifications2 = {}
local title = {
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Placeid = game.PlaceId,
    Build = "Dev build", -- Wtv build you want to put
    playerName = localPlayer.Name,
    userId = localPlayer.UserId,
}
--[[>>End Of Varibles>>]]
menu.bg.Position     = UDim2.new(0.5,-menu.bg.Size.X.Offset/2,0.5,-menu.bg.Size.Y.Offset/2)
--[[>>Very Unoptimized title format but its wtv. you can also change it or take out some things from it and add new things to the title>>]]
--[[>>Title>>]]
menu.bg.pre.Text = "<font color=\"#ffffff\">Angel</font><font color=\"#df9eff\">.Girls</font> | " .. title.playerName .. " | (" .. title.userId .. ") | " .. title.gameName .. " | (" .. title.Placeid .. ") | Uid: Who?"
menu.Parent          = game:GetService("CoreGui")
--[[>>>>]]

local function Rejoin()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
--[[>>init Binds and Watermark>>]]
-- Create the main GUI for the watermark
local WatermarkUI = Instance.new("ScreenGui")
WatermarkUI.Name = "Watermark"
WatermarkUI.Parent = gethui()  -- Using gethui() for systems like Synapse, but replace with PlayerGui if necessary

local WatermarkOutline = Instance.new("Frame")
local WatermarkInner = Instance.new("Frame")
local WatermarkAccent = Instance.new("Frame")
local WatermarkText = Instance.new("TextLabel")

-- Setup the watermark elements
WatermarkOutline.Name = "WatermarkOutline"
WatermarkOutline.Parent = WatermarkUI
WatermarkOutline.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
WatermarkOutline.Size = UDim2.new(0, 200, 0, 20)

WatermarkInner.Parent = WatermarkOutline
WatermarkInner.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
WatermarkInner.Size = UDim2.new(1, -4, 1, -4)

WatermarkAccent.Parent = WatermarkInner
WatermarkAccent.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Accent color
WatermarkAccent.Size = UDim2.new(1, 0, 0, 1)

WatermarkText.Parent = WatermarkInner
WatermarkText.BackgroundTransparency = 1.0
WatermarkText.Size = UDim2.new(1, 0, 1, 0)
WatermarkText.Font = Enum.Font.SourceSans
WatermarkText.TextColor3 = Color3.fromRGB(255, 255, 255)
WatermarkText.TextSize = 14
WatermarkText.Text = "RAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"

-- Automatically resize the watermark based on text size
WatermarkText:GetPropertyChangedSignal("Text"):Connect(function()
    WatermarkOutline.Size = UDim2.new(0, WatermarkText.TextBounds.X + 10, 0, 20)
end)

-- Initialize visibility of watermark (start as visible)
local watermarkVisible = false

-- Toggle Function
local function ToggleWatermark(isVisible)
    watermarkVisible = isVisible
    WatermarkUI.Enabled = isVisible  -- Show or hide the watermark UI
end

-- Function to set the position of the watermark
local function setWatermarkPosition(x, y)
    WatermarkOutline.Position = UDim2.new(0, x, 0, y)
end

-- Create Sliders for X and Y Position
local function createSlider(text, flag, min, max, defaultValue, callback)
    -- Create a Frame for the slider
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 300, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.Parent = WatermarkUI

    -- Slider Label
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Text = text
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.Parent = sliderFrame

    -- Slider
    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.Parent = sliderFrame

    -- Handle input
    slider.MouseButton1Down:Connect(function()
        local userInputService = game:GetService("UserInputService")
        local dragging = true

        -- Update slider value based on mouse movement
        userInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouseX = input.Position.X
                local sliderStartX = sliderFrame.AbsolutePosition.X
                local sliderWidth = sliderFrame.AbsoluteSize.X
                local value = math.clamp((mouseX - sliderStartX) / sliderWidth, 0, 1) * (max - min) + min

                callback(value) -- Call the callback function with the new value
                slider.Size = UDim2.new(value / (max - min), 0, 0, 20) -- Update visual representation
            end
        end)

        -- Stop dragging
        userInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end)

    -- Set initial value
    callback(defaultValue)
end


-- Call ToggleWatermark to make the watermark visible at the start
ToggleWatermark(false)

--[[>>Start Of Ui>>]]






local library = {colorpicking = false;tabbuttons = {};tabs = {};options = {};flags = {};scrolling = false;playing = false;multiZindex = 200;toInvis = {};libColor = Menu_Data.Colors;disabledcolor = Color3.fromRGB(233, 0, 0);blacklisted = {Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.UserInputType.MouseMovement}}
function draggable(a) local b=inputService;local c;local d;local e;local f;local function g(h)if not library.colorpicking then local i=h.Position-e;a.Position=UDim2.new(f.X.Scale,f.X.Offset+i.X,f.Y.Scale,f.Y.Offset+i.Y)end end;a.InputBegan:Connect(function(h)if h.UserInputType==Enum.UserInputType.MouseButton1 or h.UserInputType==Enum.UserInputType.Touch then c=true;e=h.Position;f=a.Position;h.Changed:Connect(function()if h.UserInputState==Enum.UserInputState.End then c=false end end)end end)a.InputChanged:Connect(function(h)if h.UserInputType==Enum.UserInputType.MouseMovement or h.UserInputType==Enum.UserInputType.Touch then d=h end end)b.InputChanged:Connect(function(h)if h==d and c then g(h)end end)end
draggable(menu.bg)
local tabholder = menu.bg.bg.bg.bg.main.group
local tabviewer = menu.bg.bg.bg.bg.tabbuttons
game:GetService('UserInputService').MouseIconEnabled = false
local Cursor = Drawing.new('Triangle');
Cursor.Thickness = 1;
Cursor.Filled = true;
Cursor.Visible = true;
Cursor.ZIndex = math.huge;
local CursorOutline = Drawing.new('Triangle');
CursorOutline.Thickness = 1;
CursorOutline.Filled = false;
CursorOutline.Color = Color3.new(0, 0, 0);
CursorOutline.Visible = true;
CursorOutline.ZIndex = math.huge;

function cursorupdate()
    local mPos = game:GetService('UserInputService'):GetMouseLocation();
    Cursor.Color = Menu_Data.Cursor_Color;
    Cursor.PointA = Vector2.new(mPos.X, mPos.Y);
    Cursor.PointB = Vector2.new(mPos.X + 16, mPos.Y + 6);
    Cursor.PointC = Vector2.new(mPos.X + 6, mPos.Y + 16);
    CursorOutline.PointA = Cursor.PointA;
    CursorOutline.PointB = Cursor.PointB;
    CursorOutline.PointC = Cursor.PointC;
    game:GetService('RunService').RenderStepped:Wait();
end;
task.spawn(function() while true do cursorupdate() end end)
inputService.InputEnded:Connect(function(key) -- hide
    if key.KeyCode == Enum.KeyCode.End then
        menu.Enabled = not menu.Enabled
        library.scrolling = false
        library.colorpicking = false
        Cursor.Visible = not Cursor.Visible
        CursorOutline.Visible = not CursorOutline.Visible
        game:GetService('UserInputService').MouseIconEnabled = not Cursor.Visible
        for i,v in next, library.toInvis do
            v.Visible = false
        end
    end
end)
local keyNames = {
    [Enum.KeyCode.LeftAlt] = 'LALT';
    [Enum.KeyCode.RightAlt] = 'RALT';
    [Enum.KeyCode.LeftControl] = 'LCTRL';
    [Enum.KeyCode.RightControl] = 'RCTRL';
    [Enum.KeyCode.LeftShift] = 'LSHIFT';
    [Enum.KeyCode.RightShift] = 'RSHIFT';
    [Enum.KeyCode.Underscore] = '_';
    [Enum.KeyCode.Minus] = '-';
    [Enum.KeyCode.Plus] = '+';
    [Enum.KeyCode.Period] = '.';
    [Enum.KeyCode.Slash] = '/';
    [Enum.KeyCode.BackSlash] = '\\';
    [Enum.KeyCode.Question] = '?';
    [Enum.UserInputType.MouseButton1] = 'MB1';
    [Enum.UserInputType.MouseButton2] = 'MB2';
    [Enum.UserInputType.MouseButton3] = 'MB3';
}
function library:Tween(...)
    tweenService:Create(...):Play()
end
function library:addTab(name)
    local newTab = tabholder.tab:Clone()
    local newButton = tabviewer.button:Clone()
    local UnderLine = newButton.element
    UnderLine.BackgroundColor3 = Menu_Data.Colors
    local Under_Line_Gradient = Instance.new("UIGradient", UnderLine)
    Under_Line_Gradient.Color = ColorPicker_Gradients.Tab_Underline
    table.insert(library.tabs,newTab)
    newTab.Parent = tabholder
    newTab.Visible = false
    table.insert(library.tabbuttons, newButton)
    newButton.Parent = tabviewer
    newButton.Modal = true
    newButton.Visible = true
    newButton.text.Text = name
    newButton.MouseButton1Click:Connect(function()
        for i,v in next, library.tabs do
            v.Visible = v == newTab
        end
        for i,v in next, library.toInvis do
            v.Visible = false
        end
        for i,v in next, library.tabbuttons do
            local state = v == newButton
            if state then
                v.element.Visible = true
                library:Tween(v.element, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.000})
                v.text.TextColor3 = Color3.fromRGB(244, 244, 244)
            else
                library:Tween(v.element, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1.000})
                v.text.TextColor3 = Color3.fromRGB(144, 144, 144)
            end
        end
    end)
    local tab = {}
    local groupCount = 0
    local jigCount = 0
    local topStuff = 2000
    function tab:createGroup(pos,groupname) -- newTab[pos == 0 and "left" or "right"] 
        local groupbox = Instance.new("Frame")
        local grouper = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")
        local element = Instance.new("Frame")
        local title = Instance.new("TextLabel")
        local backframe = Instance.new("Frame")
        groupCount -= 1
        groupbox.Parent = newTab[pos]
        groupbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        groupbox.BorderColor3 = Color3.fromRGB(30, 30, 30)
        groupbox.BorderSizePixel = 2
        groupbox.Size = UDim2.new(0, 211, 0, 8)
        groupbox.ZIndex = groupCount
        title.Parent = groupbox
        title.Text = groupname or ""
        title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title.BackgroundTransparency = 0
        title.BorderSizePixel = 1
        title.Position = UDim2.new(0, 17, 0, 0)
        title.ZIndex = 2
        title.Font = Enum.Font.Code
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 13.000
        title.TextStrokeTransparency = 0.000
        title.TextXAlignment = Enum.TextXAlignment.Left
        grouper.Parent = groupbox
        grouper.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        grouper.BorderColor3 = Color3.fromRGB(0, 0, 0)
        grouper.Size = UDim2.new(1, 0, 1, 0)
        UIListLayout.Parent = grouper
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIPadding.Parent = grouper
        UIPadding.PaddingBottom = UDim.new(0, 4)
        UIPadding.PaddingTop = UDim.new(0, 7)
        element.Name = "element"
        element.Parent = groupbox
        element.BackgroundColor3 = library.libColor
        element.BackgroundTransparency = 0
        element.BorderSizePixel = 0
        element.Size = UDim2.new(1, 0, 0, 1)
        local Under_Line_Gradient = Instance.new("UIGradient", element)
        Under_Line_Gradient.Color = ColorPicker_Gradients.GroupBoxs_Underline
        backframe.Parent = groupbox
        backframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        backframe.BorderSizePixel = 0
        backframe.Position = UDim2.new(0, 10, 0, -2)
        --print(title.TextBounds.X)
        if title.TextBounds.X then
            backframe.Size = UDim2.new(0, 13 + title.TextBounds.X, 0, 3)
        else
            backframe.Size = UDim2.new(0, 13 + 170, 0, 3)
        end
        local group = {}
        function group:addToggle(args)
            if not args.flag and args.text then args.flag = args.text end
            if not args.flag then return end
            groupbox.Size += UDim2.new(0, 0, 0, 20)
            local toggleframe = Instance.new("Frame")
            local tobble = Instance.new("Frame")
            local mid = Instance.new("Frame")
            local front = Instance.new("Frame")
            local text = Instance.new("TextLabel")
            local button = Instance.new("TextButton")
            jigCount -= 1
            library.multiZindex -= 1
            toggleframe.Name = "toggleframe"
            toggleframe.Parent = grouper
            toggleframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleframe.BackgroundTransparency = 1.000
            toggleframe.BorderSizePixel = 0
            toggleframe.Size = UDim2.new(1, 0, 0, 20)
            toggleframe.ZIndex = library.multiZindex
            tobble.Name = "tobble"
            tobble.Parent = toggleframe
            tobble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tobble.BorderColor3 = Color3.fromRGB(0, 0, 0)
            tobble.BorderSizePixel = 3
            tobble.Position = UDim2.new(0.0299999993, 0, 0.272000015, 0)
            tobble.Size = UDim2.new(0, 10, 0, 10)
            mid.Name = "mid"
            mid.Parent = tobble
            mid.BackgroundColor3 = Color3.fromRGB(69, 23, 255)
            mid.BorderColor3 = Color3.fromRGB(30,30,30)
            mid.BorderSizePixel = 2
            mid.Size = UDim2.new(0, 10, 0, 10)
            front.Name = "front"
            front.Parent = mid
            front.BackgroundColor3 = Color3.fromRGB(15,15,15)
            front.BorderColor3 = Color3.fromRGB(0, 0, 0)
            front.Size = UDim2.new(0, 10, 0, 10)
            local Toggle_Gradient = Instance.new("UIGradient", front)
            Toggle_Gradient.Color = ColorPicker_Gradients.Toggle
            Toggle_Gradient.Rotation = 270
            text.Name = "text"
            text.Parent = toggleframe
            text.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0, 22, 0, 0)
            text.Size = UDim2.new(0, 0, 1, 2)
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag
            text.TextColor3 = Color3.fromRGB(155, 155, 155)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
            button.Name = "button"
            button.Parent = toggleframe
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundTransparency = 1.000
            button.BorderSizePixel = 0
            button.Size = UDim2.new(0, 101, 1, 0)
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
            if args.disabled then
                button.Visible = false
                text.TextColor3 = library.disabledcolor
                text.Text = args.text
            return end
            local state = false
            function toggle(newState)
                state = newState
                library.flags[args.flag] = state
                front.BackgroundColor3 = state and library.libColor or Color3.fromRGB(15,15,15)
                text.TextColor3 = state and Color3.fromRGB(244, 244, 244) or Color3.fromRGB(144, 144, 144)
                if args.callback then
                    args.callback(state)
                end
            end
            button.MouseButton1Click:Connect(function()
                state = not state
                front.Name = state and "accent" or "back"
                library.flags[args.flag] = state
                mid.BorderColor3 = Color3.fromRGB(30,30,30)
                front.BackgroundColor3 = state and library.libColor or Color3.fromRGB(15,15,15)
                text.TextColor3 = state and Color3.fromRGB(244, 244, 244) or Color3.fromRGB(144, 144, 144)
                if args.callback then
                    args.callback(state)
                end
            end)
            button.MouseEnter:connect(function()
                mid.BorderColor3 = library.libColor
            end)
            button.MouseLeave:connect(function()
                mid.BorderColor3 = Color3.fromRGB(30,30,30)
            end)
            library.flags[args.flag] = false
            library.options[args.flag] = {type = "toggle",changeState = toggle,skipflag = args.skipflag,oldargs = args}
            local toggle = {}
            function toggle:addKeybind(args)
                if not args.flag then return end
                local next = false
                local keybind = Instance.new("Frame")
                local button = Instance.new("TextButton")
                keybind.Parent = toggleframe
                keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybind.BackgroundTransparency = 1.000
                keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
                keybind.BorderSizePixel = 0
                keybind.Position = UDim2.new(0.720000029, 4, 0.272000015, 0)
                keybind.Size = UDim2.new(0, 51, 0, 10)
                button.Parent = keybind
                button.BackgroundColor3 = Color3.fromRGB(187, 131, 255)
                button.BackgroundTransparency = 1.000
                button.BorderSizePixel = 0
                button.Position = UDim2.new(-0.270902753, 0, 0, 0)
                button.Size = UDim2.new(1.27090275, 0, 1, 0)
                button.Font = Enum.Font.Code
                button.Text = ""
                button.TextColor3 = Color3.fromRGB(155, 155, 155)
                button.TextSize = 13.000
                button.TextStrokeTransparency = 0.000
                button.TextXAlignment = Enum.TextXAlignment.Right
                function updateValue(val)
                    if library.colorpicking then return end
                    library.flags[args.flag] = val
                    button.Text = keyNames[val] or val.Name
                end
                inputService.InputBegan:Connect(function(key)
                    local key = key.KeyCode == Enum.KeyCode.Unknown and key.UserInputType or key.KeyCode
                    if next then
                        if not table.find(library.blacklisted,key) then
                            next = false
                            library.flags[args.flag] = key
                            button.Text = keyNames[key] or key.Name
                            button.TextColor3 = Color3.fromRGB(155, 155, 155)
                        end
                    end
                    if not next and key == library.flags[args.flag] and args.callback then
                        args.callback()
                    end
                end)
                button.MouseButton1Click:Connect(function()
                    if library.colorpicking then return end
                    library.flags[args.flag] = Enum.KeyCode.Unknown
                    button.Text = "--"
                    button.TextColor3 = library.libColor
                    next = true
                end)
                library.flags[args.flag] = Enum.KeyCode.Unknown
                library.options[args.flag] = {type = "keybind",changeState = updateValue,skipflag = args.skipflag,oldargs = args}
    
                updateValue(args.key or Enum.KeyCode.Unknown)
            end
            function toggle:addColorpicker(args)
                if not args.flag and args.text then args.flag = args.text end
                if not args.flag then return end
                local colorpicker = Instance.new("Frame")
                local mid = Instance.new("Frame")
                local front = Instance.new("Frame")
                local button2 = Instance.new("TextButton")
                local colorFrame = Instance.new("Frame")
                local colorFrame_2 = Instance.new("Frame")
                local hueframe = Instance.new("Frame")
                local main = Instance.new("Frame")
                local hue = Instance.new("ImageLabel")
                local pickerframe = Instance.new("Frame")
                local main_2 = Instance.new("Frame")
                local picker = Instance.new("ImageLabel")
                local clr = Instance.new("Frame")
                local CurrentColorFrame = Instance.new("Frame")
                local CurrentColorFrame_Text = Instance.new("TextLabel")
                library.multiZindex -= 1
                jigCount -= 1
                topStuff -= 1 --args.second
                colorpicker.Parent = toggleframe
                colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                colorpicker.BorderSizePixel = 3
                colorpicker.Position = args.second and UDim2.new(0.720000029, 4, 0.272000015, 0) or UDim2.new(0.860000014, 4, 0.272000015, 0)
                colorpicker.Size = UDim2.new(0, 20, 0, 10)
                mid.Name = "mid"
                mid.Parent = colorpicker
                mid.BackgroundColor3 = Color3.fromRGB(69, 23, 255)
                mid.BorderColor3 = Color3.fromRGB(30,30,30)
                mid.BorderSizePixel = 2
                mid.Size = UDim2.new(1, 0, 1, 0)
                front.Name = "front"
                front.Parent = mid
                front.BackgroundColor3 = Color3.fromRGB(0, 255, 251)
                front.BorderColor3 = Color3.fromRGB(0, 0, 0)
                front.Size = UDim2.new(1, 0, 1, 0)
                local ColorPicker_Gradient1 = Instance.new("UIGradient", front)
                ColorPicker_Gradient1.Color = ColorPicker_Gradients.ColorPicker
                ColorPicker_Gradient1.Rotation = 270
                button2.Name = "button2"
                button2.Parent = front
                button2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                button2.BackgroundTransparency = 1.000
                button2.Size = UDim2.new(1, 0, 1, 0)
                button2.Text = ""
                button2.Font = Enum.Font.SourceSans
                button2.TextColor3 = Color3.fromRGB(0, 0, 0)
                button2.TextSize = 14.000
                colorFrame.Name = "colorFrame"
                colorFrame.Parent = toggleframe
                colorFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                colorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                colorFrame.BorderSizePixel = 2
                colorFrame.Position = UDim2.new(0.101092957, 0, 0.75, 0)
                colorFrame.Size = UDim2.new(0, 187, 0, 178)
                colorFrame_2.Name = "colorFrame"
                colorFrame_2.Parent = colorFrame
                colorFrame_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                colorFrame_2.BorderColor3 = Color3.fromRGB(60, 60, 60)
                colorFrame_2.Size = UDim2.new(1, 0, 1, 0)
                hueframe.Name = "hueframe"
                hueframe.Parent = colorFrame_2
                hueframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                hueframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
                hueframe.BorderSizePixel = 2
                hueframe.Position = UDim2.new(-0.0830000022, 18, -0.0559999987, 13)
                hueframe.Size = UDim2.new(0.25, 110, 0.25, 110)
                main.Name = "main"
                main.Parent = hueframe
                main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                main.BorderColor3 = Color3.fromRGB(0, 0, 0)
                main.Size = UDim2.new(1, 0, 1, 0)
                main.ZIndex = 6
                picker.Name = "picker"
                picker.Parent = main
                picker.BackgroundColor3 = Color3.fromRGB(232, 0, 255)
                picker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                picker.BorderSizePixel = 0
                picker.Size = UDim2.new(1, 0, 1, 0)
                picker.ZIndex = 104
                picker.Image = "rbxassetid://2615689005"
                pickerframe.Name = "pickerframe"
                pickerframe.Parent = colorFrame
                pickerframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                pickerframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
                pickerframe.BorderSizePixel = 2
                pickerframe.Position = UDim2.new(0.801000025, 14, -0.0559999987, 13)
                pickerframe.Size = UDim2.new(0, 20, 0.25, 110)
                CurrentColorFrame.Name = "CurrentColorFrame"
                CurrentColorFrame.Parent = colorFrame
                CurrentColorFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                CurrentColorFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
                CurrentColorFrame.BorderSizePixel = 2
                CurrentColorFrame.Position = UDim2.new(0.98, 0, 0.915, 0)
                CurrentColorFrame.Size = UDim2.new(-0.965, 0, 0, 12)
                CurrentColorFrame_Text.Name = "CurrentColorFrame_Text"
                CurrentColorFrame_Text.Parent = CurrentColorFrame
                CurrentColorFrame_Text.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                CurrentColorFrame_Text.BackgroundTransparency = 1.000
                CurrentColorFrame_Text.BorderSizePixel = 0
                CurrentColorFrame_Text.Size = UDim2.new(1, 0, 1, 0)
                CurrentColorFrame_Text.Font = Enum.Font.Code
                CurrentColorFrame_Text.Text = args.text or args.flag
                CurrentColorFrame_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                CurrentColorFrame_Text.TextSize = 13.000
                CurrentColorFrame_Text.TextStrokeTransparency = 0.000
                main_2.Name = "main"
                main_2.Parent = pickerframe
                main_2.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                main_2.Size = UDim2.new(0, 20, 1, 0)
                main_2.ZIndex = 6
                hue.Name = "hue"
                hue.Parent = main_2
                hue.BackgroundColor3 = Color3.fromRGB(255, 0, 178)
                hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
                hue.BorderSizePixel = 0
                hue.Size = UDim2.new(0, 20, 1, 0)
                hue.ZIndex = 104
                hue.Image = "rbxassetid://2615692420"
                clr.Name = "clr"
                clr.Parent = colorFrame
                clr.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                clr.BackgroundTransparency = 1.000
                clr.BorderColor3 = Color3.fromRGB(60, 60, 60)
                clr.BorderSizePixel = 2
                clr.Position = UDim2.new(0.0280000009, 0, 0, 2)
                clr.Size = UDim2.new(0, 0, 0, 14)
                clr.ZIndex = 5
                button2.MouseButton1Click:Connect(function()
                    colorFrame.Visible = not colorFrame.Visible
                    mid.BorderColor3 = Color3.fromRGB(30,30,30)
                end)
                button2.MouseEnter:connect(function()
                    mid.BorderColor3 = library.libColor
                end)
                button2.MouseLeave:connect(function()
                    mid.BorderColor3 = Color3.fromRGB(30,30,30)
                end)
                local function updateValue(value,fakevalue)
                    if typeof(value) == "table" then value = fakevalue end
                    library.flags[args.flag] = value
                    front.BackgroundColor3 = value
                    if args.callback then
                        args.callback(value)
                    end
                end
                local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
                local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
                local heartbeat = game:GetService("RunService").Heartbeat
                local pickerX,pickerY,hueY = 0,0,0
                local oldpercentX,oldpercentY = 0,0
                hue.MouseEnter:Connect(function()
                    local input = hue.InputBegan:connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                            while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                library.colorpicking = true
                                local percent = (hueY-hue.AbsolutePosition.Y-36)/hue.AbsoluteSize.Y
                                local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
                                local startC = colors[math.floor(num)]
                                local endC = colors[math.ceil(num)]
                                local color = white:lerp(picker.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
                                picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
                                updateValue(color)
                            end
                            library.colorpicking = false
                        end
                    end)
                    local leave
                    leave = hue.MouseLeave:connect(function()
                        input:disconnect()
                        leave:disconnect()
                    end)
                end)
                picker.MouseEnter:Connect(function()
                    local input = picker.InputBegan:connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                            while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                library.colorpicking = true
                                local xPercent = (pickerX-picker.AbsolutePosition.X)/picker.AbsoluteSize.X
                                local yPercent = (pickerY-picker.AbsolutePosition.Y-36)/picker.AbsoluteSize.Y
                                local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
                                updateValue(color)
                                oldpercentX,oldpercentY = xPercent,yPercent
                            end
                            library.colorpicking = false
                        end
                    end)
                    local leave
                    leave = picker.MouseLeave:connect(function()
                        input:disconnect()
                        leave:disconnect()
                    end)
                end)
                hue.MouseMoved:connect(function(_, y)
                    hueY = y
                end)
                picker.MouseMoved:connect(function(x, y)
                    pickerX,pickerY = x,y
                end)
                table.insert(library.toInvis,colorFrame)
                library.flags[args.flag] = Color3.new(1,1,1)
                library.options[args.flag] = {type = "colorpicker",changeState = updateValue,skipflag = args.skipflag,oldargs = args}
                updateValue(args.color or Color3.new(1,1,1))
            end
            return toggle
        end
        function group:addButton(args)
            if not args.callback or not args.text then return end
            groupbox.Size += UDim2.new(0, 0, 0, 22)
            local buttonframe = Instance.new("Frame")
            local bg = Instance.new("Frame")
            local main = Instance.new("Frame")
            local button = Instance.new("TextButton")
            local gradient = Instance.new("UIGradient")
            buttonframe.Name = "buttonframe"
            buttonframe.Parent = grouper
            buttonframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            buttonframe.BackgroundTransparency = 1.000
            buttonframe.BorderSizePixel = 0
            buttonframe.Size = UDim2.new(1, 0, 0, 21)
            bg.Name = "bg"
            bg.Parent = buttonframe
            bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
            bg.BorderSizePixel = 2
            bg.Position = UDim2.new(0.02, -1, 0, 0)
            bg.Size = UDim2.new(0, 205, 0, 15)
            main.Name = "main"
            main.Parent = bg
            main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            main.Size = UDim2.new(1, 0, 1, 0)
            button.Name = "button"
            button.Parent = main
            button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            button.BackgroundTransparency = 1.000
            button.BorderSizePixel = 0
            button.Size = UDim2.new(1, 0, 1, 0)
            button.Font = Enum.Font.Code
            button.Text = args.text or args.flag
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 13.000
            button.TextStrokeTransparency = 0.000
            gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
            gradient.Rotation = 90
            gradient.Name = "gradient"
            gradient.Parent = main
            button.MouseButton1Click:Connect(function()
                if not library.colorpicking then
                    args.callback()
                end
            end)
            button.MouseEnter:connect(function()
                main.BorderColor3 = library.libColor
            end)
            button.MouseLeave:connect(function()
                main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            end)
        end
        function group:addSlider(args, sub)
            if not args.flag or not args.max then return end
        
            -- Adjust groupbox size to accommodate the slider
            groupbox.Size = groupbox.Size + UDim2.new(0, 0, 0, 30)
        
            -- Creating the slider components
            local slider = Instance.new("Frame")
            local bg = Instance.new("Frame")
            local main = Instance.new("Frame")
            local fill = Instance.new("Frame")
            local button = Instance.new("TextButton")
            local valuetext = Instance.new("TextLabel")
            local UIGradient = Instance.new("UIGradient")
            local text = Instance.new("TextLabel")
        
            -- Slider setup
            slider.Name = "slider"
            slider.Parent = grouper
            slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            slider.BackgroundTransparency = 1.000
            slider.BorderSizePixel = 0
            slider.Size = UDim2.new(1, 0, 0, 30)
        
            -- Background frame of the slider
            bg.Name = "bg"
            bg.Parent = slider
            bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
            bg.BorderSizePixel = 2
            bg.Position = UDim2.new(0.02, -1, 0, 16)
            bg.Size = UDim2.new(0, 205, 0, 10)
        
            -- Main slider background
            main.Name = "main"
            main.Parent = bg
            main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            main.BorderColor3 = Color3.fromRGB(50, 50, 50)
            main.Size = UDim2.new(1, 0, 1, 0)
        
            -- Fill part of the slider
            fill.Name = "fill"
            fill.Parent = main
            fill.BackgroundColor3 = library.libColor
            fill.BackgroundTransparency = 0.200
            fill.BorderColor3 = Color3.fromRGB(60, 60, 60)
            fill.BorderSizePixel = 0
            fill.Size = UDim2.new(0.617, 13, 1, 0)
        
            -- Fill gradient
            local Fill_UIGradient = Instance.new("UIGradient", fill)
            Fill_UIGradient.Color = ColorPicker_Gradients.Slider
            Fill_UIGradient.Rotation = 90
        
            -- Button for interaction
            button.Name = "button"
            button.Parent = main
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundTransparency = 1.000
            button.Size = UDim2.new(0, 191, 1, 0)
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
        
            -- Value display
            valuetext.Parent = main
            valuetext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            valuetext.BackgroundTransparency = 1.000
            valuetext.Position = UDim2.new(0.5, 0, 0.5, 0)
            valuetext.Font = Enum.Font.Code
            valuetext.Text = args.value.."/"..args.max -- Display the current value
            valuetext.TextColor3 = Color3.fromRGB(255, 255, 255)
            valuetext.TextSize = 14.000
            valuetext.TextStrokeTransparency = 0.000
        
            -- Label for the slider
            text.Name = "text"
            text.Parent = slider
            text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0.03, -1, 0, 7)
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag -- Text that appears next to the slider
            text.TextColor3 = Color3.fromRGB(244, 244, 244)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
        
            -- Function to update the value
            local function updateValue(value)
                if library.colorpicking then return end
        
                -- Ensure the fill reflects the current value
                if value ~= 0 then
                    fill:TweenSize(UDim2.new(value / args.max, 0, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.1)
                else
                    fill:TweenSize(UDim2.new(0, 1, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.1)
                end
        
                valuetext.Text = value .. (sub or "")
                library.flags[args.flag] = value
                if args.callback then
                    args.callback(value)
                end
            end
        
            -- Handling slider scroll updates
            local function updateScroll()
                if scrolling or library.scrolling or not newTab.Visible or library.colorpicking then return end
                while inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and menu.Enabled do
                    runService.RenderStepped:Wait()
                    library.scrolling = true
                    valuetext.TextColor3 = Color3.fromRGB(255, 255, 255)
                    scrolling = true
        
                    -- Calculate the new slider value based on mouse position
                    local value = args.min + ((mouse.X - button.AbsolutePosition.X) / button.AbsoluteSize.X) * (args.max - args.min)
                    value = math.clamp(value, args.min, args.max) -- Clamp the value between min and max
                    updateValue(math.floor(value * 100) / 100)
                end
        
                -- Reset scrolling states
                scrolling = false
                library.scrolling = false
            end
        
            -- Button mouse interactions
            button.MouseEnter:Connect(function()
                if library.colorpicking then return end
                if scrolling or entered then return end
                entered = true
                main.BorderColor3 = library.libColor
        
                -- Listen for slider scroll updates
                while entered do
                    wait()
                    updateScroll()
                end
            end)
        
            button.MouseLeave:Connect(function()
                entered = false
                main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            end)
        
            -- Set initial value if provided
            if args.value then
                updateValue(args.value)
            end
        
            -- Register slider in the library
            library.flags[args.flag] = args.value or 0
            library.options[args.flag] = {type = "slider", changeState = updateValue, skipflag = args.skipflag, oldargs = args}
        end
        function group:addLabel(args)
            if not args.text then return end
        
            -- Adjust the groupbox size to accommodate the label
            groupbox.Size = groupbox.Size + UDim2.new(0, 0, 0, 20)
        
            -- Create a frame for the label
            local labelFrame = Instance.new("Frame")
            local labelText = Instance.new("TextLabel")
        
            -- Label frame properties
            labelFrame.Name = "labelFrame"
            labelFrame.Parent = grouper
            labelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            labelFrame.BackgroundTransparency = 1.000
            labelFrame.BorderSizePixel = 0
            labelFrame.Size = UDim2.new(1, 0, 0, 20)
        
            -- Label text properties
            labelText.Name = "labelText"
            labelText.Parent = labelFrame
            labelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            labelText.BackgroundTransparency = 1.000
            labelText.Position = UDim2.new(0.03, -1, 0, 0) -- Adjust position as needed
            labelText.Size = UDim2.new(0, 200, 0, 20)
            labelText.Font = Enum.Font.Code -- You can change this to any font you prefer
            labelText.Text = args.text -- Set the label text from the arguments
            labelText.TextColor3 = Color3.fromRGB(244, 244, 244)
            labelText.TextSize = 13.000
            labelText.TextXAlignment = Enum.TextXAlignment.Left
            labelText.TextStrokeTransparency = 0.000

            return labelFrame
        end        
        function group:addTextbox(args)
            if not args.flag then return end
            groupbox.Size += UDim2.new(0, 0, 0, 35)
            local textbox = Instance.new("Frame")
            local bg = Instance.new("Frame")
            local main = Instance.new("ScrollingFrame")
            local box = Instance.new("TextBox")
            local gradient = Instance.new("UIGradient")
            local text = Instance.new("TextLabel")
            box:GetPropertyChangedSignal('Text'):Connect(function(val)
                if library.colorpicking then return end
                library.flags[args.flag] = box.Text
                args.value = box.Text
                if args.callback then
                    args.callback()
                end
            end)
            textbox.Name = "textbox"
            textbox.Parent = grouper
            textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textbox.BackgroundTransparency = 1.000
            textbox.BorderSizePixel = 0
            textbox.Size = UDim2.new(1, 0, 0, 35)
            textbox.ZIndex = 10
            bg.Name = "bg"
            bg.Parent = textbox
            bg.BackgroundColor3 = Color3.fromRGB(15,15,15)
            bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
            bg.BorderSizePixel = 2
            bg.Position = UDim2.new(0.02, -1, 0, 16)
            bg.Size = UDim2.new(0, 205, 0, 15)
            main.Name = "main"
            main.Parent = bg
            main.Active = true
            main.BackgroundColor3 = Color3.fromRGB(15,15,15)
            main.BorderColor3 = Color3.fromRGB(30, 30, 30)
            main.Size = UDim2.new(1, 0, 1, 0)
            main.CanvasSize = UDim2.new(0, 0, 0, 0)
            main.ScrollBarThickness = 0
            box.Name = "box"
            box.Parent = main
            box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            box.BackgroundTransparency = 1.000
            box.Selectable = false
            box.Size = UDim2.new(1, 0, 1, 0)
            box.Font = Enum.Font.Code
            box.Text = args.value or ""
            box.TextColor3 = Color3.fromRGB(255, 255, 255)
            box.TextSize = 13.000
            box.TextStrokeTransparency = 0.000
            box.TextXAlignment = Enum.TextXAlignment.Left
            gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
            gradient.Rotation = 90
            gradient.Name = "gradient"
            gradient.Parent = main
            text.Name = "text"
            text.Parent = textbox
            text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0.0299999993, -1, 0, 7)
            text.ZIndex = 2
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag
            text.TextColor3 = Color3.fromRGB(244, 244, 244)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
            library.flags[args.flag] = args.value or ""
            library.options[args.flag] = {type = "textbox",changeState = function(text) box.Text = text end,skipflag = args.skipflag,oldargs = args}
        end
        function group:addDivider(args)
            groupbox.Size += UDim2.new(0, 0, 0, 10)
            local div = Instance.new("Frame")
            local bg = Instance.new("Frame")
            local main = Instance.new("Frame")
            div.Name = "div"
            div.Parent = grouper
            div.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            div.BackgroundTransparency = 1.000
            div.BorderSizePixel = 0
            div.Position = UDim2.new(0, 0, 0.743662, 0)
            div.Size = UDim2.new(0, 202, 0, 10)
            bg.Name = "bg"
            bg.Parent = div
            bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
            bg.BorderSizePixel = 2
            bg.Position = UDim2.new(0.02, 0, 0, 4)
            bg.Size = UDim2.new(0, 191, 0, 1)
            main.Name = "main"
            main.Parent = bg
            main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            main.Size = UDim2.new(0, 191, 0, 1)
        end
        function group:addList(args)
            if not args.flag or not args.values then return end
            groupbox.Size += UDim2.new(0, 0, 0, 35)
--args.multiselect and "..." or ""
            library.multiZindex -= 1
            local list = Instance.new("Frame")
            local bg = Instance.new("Frame")
            local main = Instance.new("ScrollingFrame")
            local button = Instance.new("TextButton")
            local dumbtriangle = Instance.new("ImageLabel")
            local valuetext = Instance.new("TextLabel")
            local gradient = Instance.new("UIGradient")
            local text = Instance.new("TextLabel")
            local frame = Instance.new("Frame")
            local holder = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            list.Name = "list"
            list.Parent = grouper
            list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            list.BackgroundTransparency = 1.000
            list.BorderSizePixel = 0
            list.Size = UDim2.new(1, 0, 0, 35)
            list.ZIndex = library.multiZindex
            bg.Name = "bg"
            bg.Parent = list
            bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
            bg.BorderSizePixel = 2
            bg.Position = UDim2.new(0.02, -1, 0, 16)
            bg.Size = UDim2.new(0, 205, 0, 15)
            main.Name = "main"
            main.Parent = bg
            main.Active = true
            main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            main.Size = UDim2.new(1, 0, 1, 0)
            main.CanvasSize = UDim2.new(0, 0, 0, 0)
            main.ScrollBarThickness = 0
            button.Name = "button"
            button.Parent = main
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundTransparency = 1.000
            button.Size = UDim2.new(0, 191, 1, 0)
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
            dumbtriangle.Name = "dumbtriangle"
            dumbtriangle.Parent = main
            dumbtriangle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            dumbtriangle.BackgroundTransparency = 1.000
            dumbtriangle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            dumbtriangle.BorderSizePixel = 0
            dumbtriangle.Position = UDim2.new(1, -11, 0.5, -3)
            dumbtriangle.Size = UDim2.new(0, 7, 0, 6)
            dumbtriangle.ZIndex = 3
            dumbtriangle.Image = "rbxassetid://8532000591"
            valuetext.Name = "valuetext"
            valuetext.Parent = main
            valuetext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            valuetext.BackgroundTransparency = 1.000
            valuetext.Position = UDim2.new(0.00200000009, 2, 0, 7)
            valuetext.ZIndex = 2
            valuetext.Font = Enum.Font.Code
            valuetext.Text = ""
            valuetext.TextColor3 = Color3.fromRGB(244, 244, 244)
            valuetext.TextSize = 13.000
            valuetext.TextStrokeTransparency = 0.000
            valuetext.TextXAlignment = Enum.TextXAlignment.Left
            gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
            gradient.Rotation = 90
            gradient.Name = "gradient"
            gradient.Parent = main
            text.Name = "text"
            text.Parent = list
            text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0.0299999993, -1, 0, 7)
            text.ZIndex = 2
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag
            text.TextColor3 = Color3.fromRGB(244, 244, 244)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
            frame.Name = "frame"
            frame.Parent = list
            frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            frame.BorderSizePixel = 2
            frame.Position = UDim2.new(0.0299999993, -3, 0.605000019, 15)
            frame.Size = UDim2.new(0, 205, 0, 0)
            frame.Visible = false
            frame.ZIndex = library.multiZindex
            holder.Name = "holder"
            holder.Parent = frame
            holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            holder.BorderColor3 = Color3.fromRGB(60, 60, 60)
            holder.Size = UDim2.new(1, 0, 1, 0)
            UIListLayout.Parent = holder
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local function updateValue(value)
                if value == nil then valuetext.Text = "nil" return end
                if args.multiselect then
                    if type(value) == "string" then
                        if not table.find(library.options[args.flag].values,value) then return end
                        if table.find(library.flags[args.flag],value) then
                            for i,v in pairs(library.flags[args.flag]) do
                                if v == value then
                                    table.remove(library.flags[args.flag],i)
                                end
                            end
                        else
                            table.insert(library.flags[args.flag],value)
                        end
                    else
                        library.flags[args.flag] = value
                    end
                    local buttonText = ""
                    for i,v in pairs(library.flags[args.flag]) do
                        local jig = i ~= #library.flags[args.flag] and "," or ""
                        buttonText = buttonText..v..jig
                    end
                    if buttonText == "" then buttonText = "..." end
                    for i,v in next, holder:GetChildren() do
                        if v.ClassName ~= "Frame" then continue end
                        v.off.TextColor3 = Color3.new(0.65,0.65,0.65)
                        for _i,_v in next, library.flags[args.flag] do
                            if v.Name == _v then
                                v.off.TextColor3 = Color3.new(1,1,1)
                            end
                        end
                    end
                    valuetext.Text = buttonText
                    if args.callback then
                        args.callback(library.flags[args.flag])
                    end
                else
                    if not table.find(library.options[args.flag].values,value) then value = library.options[args.flag].values[1] end
                    library.flags[args.flag] = value
                    for i,v in next, holder:GetChildren() do
                        if v.ClassName ~= "Frame" then continue end
                        v.off.TextColor3 = Color3.new(0.65,0.65,0.65)
                        if v.Name == library.flags[args.flag] then
                            v.off.TextColor3 = Menu_Data.Drop_Downs
                        end
                    end
                    frame.Visible = false
                    if library.flags[args.flag] then
                        valuetext.Text = library.flags[args.flag]
                        if args.callback then
                            args.callback(library.flags[args.flag])
                        end
                    end
                end
            end
            function refresh(tbl)
                for i,v in next, holder:GetChildren() do
                    if v.ClassName == "Frame" then
                        v:Destroy()
                    end
                    frame.Size = UDim2.new(0, 205, 0, 0)
                end
                for i,v in pairs(tbl) do
                    frame.Size += UDim2.new(0, 0, 0, 20)
                    local option = Instance.new("Frame")
                    local button_2 = Instance.new("TextButton")
                    local text_2 = Instance.new("TextLabel")
                    option.Name = v
                    option.Parent = holder
                    option.BackgroundColor3 = Menu_Data.Drop_Down_BackGround
                    option.BackgroundTransparency = 1.000
                    option.Size = UDim2.new(1, 0, 0, 20)

                    button_2.Name = "button"
                    button_2.Parent = option
                    button_2.BackgroundColor3 = Menu_Data.Drop_Down_BackGround
                    button_2.BackgroundTransparency = 0
                    button_2.BorderSizePixel = 0
                    button_2.Size = UDim2.new(1, 0, 1, 0)
                    button_2.Font = Enum.Font.SourceSans
                    button_2.Text = ""
                    button_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                    button_2.TextSize = 14.000

                    text_2.Name = "off"
                    text_2.Parent = option
                    text_2.BackgroundColor3 = Menu_Data.Drop_Downs
                    text_2.BackgroundTransparency = 1.000
                    text_2.Position = UDim2.new(0, 4, 0, 0)
                    text_2.Size = UDim2.new(0, 0, 1, 0)
                    text_2.Font = Enum.Font.Code
                    text_2.Text = v
                    text_2.TextColor3 = args.multiselect and Menu_Data.Drop_Downs or Menu_Data.Drop_Downs
                    text_2.TextSize = 14.000
                    text_2.TextStrokeTransparency = 0.000
                    text_2.TextXAlignment = Enum.TextXAlignment.Left
                    button_2.MouseButton1Click:Connect(function()
                        updateValue(v)
                    end)
                end
                library.options[args.flag].values = tbl
                updateValue(table.find(library.options[args.flag].values,library.flags[args.flag]) and library.flags[args.flag] or library.options[args.flag].values[1])
            end
            button.MouseButton1Click:Connect(function()
                if not library.colorpicking then
                    frame.Visible = not frame.Visible
                end
            end)
            button.MouseEnter:connect(function()
                main.BorderColor3 = library.libColor
            end)
            button.MouseLeave:connect(function()
                main.BorderColor3 = Color3.fromRGB(60, 60, 60)
            end)
            table.insert(library.toInvis,frame)
            library.flags[args.flag] = args.multiselect and {} or ""
            library.options[args.flag] = {type = "list",changeState = updateValue,values = args.values,refresh = refresh,skipflag = args.skipflag,oldargs = args}
            refresh(args.values)
            updateValue(args.value or not args.multiselect and args.values[1] or "abcdefghijklmnopqrstuwvxyz")
        end
        function group:addConfigbox(args)
            if not args.flag or not args.values then return end
            groupbox.Size += UDim2.new(0, 0, 0, 138)
            library.multiZindex -= 1
            local list2 = Instance.new("Frame")
            local frame = Instance.new("Frame")
            local main = Instance.new("Frame")
            local holder = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local dwn = Instance.new("ImageLabel")
            local up = Instance.new("ImageLabel")
            list2.Name = "list2"
            list2.Parent = grouper
            list2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            list2.BackgroundTransparency = 1.000
            list2.BorderSizePixel = 0
            list2.Position = UDim2.new(0, 0, 0.108108111, 0)
            list2.Size = UDim2.new(1, 0, 0, 138)
            frame.Name = "frame"
            frame.Parent = list2
            frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            frame.BorderSizePixel = 2
            frame.Position = UDim2.new(0.02, -1, 0.0439999998, 0)
            frame.Size = UDim2.new(0, 205, 0, 128)
            main.Name = "main"
            main.Parent = frame
            main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            main.BorderColor3 = Color3.fromRGB(30,30,30)
            main.Size = UDim2.new(1, 0, 1, 0)
            holder.Name = "holder"
            holder.Parent = main
            holder.Active = true
            holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            holder.BackgroundTransparency = 1.000
            holder.BorderSizePixel = 0
            holder.Position = UDim2.new(0, 0, 0.00571428565, 0)
            holder.Size = UDim2.new(1, 0, 1, 0)
            holder.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            holder.CanvasSize = UDim2.new(0, 0, 0, 0)
            holder.ScrollBarThickness = 0
            holder.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
            holder.ScrollingEnabled = true
            holder.ScrollBarImageTransparency = 0
            UIListLayout.Parent = holder
            dwn.Name = "dwn"
            dwn.Parent = frame
            dwn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            dwn.BackgroundTransparency = 1.000
            dwn.BorderColor3 = Color3.fromRGB(0, 0, 0)
            dwn.BorderSizePixel = 0
            dwn.Position = UDim2.new(0.930000007, 4, 1, -9)
            dwn.Size = UDim2.new(0, 7, 0, 6)
            dwn.ZIndex = 3
            dwn.Image = "rbxassetid://8548723563"
            dwn.Visible = false
            up.Name = "up"
            up.Parent = frame
            up.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            up.BackgroundTransparency = 1.000
            up.BorderColor3 = Color3.fromRGB(0, 0, 0)
            up.BorderSizePixel = 0
            up.Position = UDim2.new(0, 3, 0, 3)
            up.Size = UDim2.new(0, 7, 0, 6)
            up.ZIndex = 3
            up.Image = "rbxassetid://8548757311"
            up.Visible = false
            local function updateValue(value)
                if value == nil then return end
                if not table.find(library.options[args.flag].values,value) then value = library.options[args.flag].values[1] end
                library.flags[args.flag] = value
                for i,v in next, holder:GetChildren() do
                    if v.ClassName ~= "Frame" then continue end
                    if v.text.Text == library.flags[args.flag] then
                        v.text.TextColor3 = library.libColor
                    else
                        v.text.TextColor3 = Color3.fromRGB(255,255,255)
                    end
                end
                if library.flags[args.flag] then
                    if args.callback then
                        args.callback(library.flags[args.flag])
                    end
                end
                holder.Visible = true
            end
            holder:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                up.Visible = (holder.CanvasPosition.Y > 1)
                dwn.Visible = (holder.CanvasPosition.Y + 1 < (holder.AbsoluteCanvasSize.Y - holder.AbsoluteSize.Y))
            end)
            function refresh(tbl)
                for i,v in next, holder:GetChildren() do
                    if v.ClassName == "Frame" then
                        v:Destroy()
                    end
                end
                for i,v in pairs(tbl) do
                    local item = Instance.new("Frame")
                    local button = Instance.new("TextButton")
                    local text = Instance.new("TextLabel")
                    item.Name = v
                    item.Parent = holder
                    item.Active = true
                    item.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    item.BackgroundTransparency = 1.000
                    item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    item.BorderSizePixel = 0
                    item.Size = UDim2.new(1, 0, 0, 18)
                    button.Parent = item
                    button.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                    button.BackgroundTransparency = 1
                    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    button.BorderSizePixel = 0
                    button.Size = UDim2.new(1, 0, 1, 0)
                    button.Text = ""
                    button.TextTransparency = 1.000
                    text.Name = 'text'
                    text.Parent = item
                    text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    text.BackgroundTransparency = 1.000
                    text.Size = UDim2.new(1, 0, 0, 18)
                    text.Font = Enum.Font.Code
                    text.Text = v
                    text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    text.TextSize = 14.000
                    text.TextStrokeTransparency = 0.000
                    button.MouseButton1Click:Connect(function()
                        updateValue(v)
                    end)
                end
                holder.Visible = true
                library.options[args.flag].values = tbl
                updateValue(table.find(library.options[args.flag].values,library.flags[args.flag]) and library.flags[args.flag] or library.options[args.flag].values[1])
            end
            library.flags[args.flag] = ""
            library.options[args.flag] = {type = "cfg",changeState = updateValue,values = args.values,refresh = refresh,skipflag = args.skipflag,oldargs = args}
            refresh(args.values)
            updateValue(args.value or not args.multiselect and args.values[1] or "abcdefghijklmnopqrstuwvxyz")
        end
        function group:addColorpicker(args)
            if not args.flag then return end
            groupbox.Size += UDim2.new(0, 0, 0, 20)
            library.multiZindex -= 1
            jigCount -= 1
            topStuff -= 1
            local colorpicker = Instance.new("Frame")
            local back = Instance.new("Frame")
            local mid = Instance.new("Frame")
            local front = Instance.new("Frame")
            local text = Instance.new("TextLabel")
            local colorpicker_2 = Instance.new("Frame")
            local button = Instance.new("TextButton")
            local colorFrame = Instance.new("Frame")
            local colorFrame_2 = Instance.new("Frame")
            local hueframe = Instance.new("Frame")
            local main = Instance.new("Frame")
            local hue = Instance.new("ImageLabel")
            local pickerframe = Instance.new("Frame")
            local main_2 = Instance.new("Frame")
            local picker = Instance.new("ImageLabel")
            local clr = Instance.new("Frame")
            local CurrentColorFrame = Instance.new("Frame")
            local CurrentColorFrame_Text = Instance.new("TextLabel")
            local ColorPicker_Gradient = Instance.new("UIGradient", front)
            ColorPicker_Gradient.Color = ColorPicker_Gradients.ColorPicker
            ColorPicker_Gradient.Rotation = 270
            colorpicker.Name = "colorpicker"
            colorpicker.Parent = grouper
            colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            colorpicker.BackgroundTransparency = 1.000
            colorpicker.BorderSizePixel = 0
            colorpicker.Size = UDim2.new(1, 0, 0, 20)
            colorpicker.ZIndex = topStuff
            text.Name = "text"
            text.Parent = colorpicker
            text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0.02, -1, 0, 10)
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag
            text.TextColor3 = Color3.fromRGB(244, 244, 244)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
            button.Name = "button"
            button.Parent = colorpicker
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundTransparency = 1.000
            button.BorderSizePixel = 0
            button.Size = UDim2.new(1, 0, 1, 0)
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
            colorpicker_2.Name = "colorpicker"
            colorpicker_2.Parent = colorpicker
            colorpicker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            colorpicker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            colorpicker_2.BorderSizePixel = 3
            colorpicker_2.Position = UDim2.new(0.860000014, 4, 0.272000015, 0)
            colorpicker_2.Size = UDim2.new(0, 20, 0, 10)
            mid.Name = "mid"
            mid.Parent = colorpicker_2
            mid.BackgroundColor3 = Color3.fromRGB(69, 23, 255)
            mid.BorderColor3 = Color3.fromRGB(30,30,30)
            mid.BorderSizePixel = 2
            mid.Size = UDim2.new(1, 0, 1, 0)
            front.Name = "front"
            front.Parent = mid
            front.BackgroundColor3 = Color3.fromRGB(0, 255, 251)
            front.BorderColor3 = Color3.fromRGB(0, 0, 0)
            front.Size = UDim2.new(1, 0, 1, 0)
            button.Name = "button"
            button.Parent = colorpicker
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundTransparency = 1.000
            button.Size = UDim2.new(0, 202, 0, 22)
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.ZIndex = args.ontop and topStuff or jigCount
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
            colorFrame.Name = "colorFrame"
            colorFrame.Parent = colorpicker
            colorFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            colorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            colorFrame.BorderSizePixel = 2
            colorFrame.Position = UDim2.new(0.101092957, 0, 0.75, 0)
            colorFrame.Size = UDim2.new(0, 187, 0, 178)
            colorFrame_2.Name = "colorFrame"
            colorFrame_2.Parent = colorFrame
            colorFrame_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            colorFrame_2.BorderColor3 = Color3.fromRGB(60, 60, 60)
            colorFrame_2.Size = UDim2.new(1, 0, 1, 0)
            hueframe.Name = "hueframe"
            hueframe.Parent = colorFrame_2
            hueframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            hueframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
            hueframe.BorderSizePixel = 2
            hueframe.Position = UDim2.new(-0.0830000022, 18, -0.0559999987, 13)
            hueframe.Size = UDim2.new(0.25, 110, 0.25, 110)
            main.Name = "main"
            main.Parent = hueframe
            main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            main.BorderColor3 = Color3.fromRGB(0, 0, 0)
            main.Size = UDim2.new(1, 0, 1, 0)
            main.ZIndex = 6
            picker.Name = "picker"
            picker.Parent = main
            picker.BackgroundColor3 = Color3.fromRGB(232, 0, 255)
            picker.BorderColor3 = Color3.fromRGB(0, 0, 0)
            picker.BorderSizePixel = 0
            picker.Size = UDim2.new(1, 0, 1, 0)
            picker.ZIndex = 104
            picker.Image = "rbxassetid://2615689005"
            pickerframe.Name = "pickerframe"
            pickerframe.Parent = colorFrame
            pickerframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            pickerframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
            pickerframe.BorderSizePixel = 2
            pickerframe.Position = UDim2.new(0.801000025, 14, -0.0559999987, 13)
            pickerframe.Size = UDim2.new(0, 20, 0.25, 110)
            CurrentColorFrame.Name = "CurrentColorFrame"
            CurrentColorFrame.Parent = colorFrame
            CurrentColorFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            CurrentColorFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
            CurrentColorFrame.BorderSizePixel = 2
            CurrentColorFrame.Position = UDim2.new(0.98, 0, 0.915, 0)
            CurrentColorFrame.Size = UDim2.new(-0.965, 0, 0, 12)
            CurrentColorFrame_Text.Name = "CurrentColorFrame_Text"
            CurrentColorFrame_Text.Parent = CurrentColorFrame
            CurrentColorFrame_Text.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            CurrentColorFrame_Text.BackgroundTransparency = 1.000
            CurrentColorFrame_Text.BorderSizePixel = 0
            CurrentColorFrame_Text.Size = UDim2.new(1, 0, 1, 0)
            CurrentColorFrame_Text.Font = Enum.Font.Code
            CurrentColorFrame_Text.Text = args.text or args.flag
            CurrentColorFrame_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
            CurrentColorFrame_Text.TextSize = 13.000
            CurrentColorFrame_Text.TextStrokeTransparency = 0.000
            main_2.Name = "main"
            main_2.Parent = pickerframe
            main_2.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            main_2.Size = UDim2.new(0, 20, 1, 0)
            main_2.ZIndex = 6
            hue.Name = "hue"
            hue.Parent = main_2
            hue.BackgroundColor3 = Color3.fromRGB(255, 0, 178)
            hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
            hue.BorderSizePixel = 0
            hue.Size = UDim2.new(0, 20, 1, 0)
            hue.ZIndex = 104
            hue.Image = "rbxassetid://2615692420"
            clr.Name = "clr"
            clr.Parent = colorFrame
            clr.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            clr.BackgroundTransparency = 1.000
            clr.BorderColor3 = Color3.fromRGB(60, 60, 60)
            clr.BorderSizePixel = 2
            clr.Position = UDim2.new(0.0280000009, 0, 0, 2)
            clr.Size = UDim2.new(0, 0, 0, 14)
            clr.ZIndex = 5
            button.MouseButton1Click:Connect(function()
                colorFrame.Visible = not colorFrame.Visible
                mid.BorderColor3 = Color3.fromRGB(30,30,30)
            end)
            button.MouseEnter:connect(function()
                mid.BorderColor3 = library.libColor
            end)
            button.MouseLeave:connect(function()
                mid.BorderColor3 = Color3.fromRGB(30,30,30)
            end)
            local function updateValue(value,fakevalue)
                if typeof(value) == "table" then value = fakevalue end
                library.flags[args.flag] = value
                front.BackgroundColor3 = value
                if args.callback then
                    args.callback(value)
                end
            end
            local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
            local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
            local heartbeat = game:GetService("RunService").Heartbeat
            local pickerX,pickerY,hueY = 0,0,0
            local oldpercentX,oldpercentY = 0,0
            hue.MouseEnter:Connect(function()
                local input = hue.InputBegan:connect(function(key)
                    if key.UserInputType == Enum.UserInputType.MouseButton1 then
                        while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            library.colorpicking = true
                            local percent = (hueY-hue.AbsolutePosition.Y-36)/hue.AbsoluteSize.Y
                            local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
                            local startC = colors[math.floor(num)]
                            local endC = colors[math.ceil(num)]
                            local color = white:lerp(picker.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
                            picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
                            updateValue(color)
                        end
                        library.colorpicking = false
                    end
                end)
                local leave
                leave = hue.MouseLeave:connect(function()
                    input:disconnect()
                    leave:disconnect()
                end)
            end)
            picker.MouseEnter:Connect(function()
                local input = picker.InputBegan:connect(function(key)
                    if key.UserInputType == Enum.UserInputType.MouseButton1 then
                        while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            library.colorpicking = true
                            local xPercent = (pickerX-picker.AbsolutePosition.X)/picker.AbsoluteSize.X
                            local yPercent = (pickerY-picker.AbsolutePosition.Y-36)/picker.AbsoluteSize.Y
                            local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
                            updateValue(color)
                            oldpercentX,oldpercentY = xPercent,yPercent
                        end
                        library.colorpicking = false
                    end
                end)
                local leave
                leave = picker.MouseLeave:connect(function()
                    input:disconnect()
                    leave:disconnect()
                end)
            end)
            hue.MouseMoved:connect(function(_, y)
                hueY = y
            end)

            picker.MouseMoved:connect(function(x, y)
                pickerX,pickerY = x,y
            end)
            table.insert(library.toInvis,colorFrame)
            library.flags[args.flag] = Color3.new(1,1,1)
            library.options[args.flag] = {type = "colorpicker",changeState = updateValue,skipflag = args.skipflag,oldargs = args}
            updateValue(args.color or Color3.new(1,1,1))
        end
        function group:addKeybind(args)
            if not args.flag then return warn("Invalid Args - toggle:keybind") end
            groupbox.Size += UDim2.new(0, 0, 0, 20)
            local next = false
            local keybind = Instance.new("Frame")
            local text = Instance.new("TextLabel")
            local button = Instance.new("TextButton")
            keybind.Parent = grouper
            keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybind.BackgroundTransparency = 1.000
            keybind.BorderSizePixel = 0
            keybind.Size = UDim2.new(1, 0, 0, 20)
            text.Parent = keybind
            text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            text.BackgroundTransparency = 1.000
            text.Position = UDim2.new(0.02, -1, 0, 10)
            text.Font = Enum.Font.Code
            text.Text = args.text or args.flag
            text.TextColor3 = Color3.fromRGB(244, 244, 244)
            text.TextSize = 13.000
            text.TextStrokeTransparency = 0.000
            text.TextXAlignment = Enum.TextXAlignment.Left
            button.Parent = keybind
            button.BackgroundColor3 = Color3.fromRGB(187, 131, 255)
            button.BackgroundTransparency = 1.000
            button.BorderSizePixel = 0
            button.Position = UDim2.new(7.09711117e-08, 0, 0, 0)
            button.Size = UDim2.new(0.02, 0, 1, 0)
            button.Font = Enum.Font.Code
            button.Text = "--"
            button.TextColor3 = Color3.fromRGB(155, 155, 155)
            button.TextSize = 13.000
            button.TextStrokeTransparency = 0.000
            button.TextXAlignment = Enum.TextXAlignment.Right
            function updateValue(val)
                if library.colorpicking then return end
                library.flags[args.flag] = val
                button.Text = keyNames[val] or val.Name
            end
            inputService.InputBegan:Connect(function(key)
                local key = key.KeyCode == Enum.KeyCode.Unknown and key.UserInputType or key.KeyCode
                if next then
                    if not table.find(library.blacklisted,key) then
                        next = false
                        library.flags[args.flag] = key
                        button.Text = keyNames[key] or key.Name
                        button.TextColor3 = Color3.fromRGB(155, 155, 155)
                    end
                end
                if not next and key == library.flags[args.flag] and args.callback then
                    args.callback()
                end
            end)
            button.MouseButton1Click:Connect(function()
                if library.colorpicking then return end
                library.flags[args.flag] = Enum.KeyCode.Unknown
                button.Text = "..."
                button.TextColor3 = Color3.new(0.2,0.2,0.2)
                next = true
            end)
            library.flags[args.flag] = Enum.KeyCode.Unknown
            library.options[args.flag] = {type = "keybind",changeState = updateValue,skipflag = args.skipflag,oldargs = args}

            updateValue(args.key or Enum.KeyCode.Unknown)
        end
        return group, groupbox
    end
    return tab
end
function contains(list, x)
    for _, v in pairs(list) do
        if v == x then return true end
    end
    return false
end
function library:createConfig()
    local name = library.flags["config_name"]
    if contains(library.options["selected_config"].values, name) then return library:notify(name..".cfg already exists!") end
    if name == "" then return library:notify("Put a name goofy") end
    local jig = {}
    for i,v in next, library.flags do
        if library.options[i].skipflag then continue end
        if typeof(v) == "Color3" then
            jig[i] = {v.R,v.G,v.B}
        elseif typeof(v) == "EnumItem" then
            jig[i] = {string.split(tostring(v),".")[2],string.split(tostring(v),".")[3]}
        else
            jig[i] = v
        end
    end
    writefile("OsirisCFGS/"..name..".cfg",game:GetService("HttpService"):JSONEncode(jig))
    library:notify("Succesfully created config "..name..".cfg!")
    library:refreshConfigs()
end
function library:saveConfig()
    local name = library.flags["selected_config"]
    local jig = {}
    for i,v in next, library.flags do
        if library.options[i].skipflag then continue end
        if typeof(v) == "Color3" then
            jig[i] = {v.R,v.G,v.B}
        elseif typeof(v) == "EnumItem" then
            jig[i] = {string.split(tostring(v),".")[2],string.split(tostring(v),".")[3]}
        else
            jig[i] = v
        end
    end
    writefile("OsirisCFGS/"..name..".cfg",game:GetService("HttpService"):JSONEncode(jig))
    library:notify("Succesfully updated config "..name..".cfg!")
    library:refreshConfigs()
end

function library:loadConfig()
    local name = library.flags["selected_config"]
    if not isfile("OsirisCFGS/"..name..".cfg") then
        library:notify("Config file not found!")
        return
    end
    local config = game:GetService("HttpService"):JSONDecode(readfile("OsirisCFGS/"..name..".cfg"))
    for i,v in next, library.options do
        spawn(function()pcall(function()
            if config[i] then
                if v.type == "colorpicker" then
                    v.changeState(Color3.new(config[i][1],config[i][2],config[i][3]))
                elseif v.type == "keybind" then
                    v.changeState(Enum[config[i][1]][config[i][2]])
                else
                    if config[i] ~= library.flags[i] then
                        v.changeState(config[i])
                    end
                end
            else
                if v.type == "toggle" then
                    v.changeState(false)
                elseif v.type == "slider" then
                    v.changeState(v.args.value or 0)
                elseif v.type == "textbox" or v.type == "list" or v.type == "cfg" then
                    v.changeState(v.args.value or v.args.text or "")
                elseif v.type == "colorpicker" then
                    v.changeState(v.args.color or Color3.new(1,1,1))
                elseif option.type == "list" then
                    v.changeState("")
                elseif option.type == "keybind" then
                    v.changeState(v.args.key or Enum.KeyCode.Unknown)
                end
            end
        end)end)
    end
    library:notify("Succesfully loaded config "..name..".cfg!")
end
function library:refreshConfigs()
    local tbl = {}
    for i,v in next, listfiles("OsirisCFGS") do
        table.insert(tbl,v)
    end
    library.options["selected_config"].refresh(tbl)
end
function library:deleteConfig()
    if isfile("OsirisCFGS/"..library.flags["selected_config"]..".cfg") then
        delfile("OsirisCFGS/"..library.flags["selected_config"]..".cfg")
        library:refreshConfigs()
    end
end


-- Assuming TweenService and InputService are already initialized
local tweenService = game:GetService("TweenService")
local inputService = game:GetService("UserInputService")

-- Define the duration of the fade animation
local fadeDuration = 0.3

-- Function to create a fade effect
local function FadeUI(element, targetTransparency, callback)
    -- Tween the transparency property for a smooth transition
    local tweenInfo = TweenInfo.new(fadeDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Loop through all UI elements inside the menu and apply fade
    for _, descendant in pairs(element:GetDescendants()) do
        if descendant:IsA("GuiObject") then
            -- Determine the correct property to tween (for both text and background)
            local tweenProperties = {}

            -- If it has BackgroundTransparency, fade it
            if descendant:FindFirstChild("BackgroundTransparency") then
                tweenProperties.BackgroundTransparency = targetTransparency
            end

            -- If it has TextTransparency (like TextLabels), fade the text
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                tweenProperties.TextTransparency = targetTransparency
            end

            -- Apply the tween to each descendant UI element
            local tween = tweenService:Create(descendant, tweenInfo, tweenProperties)
            tween:Play()

            tween.Completed:Connect(function()
                if callback then callback() end
            end)
        end
    end
end

-- Toggle function to show/hide UI with fade effect
local uiVisible = true
local function ToggleUI()
    if uiVisible then
        -- Fade out all UI elements
        FadeUI(menu, 1, function() 
            menu.Enabled = false  -- Disable the entire UI after fading out
        end)
    else
        -- Enable the UI first, then fade in all elements
        menu.Enabled = true
        FadeUI(menu, 0)
    end
    uiVisible = not uiVisible
end

-- Bind the toggle to a key (e.g., "End" key)
inputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Insert then
        ToggleUI()  -- Call the toggle function when "End" is pressed
    end
end)

local function UnloadUI()
    -- Check if the menu exists and remove it
    if menu then
        menu:Destroy()  -- Destroy the UI
    end

    -- Clean up notifications
    for _, notification in pairs(notifications1) do
        notification:Destroy()
    end
    for _, notification in pairs(notifications2) do
        notification:Destroy()
    end

    -- Hide the custom cursor if enabled
    if Cursor then
        Cursor:Remove()
    end
    if CursorOutline then
        CursorOutline:Remove()
    end

    -- Restore the default mouse icon
    game:GetService('UserInputService').MouseIconEnabled = true

    -- Optionally reset any other states like toggled flags, etc.
    -- For example, reset flags used in the library if needed.
    library.flags = {}
end



--[[>>End Of Ui>>]]




















































--[[>>INIT UI>>]]

local Legit = library:addTab("Legit")
local visualsTab = library:addTab("Visuals")
local miscTab = library:addTab("Misc")
-- kinda fucking useless tbh [[ local luaTab = library:addTab("Luas") ]]
local configTab = library:addTab("Settings")

local sections = {
    -- regular stuffs 
    LegitSec1 = Legit:createGroup('left', 'Left'); -- left
    LegitSec2 = Legit:createGroup('center', 'Center'); -- left
    LegitSec3 = Legit:createGroup('right', 'Right'); -- right
    --[[>>>>]]
    --visuals stuffs
    VisualsSec1 = visualsTab:createGroup('left', 'Left'); -- left
    VisualsSec2 = visualsTab:createGroup('center', 'Center'); -- left
    VisualsSec3 = visualsTab:createGroup('right', 'Right'); -- right
    --[[>>>>]]
    -- Misc Stuffs
    MiscSec1 = miscTab:createGroup('left', 'Left'); -- left
    MiscSec2 = miscTab:createGroup('center', 'Center'); -- left
    MiscSec3 = miscTab:createGroup('right', 'Right'); -- right
    --[[>>>>]]
    --ui settings
    createconfigs = configTab:createGroup('left', 'Create Configs');
    configsettings = configTab:createGroup('left', 'Config Settings');
    uisettings = configTab:createGroup('center', 'UI Settings');
    othersettings = configTab:createGroup('right', 'Other');
}
        --[[>>                                  <<]]

        
        sections.LegitSec1:addSlider({
            text = "Volume", -- The label that appears next to the slider
            flag = "VolumeSlider", -- A unique identifier for this slider
            min = 0, -- The minimum value for the slider
            max = 100, -- The maximum value for the slider
            value = 50, -- The default starting value
            callback = function(value) -- A function that gets called whenever the slider's value changes
                print("Slider value changed to:", value) -- Your custom logic here
                -- You can replace the print statement with any action, like adjusting volume
            end
        })
sections.LegitSec1:addButton({
    text = "p diddy",
    callback = function() UnloadUI() end
})
--



--
sections.LegitSec1:addToggle({
    text = "Toggle 1",
    callback = function() print("d") end
})
--

sections.MiscSec1:addLabel({
    text = "This is a label!"
})

--
sections.LegitSec2:addButton({
    text = "print \\D\" 2",
    callback = function() print("d") end
})
--
sections.LegitSec2:addToggle({
    text = "Toggle 2",
    callback = function() print("d") end
})
--
sections.LegitSec3:addButton({
    text = "print \"D\" 3",
    callback = function() print("d") end
})
--
sections.LegitSec3:addToggle({
    text = "Toggle 3",
    callback = function() print("d") end
})
--
sections.VisualsSec1:addButton({
    text = "print \"D\" 4",
    callback = function() print("d") end
})
--
sections.VisualsSec1:addToggle({
    text = "Toggle 4",
    callback = function() print("d") end
})
--
sections.VisualsSec2:addButton({
    text = "print \\D\" 5",
    callback = function() print("d") end
})
--
sections.VisualsSec2:addToggle({
    text = "Toggle 5",
    callback = function() print("d") end
})
--
sections.VisualsSec3:addButton({
    text = "print \"D\" 6",
    callback = function() print("d") end
})
--
sections.VisualsSec3:addToggle({
    text = "Toggle 6",
    callback = function() print("d") end
})
--
sections.MiscSec1:addButton({
    text = "print \"D\" 7",
    callback = function() print("d") end
})
sections.MiscSec1:addToggle({
    text = "Toggle 7",
    callback = function() print("d") end
})
--
sections.MiscSec2:addButton({
    text = "print \\D\" 8",
    callback = function() print("d") end
})
--
sections.MiscSec2:addToggle({
    text = "Toggle 8",
    callback = function() print("d") end
})
sections.MiscSec3:addButton({
    text = "print \"D\" 9",
    callback = function() print("d") end
})
--
sections.MiscSec3:addToggle({
    text = "Toggle 9",
    callback = function() print("d") end
})
sections.MiscSec1:addSlider({
    text = "Sdlier 9",
    callback = function() print("d") end
})
        --[[>>                                  <<]]

-- Add buttons and other elements to the sections

sections.createconfigs:addTextbox({text = "Name", flag = "config_name"})

sections.configsettings:addConfigbox({flag = 'test', values = {}})
sections.configsettings:addButton({text = "Load", callback = library.loadConfig})
sections.configsettings:addButton({text = "Update", callback = library.saveConfig})
sections.configsettings:addButton({text = "Delete", callback = library.deleteConfig})
sections.configsettings:addButton({text = "Refresh", callback = library.refreshConfigs})

sections.uisettings:addToggle({text = "Show Game Name", flag = "show_game_name"})

-- Toggle setup (integrating your toggle with the watermark toggle)
sections.uisettings:addToggle({
    text = "Toggle Watermark",
    callback = function(value)
        ToggleWatermark(value)  -- Pass true/false to toggle the visibility of the watermark
    end
})

-- Create X Position Slider
sections.LegitSec1:addSlider({
    text = "Watermark X Position", -- The label that appears next to the slider
    flag = "WatermarkXSlider", -- A unique identifier for this slider
    min = 0, -- The minimum value for the slider
    max = 2500, -- The maximum value for the slider
    value = 0, -- The default starting value
    callback = function(value) -- A function that gets called whenever the slider's value changes
        setWatermarkPosition(value, WatermarkOutline.Position.Y.Offset)
        print("Watermark X Position changed to:", value) -- Custom logic here
    end
})

-- Create Y Position Slider
sections.LegitSec1:addSlider({
    text = "Watermark Y Position", -- The label that appears next to the slider
    flag = "WatermarkYSlider", -- A unique identifier for this slider
    min = -35, -- The minimum value for the slider
    max = 1000, -- The maximum value for the slider
    value = 0, -- The default starting value
    callback = function(value) -- A function that gets called whenever the slider's value changes
        setWatermarkPosition(WatermarkOutline.Position.X.Offset, value)
        print("Watermark Y Position changed to:", value) -- Custom logic here
    end
})
sections.uisettings:addToggle({
    text = "Show Keybinds",
    callback = function(Valuee) getgenv().Toggledkeybinds = Valuee end
})

sections.uisettings:addTextbox({text = "Menu Title", flag = "menutitle"})
sections.uisettings:addTextbox({text = "Domain", flag = "menudomain"})
sections.uisettings:addColorpicker({text = "Domain Accent", ontop = true, flag = "domainaccent", color = Color3.new(1, 1, 1)})
sections.uisettings:addColorpicker({text = "Menu Accent", ontop = true, flag = "menuaccent", color = Color3.new(1, 1, 1)})

sections.othersettings:addButton({text = "Rejoin", callback = Rejoin})
sections.othersettings:addToggle({text = "Show Keybinds", flag = "show_keybinds"})
sections.configsettings:addButton({text = "Copy Game Invite"})
sections.configsettings:addButton({text = "Rejoin Server"})
sections.configsettings:addButton({text = "Server Hop"})

