local function isfolder(v) return false end
local function isfile(v) return false end
local function makefolder(v) end
local function writefile(v) end
local function readfile(v) return nil end
local function listfiles(v) return {} end
local function delfile(v) end
local function delfolder(v) end
local function cloneref(v) return v end

local Lighting = cloneref(game:GetService("Lighting"))
local TweenService = cloneref(game:GetService("TweenService"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local Workspace = cloneref(game:GetService("Workspace"))
local CoreGui = RunService:IsStudio() and Players.LocalPlayer.PlayerGui or cloneref(game:GetService("CoreGui"))

local Library = {
	Fading = false,
	Accent = Color3.fromRGB(2, 112, 200),
	AccentObjects = {},

	Flags = {},
	Config = {},

	Font = Font.fromId(11702779409, Enum.FontWeight.Regular), -- Poppins
	FontSize = 15,
	MenuKey = Enum.KeyCode.LeftAlt,
	Folder = "v3"
}

Library.__index = Library

if not isfolder(Library.Folder) then
	makefolder(Library.Folder)
end

if not isfolder(Library.Folder .. "/Configs") then
	makefolder(Library.Folder .. "/Configs")
end

local ConvertKeys = {
	[Enum.KeyCode.LeftShift] = "LS",
	[Enum.KeyCode.RightShift] = "RS",
	[Enum.KeyCode.LeftControl] = "LC",
	[Enum.KeyCode.RightControl] = "RC",
	[Enum.KeyCode.Insert] = "INS",
	[Enum.KeyCode.Backspace] = "BS",
	[Enum.KeyCode.Return] = "Ent",
	[Enum.KeyCode.LeftAlt] = "LA",
	[Enum.KeyCode.RightAlt] = "RA",
	[Enum.KeyCode.CapsLock] = "CAPS",
	[Enum.KeyCode.One] = "1",
	[Enum.KeyCode.Two] = "2",
	[Enum.KeyCode.Three] = "3",
	[Enum.KeyCode.Four] = "4",
	[Enum.KeyCode.Five] = "5",
	[Enum.KeyCode.Six] = "6",
	[Enum.KeyCode.Seven] = "7",
	[Enum.KeyCode.Eight] = "8",
	[Enum.KeyCode.Nine] = "9",
	[Enum.KeyCode.Zero] = "0",
	[Enum.KeyCode.KeypadOne] = "Num1",
	[Enum.KeyCode.KeypadTwo] = "Num2",
	[Enum.KeyCode.KeypadThree] = "Num3",
	[Enum.KeyCode.KeypadFour] = "Num4",
	[Enum.KeyCode.KeypadFive] = "Num5",
	[Enum.KeyCode.KeypadSix] = "Num6",
	[Enum.KeyCode.KeypadSeven] = "Num7",
	[Enum.KeyCode.KeypadEight] = "Num8",
	[Enum.KeyCode.KeypadNine] = "Num9",
	[Enum.KeyCode.KeypadZero] = "Num0",
	[Enum.KeyCode.Minus] = "-",
	[Enum.KeyCode.Equals] = "=",
	[Enum.KeyCode.Tilde] = "~",
	[Enum.KeyCode.LeftBracket] = "[",
	[Enum.KeyCode.RightBracket] = "]",
	[Enum.KeyCode.RightParenthesis] = ")",
	[Enum.KeyCode.LeftParenthesis] = "(",
	[Enum.KeyCode.Semicolon] = ",",
	[Enum.KeyCode.Quote] = "'",
	[Enum.KeyCode.BackSlash] = "\\",
	[Enum.KeyCode.Comma] = ",",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Slash] = "/",
	[Enum.KeyCode.Asterisk] = "*",
	[Enum.KeyCode.Plus] = "+",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Backquote] = "`",
	[Enum.UserInputType.MouseButton1] = "MB1",
	[Enum.UserInputType.MouseButton2] = "MB2",
	[Enum.UserInputType.MouseButton3] = "MB3",
	[Enum.KeyCode.Escape] = "ESC",
	[Enum.KeyCode.Space] = "SPC",
}

function Library:New(Type, Props)
	local Obj = Instance.new(Type)

	if Props then
		for i, v in Props do
			Obj[i] = v
		end
	end

	return Obj
end

function Library:Round(Val, Float)
	local Mult = 1 / (Float or 1)
	return math.floor(Val * Mult + 0.5) / Mult
end

function Library:SetAccent(Color)
	local NewColor = Color or Color3.fromRGB(255, 255, 255)
	Library.Accent = NewColor
	for _, v in Library.AccentObjects do
		if v:IsA("Frame") then
			v.BackgroundColor3 = NewColor
		elseif v:IsA("ScrollingFrame") then
			v.ScrollBarImageColor3 = NewColor
		elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
			if v.BackgroundColor3 ~= Color3.fromRGB(46, 46, 46) then
				v.BackgroundColor3 = NewColor
				v.ImageColor3 = NewColor
			end
		end
	end
end

function Library:Save()
	local Table = {}

	for Flag, Obj in Library.Config do
		local Value = Library.Flags[Flag]

		if Obj.Class == "Colorpicker" then
			Table[Flag] = {a = Value.a, c = Value.c:ToHex()}
		elseif Obj.Class == "Keybind" then
			Table[Flag] = {Key = tostring(Obj.Key), Mode = Obj.Mode}
		else
			Table[Flag] = Value
		end
	end

	return HttpService:JSONEncode(Table)
end

function Library:Load(Config)
	local Table = HttpService:JSONDecode(Config)

	for Flag, Obj in Table do
		local Element = Library.Config[Flag]

		if Element then
			if Element.Class == "Colorpicker" then
				Element:Set({a = Obj.a, c = Color3.fromHex(Obj.c)})
			elseif Element.Class == "Keybind" then
				Element:Set({Key = Obj.Key, Mode = Obj.Mode})
			else
				Element:Set(Obj)
			end
		end
	end
end	

function Library:GetFiles(Folder)
	local Files = {}
	local Names = {}

	local Test = Folder .. "/"

	if isfolder(Folder) then
		for _, File in listfiles(Folder) do
			table.insert(Files, File)
			local Name = File:gsub(Test, ""):gsub(".cfg", "")
			table.insert(Names, Name)
		end
	end

	return Files, Names
end

function Library:ConvertToEnum(Value)
	local enumParts = {}
	for part in string.gmatch(Value, "[%w_]+") do
		table.insert(enumParts, part)
	end

	local enumTable = Enum
	for i = 2, #enumParts do
		local enumItem = enumTable[enumParts[i]]

		enumTable = enumItem
	end

	return enumTable
end

Library.ScreenGui = Library:New("ScreenGui", {
	Name = "\0",
	Enabled = true,
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	DisplayOrder = 8,
	Parent = CoreGui
})

Library.Priority = Library:New("ScreenGui", {
	Name = "\0",
	Enabled = true,
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	DisplayOrder = 9,
	Parent = CoreGui
})

Library.Mouse = Library:New("ImageLabel", {
	Name = "\0",
	Image = "rbxassetid://76170730910067",
	ImageColor3 = Library.Accent,
	Size = UDim2.new(0, 14, 0, 19),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 100,
	Parent = Library.Priority
})
table.insert(Library.AccentObjects, Library.Mouse)

function Library:Window(Props)
	local Props = {
		Name = Props.Name or "Window Name",
		Size = Props.Size or Vector2.new(448, 598),
		Font = Props.Font or nil,
		FontSize = Props.FontSize or nil
	}

	do -- Custom Fonts
		if Props.Font ~= nil then
			Library.Font = Props.Font
		end

		if Props.FontSize ~= nil then
			Library.FontSize = Props.FontSize
		end
	end

	local Window = {
		Mouse = false,
		Visible = false,
		Objects = {},
		Pages = {}
	}

	local WatermarkInline = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(0, 19),
		Position = UDim2.fromOffset(5, 5),
		AutomaticSize = "X",
		ZIndex = 50,
		Visible = false,
		Parent = Library.ScreenGui
	})

	local WatermarkInlineStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = WatermarkInline
	})

	local WatermarkInlineAccent = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 2),
		ZIndex = 60,
		Parent = WatermarkInline
	})
	table.insert(Library.AccentObjects, WatermarkInlineAccent)

	local WatermarkInlineAccentStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = WatermarkInlineAccent
	})

	local WatermarkInlineAccentGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
		}),
		Rotation = 90,
		Parent = WatermarkInlineAccent
	})

	local WatermarkHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -5),
		Position = UDim2.fromOffset(1, 4),
		ZIndex = 51,
		Parent = WatermarkInline
	})

	local WatermarkBackground = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 52,
		Parent = WatermarkHolder
	})

	local WatermarkBackgroundGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 90,
		Parent = WatermarkBackground
	})

	local WatermarkText = Library:New("TextLabel", {
		Name = "\0",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(4, 0),
		Size = UDim2.new(0, 0, 1, 0),
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		Text = "TBD",
		AutomaticSize = "X",
		ZIndex = 53,
		Parent = WatermarkBackground
	})
	local WatermarkTextPadding = Library:New("UIPadding", {
		Name = "\0",
		PaddingRight = UDim.new(0, 4),
		Parent = WatermarkText
	})

	local Modal = Library:New('TextButton', {
		Name = "\0",
		Size = UDim2.new(0, 0, 0, 0),
		Text = "",
		Visible = true,
		Modal = false,
		BackgroundTransparency = 1,
		Parent = Library.ScreenGui
	})

	local Inline1 = Library:New("ImageButton", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		Size = UDim2.fromOffset(Props.Size.X, Props.Size.Y),
		Position = UDim2.new(0, (Workspace.CurrentCamera.ViewportSize.X / 2) - (Props.Size.X / 2), 0, (Workspace.CurrentCamera.ViewportSize.Y / 2) - (Props.Size.Y / 2)),
		BorderSizePixel = 0,
		Visible = false,
		Image = "",
		ImageTransparency = 1,
		AutoButtonColor = false,
		ZIndex = 1,
		Parent = Library.ScreenGui
	})

	local Inline1Stroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline1
	})

	local Inline1Accent = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 2),
		ZIndex = 5,
		Parent = Inline1
	})
	table.insert(Library.AccentObjects, Inline1Accent)

	local Inline1AccentStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = Inline1Accent
	})

	local Inline1AccentGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
		}),
		Rotation = 90,
		Parent = Inline1Accent
	})

	local Holder1 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		Size = UDim2.new(1, -2, 1, -5),
		Position = UDim2.fromOffset(1, 4),
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = Inline1
	})

	local TitleHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(1, 0, 0, 20),
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = Holder1
	})

	local TitleHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 46, 46)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
		}),
		Rotation = 90,
		Parent = TitleHolder
	})

	local ActualTitle = Library:New("TextLabel", {
		Name = "\0",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(3, 0),
		Size = UDim2.new(1, -3, 0, 14),
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextWrapped = true,
		TextXAlignment = "Left",
		Text = Props.Name,
		ZIndex = 4,
		Parent = TitleHolder
	})

	local Inline2 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		Size = UDim2.new(1, -14, 1, -22),
		Position = UDim2.fromOffset(7, 15),
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = Holder1
	})

	local Inline2Stroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(46, 46, 46),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = Inline2
	})

	local Inline2Darker = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(25, 25, 25),
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		BorderSizePixel = 0,
		ZIndex = 5,
		Parent = Inline2
	})

	local Darker1 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		Size = UDim2.new(1, -4, 1, -4),
		Position = UDim2.fromOffset(2, 2),
		BorderSizePixel = 0,
		ZIndex = 6,
		Parent = Inline2Darker
	})

	local Inline3 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		BorderSizePixel = 0,
		ZIndex = 7,
		Parent = Darker1
	})

	local Inline3Accent = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 2),
		ZIndex = 20,
		Parent = Inline3
	})
	table.insert(Library.AccentObjects, Inline3Accent)

	local Inline3AccentStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = Inline3Accent
	})

	local Inline3AccentGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
		}),
		Rotation = 90,
		Parent = Inline3Accent
	})

	local TabHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		Size = UDim2.new(1, 0, 0, 19),
		Position = UDim2.fromOffset(0, 2),
		ClipsDescendants = true,
		BorderSizePixel = 0,
		ZIndex = 8,
		Parent = Inline3
	})

	local TabHolderGradientFrame = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(31, 31, 31),
		Size = UDim2.new(1, 0, 1, -2),
		Position = UDim2.fromOffset(0, 1),
		BorderSizePixel = 0,
		ZIndex = 9,
		Parent = TabHolder
	})

	local TabHolderActualGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 90,
		Parent = TabHolderGradientFrame
	})

	local ActualTabHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -2),
		Position = UDim2.fromOffset(0, 1),
		BorderSizePixel = 0,
		ZIndex = 10,
		Parent = TabHolder
	})

	local ActualTabHolderList = Library:New("UIListLayout", {
		Name = "\0",
		FillDirection = "Horizontal",
		Parent = ActualTabHolder
	})

	local Darker2 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		Size = UDim2.new(1, -2, 1, -23),
		Position = UDim2.fromOffset(1, 22),
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = Inline3
	})

	local Darker2GradientFrame = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		Size = UDim2.new(1, 0, 0, 28),
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = Darker2
	})

	local Darker2ActualGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 190, 190))
		}),
		Rotation = 90,
		Parent = Darker2GradientFrame
	})

	local FadeThing = Library:New("Frame", {
		Name = "\0",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 40,
		Parent = Darker2
	})

	local PageHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -6, 1, -7),
		Position = UDim2.fromOffset(3, 4),
		BorderSizePixel = 0,
		ZIndex = 13,
		Parent = Darker2
	})

	local DragFrame = Library:New("Frame", {
		Name = "\0",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 18),
		ZIndex = 6,
		Parent = Holder1
	})

	local OldMouseState = nil

	local Dragging = false
	local DragPos, FramePos

	DragFrame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragPos = Vector2.new(Input.Position.X, Input.Position.Y)
			FramePos = Inline1.Position
		end
	end)

	DragFrame.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = false
		end
	end)

	RunService.RenderStepped:Connect(function()
		local MousePos = UserInputService:GetMouseLocation()

		if Dragging then
			local MousePos = UserInputService:GetMouseLocation()
			local NewPos = Vector2.new(MousePos.X, MousePos.Y - 36)
			local Delta = NewPos - DragPos
			Inline1.Position = UDim2.new(
				FramePos.X.Scale, FramePos.X.Offset + Delta.X,
				FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y
			)
		end

		if Window.Mouse then
			UserInputService.MouseIconEnabled = false
			Library.Mouse.Position = UDim2.fromOffset(MousePos.X, MousePos.Y)
			Library.Mouse.Visible = true
		else
			if OldMouseState ~= nil then
				UserInputService.MouseIconEnabled = OldMouseState
			end

			Library.Mouse.Visible = false
			OldMouseState = nil
		end
	end)

	Window.Objects.FadeThing = FadeThing

	Window.Objects.Tabs = ActualTabHolder
	Window.Objects.Pages = PageHolder
	Window.Objects.Modal = Modal

	function Window:SetTitle(Name)
		if Name then
			ActualTitle.Text = Name
		end
	end

	-- function Window:SetVisibility(Value)
	-- 	if Value == true and Library.Fading == false then
	-- 		OldMouseState = UserInputService.MouseIconEnabled
	-- 		Window.Mouse = true
	-- 		Library.Fading = true
	-- 		for _, Obj in Library.ScreenGui:GetChildren() do
	-- 			if Obj:IsA("ImageButton") then
	-- 				Obj.Visible = true

	-- 				for _, Desc in Obj:GetDescendants() do
	-- 					local ToTween = {}
	-- 					if Desc:IsA("Frame") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 					elseif Desc:IsA("ScrollingFrame") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "ScrollBarImageTransparency")
	-- 					elseif Desc:IsA("UIStroke") then
	-- 						table.insert(ToTween, "Transparency")
	-- 					elseif Desc:IsA("TextLabel") or Desc:IsA("TextButton") or Desc:IsA("TextBox") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "TextTransparency")
	-- 					elseif Desc:IsA("ImageButton") or Desc:IsA("ImageLabel") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "ImageTransparency")
	-- 					end

	-- 					for _, T in ToTween do
	-- 						if Desc:IsA("UIStroke") then
	-- 							TweenService:Create(Desc, TweenInfo.new(0.25), {[T] = 0}):Play()
	-- 						elseif Desc:IsA("ImageButton") or Desc:IsA("ImageLabel") then
	-- 							if Desc["Image"] ~= "" then
	-- 								if Desc["BackgroundColor3"] == Color3.fromRGB(163, 162, 165) then
	-- 									TweenService:Create(Desc, TweenInfo.new(0.25), {["ImageTransparency"] = 0}):Play()
	-- 								else
	-- 									TweenService:Create(Desc, TweenInfo.new(0.25), {[T] = 0}):Play()
	-- 								end
	-- 							end
	-- 						else
	-- 							if Desc[T] ~= 1 then
	-- 								TweenService:Create(Desc, TweenInfo.new(0.25), {[T] = 0}):Play()
	-- 							end
	-- 						end
	-- 					end
	-- 				end

	-- 				local Tween = TweenService:Create(Obj, TweenInfo.new(0.25), {BackgroundTransparency = 0}) 
	-- 				Tween:Play()
	-- 				Tween.Completed:Connect(function()
	-- 					Window.Visible = true
	-- 					Library.Fading = false
	-- 				end)
	-- 			end
	-- 		end
	-- 		Modal.Modal = true
	-- 	elseif Value == false and Library.Fading == false then
	-- 		Window.Mouse = false
	-- 		Library.Fading = true
	-- 		for _, Obj in Library.ScreenGui:GetChildren() do
	-- 			if Obj:IsA("ImageButton") then
	-- 				for _, Desc in Obj:GetDescendants() do
	-- 					local ToTween = {}
	-- 					if Desc:IsA("Frame") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 					elseif Desc:IsA("ScrollingFrame") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "ScrollBarImageTransparency")
	-- 					elseif Desc:IsA("UIStroke") then
	-- 						table.insert(ToTween, "Transparency")
	-- 					elseif Desc:IsA("TextLabel") or Desc:IsA("TextButton") or Desc:IsA("TextBox") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "TextTransparency")
	-- 					elseif Desc:IsA("ImageButton") or Desc:IsA("ImageLabel") then
	-- 						table.insert(ToTween, "BackgroundTransparency")
	-- 						table.insert(ToTween, "ImageTransparency")
	-- 					end

	-- 					for _, T in ToTween do
	-- 						if Desc[T] ~= 1 then
	-- 							if Desc:IsA("UIStroke") then
	-- 								TweenService:Create(Desc, TweenInfo.new(0.25), {[T] = 1}):Play()
	-- 							else
	-- 								TweenService:Create(Desc, TweenInfo.new(0.25), {[T] = 1.01}):Play()
	-- 							end
	-- 						end
	-- 					end
	-- 				end

	-- 				local Tween = TweenService:Create(Obj, TweenInfo.new(0.25), {BackgroundTransparency = 1})
	-- 				Tween:Play()
	-- 				Tween.Completed:Connect(function()
	-- 					Obj.Visible = false
	-- 					Library.Fading = false
	-- 					Window.Visible = false
	-- 				end)
	-- 			end
	-- 		end
	-- 		Modal.Modal = false
	-- 	end
	-- end

	function Window:SetVisibility(Value)
		if Value == true then
			OldMouseState = UserInputService.MouseIconEnabled
			Window.Mouse = true
			Modal.Modal = true
			Window.Visible = true
			Inline1.Visible = true
		elseif Value == false then
			Window.Mouse = false
			Modal.Modal = false
			Window.Visible = false
			Inline1.Visible = false
		end
	end

	function Window:SetSize(vec2)
		if vec2 and vec2.X and vec2.Y then
			Inline1.Size = UDim2.fromOffset(vec2.X, vec2.Y)
		end
	end

	Window:SetVisibility(true)

	return setmetatable(Window, Library)
end

function Library:Page(Props)
	local Props = {
		Name = Props.Name or "Page Name"
	}

	local Page = {
		Window = self,
		Objects = {},
		Sections = {}
	}

	local TabHolder = Page.Window.Objects.Tabs
	local PageHolder = Page.Window.Objects.Pages

	local ButtonHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(31, 31, 31),
		AutomaticSize = "X",
		Size = UDim2.new(0, 0, 1, 0),
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = TabHolder
	})

	local ButtonHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 270,
		Parent = ButtonHolder
	})

	local ButtonHolderStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = ButtonHolder
	})

	local ActualButton = Library:New("TextButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		AutomaticSize = "X",
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		Size = UDim2.new(1, 14, 0, 18),
		ZIndex = 12,
		Parent = ButtonHolder
	})

	local PageFrame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 14,
		Parent = PageHolder
	})

	local PageLeft = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, -3, 1, 0),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = PageFrame
	})

	local PageLeftList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 6),
		Parent = PageLeft
	})

	local PageRight = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, -3, 1, 0),
		Position = UDim2.new(0.5, 3, 0, 0),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = PageFrame
	})

	local PageRightList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 6),
		Parent = PageRight
	})

	local PageMiddle = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = PageFrame
	})

	local PageMiddleList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 6),
		Parent = PageMiddle
	})

	Page.Objects = {
		Left = PageLeft,
		Right = PageRight,
		Middle = PageMiddle,
		Button = ActualButton
	}

	function Page:Select(Skip)
		Skip = Skip ~= nil and true or false
		if Skip then
			for _, v in PageHolder:GetChildren() do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end

			for _, v in TabHolder:GetChildren() do
				if v:IsA("Frame") then
					v.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
					v.Size = UDim2.new(0, 0, 1, 0)
				end
			end

			ButtonHolder.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			ButtonHolder.Size = UDim2.new(0, 0, 1, 1)
			PageFrame.Visible = true
			return
		end

		if ButtonHolder.BackgroundColor3 ~= Color3.fromRGB(46, 46, 46) then
			local FadeThing = Page.Window.Objects.FadeThing
			FadeThing.Visible = true

			local FadeIn = TweenService:Create(FadeThing, TweenInfo.new(0.1), {BackgroundTransparency = 0})
			FadeIn:Play()

			FadeIn.Completed:Connect(function() 
				for _, v in PageHolder:GetChildren() do
					if v:IsA("Frame") then
						v.Visible = false
					end
				end

				for _, v in TabHolder:GetChildren() do
					if v:IsA("Frame") then
						if v.BackgroundColor3 ~= Color3.fromRGB(31, 31, 31) then
							v.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
							v.Size = UDim2.new(0, 0, 1, 0)
						end
					end
				end

				TweenService:Create(ButtonHolder, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(46, 46, 46)}):Play()
				ButtonHolder.Size = UDim2.new(0, 0, 1, 1)
				PageFrame.Visible = true

				local FadeOut = TweenService:Create(FadeThing, TweenInfo.new(0.1), {BackgroundTransparency = 1})
				FadeOut:Play()

				FadeOut.Completed:Connect(function()
					FadeThing.Visible = false
				end)
			end)
		end
	end

	ActualButton.MouseButton1Down:Connect(function()
		Page:Select(true)
	end)

	table.insert(Page.Window.Pages, Page)
	if #Page.Window.Pages == 1 then
		Page:Select(true)
	end

	return setmetatable(Page, Library)
end

function Library:Section(Props)
	Props = {
		Name = Props.Name or "Missing Section Name!!",
		Size = Props.Size or Vector2.new(0, 150),
		Side = Props.Side or "Left",
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Section = {
		Page = self,
		Objects = {}
	}

	local Inline1 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, Props.Size.Y),
		ZIndex = 16,
		Visible = Props.Visible,
		Parent = Section.Page.Objects[Props.Side]
	})

	local Inline1Stroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline1
	})

	local Inline1Accent = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 2),
		ZIndex = 17,
		Parent = Inline1
	})
	table.insert(Library.AccentObjects, Inline1Accent)

	local Inline1AccentStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = Inline1Accent
	})

	local Inline1AccentGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
		}),
		Rotation = 90,
		Parent = Inline1Accent
	})

	local Darker = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -5),
		Position = UDim2.fromOffset(1, 4),
		ZIndex = 17,
		Parent = Inline1
	})

	local NameHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 30),
		ZIndex = 18,
		Parent = Darker
	})

	local NameHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 46, 46)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
		}),
		Rotation = 90,
		Parent = NameHolder
	})

	local ActualName = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -3, 0, 14),
		Position = UDim2.fromOffset(3, 0),
		Text = Props.Name,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		TextWrapped = true,
		ZIndex = 19,
		Parent = NameHolder
	})

	local ActualSection = Library:New("ScrollingFrame", {
		Name = "\0",
		Size = UDim2.new(1, 0, 1, -18),
		Position = UDim2.new(0, 0, 0, 18),
		BackgroundTransparency = 1,
		ZIndex = 18,
		ClipsDescendants = true,
		Visible = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		BottomImage = "rbxassetid://136016235498668",
		MidImage = "rbxassetid://136016235498668",
		TopImage = "rbxassetid://136016235498668",
		ScrollBarImageColor3 = Library.Accent,
		ScrollingEnabled = true,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
		BorderSizePixel = 0,
		ScrollBarThickness = 2,
		Parent = Darker
	})
	table.insert(Library.AccentObjects, ActualSection)

	local ActualSectionList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 4),
		Parent = ActualSection
	})

	function Section:Rename(String)
		if String then
			ActualName.Text = String
		end
	end

	function Section:Resize(Vec2)
		if Vec2 and Vec2.X and Vec2.Y then
			Inline1.Size = UDim2.new(1, 0, 0, Vec2.Y)
		end
	end

	function Section:SetVisibility(Value)
		Inline1.Visible = Value
	end

	Section.Objects.ActualSection = ActualSection

	return setmetatable(Section, Library)
end

function Library:MultiSection(Props)
	local Props = {
		Tabs = Props.Tabs or {"Tab1", "Tab2", "Tab3"},
		Size = Props.Size or Vector2.new(0, 150),
		Side = Props.Side or "Left",
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Section = {
		Page = self,
		Objects = {},
		Tabs = {},
		ActualSections = {}
	}

	local Inline1 = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, Props.Size.Y),
		ZIndex = 16,
		Visible = Props.Visible,
		Parent = Section.Page.Objects[Props.Side]
	})

	local Inline1Stroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline1
	})

	local Inline1Accent = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 2),
		ZIndex = 17,
		Parent = Inline1
	})
	table.insert(Library.AccentObjects, Inline1Accent)

	local Inline1AccentStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Thickness = 1,
		Enabled = true,
		Parent = Inline1Accent
	})

	local Inline1AccentGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
		}),
		Rotation = 90,
		Parent = Inline1Accent
	})

	local Darker = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -5),
		Position = UDim2.fromOffset(1, 4),
		ZIndex = 17,
		Parent = Inline1
	})

	local GradientHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.fromOffset(0, 17),
		ZIndex = 18,
		Parent = Darker
	})

	local GradientHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 46, 46)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
		}),
		Rotation = 90,
		Parent = GradientHolder
	})

	local TabHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		Size = UDim2.new(1, 0, 0, 19),
		Position = UDim2.fromOffset(0, 2),
		ClipsDescendants = true,
		BorderSizePixel = 0,
		ZIndex = 18,
		Parent = Inline1
	})

	local TabHolderGradientFrame = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(31, 31, 31),
		Size = UDim2.new(1, 0, 1, -2),
		Position = UDim2.fromOffset(0, 1),
		BorderSizePixel = 0,
		ZIndex = 19,
		Parent = TabHolder
	})

	local TabHolderActualGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 90,
		Parent = TabHolderGradientFrame
	})

	local ActualTabHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -2),
		Position = UDim2.fromOffset(0, 1),
		BorderSizePixel = 0,
		ZIndex = 20,
		Parent = TabHolder
	})

	local ActualTabHolderList = Library:New("UIListLayout", {
		Name = "\0",
		FillDirection = "Horizontal",
		Parent = ActualTabHolder
	})

	local PageHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -23),
		Position = UDim2.fromOffset(0, 23),
		BorderSizePixel = 0,
		ZIndex = 20,
		Parent = Darker
	})

	local function CreateTab(Name)
		local ButtonHolder = Library:New("Frame", {
			Name = "\0",
			BackgroundColor3 = Color3.fromRGB(31, 31, 31),
			AutomaticSize = "X",
			Size = UDim2.new(0, 0, 1, 0),
			BorderSizePixel = 0,
			ZIndex = 21,
			Parent = ActualTabHolder
		})

		local ButtonHolderGradient = Library:New("UIGradient", {
			Name = "\0",
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
			}),
			Rotation = 270,
			Parent = ButtonHolder
		})

		local ButtonHolderStroke = Library:New("UIStroke", {
			Name = "\0",
			ApplyStrokeMode = "Border",
			Color = Color3.fromRGB(12, 12, 12),
			LineJoinMode = "Miter",
			Thickness = 1,
			Enabled = true,
			Parent = ButtonHolder
		})

		local ActualButton = Library:New("TextButton", {
			Name = "\0",
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			AutomaticSize = "X",
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			Text = Name or "None",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextStrokeTransparency = 0,
			Size = UDim2.new(1, 14, 0, 18),
			ZIndex = 22,
			Parent = ButtonHolder
		})

		local PageFrame = Library:New("Frame", {
			Name = "\0",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			BorderSizePixel = 0,
			ZIndex = 21,
			Visible = false,
			Parent = PageHolder
		})

		local ActualSection = Library:New("ScrollingFrame", {
			Name = "\0",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 22,
			ClipsDescendants = true,
			Visible = true,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			BottomImage = "rbxassetid://136016235498668",
			MidImage = "rbxassetid://136016235498668",
			TopImage = "rbxassetid://136016235498668",
			ScrollBarImageColor3 = Library.Accent,
			ScrollingEnabled = true,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
			VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
			BorderSizePixel = 0,
			ScrollBarThickness = 2,
			Parent = PageFrame
		})
		table.insert(Library.AccentObjects, ActualSection)

		local ActualSectionList = Library:New("UIListLayout", {
			Name = "\0",
			Padding = UDim.new(0, 4),
			Parent = ActualSection
		})

		local function SelectTab()
			for _, P in PageHolder:GetChildren() do
				if P:IsA("Frame") then
					P.Visible = false
				end
			end

			for _, B in ActualTabHolder:GetChildren() do
				if B:IsA("Frame") then
					B.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
					B.Size = UDim2.new(0, 0, 1, 0)
				end
			end

			PageFrame.Visible = true
			ButtonHolder.BackgroundColor3 = Color3.fromRGB(46, 46, 46) 
			ButtonHolder.Size = UDim2.new(0, 0, 1, 1)
		end

		ActualButton.MouseButton1Down:Connect(function()
			SelectTab()
		end)

		table.insert(Section.Tabs, ActualSection)
		if #Section.Tabs == 1 then
			SelectTab()
		end

		table.insert(Section.ActualSections, ActualSection)
	end

	for _, v in Props.Tabs do
		CreateTab(v)
	end

	return setmetatable(Section, Library)
end

function Library:Label(Props)
	local Props = {
		Name = Props.Name or "Missing Name!!",
		Section = Props.Section or nil,
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Label = {
		Section = self.Objects.ActualSection,
		Objects = {}
	}

	if Props.Section ~= nil then
		Label.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 10),
		ZIndex = 23,
		Parent = Label.Section
	})

	local TextLabel = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		Size = UDim2.new(1, -9, 1, 0),
		Position = UDim2.fromOffset(5, 0),
		ZIndex = 24,
		Parent = Frame
	})

	local TextLabelList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 2),
		FillDirection = "Horizontal",
		HorizontalAlignment = "Right",
		VerticalAlignment = "Center",
		Parent = TextLabel
	})

	function Label:SetVisibility(Value)
		Frame.Visible = Value
	end

	Label.Objects.Holder = TextLabel

	return setmetatable(Label, Library)
end

function Library:Toggle(Props)
	local Props = {
		Name = Props.Name or "Missing Name!!",
		Risk = Props.Risk ~= nil and Props.Risk or false,
		Section = Props.Section or nil,
		Callback = Props.Callback or nil,
		Visible = Props.Visible == nil and true or Props.Visible,
		State = Props.State ~= nil and Props.State or false,
		Flag = Props.Flag or math.random(5^10)
	}

	local Toggle = {
		Class = "Toggle",
		Section = self.Objects.ActualSection,
		Objects = {},
		State = nil
	}

	if Props.Section ~= nil then
		Toggle.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 11),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = Toggle.Section
	})

	local ImageLabel = Library:New("ImageLabel", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(9, 9),
		Position = UDim2.fromOffset(5, 1),
		Image = "99233836854062",
		ImageTransparency = 1,
		ZIndex = 24,
		Parent = Frame
	})
	table.insert(Library.AccentObjects, ImageLabel)

	local ImageLabelStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = ImageLabel
	})

	local ImageLabelGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
		}),
		Rotation = 90,
		Parent = ImageLabel
	})

	local TextLabel = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		TextColor3 = Props.Risk and Color3.fromRGB(242, 242, 2) or Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		Size = UDim2.new(1, -22, 0, 11),
		Position = UDim2.fromOffset(18, 1),
		ZIndex = 24,
		Parent = Frame
	})

	local Click = Library:New("ImageButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		ImageTransparency = 1,
		Size = UDim2.new(1, -8, 1, 0),
		Position = UDim2.fromOffset(4, 0),
		ZIndex = 25,
		Parent = Frame
	})

	local ClickList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 2),
		FillDirection = "Horizontal",
		HorizontalAlignment = "Right",
		VerticalAlignment = "Center",
		Parent = Click
	})

	function Toggle:SetVisibility(Value)
		Frame.Visible = Value
	end

	function Toggle:Set(Val)
		Toggle.State = Val

		Library.Flags[Props.Flag] = Val

		if Props.Callback ~= nil then
			Props.Callback(Val)
		end

		if Val then
			TweenService:Create(ImageLabel, TweenInfo.new(0.15), {BackgroundColor3 = Library.Accent}):Play()
		else
			TweenService:Create(ImageLabel, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(46, 46, 46)}):Play()
		end
	end

	Toggle:Set(Props.State)

	Click.MouseButton1Down:Connect(function()
		Toggle:Set(not Toggle.State)
	end)

	Toggle.Objects.Holder = Click

	Library.Config[Props.Flag] = Toggle
	return setmetatable(Toggle, Library)
end

function Library:Textbox(Props)
	local Props = {
		Name = Props.Name or "Missing Name!!",
		Text = Props.Text or "",
		Placeholder = Props.Placeholder or "",
		Section = Props.Section or nil,
		Nameless = Props.Nameless ~= nil and Props.Nameless or false,
		Callback = Props.Callback or nil,
		Flag = Props.Flag or tostring(math.random(5^10)),
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Textbox = {
		Class = "Textbox",
		Section = self.Objects.ActualSection,
		Objects = {}
	}

	if Props.Section ~= nil then
		Textbox.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = Props.Nameless and UDim2.new(1, 0, 0, 18) or UDim2.new(1, 0, 0, 30),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = Textbox.Section
	})

	if not Props.Nameless then
		local NameLabel = Library:New("TextLabel", {
			Name = "\0",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			Text = Props.Name,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			Size = UDim2.new(1, -10, 0, 10),
			Position = UDim2.fromOffset(5, 0),
			ZIndex = 24,
			Parent = Frame
		})
	end

	local Inline = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -10, 0, 16),
		Position = Props.Nameless and UDim2.fromOffset(5, 1) or UDim2.fromOffset(5, 13),
		ZIndex = 24,
		Parent = Frame
	})

	local InlineStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline
	})

	local TextboxHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 25,
		Parent = Inline
	})

	local TextboxHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 270,
		Parent = TextboxHolder
	})

	local ActualTextbox = Library:New("TextBox", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		PlaceholderText = Props.Placeholder,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		ClearTextOnFocus = false,
		TextWrapped = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		ZIndex = 26,
		Parent = TextboxHolder
	})

	ActualTextbox:GetPropertyChangedSignal("Text"):Connect(function()
		Library.Flags[Props.Flag] = ActualTextbox.Text

		if Props.Callback ~= nil then
			Props.Callback(ActualTextbox.Text)
		end
	end)

	function Textbox:SetVisibility(Val)
		Frame.Visible = Val
	end

	function Textbox:Set(Val)
		ActualTextbox.Text = tostring(Val)
	end

	Textbox:Set(Props.Text)

	Library.Config[Props.Flag] = Textbox
	return setmetatable(Textbox, Library)
end

function Library:Button(Props)
	local Props = {
		Name = Props.Name or "Missing Name!!",
		Section = Props.Section or nil,
		Callback = Props.Callback or nil,
		Visible = Props.Visible == nil and true or Props.Visible,
		Confirm = Props.Confirm ~= nil and Props.Confirm or false
	}

	local Button = {
		Section = self.Objects.ActualSection,
		Objects = {}
	}

	if Props.Section ~= nil then
		Button.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 18),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = Button.Section
	})


	local Inline = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -10, 0, 16),
		Position = UDim2.fromOffset(5, 1),
		ZIndex = 24,
		Parent = Frame
	})

	local InlineStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline
	})

	local ButtonHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 25,
		Parent = Inline
	})

	local ButtonHolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 270,
		Parent = ButtonHolder
	})

	local ActualButton = Library:New("TextButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		AutoButtonColor = false,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextWrapped = true,
		ZIndex = 26,
		Parent = ButtonHolder
	})

	local LastPress = 0
	ActualButton.MouseButton1Down:Connect(function()
		local TweenTime = 0.15
		if Props.Callback ~= nil then
			local Time = tick()

			if Props.Confirm then
				ActualButton.Text = "Confirm?"

				local TweenConfirm = TweenService:Create(ActualButton, TweenInfo.new(TweenTime), {TextColor3 = Library.Accent})
				TweenConfirm:Play()

				if Time - LastPress <= 3 then
					Props.Callback()
					LastPress = 0

					local TweenReset = TweenService:Create(ActualButton, TweenInfo.new(TweenTime), {TextColor3 = Color3.fromRGB(255, 255, 255)})
					TweenReset:Play()
					ActualButton.Text = Props.Name

					return
				end

				task.delay(3, function()
					if tick() - LastPress >= 3 then
						local TweenTimeout = TweenService:Create(ActualButton, TweenInfo.new(TweenTime), {TextColor3 = Color3.fromRGB(255, 255, 255)})
						TweenTimeout:Play()
						TweenTimeout.Completed:Connect(function()
							ActualButton.Text = Props.Name
						end)
					end
				end)
			else
				Props.Callback()

				local Tween = TweenService:Create(ActualButton, TweenInfo.new(TweenTime), {TextColor3 = Library.Accent})
				Tween:Play()
				Tween.Completed:Connect(function()
					TweenService:Create(ActualButton, TweenInfo.new(TweenTime), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end)
			end

			LastPress = Time
		end
	end)

	function Button:SetVisibility(Val)
		Frame.Visible = Val
	end

	return setmetatable(Button, Library)
end

function Library:Slider(Props)
	local Props = {
		Name = Props.Name,
		Section = Props.Section or nil,
		Value = Props.Value or 1,
		Min = Props.Min or -10,
		Max = Props.Max or 10,
		Float = Props.Float or 0.1,
		Suffix = Props.Suffix or "",
		Flag = Props.Flag or tostring(math.random(5^10)),
		Callback = Props.Callback or nil,
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Slider = {
		Class = "Slider",
		Value = Props.Value,
		Dragging = false,
		Section = self.Objects.ActualSection,
		Objects = {}
	}

	if Props.Section ~= nil then
		Slider.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 23),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = Slider.Section
	})

	local NameLabel = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		Size = UDim2.new(1, -9, 0, 10),
		Position = UDim2.fromOffset(5, 0),
		ZIndex = 24,
		Parent = Frame
	})

	local NameLabelList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 3),
		FillDirection = "Horizontal",
		HorizontalAlignment = "Right",
		VerticalAlignment = "Center",
		Parent = NameLabel
	})

	local MinusButton = Library:New("ImageButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(10, 10),
		AutoButtonColor = false,
		Image = "rbxassetid://82248022060766",
		ZIndex = 25,
		Parent = NameLabel
	})

	local PlusButton = Library:New("ImageButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(10, 10),
		AutoButtonColor = false,
		Image = "rbxassetid://128727528618379",
		ZIndex = 25,
		Parent = NameLabel
	})

	local Holder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -8, 0, 11),
		Position = UDim2.new(0, 4, 1, -11),
		ZIndex = 24,
		Parent = Frame
	})

	local Click = Library:New("ImageButton", {
		Name = "\0",
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		ImageTransparency = 1,
		ZIndex = 30,
		Parent = Holder
	})

	local ValueLabel = Library:New("TextLabel", {
		Name = "\0",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "10%",
		FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Medium),
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextWrapped = true,
		ZIndex = 29,
		Parent = Holder
	})

	local BarHolder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 25,
		Parent = Holder
	})

	local BarValue = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Library.Accent,
		BorderSizePixel = 0,
		Size = UDim2.new(0.1, 0, 1, 0),
		ZIndex = 26,
		Parent = BarHolder
	})
	table.insert(Library.AccentObjects, BarValue)

	local BarValueGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
		}),
		Rotation = 90,
		Parent = BarValue
	})

	function Slider:SetVisibility(Val)
		Frame.Visible = Val
	end

	function Slider:Set(Val)
		local Value = math.clamp(Library:Round(Val, Props.Float), Props.Min, Props.Max)
		Slider.Value = Value

		Library.Flags[Props.Flag] = Value

		if Props.Callback ~= nil then
			Props.Callback(Value)
		end

		ValueLabel.Text = Value .. Props.Suffix

		TweenService:Create(BarValue, TweenInfo.new(0.15), {Size = UDim2.new((Value - Props.Min) / (Props.Max - Props.Min), 0, 1, 0)}):Play()

		--BarValue.Size = UDim2.new((Value - Props.Min) / (Props.Max - Props.Min), 0, 1, 0)
	end

	MinusButton.MouseButton1Down:Connect(function()
		Slider:Set(Slider.Value - Props.Float)

		local Tween = TweenService:Create(MinusButton, TweenInfo.new(0.15), {ImageColor3 = Library.Accent})
		Tween:Play()
		Tween.Completed:Connect(function()
			TweenService:Create(MinusButton, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end)
	end)

	PlusButton.MouseButton1Down:Connect(function()
		Slider:Set(Slider.Value + Props.Float)

		local Tween = TweenService:Create(PlusButton, TweenInfo.new(0.15), {ImageColor3 = Library.Accent})
		Tween:Play()
		Tween.Completed:Connect(function()
			TweenService:Create(PlusButton, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end)
	end)

	Click.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Slider.Sliding = true
			local Size = (input.Position.X - Click.AbsolutePosition.X) / Click.AbsoluteSize.X
			local Val = ((Props.Max - Props.Min) * Size) + Props.Min
			Slider:Set(Val)
		end
	end)

	Click.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Slider.Sliding = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and Slider.Sliding then
			local Size = (input.Position.X - Click.AbsolutePosition.X) / Click.AbsoluteSize.X
			local Val = ((Props.Max - Props.Min) * Size) + Props.Min
			Slider:Set(Val)
		end
	end)

	Slider:Set(Props.Value)

	Library.Config[Props.Flag] = Slider
	return setmetatable(Slider, Library)
end

function Library:Dropdown(Props)
	local Images = {
		Dropdown = {
			Opened = "rbxassetid://130984052732287",
			Closed = "rbxassetid://138131288578341"
		},
		MultiDropdown = {
			Opened = "rbxassetid://130984052732287",
			Closed = "rbxassetid://109453780595969"
		}
	}

	local Props = {
		Name = Props.Name or "Missing Name!!",
		Section = Props.Section or nil,
		Items = Props.Items or {},
		Multi = Props.Multi or false,
		Value = Props.Value or "...",
		Callback = Props.Callback or nil,
		Flag = Props.Flag or tostring(math.random(5^10)),
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local Dropdown = {
		Class = "Dropdown",
		Section = self.Objects.ActualSection,
		Selected = nil,
		Selections = {},
		Objects = {}
	}

	if Props.Section ~= nil then
		Dropdown.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 30),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = Dropdown.Section
	})

	local NameLabel = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		Text = Props.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextXAlignment = "Left",
		Size = UDim2.new(1, -10, 0, 10),
		Position = UDim2.fromOffset(5, 0),
		ZIndex = 24,
		Parent = Frame
	})

	local Inline = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -10, 0, 16),
		Position = UDim2.fromOffset(5, 13),
		ZIndex = 24,
		Parent = Frame
	})

	local InlineStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline
	})

	local Holder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 25,
		Parent = Inline
	})

	local HolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 270,
		Parent = Holder
	})

	local DropdownValues = Library:New("TextLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "...",
		Size = UDim2.new(1, -3, 1, 0),
		Position = UDim2.fromOffset(3, 0),
		ZIndex = 26,
		FontFace = Library.Font,
		TextSize = Library.FontSize,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		TextWrapped = true,
		TextXAlignment = "Left",
		Parent = Holder
	})

	local DropdownIcon = Library:New("ImageLabel", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 10, 0, 10),
		ImageTransparency = 0,
		Image = Props.Multi and Images.MultiDropdown.Closed or Images.Dropdown.Closed,
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		Position = UDim2.new(1, -12, 0.5, -5),
		ZIndex = 26,
		Parent = Holder
	})

	local DropdownButton = Library:New("ImageButton", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ImageTransparency = 1,
		Image = "",
		ZIndex = 27,
		Parent = Holder
	})

	function Dropdown:SetVisibility(Val)
		Frame.Visible = Val
	end

	function Dropdown:Set(Val) -- Table/String
		if Props.Multi then
			if tostring(type(Val)) == "table" then
				Dropdown.Selections = Val

				if #Dropdown.Selections > 0 then
					local order = {}
					for i, v in Props.Items do
						order[v] = i
					end

					table.sort(Dropdown.Selections, function(a, b)
						return order[a] < order[b]
					end)

					DropdownValues.Text = table.concat(Dropdown.Selections, ", ")
				else
					DropdownValues.Text = "..."
				end

				Library.Flags[Props.Flag] = Dropdown.Selections

				if Props.Callback ~= nil then
					Props.Callback(Dropdown.Selections)
				end
			else
				local Exists = nil
				for i, v in Dropdown.Selections do
					if v == Val then
						Exists = i
						break
					end
				end

				if Exists then
					table.remove(Dropdown.Selections, Exists)
				else
					table.insert(Dropdown.Selections, Val)
				end

				if #Dropdown.Selections > 0 then
					local order = {}
					for i, v in Props.Items do
						order[v] = i
					end

					table.sort(Dropdown.Selections, function(a, b)
						return order[a] < order[b]
					end)

					DropdownValues.Text = table.concat(Dropdown.Selections, ", ")
				else
					DropdownValues.Text = "..."
				end

				Library.Flags[Props.Flag] = Dropdown.Selections

				if Props.Callback ~= nil then
					Props.Callback(Dropdown.Selections)
				end
			end
		else
			Dropdown.Selected = Val

			Library.Flags[Props.Flag] = Val

			if Props.Callback ~= nil then
				Props.Callback(Val)
			end

			DropdownValues.Text = Val
		end
	end

	local DroppedFrame = nil
	local CloseConnection = nil
	DropdownButton.MouseButton1Down:Connect(function()
		if DroppedFrame == nil then
			DroppedFrame = Library:New("ImageButton", {
				Name = "\0",
				Image = "",
				ImageTransparency = 1,
				AutoButtonColor = false,
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BorderSizePixel = 0,
				Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, 0),
				Position = UDim2.new(0, Inline.AbsolutePosition.X, 0, Inline.AbsolutePosition.Y + 56),
				ZIndex = 50,
				Parent = Library.ScreenGui
			})

			local InlineStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Parent = DroppedFrame
			})

			local Holder = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				Size = UDim2.new(1, -2, 1, -2),
				Position = UDim2.new(0, 1, 0, 1),
				ZIndex = 52,
				Parent = DroppedFrame
			})

			local HolderGradient = Library:New("UIGradient", {
				Name = "\0",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
				}),
				Rotation = 90,
				Parent = Holder
			})

			local ActualDropdown = Library:New("ScrollingFrame", {
				Name = "\0",
				Size = UDim2.new(1, 0, 1, -2),
				Position = UDim2.new(0, 0, 0, 2),
				BackgroundTransparency = 1,
				ZIndex = 53,
				ClipsDescendants = true,
				Visible = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = UDim2.new(0, 0, 0, 0),
				BottomImage = "rbxassetid://136016235498668",
				MidImage = "rbxassetid://136016235498668",
				TopImage = "rbxassetid://136016235498668",
				ScrollBarImageColor3 = Library.Accent,
				ScrollBarImageTransparency = 1,
				ScrollingEnabled = true,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				VerticalScrollBarInset = "None",
				VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
				BorderSizePixel = 0,
				ScrollBarThickness = 2,
				Parent = Holder
			})
			table.insert(Library.AccentObjects, ActualDropdown)

			local Tween = TweenService:Create(DroppedFrame, TweenInfo.new(0.15, Enum.EasingStyle.Circular), {Size = UDim2.new(0, Inline.AbsoluteSize.X, 0, 100)})
			Tween:Play()
			Tween.Completed:Connect(function()
				ActualDropdown.ScrollBarImageTransparency = 0
				ActualDropdown.VerticalScrollBarInset = "ScrollBar"
			end)

			local ActualDropdownList = Library:New("UIListLayout", {
				Name = "\0",
				Padding = UDim.new(0, 4),
				FillDirection = "Vertical",
				HorizontalAlignment = "Left",
				VerticalAlignment = "Top",
				Parent = ActualDropdown
			})

			DropdownIcon.Image = Props.Multi and Images.MultiDropdown.Opened or Images.Dropdown.Opened

			for _, v in Props.Items do
				local Button = Library:New("TextButton", {
					Name = "\0",
					Text = tostring(v),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					TextColor3 = string.find(string.lower(DropdownValues.Text), string.lower(v)) and Library.Accent or Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(1, 0, 0, 10),
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = "Left",
					ZIndex = 54,
					Parent = ActualDropdown
				})

				local ButtonPadding = Library:New("UIPadding", {
					Name = "\0",
					PaddingLeft = UDim.new(0, 2),
					Parent = Button
				})

				Button.MouseButton1Down:Connect(function()
					if Props.Multi then
						if Button.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
							Button.TextColor3 = Color3.fromRGB(255, 255, 255)
						else
							Button.TextColor3 = Library.Accent
						end
					else
						for _, b in ActualDropdown:GetChildren() do
							if b:IsA("TextButton") then
								if b == Button then
									b.TextColor3 = Library.Accent
								else
									b.TextColor3 = Color3.fromRGB(255, 255, 255)
								end
							end
						end
					end

					Dropdown:Set(v)
				end)
			end

			task.wait()
			CloseConnection = UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local InputPos = input.Position
					local AbsPos = DroppedFrame.AbsolutePosition
					local AbsSize = Vector2.new(DroppedFrame.AbsoluteSize.X - 1, DroppedFrame.AbsoluteSize.Y - 1)

					if not (InputPos.X >= AbsPos.X and InputPos.X <= AbsPos.X + AbsSize.X and InputPos.Y >= AbsPos.Y and InputPos.Y <= AbsPos.Y + AbsSize.Y) then
						DroppedFrame:Destroy()
						DroppedFrame = nil

						if CloseConnection then
							CloseConnection:Disconnect()
							CloseConnection = nil
						end

						DropdownIcon.Image = Props.Multi and Images.MultiDropdown.Closed or Images.Dropdown.Closed
					end
				end
			end)
		else
			DroppedFrame:Destroy()
			DroppedFrame = nil

			if CloseConnection then
				CloseConnection:Disconnect()
			end

			DropdownIcon.Image = Props.Multi and Images.MultiDropdown.Closed or Images.Dropdown.Closed
		end
	end)

	if Props.Multi then
		Dropdown:Set(Props.Value)
	else
		Dropdown:Set(Props.Value)
	end


	Library.Config[Props.Flag] = Dropdown
	return setmetatable(Dropdown, Library)
end

function Library:List(Props)
	local Props = {
		Name = Props.Name or "Missing Name!!",
		Items = Props.Items or {},
		Value = Props.Value or "...",
		Size = Props.Size or Vector2.new(0, 100),
		Callback = Props.Callback or nil,
		Flag = Props.Flag or tostring(math.random(5^10)),
		Nameless = Props.Nameless ~= nil and Props.Nameless or false,
		Visible = Props.Visible == nil and true or Props.Visible
	}

	local List = {
		Class = "List",
		Section = self.Objects.ActualSection,
		Objects = {}
	}

	if Props.Section ~= nil then
		List.Section = self.ActualSections[Props.Section]
	end

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = Props.Nameless and UDim2.new(1, 0, 0, Props.Size.Y + 2) or UDim2.new(1, 0, 0, Props.Size.Y + 14),
		ZIndex = 23,
		Visible = Props.Visible,
		Parent = List.Section
	})

	if not Props.Nameless then
		local NameLabel = Library:New("TextLabel", {
			Name = "\0",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			Text = Props.Name,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			Size = UDim2.new(1, -10, 0, 10),
			Position = UDim2.fromOffset(5, 0),
			ZIndex = 24,
			Parent = Frame
		})
	end

	local Inline = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -10, 0, Props.Size.Y),
		Position = Props.Nameless and UDim2.fromOffset(5, 1) or UDim2.fromOffset(5, 13),
		ZIndex = 24,
		Parent = Frame
	})

	local InlineStroke = Library:New("UIStroke", {
		Name = "\0",
		ApplyStrokeMode = "Border",
		Color = Color3.fromRGB(12, 12, 12),
		LineJoinMode = "Miter",
		Parent = Inline
	})

	local Holder = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 25,
		Parent = Inline
	})

	local HolderGradient = Library:New("UIGradient", {
		Name = "\0",
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
		}),
		Rotation = 270,
		Parent = Holder
	})

	local ActualList = Library:New("ScrollingFrame", {
		Name = "\0",
		Size = UDim2.new(1, -4, 1, -4),
		Position = UDim2.new(0, 2, 0, 2),
		BackgroundTransparency = 1,
		ZIndex = 26,
		ClipsDescendants = true,
		Visible = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		BottomImage = "rbxassetid://136016235498668",
		MidImage = "rbxassetid://136016235498668",
		TopImage = "rbxassetid://136016235498668",
		ScrollBarImageColor3 = Library.Accent,
		ScrollingEnabled = true,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
		BorderSizePixel = 0,
		ScrollBarThickness = 2,
		Parent = Holder
	})
	table.insert(Library.AccentObjects, ActualList)

	local ActualListList = Library:New("UIListLayout", {
		Name = "\0",
		Padding = UDim.new(0, 4),
		FillDirection = "Vertical",
		HorizontalAlignment = "Left",
		VerticalAlignment = "Top",
		Parent = ActualList
	})

	function List:Set(Value)		
		Library.Flags[Props.Flag] = Value
		if Props.Callback ~= nil then
			Props.Callback(Value)
		end

		for _, v in ActualList:GetChildren() do
			if v:IsA("TextButton") then
				if v.Text == Value then
					v.TextColor3 = Library.Accent
				else
					v.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
		end
	end

	local function CreateButton(Name)
		local Button = Library:New("TextButton", {
			Name = "\0",
			Text = Name or "Missing Name!!",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			TextWrapped = true,
			FontFace = Library.Font,
			TextSize = Library.FontSize,
			Size = UDim2.new(1, 0, 0, 10),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextStrokeTransparency = 0,
			TextXAlignment = "Left",
			TextScaled = false,
			ZIndex = 27,
			Parent = ActualList
		})

		Button.MouseButton1Down:Connect(function()
			List:Set(Name)
		end)
	end

	function List:SetTable(Table)
		List:Set("...")

		for _, v in ActualList:GetChildren() do
			if v:IsA("TextButton") then
				v:Destroy()
			end
		end

		for _, v in Table do
			CreateButton(v)
		end
	end

	function List:SetVisibility(Val)
		Frame.Visible = Val
	end

	List.Objects.ActualList = ActualList

	List:SetTable(Props.Items)
	List:Set(Props.Value)

	Library.Config[Props.Flag] = List
	return setmetatable(List, Library)
end

function Library:Colorpicker(Props)
	local Props = {
		Color = Props.Color or Library.Accent,
		Transparency = Props.Transparency or 0,
		Flag = Props.Flag or math.random(5^10),
		Callback = Props.Callback or nil
	}

	local Colorpicker = {
		Class = "Colorpicker",
		SlidingSaturation = false,
		SlidingHue = false,
		SlidingTransparency = false,
		HuePosition = nil,
		Color = nil,
		Transparency = nil,
		Parent = self.Objects.Holder,
		Objects = {}
	}

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 24, 0, 11),
		ZIndex = 26,
		Parent = Colorpicker.Parent
	})

	local Holder = Library:New("Frame", {
		Name = "\0",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -2, 1, -2),
		Position = UDim2.fromOffset(1, 1),
		ZIndex = 27,
		Parent = Frame
	})

	local Checkered = Library:New("ImageLabel", {
		Name = "\0",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 28,
		Image = "rbxassetid://18274452449",
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ScaleType = "Tile",
		TileSize = UDim2.new(0, 6, 0, 6),
		Parent = Holder
	})

	local ColorButton = Library:New("ImageButton", {
		Name = "\0",
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 0, 0),
		AutoButtonColor = false,
		ZIndex = 29,
		Image = "rbxassetid://86594667755676",
		Parent = Holder
	})

	local Hue, Sat, Val = nil, nil, nil
	local ColorpickerOpen = nil

	function Colorpicker:Set(Color, Transparency)
		local color = Color or Color3.fromRGB(255, 255, 255)
		local transparency = Transparency or 0

		if type(color) == "table" then
			transparency = color.a
			color = color.c
		end

		Colorpicker.Color = color
		Colorpicker.Transparency = transparency

		Hue, Sat, Val = color:ToHSV()

		ColorButton.BackgroundColor3 = color
		ColorButton.BackgroundTransparency = transparency
		--ColorButton.ImageTransparency = transparency

		Library.Flags[Props.Flag] = {
			c = color,
			a = transparency
		}

		if Props.Callback ~= nil then
			Props.Callback({c = color, a = transparency})
		end
	end

	local CloseConnection = nil
	ColorButton.MouseButton1Down:Connect(function()
		if ColorpickerOpen == nil then
			ColorpickerOpen = Library:New("ImageButton", {
				Name = "\0",
				Size = UDim2.new(0, 185, 0, 168),
				Position = UDim2.fromOffset(ColorButton.AbsolutePosition.X + 26, ColorButton.AbsolutePosition.Y + 37),
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BorderSizePixel = 0,
				Image = "",
				ImageTransparency = 1,
				AutoButtonColor = false,
				ZIndex = 50,
				Parent = Library.ScreenGui
			})

			local ColorpickerOpenStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Parent = ColorpickerOpen
			})

			local ColorpickerOpenAccent = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Library.Accent,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 2),
				ZIndex = 51,
				Parent = ColorpickerOpen
			})

			local ColorpickerOpenAccentStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = ColorpickerOpenAccent
			})

			local ColorpickerOpenAccentGradient = Library:New("UIGradient", {
				Name = "\0",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
				}),
				Rotation = 90,
				Parent = ColorpickerOpenAccent
			})

			local BackgroundFrame = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -2, 1, -5),
				Position = UDim2.fromOffset(1, 4),
				ZIndex = 52,
				Parent = ColorpickerOpen
			})

			local BackgroundFrameGradient = Library:New("UIGradient", {
				Name = "\0",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
				}),
				Rotation = 90,
				Parent = BackgroundFrame
			})

			local AlphaHolder = Library:New("ImageLabel", {
				Name = "\0",
				Image = "rbxassetid://18274452449",
				ScaleType = "Tile",
				TileSize = UDim2.fromOffset(6, 6),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(164, 3),
				Size = UDim2.fromOffset(16, 137),
				ZIndex = 53,
				Parent = BackgroundFrame
			})

			local AlphaHolderStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = AlphaHolder
			})

			local AlphaTransparency = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 54,
				Parent = AlphaHolder
			}) 

			local AlphaGradient = Library:New("UIGradient", {
				Name = "\0",
				Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
				Rotation = 90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 1)
				}),
				Parent = AlphaTransparency
			})

			local AlphaSlider = Library:New("Frame", {
				Name = "\0",
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 54,
				Parent = AlphaHolder
			})

			local AlphaSliderStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = AlphaSlider
			})

			local AlphaClick = Library:New("ImageButton", {
				Name = "\0",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "",
				ImageTransparency = 1,
				AutoButtonColor = false,
				ZIndex = 55,
				Parent = AlphaHolder
			})

			local HueHolder = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Size = UDim2.fromOffset(16, 137),
				Position = UDim2.fromOffset(144, 3),
				ZIndex = 53,
				Parent = BackgroundFrame
			})

			local HueHolderStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = HueHolder
			})

			local HueGradient = Library:New("UIGradient", {
				Name = "\0",
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
					ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
					ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
					ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
				}),
				Parent = HueHolder
			})

			local HueSlider = Library:New("Frame", {
				Name = "\0",
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 54,
				Parent = HueHolder
			})

			local HueSliderStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = HueSlider
			})

			local HueClick = Library:New("ImageButton", {
				Name = "\0",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "",
				ImageTransparency = 1,
				AutoButtonColor = false,
				ZIndex = 54,
				Parent = HueHolder
			})

			local ActualPicker = Library:New("ImageLabel", {
				Name = "\0",
				BorderSizePixel = 0,
				Image = "rbxassetid://72529003716639",
				ImageColor3 = Color3.fromRGB(255, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.fromOffset(137, 137),
				Position = UDim2.fromOffset(3, 3),
				ZIndex = 53,
				Parent = BackgroundFrame
			})

			local ActualPickerStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = ActualPicker
			})

			local ActualPickerSlider = Library:New("Frame", {
				Name = "\0",
				BorderSizePixel = 0,
				Size = UDim2.new(0, 2, 0, 2),
				Position = UDim2.new(1, -2),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				ZIndex = 54,
				Parent = ActualPicker
			})

			local ActualPickerSliderStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Thickness = 1,
				Enabled = true,
				Parent = ActualPickerSlider
			})

			local ActualPickerClick = Library:New("ImageButton", {
				Name = "\0",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Image = "",
				ImageTransparency = 1,
				AutoButtonColor = false,
				ZIndex = 55,
				Parent = ActualPicker
			})

			local TextboxInline = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -6, 0, 16),
				Position = UDim2.fromOffset(3, 144),
				ZIndex = 53,
				Parent = BackgroundFrame
			})

			local TextboxInlineStroke = Library:New("UIStroke", {
				Name = "\0",
				ApplyStrokeMode = "Border",
				Color = Color3.fromRGB(12, 12, 12),
				LineJoinMode = "Miter",
				Parent = TextboxInline
			})

			local TextboxHolder = Library:New("Frame", {
				Name = "\0",
				BackgroundColor3 = Color3.fromRGB(46, 46, 46),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -2, 1, -2),
				Position = UDim2.fromOffset(1, 1),
				ZIndex = 54,
				Parent = TextboxInline
			})

			local TextboxHolderGradient = Library:New("UIGradient", {
				Name = "\0",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
				}),
				Rotation = 270,
				Parent = TextboxHolder
			})

			local ActualTextbox = Library:New("TextBox", {
				Name = "\0",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Text = "",
				PlaceholderText = "(RGB) or (0 - 1)",
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				ClearTextOnFocus = false,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0,
				ZIndex = 55,
				Parent = TextboxHolder
			})

			if Hue and Sat and Val then
				Colorpicker.HuePosition = Hue

				HueSlider.Position = UDim2.new(0, 0, 1 - Hue, Hue < 1 and -1 or 0)
				ActualPicker.ImageColor3 = Color3.fromHSV(Hue, 1, 1)
				AlphaTransparency.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Val)
				ActualPickerSlider.Position = UDim2.new(Sat, Sat >= 0.95 and -2 or 0, 1 - Val, Val <= 0.05 and -2 or 0)
			end

			if Colorpicker.Transparency ~= nil then
				AlphaSlider.Position = UDim2.new(0, 0, Colorpicker.Transparency, Colorpicker.Transparency == 1 and -1 or 0)
			end

			local function PickerSet(pos)
				local PickerPos = ActualPicker.AbsolutePosition
				local PickerSize = ActualPicker.AbsoluteSize
				local SizeX = math.clamp((pos.X - PickerPos.X) / PickerSize.X, 0, 1)
				local SizeY = 1 - math.clamp((pos.Y - PickerPos.Y) / PickerSize.Y, 0, 1)

				TweenService:Create(ActualPickerSlider, TweenInfo.new(0.15), {
					Position = UDim2.new(SizeX, SizeX >= 0.95 and -2 or 0, 1 - SizeY, SizeY <= 0.05 and -2 or 0)
				}):Play()

				local Color = Color3.fromHSV(Colorpicker.HuePosition, SizeX, SizeY)
				ActualPicker.ImageColor3 = Color3.fromHSV(Colorpicker.HuePosition, 1, 1)
				AlphaTransparency.BackgroundColor3 = Color
				Colorpicker:Set(Color, Colorpicker.Transparency)
			end

			local function HueSet(pos)
				local HuePos = HueHolder.AbsolutePosition
				local HueSize = HueHolder.AbsoluteSize
				local SizeY = 1 - math.clamp((pos.Y - HuePos.Y) / HueSize.Y, 0, 1)

				TweenService:Create(HueSlider, TweenInfo.new(0.15), {
					Position = UDim2.new(0, 0, 1 - SizeY, SizeY < 1 and -1 or 0)
				}):Play()

				Colorpicker.HuePosition = SizeY
				local Color = Color3.fromHSV(SizeY, Sat, Val)
				ActualPicker.ImageColor3 = Color3.fromHSV(SizeY, 1, 1)
				AlphaTransparency.BackgroundColor3 = Color
				Colorpicker:Set(Color, Colorpicker.Transparency)
			end

			local function AlphaSet(pos)
				local AlphaPos = AlphaHolder.AbsolutePosition
				local AlphaSize = AlphaHolder.AbsoluteSize
				local SizeY = math.clamp((pos.Y - AlphaPos.Y) / AlphaSize.Y, 0, 1)

				TweenService:Create(AlphaSlider, TweenInfo.new(0.15), {
					Position = UDim2.new(0, 0, SizeY, SizeY == 1 and -1 or 0)
				}):Play()

				Colorpicker:Set(Color3.fromHSV(Colorpicker.HuePosition, Sat, Val), SizeY)
			end

			local Connections = {}

			local MouseOffset = Vector2.new(0, 38)

			Connections.A = ActualPickerClick.MouseButton1Down:Connect(function()
				Colorpicker.SlidingSaturation = true
				PickerSet(UserInputService:GetMouseLocation() - MouseOffset)
			end)

			Connections.B = HueClick.MouseButton1Down:Connect(function()
				Colorpicker.SlidingHue = true
				HueSet(UserInputService:GetMouseLocation() - MouseOffset)
			end)

			Connections.C = AlphaClick.MouseButton1Down:Connect(function()
				Colorpicker.SlidingAlpha = true
				AlphaSet(UserInputService:GetMouseLocation() - MouseOffset)
			end)

			Connections.D = UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Colorpicker.SlidingSaturation, Colorpicker.SlidingHue, Colorpicker.SlidingAlpha = false, false, false
				end
			end)

			Connections.E = UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					local mouseLocation = UserInputService:GetMouseLocation() - MouseOffset
					if Colorpicker.SlidingSaturation then
						PickerSet(mouseLocation)
					elseif Colorpicker.SlidingHue then
						HueSet(mouseLocation)
					elseif Colorpicker.SlidingAlpha then
						AlphaSet(mouseLocation)
					end
				end
			end)

			Connections.F = ActualTextbox.FocusLost:Connect(function(EnterPressed)
				local String = ActualTextbox.Text

				if EnterPressed then
					local R, G, B = String:match("(%d+),%s*(%d+),%s*(%d+)")
					if R and G and B then
						R, G, B = tonumber(R), tonumber(G), tonumber(B)
						Colorpicker:Set(Color3.fromRGB(R, G, B), Colorpicker.Transparency)

						Colorpicker.HuePosition = Hue

						HueSlider.Position = UDim2.new(0, 0, 1 - Hue, Hue < 1 and -1 or 0)
						ActualPicker.ImageColor3 = Color3.fromHSV(Hue, 1, 1)
						AlphaTransparency.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
						ActualPickerSlider.Position = UDim2.new(Sat, Sat >= 0.95 and -2 or 0, 1 - Val, Val <= 0.05 and -2 or 0)
					else
						local Numberized = tonumber(String)
						if Numberized and Numberized <= 1 and Numberized >= 0 then
							AlphaSlider.Position = UDim2.new(0, 0, Numberized, Numberized == 1 and -1 or 0)
							Colorpicker:Set(Color3.fromHSV(Colorpicker.HuePosition, Sat, Val), Numberized)
						end
					end
				end
			end)

			task.wait()
			CloseConnection = UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local InputPos = input.Position
					local AbsPos = ColorpickerOpen.AbsolutePosition
					local AbsSize = ColorpickerOpen.AbsoluteSize

					if not (InputPos.X >= AbsPos.X and InputPos.X <= AbsPos.X + AbsSize.X and InputPos.Y >= AbsPos.Y and InputPos.Y <= AbsPos.Y + AbsSize.Y) then
						ColorpickerOpen:Destroy()
						ColorpickerOpen = nil

						if CloseConnection then
							CloseConnection:Disconnect()
							CloseConnection = nil
						end

						for _, Con in Connections do
							Con:Disconnect()
							Con = nil
						end
					end
				end
			end)
		end
	end)

	Colorpicker:Set(Props.Color, Props.Transparency)

	Library.Config[Props.Flag] = Colorpicker
	return setmetatable(Colorpicker, Library)
end

function Library:Keybind(Props)
	local Props = {
		Mode = Props.Mode or "Toggle",
		Key = Props.Key or "?",
		Flag = Props.Flag or math.random(5^10),
		Callback = Props.Callback or nil
	}

	local Keybind = {
		Class = "Keybind",
		Mode = "",
		Key = "",
		Value = false,
		Parent = self.Objects.Holder,
		Listening = false,
		Objects = {}
	}

	local Frame = Library:New("Frame", {
		Name = "\0",
		BackgroundColor3 = Color3.fromRGB(12, 12, 12),
		BorderSizePixel = 0,
		AutomaticSize = "X",
		Size = UDim2.new(0, 16, 0, 11),
		ZIndex = 26,
		Parent = Keybind.Parent
	})

	--FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Medium),
	--TextSize = 12,

	local ActualButton = Library:New("TextButton", {
		Name = "\0",
		Text = "?",
		Size = UDim2.new(1, 4, 1, 0),
		Position = UDim2.fromOffset(0, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Medium),
		TextSize = 12,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextStrokeTransparency = 0,
		AutomaticSize = "X",
		ZIndex = 27,
		Parent = Frame
	})

	function Keybind:Set(Val)
		if type(Val) == "boolean" then
			local TempVal = Val
			if Keybind.Mode == "Always" then
				TempVal = true
			end

			Keybind.Value = TempVal
		elseif type(Val) == "string" and string.find(Val, "?") then
			Keybind.Key = "?"
		elseif type(Val) == "userdata" then
			if Val.UserInputType == Enum.UserInputType.Keyboard then
				Keybind.Key = Val.KeyCode
			elseif Val.UserInputType == Enum.UserInputType.MouseButton1 or Val.UserInputType == Enum.UserInputType.MouseButton2 or Val.UserInputType == Enum.UserInputType.MouseButton3 then
				Keybind.Key = Val.UserInputType
			end
		elseif table.find({"Hold", "Toggle", "Always"}, Val) then
			Keybind.Mode = Val

			if Val == "Always" then
				Keybind:Set(true)
			elseif Val == "Hold" then
				Keybind:Set(false)
			elseif Val == "Toggle" then
				Keybind:Set(false)
			end
		elseif type(Val) == "table" then
			if Val.Key and Val.Mode then
				Val.Key = type(Val.Key) == "string" and Val.Key ~= "?" and Library:ConvertToEnum(Val.Key) or Val.Key
				Keybind.Key = Val.Key
				Keybind.Mode = Val.Mode
			else
				return
			end
		end

		ActualButton.Text = ConvertKeys[Keybind.Key] or string.gsub(tostring(Keybind.Key), "Enum.KeyCode.", "")

		Library.Flags[Props.Flag] = Keybind.Value

		if Props.Callback ~= nil then
			Props.Callback(Keybind.Value)
		end
	end

	local Connections = {}
	local SelectorOpened = nil
	local SelectorConnection = nil
	ActualButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not Keybind.Listening then
			TweenService:Create(ActualButton, TweenInfo.new(0.15), {TextColor3 = Library.Accent}):Play()

			task.wait()

			Keybind.Listening = true
		end

		if input.UserInputType == Enum.UserInputType.MouseButton2 and not Keybind.Listening then
			if SelectorOpened == nil then
				SelectorOpened = Library:New("ImageButton", {
					Name = "\0",
					Image = "",
					ImageTransparency = 1,
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(46, 46, 46),
					BorderSizePixel = 0,
					Size = UDim2.fromOffset(60, 45),
					Position = UDim2.fromOffset(Frame.AbsolutePosition.X + 27, Frame.AbsolutePosition.Y + 38),
					ZIndex = 50,
					Parent = Library.ScreenGui
				})

				local SelectorStroke = Library:New("UIStroke", {
					Name = "\0",
					ApplyStrokeMode = "Border",
					LineJoinMode = "Miter", 
					Color = Color3.fromRGB(12, 12, 12),
					Parent = SelectorOpened
				})

				local SelectorAccent = Library:New("Frame", {
					Name = "\0",
					BackgroundColor3 = Library.Accent,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 2),
					ZIndex = 51,
					Parent = SelectorOpened
				})

				local SelectorAccentStroke = Library:New("UIStroke", {
					Name = "\0",
					ApplyStrokeMode = "Border",
					Color = Color3.fromRGB(12, 12, 12),
					LineJoinMode = "Miter",
					Thickness = 1,
					Enabled = true,
					Parent = SelectorAccent
				})

				local SelectorAccentGradient = Library:New("UIGradient", {
					Name = "\0",
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
					}),
					Rotation = 90,
					Parent = SelectorAccent
				})

				local DarkerFrame = Library:New("Frame", {
					Name = "\0",
					BackgroundColor3 = Color3.fromRGB(46, 46, 46),
					BorderSizePixel = 0,
					Size = UDim2.new(1, -2, 1, -5),
					Position = UDim2.fromOffset(1, 4),
					ZIndex = 51,
					Parent = SelectorOpened
				})

				local DarkerFrameGradient = Library:New("UIGradient", {
					Name = "\0",
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193))
					}),
					Rotation = 90,
					Parent = DarkerFrame
				})

				local HoldButton = Library:New("TextButton", {
					Name = "\0",
					Size = UDim2.new(1, 0, 0, 12),
					Text = "Hold",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 52,
					Parent = DarkerFrame
				})

				local ToggleButton = Library:New("TextButton", {
					Name = "\0",
					Size = UDim2.new(1, 0, 0, 12),
					Position = UDim2.fromOffset(0, 14),
					Text = "Toggle",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 52,
					Parent = DarkerFrame
				})

				local AlwaysButton = Library:New("TextButton", {
					Name = "\0",
					Size = UDim2.new(1, 0, 0, 12),
					Position = UDim2.fromOffset(0, 28),
					Text = "Always",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 52,
					Parent = DarkerFrame
				})

				HoldButton.TextColor3 = Keybind.Mode == "Hold" and Library.Accent or Color3.fromRGB(255, 255, 255)
				ToggleButton.TextColor3 = Keybind.Mode == "Toggle" and Library.Accent or Color3.fromRGB(255, 255, 255)
				AlwaysButton.TextColor3 = Keybind.Mode == "Always" and Library.Accent or Color3.fromRGB(255, 255, 255)

				Connections.A = HoldButton.MouseButton1Down:Connect(function()
					Keybind:Set("Hold")

					TweenService:Create(HoldButton, TweenInfo.new(0.15), {TextColor3 = Library.Accent}):Play()

					if ToggleButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(ToggleButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end

					if AlwaysButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(AlwaysButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end
				end)

				Connections.B = ToggleButton.MouseButton1Down:Connect(function()
					Keybind:Set("Toggle")

					if HoldButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(HoldButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end

					TweenService:Create(ToggleButton, TweenInfo.new(0.15), {TextColor3 = Library.Accent}):Play()

					if AlwaysButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(AlwaysButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end
				end)

				Connections.C = AlwaysButton.MouseButton1Down:Connect(function()
					Keybind:Set("Always")

					if HoldButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(HoldButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end

					if ToggleButton.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
						TweenService:Create(ToggleButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end

					TweenService:Create(AlwaysButton, TweenInfo.new(0.15), {TextColor3 = Library.Accent}):Play()
				end)

				task.wait()
				SelectorConnection = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local InputPos = input.Position
						local AbsPos = SelectorOpened.AbsolutePosition
						local AbsSize = Vector2.new(SelectorOpened.AbsoluteSize.X - 1, SelectorOpened.AbsoluteSize.Y - 1)

						if not (InputPos.X >= AbsPos.X and InputPos.X <= AbsPos.X + AbsSize.X and InputPos.Y >= AbsPos.Y and InputPos.Y <= AbsPos.Y + AbsSize.Y) then
							SelectorOpened:Destroy()
							SelectorOpened = nil

							if SelectorConnection then
								SelectorConnection:Disconnect()
								SelectorConnection = nil
							end

							for _, Con in Connections do
								Con:Disconnect()
							end
						end
					end
				end)
			else
				SelectorOpened:Destroy()
				SelectorOpened = nil

				if SelectorConnection then
					SelectorConnection:Disconnect()
				end

				for _, Con in Connections do
					Con:Disconnect()
				end
			end
		end
	end)

	UserInputService.InputBegan:Connect(function(input)
		if Keybind.Listening then
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
				Keybind:Set("?")

				TweenService:Create(ActualButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()

				Keybind.Listening = false
				return
			end

			Keybind:Set(input)

			TweenService:Create(ActualButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()

			Keybind.Listening = false
		elseif input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then
			Keybind:Set(not Keybind.Value)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if Keybind.Mode == "Hold" and (input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key) and not Keybind.Listening then
			Keybind:Set(false)
		end
	end)

	Keybind:Set({Key = Props.Key, Mode = Props.Mode})

	Library.Config[Props.Flag] = Keybind
	return setmetatable(Keybind, Library)
end
