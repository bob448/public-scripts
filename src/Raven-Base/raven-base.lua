-- RAVEN
-- made by @bob448 or bobmichealson8 on scriptblox

-- A command-based system which can be used to create other scripts
-- This is the official base version of Raven!

--[[
to do:
    add the spin command
]]

if getgenv and getgenv().RAVEN_LOADED then
    error("Raven is already loaded.")
end

local module = {}

module.Name = "Raven"
module.VERSION = -1

local function GetService(name: string)
    return game:GetService(name)
end

local HttpService = GetService("HttpService")
local ReplicatedStorage = GetService("ReplicatedStorage")
local RunService: RunService = GetService("RunService")
local _CoreGui = GetService("CoreGui")
local StarterGui = GetService("StarterGui")
local TeleportService = GetService("TeleportService")
local TweenService: TweenService = GetService("TweenService")
local UserInputService = GetService("UserInputService")
local Players: Players = GetService("Players")
local LocalPlayer: Player = Players.LocalPlayer
local TextChatService: TextChatService = GetService("TextChatService")
local TextChannels
local RBXGeneral: TextChannel? = nil
local RBXSystem: TextChannel? = nil

local function Exists(inst: Instance?)
    return inst ~= nil and inst.Parent ~= nil
end

module.Instance = {}

function module.Instance:Exists(...)
    return Exists(...)
end

task.spawn(function()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChannels = TextChatService:WaitForChild("TextChannels")
        RBXGeneral = TextChannels:WaitForChild("RBXGeneral")
        RBXSystem = TextChannels:WaitForChild("RBXSystem")
    end
end)

local ClosedPosition = UDim2.new(.5, 0, 0, -122)
local OpenPosition = UDim2.new(.5, 0, 0, 4)

local CanAccessCoreGui = true

local function GetCoreGui()
    if not CanAccessCoreGui then
        return LocalPlayer.PlayerGui
    else
        return _CoreGui
    end
end

function module:GetCoreGui()
    return GetCoreGui()
end

do
    local TestInstance = Instance.new("ScreenGui")

    local success, _ = pcall(function()
        TestInstance.Parent = _CoreGui
    end)

    CanAccessCoreGui = success

    TestInstance:Destroy()
end

module.CanAccessCoreGui = CanAccessCoreGui

local function AnimateGradient(uigradient: UIGradient, speed: number)
    return RunService.RenderStepped:Connect(function(delta)
        uigradient.Rotation += speed * 10 * delta

        if uigradient.Rotation >= 180 then
            uigradient.Rotation = 0
        end
    end)
end

module.Gui = {}
function module.Gui:AnimateGradient(...)
    return AnimateGradient(...)
end

local Mobile = UserInputService.TouchEnabled

RunService.Heartbeat:Connect(function(delta)
    Mobile = UserInputService.TouchEnabled
end)

module.IsMobile = Mobile

function Draggable(dragframe,mainframe)
	local dragging=false
	local ogpos=Vector2.new(0,0)
	local ogguipos=UDim2.new(0,0,0,0)
	local dinput

	dragframe.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true
			ogpos=input.Position
			ogguipos=mainframe.Position
		end
	end)

	dragframe.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=false
		end
	end)

	dragframe.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
			dinput=input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input==dinput and dragging then
			local minus = input.Position - ogpos
			local position=UDim2.new(ogguipos.X.Scale,ogguipos.X.Offset + minus.X ,ogguipos.Y.Scale,ogguipos.Y.Offset + minus.Y)
			if not Mobile then
				TweenService:Create(
					mainframe,
					TweenInfo.new(.2),
					{["Position"]=position}
				):Play()
			else
				mainframe.Position=position
			end
		end
	end)
end

function module.Gui:Draggable(...)
    return Draggable(...)
end

local raven = Instance.new("ScreenGui")
raven.IgnoreGuiInset = true
raven.ResetOnSpawn = false
raven.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
raven.Name = "Raven"
raven.Parent = GetCoreGui()

local main_frame = Instance.new("Frame")
main_frame.AnchorPoint = Vector2.new(0.5, 0)
main_frame.BackgroundColor3 = Color3.new(0, 0, 0)
main_frame.BorderColor3 = Color3.new(0, 0, 0)
main_frame.BorderSizePixel = 0
main_frame.Position = UDim2.new(0.5, 0, 0, 0)
main_frame.Size = UDim2.new(0, 304, 0, 121)
main_frame.Visible = true
main_frame.Name = "MainFrame"
main_frame.Parent = raven

local uicorner = Instance.new("UICorner")
uicorner.Parent = main_frame

local welcome_label = Instance.new("TextLabel")
welcome_label.Font = Enum.Font.Arial
welcome_label.Text = "Welcome To Raven!"
welcome_label.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
welcome_label.TextSize = 50
welcome_label.TextStrokeColor3 = Color3.new(0.443137, 0.305882, 1)
welcome_label.TextWrapped = true
welcome_label.AnchorPoint = Vector2.new(0.5, 0.5)
welcome_label.BackgroundColor3 = Color3.new(0, 0, 0)
welcome_label.BorderColor3 = Color3.new(0, 0, 0)
welcome_label.BorderSizePixel = 0
welcome_label.Position = UDim2.new(0.5, 0, 0.5, 0)
welcome_label.Size = UDim2.new(1, 0, 1, 0)
welcome_label.Visible = false
welcome_label.ZIndex = 999999
welcome_label.Name = "WelcomeLabel"
welcome_label.Parent = main_frame

local uicorner_2 = Instance.new("UICorner")
uicorner_2.Parent = welcome_label

local uistroke = Instance.new("UIStroke")
uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke.Thickness = 5
uistroke.Parent = main_frame

local animated_main_gradient = Instance.new("UIGradient")
animated_main_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_main_gradient.Name = "AnimatedMainGradient"
animated_main_gradient.Parent = uistroke

local command_box = Instance.new("TextBox")
command_box.CursorPosition = -1
command_box.Font = Enum.Font.Code
command_box.PlaceholderColor3 = Color3.new(0.423529, 0.423529, 0.423529)
command_box.PlaceholderText = "enter command here.."
command_box.RichText = true
command_box.Text = ""
command_box.TextColor3 = Color3.new(0.423529, 0.321569, 0.764706)
command_box.TextSize = 22
command_box.TextTruncate = Enum.TextTruncate.AtEnd
command_box.TextWrapped = true
command_box.BackgroundColor3 = Color3.new(0.0941177, 0.0941177, 0.0941177)
command_box.BorderColor3 = Color3.new(0, 0, 0)
command_box.BorderSizePixel = 0
command_box.Position = UDim2.new(0.032894738, 0, 0.255665421, 0)
command_box.Size = UDim2.new(0.9342103, 0, 0.686483324, 0)
command_box.Visible = true
command_box.Name = "CommandBox"
command_box.Parent = main_frame

local uicorner_3 = Instance.new("UICorner")
uicorner_3.Parent = command_box

local uistroke_2 = Instance.new("UIStroke")
uistroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_2.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_2.Thickness = 3
uistroke_2.Parent = command_box

local animated_command_gradient = Instance.new("UIGradient")
animated_command_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_command_gradient.Name = "AnimatedCommandGradient"
animated_command_gradient.Parent = uistroke_2

local title_label = Instance.new("TextLabel")
title_label.Font = Enum.Font.Unknown
title_label.Text = "Raven"
title_label.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
title_label.TextScaled = true
title_label.TextSize = 14
title_label.TextStrokeColor3 = Color3.new(0.494118, 0.164706, 0.87451)
title_label.TextStrokeTransparency = 0.5
title_label.TextWrapped = true
title_label.BackgroundColor3 = Color3.new(1, 1, 1)
title_label.BackgroundTransparency = 1
title_label.BorderColor3 = Color3.new(0, 0, 0)
title_label.BorderSizePixel = 0
title_label.Position = UDim2.new(-0.00210531126, 0, 0, 0)
title_label.Size = UDim2.new(1.00210536, 0, 0.255665421, 0)
title_label.Visible = true
title_label.Name = "TitleLabel"
title_label.Parent = main_frame

local toggle_button = Instance.new("TextButton")
toggle_button.Font = Enum.Font.Arial
toggle_button.Text = "V"
toggle_button.TextColor3 = Color3.new(1, 1, 1)
toggle_button.TextScaled = true
toggle_button.TextSize = 14
toggle_button.TextWrapped = true
toggle_button.AnchorPoint = Vector2.new(0.5, 0)
toggle_button.BackgroundColor3 = Color3.new(0, 0, 0)
toggle_button.BorderColor3 = Color3.new(0, 0, 0)
toggle_button.BorderSizePixel = 0
toggle_button.Position = UDim2.new(0.5, 0, 1.03499997, 0)
toggle_button.Size = UDim2.new(0, 80, 0, 21)
toggle_button.Visible = true
toggle_button.Name = "ToggleButton"
toggle_button.Parent = main_frame

local uistroke_3 = Instance.new("UIStroke")
uistroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_3.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_3.Thickness = 5
uistroke_3.Parent = toggle_button

local animated_toggle_gradient = Instance.new("UIGradient")
animated_toggle_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_toggle_gradient.Name = "AnimatedToggleGradient"
animated_toggle_gradient.Parent = uistroke_3

local commands_frame = Instance.new("Frame")
commands_frame.AnchorPoint = Vector2.new(0.5, 0.5)
commands_frame.BackgroundColor3 = Color3.new(0, 0, 0)
commands_frame.BorderColor3 = Color3.new(0, 0, 0)
commands_frame.BorderSizePixel = 0
commands_frame.Position = UDim2.new(0.499370664, 0, 0.498955697, 0)
commands_frame.Size = UDim2.new(0, 528, 0, 251)
commands_frame.Visible = false
commands_frame.Name = "CommandsFrame"
commands_frame.Parent = raven

local uicorner_4 = Instance.new("UICorner")
uicorner_4.Parent = commands_frame

local uistroke_4 = Instance.new("UIStroke")
uistroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_4.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_4.Thickness = 5
uistroke_4.Parent = commands_frame

local animated_commands_gradient = Instance.new("UIGradient")
animated_commands_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_commands_gradient.Name = "AnimatedCommandsGradient"
animated_commands_gradient.Parent = uistroke_4

local closecommands_button = Instance.new("TextButton")
closecommands_button.Font = Enum.Font.Arimo
closecommands_button.Text = "Close"
closecommands_button.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
closecommands_button.TextScaled = true
closecommands_button.TextSize = 14
closecommands_button.TextWrapped = true
closecommands_button.BackgroundColor3 = Color3.new(0, 0, 0)
closecommands_button.BorderColor3 = Color3.new(0, 0, 0)
closecommands_button.BorderSizePixel = 0
closecommands_button.AnchorPoint = Vector2.new(.5,.5)
closecommands_button.Position = UDim2.new(0.5, 0, 0.94, 0)
closecommands_button.Size = UDim2.new(0.322, 0, -0.12, 0)
closecommands_button.Visible = true
closecommands_button.Name = "CloseCommandsButton"
closecommands_button.Parent = commands_frame

local uistroke_5 = Instance.new("UIStroke")
uistroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_5.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_5.Thickness = 5
uistroke_5.Parent = closecommands_button

local animated_close_commands_gradient = Instance.new("UIGradient")
animated_close_commands_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_close_commands_gradient.Name = "AnimatedCloseCommandsGradient"
animated_close_commands_gradient.Parent = uistroke_5

local commands_scrolling_frame = Instance.new("ScrollingFrame")
commands_scrolling_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
commands_scrolling_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
commands_scrolling_frame.ScrollBarImageColor3 = Color3.new(0.564706, 0.564706, 0.564706)
commands_scrolling_frame.Active = true
commands_scrolling_frame.BackgroundColor3 = Color3.new(1, 1, 1)
commands_scrolling_frame.BackgroundTransparency = 1
commands_scrolling_frame.BorderColor3 = Color3.new(0, 0, 0)
commands_scrolling_frame.BorderSizePixel = 0
commands_scrolling_frame.Position = UDim2.new(0, 0, 0.0956175327, 0)
commands_scrolling_frame.Size = UDim2.new(0, 528, 0, 190)
commands_scrolling_frame.Visible = true
commands_scrolling_frame.Name = "CommandsScrollingFrame"
commands_scrolling_frame.Parent = commands_frame

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 2)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = commands_scrolling_frame

local search_commands_box = Instance.new("TextBox")
search_commands_box.CursorPosition = -1
search_commands_box.Font = Enum.Font.Arial
search_commands_box.PlaceholderColor3 = Color3.new(0.258824, 0.180392, 0.27451)
search_commands_box.PlaceholderText = "Search here.."
search_commands_box.RichText = true
search_commands_box.Text = ""
search_commands_box.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
search_commands_box.TextSize = 21
search_commands_box.TextWrapped = true
search_commands_box.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
search_commands_box.BorderColor3 = Color3.new(0, 0, 0)
search_commands_box.BorderSizePixel = 0
search_commands_box.Size = UDim2.new(1, 0, 0.0956175327, 0)
search_commands_box.Visible = true
search_commands_box.Name = "SearchCommandsBox"
search_commands_box.Parent = commands_frame

local uicorner = Instance.new("UICorner")
uicorner.Parent = search_commands_box

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 2)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = commands_scrolling_frame

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 2)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = commands_scrolling_frame

local command_frame = Instance.new("Frame")
command_frame.AutomaticSize = Enum.AutomaticSize.Y
command_frame.BackgroundColor3 = Color3.new(0.494118, 0.164706, 0.87451)
command_frame.BackgroundTransparency = 0.5
command_frame.BorderColor3 = Color3.new(0, 0, 0)
command_frame.BorderSizePixel = 0
command_frame.Size = UDim2.new(1, 0, 0, 38)
command_frame.Visible = true
command_frame.Name = "CommandFrame"
command_frame.Parent = GetCoreGui()

local command_label = Instance.new("TextLabel")
command_label.Font = Enum.Font.Arimo
command_label.Text = "Loading Command.."
command_label.TextColor3 = Color3.new(0.745098, 0.745098, 0.745098)
command_label.TextSize = 14
command_label.TextStrokeColor3 = Color3.new(0.494118, 0.164706, 0.87451)
command_label.TextStrokeTransparency = 0.30000001192092896
command_label.TextWrapped = true
command_label.TextXAlignment = Enum.TextXAlignment.Left
command_label.AutomaticSize = Enum.AutomaticSize.Y
command_label.BackgroundColor3 = Color3.new(1, 1, 1)
command_label.BackgroundTransparency = 1
command_label.BorderColor3 = Color3.new(0, 0, 0)
command_label.BorderSizePixel = 0
command_label.Position = UDim2.new(0.0170454551, 0, 0, 0)
command_label.Size = UDim2.new(0.982954562, 0, 1, 0)
command_label.Visible = true
command_label.Name = "CommandLabel"
command_label.Parent = command_frame

local uicorner = Instance.new("UICorner")
uicorner.Parent = command_frame

local notifications_frame = Instance.new("ScrollingFrame")
notifications_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
notifications_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
notifications_frame.ScrollBarImageColor3 = Color3.new(0, 0, 0)
notifications_frame.ScrollBarImageTransparency = 1
notifications_frame.Active = true
notifications_frame.AnchorPoint = Vector2.new(1, 0)
notifications_frame.BackgroundColor3 = Color3.new(1, 1, 1)
notifications_frame.BackgroundTransparency = 1
notifications_frame.BorderColor3 = Color3.new(0, 0, 0)
notifications_frame.BorderSizePixel = 0
notifications_frame.Position = UDim2.new(0.999893188, 0, 0, 0)
notifications_frame.Size = UDim2.new(0, 382, 1, 0)
notifications_frame.Visible = true
notifications_frame.Name = "NotificationsFrame"
notifications_frame.ScrollingEnabled = false
notifications_frame.Parent = raven

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 5)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = notifications_frame

local notification_frame = Instance.new("Frame")
notification_frame.AutomaticSize = Enum.AutomaticSize.Y
notification_frame.BackgroundColor3 = Color3.new(0.105882, 0.0352941, 0.192157)
notification_frame.BorderColor3 = Color3.new(0, 0, 0)
notification_frame.BorderSizePixel = 0
notification_frame.Size = UDim2.new(1, 0, 0, 80)
notification_frame.Visible = true
notification_frame.Name = "NotificationFrame"
notification_frame.Parent = GetCoreGui()

local uicorner = Instance.new("UICorner")
uicorner.Parent = notification_frame

local status_frame = Instance.new("Frame")
status_frame.BackgroundColor3 = Color3.new(0.423529, 0.384314, 1)
status_frame.BorderColor3 = Color3.new(0, 0, 0)
status_frame.BorderSizePixel = 0
status_frame.Position = UDim2.new(0.976439774, 0, 0, 0)
status_frame.Size = UDim2.new(-0.0549738221, 30, 1, 0)
status_frame.Visible = true
status_frame.ZIndex = 2
status_frame.Name = "StatusFrame"
status_frame.Parent = notification_frame

local uicorner_2 = Instance.new("UICorner")
uicorner_2.Parent = status_frame

local notification_text = Instance.new("TextLabel")
notification_text.Font = Enum.Font.Arimo
notification_text.RichText = true
notification_text.Text = "Loading Notification.."
notification_text.TextColor3 = Color3.new(0.34902, 0.168627, 0.713726)
notification_text.TextSize = 20
notification_text.TextWrapped = true
notification_text.AutomaticSize = Enum.AutomaticSize.Y
notification_text.BackgroundColor3 = Color3.new(1, 1, 1)
notification_text.BackgroundTransparency = 1
notification_text.BorderColor3 = Color3.new(0, 0, 0)
notification_text.BorderSizePixel = 0
notification_text.Size = UDim2.new(0.982, 0, 1, 0)
notification_text.Visible = true
notification_text.Name = "NotificationText"
notification_text.Parent = notification_frame

local click = Instance.new("Sound")
click.RollOffMode = Enum.RollOffMode.InverseTapered
click.SoundId = "rbxassetid://6042053626"
click.Name = "Click"
click.Parent = raven

local slide = Instance.new("Sound")
slide.RollOffMode = Enum.RollOffMode.InverseTapered
slide.SoundId = "rbxassetid://18919544132"
slide.Name = "Slide"
slide.Parent = raven

local outputs_frame = Instance.new("Frame")
outputs_frame.AnchorPoint = Vector2.new(0.5, 0.5)
outputs_frame.BackgroundColor3 = Color3.new(0, 0, 0)
outputs_frame.BorderColor3 = Color3.new(0, 0, 0)
outputs_frame.BorderSizePixel = 0
outputs_frame.Position = UDim2.new(0.499370664, 0, 0.498955697, 0)
outputs_frame.Size = UDim2.new(0, 528, 0, 251)
outputs_frame.Visible = false
outputs_frame.Name = "OutputsFrame"
outputs_frame.Parent = raven

local uicorner = Instance.new("UICorner")
uicorner.Parent = outputs_frame

local uistroke = Instance.new("UIStroke")
uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke.Thickness = 5
uistroke.Parent = outputs_frame

local animated_output_gradient = Instance.new("UIGradient")
animated_output_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_output_gradient.Name = "AnimatedOutputGradient"
animated_output_gradient.Parent = uistroke

local close_output_button = Instance.new("TextButton")
close_output_button.Font = Enum.Font.Arial
close_output_button.Text = "Close"
close_output_button.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
close_output_button.TextScaled = true
close_output_button.TextSize = 14
close_output_button.TextWrapped = true
close_output_button.AnchorPoint = Vector2.new(0.5, 0.5)
close_output_button.BackgroundColor3 = Color3.new(0, 0, 0)
close_output_button.BorderColor3 = Color3.new(0, 0, 0)
close_output_button.BorderSizePixel = 0
close_output_button.Position = UDim2.new(0.5, 0, 0.940239072, 0)
close_output_button.Size = UDim2.new(0.321969688, 0, -0.119521923, 0)
close_output_button.Visible = true
close_output_button.Name = "CloseOutputButton"
close_output_button.Parent = outputs_frame

local uistroke_2 = Instance.new("UIStroke")
uistroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_2.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_2.Thickness = 5
uistroke_2.Parent = close_output_button

local animated_close_output_gradient = Instance.new("UIGradient")
animated_close_output_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_close_output_gradient.Name = "AnimatedCloseOutputGradient"
animated_close_output_gradient.Parent = uistroke_2

local output_scrolling_frame = Instance.new("ScrollingFrame")
output_scrolling_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
output_scrolling_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
output_scrolling_frame.ScrollBarImageColor3 = Color3.new(0.564706, 0.564706, 0.564706)
output_scrolling_frame.Active = true
output_scrolling_frame.BackgroundColor3 = Color3.new(1, 1, 1)
output_scrolling_frame.BackgroundTransparency = 1
output_scrolling_frame.BorderColor3 = Color3.new(0, 0, 0)
output_scrolling_frame.BorderSizePixel = 0
output_scrolling_frame.Position = UDim2.new(0, 0, 0.0956175327, 0)
output_scrolling_frame.Size = UDim2.new(0, 528, 0, 190)
output_scrolling_frame.Visible = true
output_scrolling_frame.Name = "OutputScrollingFrame"
output_scrolling_frame.Parent = outputs_frame

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 2)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = output_scrolling_frame

local search_output_box = Instance.new("TextBox")
search_output_box.Font = Enum.Font.Arial
search_output_box.PlaceholderColor3 = Color3.new(0.258824, 0.180392, 0.27451)
search_output_box.PlaceholderText = "Search here.."
search_output_box.RichText = true
search_output_box.Text = ""
search_output_box.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
search_output_box.TextSize = 21
search_output_box.TextWrapped = true
search_output_box.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
search_output_box.BorderColor3 = Color3.new(0, 0, 0)
search_output_box.BorderSizePixel = 0
search_output_box.Size = UDim2.new(1, 0, 0.0956175327, 0)
search_output_box.Visible = true
search_output_box.Name = "SearchOutputBox"
search_output_box.Parent = outputs_frame

local uicorner_2 = Instance.new("UICorner")
uicorner_2.Parent = search_output_box

local output_frame = Instance.new("Frame")
output_frame.AutomaticSize = Enum.AutomaticSize.Y
output_frame.BackgroundColor3 = Color3.new(0.494118, 0.164706, 0.87451)
output_frame.BackgroundTransparency = 0.5
output_frame.BorderColor3 = Color3.new(0, 0, 0)
output_frame.BorderSizePixel = 0
output_frame.Size = UDim2.new(1, 0, 0, 38)
output_frame.Visible = true
output_frame.Name = "OutputFrame"
output_frame.Parent = GetCoreGui()

local output_label = Instance.new("TextLabel")
output_label.Font = Enum.Font.Arial
output_label.Text = "Loading Output.."
output_label.TextColor3 = Color3.new(0.745098, 0.745098, 0.745098)
output_label.TextSize = 14
output_label.TextStrokeColor3 = Color3.new(0.494118, 0.164706, 0.87451)
output_label.TextStrokeTransparency = 0.30000001192092896
output_label.TextWrapped = true
output_label.TextXAlignment = Enum.TextXAlignment.Left
output_label.AutomaticSize = Enum.AutomaticSize.Y
output_label.BackgroundColor3 = Color3.new(1, 1, 1)
output_label.BackgroundTransparency = 1
output_label.BorderColor3 = Color3.new(0, 0, 0)
output_label.BorderSizePixel = 0
output_label.Position = UDim2.new(0.0170454551, 0, 0, 0)
output_label.Size = UDim2.new(0.982954562, 0, 1, 0)
output_label.Visible = true
output_label.Name = "OutputLabel"
output_label.Parent = output_frame

local uicorner_3 = Instance.new("UICorner")
uicorner_3.Parent = output_frame

local chat_log_frame = Instance.new("Frame")
chat_log_frame.AutomaticSize = Enum.AutomaticSize.Y
chat_log_frame.BackgroundColor3 = Color3.new(0.494118, 0.164706, 0.87451)
chat_log_frame.BackgroundTransparency = 0.5
chat_log_frame.BorderColor3 = Color3.new(0, 0, 0)
chat_log_frame.BorderSizePixel = 0
chat_log_frame.Size = UDim2.new(1, 0, 0, 38)
chat_log_frame.Visible = true
chat_log_frame.Name = "ChatLogFrame"
chat_log_frame.Parent = GetCoreGui()

local chat_log_label = Instance.new("TextLabel")
chat_log_label.Font = Enum.Font.Arial
chat_log_label.Text = "Loading ChatLog.."
chat_log_label.TextColor3 = Color3.new(0.745098, 0.745098, 0.745098)
chat_log_label.TextSize = 14
chat_log_label.TextStrokeColor3 = Color3.new(0.494118, 0.164706, 0.87451)
chat_log_label.TextStrokeTransparency = 0.30000001192092896
chat_log_label.TextWrapped = true
chat_log_label.TextXAlignment = Enum.TextXAlignment.Left
chat_log_label.AutomaticSize = Enum.AutomaticSize.Y
chat_log_label.BackgroundColor3 = Color3.new(1, 1, 1)
chat_log_label.BackgroundTransparency = 1
chat_log_label.BorderColor3 = Color3.new(0, 0, 0)
chat_log_label.BorderSizePixel = 0
chat_log_label.Position = UDim2.new(0.0170454551, 0, 0, 0)
chat_log_label.Size = UDim2.new(0.982954562, 0, 1, 0)
chat_log_label.Visible = true
chat_log_label.Name = "ChatLogLabel"
chat_log_label.Parent = chat_log_frame

local uicorner = Instance.new("UICorner")
uicorner.Parent = chat_log_frame

local chat_logs_frame = Instance.new("Frame")
chat_logs_frame.AnchorPoint = Vector2.new(0.5, 0.5)
chat_logs_frame.BackgroundColor3 = Color3.new(0, 0, 0)
chat_logs_frame.BorderColor3 = Color3.new(0, 0, 0)
chat_logs_frame.BorderSizePixel = 0
chat_logs_frame.Position = UDim2.new(0.499370664, 0, 0.498955697, 0)
chat_logs_frame.Size = UDim2.new(0, 528, 0, 251)
chat_logs_frame.Visible = false
chat_logs_frame.Name = "ChatLogsFrame"
chat_logs_frame.Parent = raven

local uicorner_2 = Instance.new("UICorner")
uicorner_2.Parent = chat_logs_frame

local uistroke = Instance.new("UIStroke")
uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke.Thickness = 5
uistroke.Parent = chat_logs_frame

local animated_chat_logs_gradient = Instance.new("UIGradient")
animated_chat_logs_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_chat_logs_gradient.Name = "AnimatedChatLogsGradient"
animated_chat_logs_gradient.Parent = uistroke

local closechat_logs_button = Instance.new("TextButton")
closechat_logs_button.Font = Enum.Font.Arial
closechat_logs_button.Text = "Close"
closechat_logs_button.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
closechat_logs_button.TextScaled = true
closechat_logs_button.TextSize = 14
closechat_logs_button.TextWrapped = true
closechat_logs_button.AnchorPoint = Vector2.new(0.5, 0.5)
closechat_logs_button.BackgroundColor3 = Color3.new(0, 0, 0)
closechat_logs_button.BorderColor3 = Color3.new(0, 0, 0)
closechat_logs_button.BorderSizePixel = 0
closechat_logs_button.Position = UDim2.new(0.5, 0, 0.940239072, 0)
closechat_logs_button.Size = UDim2.new(0.321969688, 0, -0.119521923, 0)
closechat_logs_button.Visible = true
closechat_logs_button.Name = "CloseChatLogsButton"
closechat_logs_button.Parent = chat_logs_frame

local uistroke_2 = Instance.new("UIStroke")
uistroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke_2.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke_2.Thickness = 5
uistroke_2.Parent = closechat_logs_button

local animated_close_chat_logs_gradient = Instance.new("UIGradient")
animated_close_chat_logs_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_close_chat_logs_gradient.Name = "AnimatedCloseChatLogsGradient"
animated_close_chat_logs_gradient.Parent = uistroke_2

local chat_logs_scrolling_frame = Instance.new("ScrollingFrame")
chat_logs_scrolling_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
chat_logs_scrolling_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
chat_logs_scrolling_frame.ScrollBarImageColor3 = Color3.new(0.564706, 0.564706, 0.564706)
chat_logs_scrolling_frame.Active = true
chat_logs_scrolling_frame.BackgroundColor3 = Color3.new(1, 1, 1)
chat_logs_scrolling_frame.BackgroundTransparency = 1
chat_logs_scrolling_frame.BorderColor3 = Color3.new(0, 0, 0)
chat_logs_scrolling_frame.BorderSizePixel = 0
chat_logs_scrolling_frame.Position = UDim2.new(0, 0, 0.0956175327, 0)
chat_logs_scrolling_frame.Size = UDim2.new(0, 528, 0, 190)
chat_logs_scrolling_frame.Visible = true
chat_logs_scrolling_frame.Name = "ChatLogsScrollingFrame"
chat_logs_scrolling_frame.Parent = chat_logs_frame

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.Padding = UDim.new(0, 2)
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.Parent = chat_logs_scrolling_frame

local search_chat_logs_box = Instance.new("TextBox")
search_chat_logs_box.Font = Enum.Font.Arial
search_chat_logs_box.PlaceholderColor3 = Color3.new(0.258824, 0.180392, 0.27451)
search_chat_logs_box.PlaceholderText = "Search here.."
search_chat_logs_box.RichText = true
search_chat_logs_box.Text = ""
search_chat_logs_box.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
search_chat_logs_box.TextSize = 21
search_chat_logs_box.TextWrapped = true
search_chat_logs_box.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
search_chat_logs_box.BorderColor3 = Color3.new(0, 0, 0)
search_chat_logs_box.BorderSizePixel = 0
search_chat_logs_box.Size = UDim2.new(1, 0, 0.0956175327, 0)
search_chat_logs_box.Visible = true
search_chat_logs_box.Name = "SearchChatLogsBox"
search_chat_logs_box.Parent = chat_logs_frame

local uicorner_3 = Instance.new("UICorner")
uicorner_3.Parent = search_chat_logs_box

AnimateGradient(animated_commands_gradient, 10)
AnimateGradient(animated_main_gradient, 10)
AnimateGradient(animated_command_gradient, 10)
AnimateGradient(animated_toggle_gradient, 10)
AnimateGradient(animated_close_commands_gradient, 10)
AnimateGradient(animated_output_gradient, 10)
AnimateGradient(animated_close_output_gradient, 10)
AnimateGradient(animated_close_chat_logs_gradient, 10)
AnimateGradient(animated_chat_logs_gradient, 10)

Draggable(commands_frame, commands_frame)
Draggable(outputs_frame, outputs_frame)
Draggable(chat_logs_frame, chat_logs_frame)

local NormalToggleButtonSize = toggle_button.Size
local GuiOpen = false

local function MultiplyUDim2(udim2: UDim2, by: number)
    return UDim2.new(udim2.X.Scale * by, udim2.X.Offset * by, udim2.Y.Scale * by, udim2.Y.Offset * by)
end

local function BounceButton(button: TextButton | ImageButton, OgSize: UDim2)
    local BounceTween = TweenService:Create(
        button,
        TweenInfo.new(.1),
        {["Size"] = MultiplyUDim2(OgSize, 1.5)}
    )

    BounceTween:Play()
    click:Play()
    BounceTween.Completed:Wait()

    BounceTween = TweenService:Create(
        button,
        TweenInfo.new(.1),
        {["Size"] = OgSize}
    )

    BounceTween:Play()
    BounceTween.Completed:Wait()
end

function module.Gui:BounceButton(...)
    return BounceButton(...)
end

local function ToggleButtonPressed(_inputObject, _clickCount)
    if toggle_button.Interactable then
        GuiOpen = not GuiOpen

        local SizeTween = TweenService:Create(
            toggle_button,
            TweenInfo.new(.1),
            {["Size"] = MultiplyUDim2(NormalToggleButtonSize, 1.5)}
        )

        SizeTween:Play()
        click:Play()

        if not GuiOpen then
            toggle_button.Text = "V"
        else
            toggle_button.Text = "Ʌ"
        end

        SizeTween.Completed:Wait()

        SizeTween = TweenService:Create(
            toggle_button,
            TweenInfo.new(.1),
            {["Size"] = NormalToggleButtonSize}
        )

        SizeTween:Play()

        if not GuiOpen then
            TweenService:Create(
                main_frame,
                TweenInfo.new(1, Enum.EasingStyle.Exponential),
                {["Position"] = ClosedPosition}
            ):Play()
        else
            TweenService:Create(
                main_frame,
                TweenInfo.new(2, Enum.EasingStyle.Exponential),
                {["Position"] = OpenPosition}
            ):Play()
        end
    end
end

toggle_button.Activated:Connect(ToggleButtonPressed)

module.Notif = {}

local Statuses = {
    Error = Color3.new(0.725490, 0, 0.301960),
    Warning = Color3.new(0.901960, 0.890196, 0.341176),
    Info = status_frame.BackgroundColor3,
    Debug = Color3.new(0.992156, 0.717647, 0.490196),
    Success = Color3.new(0.611764, 0.847058, 0.552941)
}

module.Notif.Statuses = Statuses

local function CloseNotification(Frame: Frame, Status: Frame, Text: TextLabel)
    Frame.AutomaticSize = Enum.AutomaticSize.None

    local CloseTween = TweenService:Create(
        Frame,
        TweenInfo.new(.7),
        {["Size"] = UDim2.new(notification_frame.Size.X.Scale, notification_frame.Size.X.Offset, 0, 0)}
    )

    TweenService:Create(
        Status,
        TweenInfo.new(.7),
        {["BackgroundTransparency"] = 1}
    ):Play()

    TweenService:Create(
        Text,
        TweenInfo.new(.4),
        {["TextTransparency"] = 1}
    ):Play()

    CloseTween:Play()
    CloseTween.Completed:Wait()
    Frame:Destroy()
end

function module.Notif:CloseNotification(...)
    return CloseNotification(...)
end

local function Notify(data: string, status: Color3?, time: number?)
    if not data then
        return Notify("Could not display notification. No data supplied.", Statuses.Error)
    end
    
    local Notif = notification_frame:Clone()
    Notif.Parent = notifications_frame
    Notif.Size = UDim2.new(notification_frame.Size.X.Scale, notification_frame.Size.X.Offset, 0, 0)
    Notif.BackgroundTransparency = 1

    local Text: TextLabel = Notif:WaitForChild("NotificationText")
    Text.Text = data
    Text.TextTransparency = 1

    local Status: Frame = Notif:WaitForChild("StatusFrame")
    Status.BackgroundColor3 = status or Statuses.Info
    Status.BackgroundTransparency = 1

    task.spawn(function()
        local OpenTween = TweenService:Create(
            Notif,
            TweenInfo.new(.5),
            {["Size"] = notification_frame.Size, ["BackgroundTransparency"] = 0}
        )

        TweenService:Create(
            Status,
            TweenInfo.new(.5),
            {["BackgroundTransparency"] = 0}
        ):Play()

        TweenService:Create(
            Text,
            TweenInfo.new(.3),
            {["TextTransparency"] = 0}
        ):Play()

        OpenTween:Play()
        OpenTween.Completed:Wait()

        task.wait(time or 4)

        if not Exists(Notif) then return end

        CloseNotification(Notif, Status, Text)
    end)

    return {Notif, Status, Text}
end

function module.Notif:Notify(...)
    return Notify(...)
end

local DebugMode = false

module.Debug = {}

function module.Debug:GetDebugMode()
    return DebugMode
end

function module.Debug:SetDebugMode(value: boolean)
    DebugMode = value
end

local function Error(data: string, time: number?)
    return Notify(data, Statuses.Error, time)
end

local function Warn(data: string, time: number?)
    return Notify(data, Statuses.Warning, time)
end

local function Info(data: string, time: number?)
    return Notify(data, nil, time)
end

local function Debug(data: string, time: number?)
    if DebugMode then
        return Notify(data, Statuses.Debug, time)
    end
end

local function Success(data: string, time: number?)
    return Notify(data, Statuses.Success, time)
end

function module.Notif:Error(...)
    return Error(...)
end
function module.Notif:Warn(...)
    return Warn(...)
end
function module.Notif:Info(...)
    return Info(...)
end
function module.Notif:Debug(...)
    return Debug(...)
end
function module.Notif:Success(...)
    return Success(...)
end

local function ToBool(str: string?)
    return str == "true"
end

local function Say(message: string, hidden: boolean?)
    if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
        local DefaultChatSystemChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        local SayMessageRequest = DefaultChatSystemChatEvents and DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")

        if SayMessageRequest then
            SayMessageRequest:FireServer(
                message,
                hidden and "System" or "All"
            )
        else
            Error("SayMessageRequest not found in ReplicatedStorage.")
        end
    else
        if not hidden and RBXGeneral or hidden and RBXSystem then
            (hidden and RBXSystem or RBXGeneral):SendAsync(message)
        else
            Error("Couldn't find RBXGeneral/RBXSystem.")
        end
    end
end

module.Player = {}

function module.Player:Say(...)
    return Say(...)
end

local Commands = {}

module.Commands = Commands

type CommandTable = {Function: ({string?}) -> (any?), Aliases: {string?}, Arguments: {string?}, Description: string, ModuleAdded: boolean}

local function AddCMD(name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?), botcommand: boolean?)
    if not Commands[name:lower()] then
        for i,v in pairs(aliases) do
            aliases[i] = v:lower()
        end

        local Table: CommandTable = {}
        Table.Function = func
        Table.Description = description
        Table.Arguments = arguments
        Table.Aliases = aliases
        Table.BotCommand = botcommand or false
        Table.ModuleAdded = false

        Commands[name:lower()] = Table

        return Table
    else
        Error("Could not add command \""..name.."\". Command already exists!")
    end
end

function module:AddCMD(...)
    local Table = AddCMD(...)
    Table.ModuleAdded = true

    return Table
end

local function GetCMD(name: string)
    for Name, Table in pairs(Commands) do
        if name == Name then
            return Table
        else
            for _, Alias in pairs(Table.Aliases) do
                if Alias == name then
                    return Table
                end
            end
        end
    end
    
    return nil
end

function module:GetCMD(...)
    return GetCMD(...)
end

local function RunCMD(name: string, arguments: {string?})
    local Command = GetCMD(name)

    if Command then
        return Command.Function(arguments)
    end
end

function module:RunCMD(...)
    return RunCMD(...)
end

local function ReplaceCMD(name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?), botcommand: boolean?)
    if Commands[name:lower()] then
        Commands[name:lower()] = nil

        AddCMD(name, description, arguments, aliases, func, botcommand)

        return true
    else
        Error("Could not replace command \""..name.."\". Command does not exist.")

        return false
    end
end

function module:ReplaceCMD(...)
    return ReplaceCMD(...)
end

local function ClearOutput()
    for _,v: Frame in pairs(output_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "OutputFrame" then
            v:Destroy()
        end
    end
end

module.Output = {}

function module.Output:ClearOutput()
    return ClearOutput()
end

local function Output(data: {any?})
    outputs_frame.Visible = true

    ClearOutput()

    for _, data in pairs(data) do
        local StringData = data and tostring(data)

        if StringData then
            local Frame = output_frame:Clone()
            Frame.Parent = output_scrolling_frame
            
            local Text: TextLabel = Frame:WaitForChild("OutputLabel")
            Text.Text = StringData
        end
    end
end

function module.Output:OutputData(...)
    return Output(...)
end

local NormalOutputsFrameSize = outputs_frame.Size
local NormalCloseOutputButtonSize = close_output_button.Size

close_output_button.Activated:Connect(function()
    ClearOutput()

    local CloseTween = TweenService:Create(
        outputs_frame,
        TweenInfo.new(1),
        {Size = UDim2.fromScale(0,0)}
    )

    BounceButton(close_output_button, NormalCloseOutputButtonSize)

    search_output_box.Text = ""
    search_output_box.Interactable = false

    CloseTween:Play()
    CloseTween.Completed:Wait()

    outputs_frame.Visible = false
    outputs_frame.Size = NormalOutputsFrameSize

    search_output_box.Interactable = true
end)

search_output_box:GetPropertyChangedSignal("Text"):Connect(function()
    for _,v: Frame in ipairs(output_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "OutputFrame" then
            local Text: TextLabel = v:FindFirstChild("OutputLabel")

            if Text and search_output_box.Text:len() > 0 and Text.Text:lower():find(search_output_box.Text:lower()) then
                v.Visible = true
            elseif Text and search_output_box.Text:len() > 0 then
                v.Visible = false
            else
                v.Visible = true
            end
        end
    end
end)

local function ClearChatLogs()
    for i,v in pairs(chat_logs_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "ChatLogFrame" then
            v:Destroy()
        end
    end
end

local function AddChatLog(message: string, player: Player)
    local ChatLog = chat_log_frame:Clone()
    ChatLog.Parent = chat_logs_scrolling_frame

    local Label: TextLabel = ChatLog:WaitForChild("ChatLogLabel")
    Label.Text = "["..player.Name.."]: "..message
end

local NormalCloseChatLogsButtonSize = closechat_logs_button.Size
local NormalChatLogsFrameSize = chat_logs_frame.Size

closechat_logs_button.Activated:Connect(function()
    local CloseTween = TweenService:Create(
        chat_logs_frame,
        TweenInfo.new(1),
        {Size = UDim2.fromScale(0,0)}
    )

    BounceButton(closechat_logs_button, NormalCloseChatLogsButtonSize)

    chat_logs_scrolling_frame.Visible = false
    search_chat_logs_box.Text = ""
    search_chat_logs_box.Interactable = false

    CloseTween:Play()
    CloseTween.Completed:Wait()

    chat_logs_scrolling_frame.Visible = true

    chat_logs_frame.Visible = false

    chat_logs_frame.Size = NormalChatLogsFrameSize

    search_chat_logs_box.Interactable = true
end)

search_chat_logs_box:GetPropertyChangedSignal("Text"):Connect(function()
    for _,v: Frame in ipairs(chat_logs_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "ChatLogFrame" then
            local Text = v:FindFirstChild("ChatLogLabel")

            if Text and search_chat_logs_box.Text:len() > 0 and Text.Text:lower():find(search_chat_logs_box.Text:lower()) then
                v.Visible = true
            elseif Text and search_chat_logs_box.Text:len() > 0 then
                v.Visible = false
            else
                v.Visible = true
            end
        end
    end
end)

chat_logs_scrolling_frame.ChildAdded:Connect(function(child)
    if child:IsA("Frame") and child.Name == "ChatLogFrame" then
        local Text: TextLabel = child:WaitForChild("ChatLogLabel")

        if Text and search_chat_logs_box.Text:len() > 0 and Text.Text:lower():find(search_chat_logs_box.Text:lower()) then
            child.Visible = true
        elseif Text and search_chat_logs_box.Text:len() > 0 then
            child.Visible = false
        else
            child.Visible = true
        end
    end
end)

local PlayerSelectors = {
    me = function()
        return {LocalPlayer}
    end,
    others = function()
        local PlayerList = Players:GetPlayers()
        local LocalIndex = table.find(PlayerList, LocalPlayer)
        if LocalIndex then table.remove(PlayerList, LocalIndex) end

        return PlayerList
    end,
    all = function()
        return Players:GetPlayers()
    end,
    random = function()
        local PlayerList = Players:GetPlayers()
        return #PlayerList > 1 and {PlayerList[math.random(1, #PlayerList)]} or {PlayerList[1]}
    end
}

module.Player.PlayerSelectors = PlayerSelectors

local function FindPlayers(...: string): {Player?}
    local Found = {}
    local Args = {...}

    for _, key in pairs(Args) do
        local IsSelector = false
        for i,v in pairs(PlayerSelectors) do
            if i == key then
                local Result = v()
                table.move(Result, 1, #Result, #Found+1, Found)

                IsSelector = true
            end
        end

        if not IsSelector then
            for _,v: Player in ipairs(Players:GetPlayers()) do
                if v.Name:lower():sub(1, key:len()) == key:lower() or v.DisplayName:lower():sub(1, key:len()) == key:lower() then
                    Found[#Found+1] = v
                end
            end
        end
    end

    return Found
end

function module.Player:FindPlayers(...)
    return FindPlayers(...)
end

local CloseCommandsButtonNormalSize = closecommands_button.Size
local CommandFrameNormalSize = commands_frame.Size

search_commands_box:GetPropertyChangedSignal("Text"):Connect(function()
    for _,v: Frame in ipairs(commands_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "CommandFrame" then
            if search_commands_box.Text:len() == 0 then
                v.Visible = true
                continue
            end

            local Tags = v:GetTags()

            if #Tags>0 then
                local Command: string = v:GetTags()[1]

                if search_commands_box.Text:len() > 0 and Command:sub(1, search_commands_box.Text:len()) == search_commands_box.Text then
                    v.Visible = true
                elseif search_commands_box.Text:len() > 0 then
                    v.Visible = false
                else
                    v.Visible = true
                end
            else
                v.Visible = false
            end
        end
    end
end)

closecommands_button.Activated:Connect(function(_, _)
    if not commands_frame.Visible then return end

    for _,v: Instance in ipairs(commands_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "CommandFrame" then
            v:Destroy()
        end
    end

    local CloseTween = TweenService:Create(
        commands_frame,
        TweenInfo.new(1),
        {["Size"] = UDim2.fromScale(0,0)}
    )

    task.spawn(BounceButton, closecommands_button, CloseCommandsButtonNormalSize)

    search_commands_box.Text = ""
    search_commands_box.Interactable = false

    CloseTween:Play()
    CloseTween.Completed:Wait()

    commands_frame.Visible = false
    commands_frame.Size = CommandFrameNormalSize

    search_commands_box.Interactable = true
end)

local function AutoCompleteCommand(data: string)
    local Split = data:split(" ")

    local Command = Split and #Split > 1 and Split[1] or data
    local Arguments = Split and #Split > 1 and Split or nil

    if Arguments ~= nil then
        table.remove(Arguments, 1)
    else
        Arguments = {}
    end

    if GetCMD(Command:lower()) then
        return command_box.Text
    else
        local Shortest: string? = nil

        for Name: string, Table: CommandTable in pairs(Commands) do
            if Name:sub(1, Command:len()) == Command then
                if Shortest and (Name:len() < Shortest:len()) or Shortest == nil then
                    Shortest = Name
                end
            else
                for _, Alias in pairs(Table.Aliases) do
                    if Alias:sub(1, Command:len()) == Command then
                        if Shortest and (Alias:len() < Shortest:len()) or Shortest == nil then
                            Shortest = Alias
                        end
                    end
                end
            end
        end

        if Shortest ~= nil then
            if #Arguments > 0 then
                return Shortest.." "..table.concat(Arguments, " ")
            else
                return Shortest
            end
        else
            return nil
        end
    end
end

module.Command = {}
function module.Command:AutoCompleteCommand(...)
    return AutoCompleteCommand(...)
end

local BotUtils = {}
BotUtils.BotMode = false
BotUtils.Prefix = "##$R!"

command_box.FocusLost:Connect(function(enterPressed, _)
    if enterPressed then
        local String = command_box.Text:lower()
        command_box.Text = ""

        local Split = String:split(" ")

        local Command = Split and #Split > 1 and Split[1] or String

        if not GetCMD(Command:lower()) then
            local NewString = AutoCompleteCommand(String)

            if NewString then
                Split = NewString:split(" ")
                Command = Split and #Split > 1 and Split[1] or NewString
            else
                Error("Could not find command \""..Command:lower().."\"!")
                return
            end
        end

        local Arguments = Split and #Split > 1 and Split or nil

        if Arguments ~= nil then
            table.remove(Arguments, 1)
        else
            Arguments = {}
        end

        local Table: CommandTable = GetCMD(Command)

        if Table.BotCommand then
            if not BotUtils.BotMode then
                local StringArguments = #Arguments > 0 and table.concat(Arguments, " ") or ""

                Say(BotUtils.Prefix..Command.." "..StringArguments, true)
                Say(".", true)
                return
            end
        end

        local Succ, Err = pcall(Table.Function, Arguments)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        end
    end
end)

AddCMD("debugon", "Turns on debug mode. Used in development for other commands.", {}, {}, function(arguments)
    DebugMode = true

    Success("Turned on debug mode.")
end)

AddCMD("debugoff", "Turns off debug mode.", {}, {}, function(arguments)
    DebugMode = false

    Success("Turned off debug mode.")
end)

AddCMD("test", "A test command used in development of Raven.", {"testalias"}, {}, function(arguments)
    for i,v in pairs(arguments) do
        Debug("Argument "..i..": "..v)
    end
    Success("Successfully ran the test command!")
end)

local function CreateCommandFrame()
    local Command: Frame = command_frame:Clone()
    local Label: TextLabel = Command:WaitForChild("CommandLabel")

    Command.Parent = commands_scrolling_frame

    return Command, Label
end

AddCMD("cmds", "Gets all commands and displays in in a GUI.", {}, {}, function(_)
    commands_frame.Visible = true

    for _,v: Instance in ipairs(commands_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "CommandFrame" then
            v:Destroy()
        end
    end

    local ModuleAdded = {}
    local BuiltIn = {}
    
    for Name: string, Table: CommandTable in pairs(Commands) do
        local Arguments = ""

        for i, arg in pairs(Table.Arguments) do
            Arguments = Arguments.."["..arg:upper().."]"..(i ~= #Table.Arguments and " " or "")
        end

        if Arguments:len() == 0 then
            Arguments = "None"
        end

        local Aliases = ""

        for i, arg in pairs(Table.Aliases) do
            Aliases = Aliases..arg..(i ~= #Table.Aliases and ", " or "")
        end

        if Aliases:len() == 0 then
            Aliases = "None"
        end

        local Text = Name..": "..Table.Description.." | Arguments: "..Arguments.." | Aliases: "..Aliases.." | BotCommand?: "..(Table.BotCommand and "Yes" or "No")

        if Table.ModuleAdded then
            ModuleAdded[Name] = Text
        else
            BuiltIn[Name] = Text
        end
    end

    local ModuleAddedLen = 0
    for i,v in pairs(ModuleAdded) do
        ModuleAddedLen += 1
    end

    if ModuleAddedLen > 0 then
        local _, _Label = CreateCommandFrame()
        _Label.Text = "Module-Added Commands ("..ModuleAddedLen.." in length):"

        for Name, Text in pairs(ModuleAdded) do
            local Command, Label = CreateCommandFrame()
            Command:AddTag(Name)
            Label.Text = Text
        end

        local _SepFrame, _SepLabel = CreateCommandFrame()
        _SepLabel.Text = ""
        _SepFrame.BackgroundTransparency = 1
    end

    local BuiltInLen = 0
    for i,v in pairs(BuiltIn) do
        BuiltInLen += 1
    end

    local _, _Label = CreateCommandFrame()
    _Label.Text = "Built-In Commands ".."("..BuiltInLen.." in length):"

    for Name, Text in pairs(BuiltIn) do
        local Command, Label = CreateCommandFrame()
        Command:AddTag(Name)
        Label.Text = Text
    end
end)

AddCMD("addalias", "Adds an alias for a command if it does not exist.", {"alias"}, {"command", "new alias"}, function(arguments)
    local CommandName = arguments[1]
    local CommandTable: CommandTable? = CommandName and GetCMD(CommandName:lower())

    local NewAlias = arguments[2]

    if CommandTable and NewAlias then
        table.insert(CommandTable.Aliases, NewAlias:lower())
        
        Success("Added alias.")
    elseif not CommandTable then
        Error("Could not find command.")
    else
        Error("You did not supply a new alias.")
    end
end)

AddCMD("savealiases", "Saves both user-defined and built-in aliases", {}, {}, function(arguments)
    if writefile and appendfile and isfile and readfile then
        if not isfile("RAVEN_SAVED_ALIASES") then
            writefile("RAVEN_SAVED_ALIASES", "")
        end

        local Contents: string = readfile("RAVEN_SAVED_ALIASES")
        local ContentsLines = Contents:split("\n")

        for Name: string, CommandTable: CommandTable in pairs(Commands) do
            if #CommandTable.Aliases > 0 then
                local IsAlreadyInFile = false
                local FileLine = nil

                for i,v in pairs(ContentsLines) do
                    local Split = v:split("=")
                    local Command = Split[1]

                    if Split and #Split >= 1 then
                        if Command == Name then
                            IsAlreadyInFile = true
                            FileLine = i
                            break
                        end
                    end
                end

                if IsAlreadyInFile then
                    table.remove(ContentsLines, FileLine)
                end
                
                local Aliases = ""

                for i, Alias: string in pairs(CommandTable.Aliases) do
                    Aliases = Aliases..Alias..(i ~= #CommandTable.Aliases and ";" or "")
                end

                ContentsLines[#ContentsLines+1] = Name.."="..Aliases
            end
        end

        writefile("RAVEN_SAVED_ALIASES", table.concat(ContentsLines, "\n"))

        Success("Saved aliases.")
    else
        Error("Your exploit does not support writefile/appendfile/isfile/readfile.")
    end
end)

AddCMD("clearsavedaliases", "Deletes the file which saved aliases are in.", {"deletesavedaliases"}, {}, function(arguments)
    if delfile and isfile then
        if isfile("RAVEN_SAVED_ALIASES") then
            delfile("RAVEN_SAVED_ALIASES")

            Success("Deleted saved aliases.")
        else
            Error("The file does not exist. This command might have already been called or you have never saved any aliases.")
        end
    else
        Error("Your exploit does not support delfile/isfile")
    end
end)

local OpenBind = nil
local LastOpenedWithBind = nil

function module:SetOpenBind(key: string?)
    OpenBind = key
end

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        if OpenBind and input.KeyCode.Name:lower() == OpenBind:lower() then
            if not GuiOpen then
                task.spawn(ToggleButtonPressed)

                command_box:CaptureFocus()
                task.wait()
                command_box.Text = ""

                LastOpenedWithBind = tick()
            else
                command_box:CaptureFocus()
                task.wait()
                command_box.Text = ""
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if OpenBind and LastOpenedWithBind then
        if tick() >= LastOpenedWithBind and not command_box:IsFocused() and GuiOpen then
            task.spawn(ToggleButtonPressed)
            LastOpenedWithBind = nil
        elseif command_box:IsFocused() and tick() >= LastOpenedWithBind and GuiOpen then
            LastOpenedWithBind = tick()
        end
    end
end)

AddCMD("setopenbind", "Sets the key to open Raven and focus on the command box.", {}, {"key/none"}, function(arguments)
    local Key = arguments[1]

    local Keycodes = Enum.KeyCode:GetEnumItems()
    local KeycodeNames = {}

    for i,v in pairs(Keycodes) do
        KeycodeNames[#KeycodeNames+1] = v.Name:lower()
    end

    if Key and table.find(KeycodeNames, Key:lower()) then
        OpenBind = Key

        Success("Set open bind.")
    elseif Key then
        Error(Key.." is not a KeyCode. Execute the command \"keycodes\" to see all available keycodes.")
    else
        OpenBind = nil
    end
end)

AddCMD("saveopenbind", "Saves the open bind to a file.", {}, {}, function(arguments)
    if writefile then
        writefile("RAVEN_OPENBIND", OpenBind or "")

        Success("Saved open bind.")
    else
        Error("Your executor does not have writefile.")
    end
end)

local SpinCommand = {}
SpinCommand.Heartbeat = nil
SpinCommand.ToMultiply = {}

local SpinAxes = {
    x = Vector3.new(1,0,0),
    y = Vector3.new(0,1,0),
    z = Vector3.new(0,0,1)
}

AddCMD("spin", "Starts spinning your root in the specified direction.", {}, {"speed", "axis"}, function(arguments)
    local Speed = arguments[1] and tonumber(arguments[1])
    local Axis = arguments[2] and SpinAxes[arguments[2]:lower()]

    if Axis then
        Axis = Axis * Speed
        
        table.insert(SpinCommand.ToMultiply, CFrame.Angles(Axis.X,Axis.Y,Axis.Z))

        if not SpinCommand.Heartbeat then
            SpinCommand.Heartbeat = RunService.Heartbeat:Connect(function(deltaTime)
                local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if Root then
                    for _, Mult in pairs(SpinCommand.ToMultiply) do
                        Root.CFrame *= Mult
                    end
                end
            end)
        end

        Success("Started spinning in that direction.")
    else
        Error("Axis not found. Available axes are 'x','y', and 'z'.")
    end
end)

AddCMD("unspin", "Stops spinning.", {}, {}, function(arguments)
    if SpinCommand.Heartbeat then
        SpinCommand.Heartbeat:Disconnect()
        SpinCommand.Heartbeat = nil
    end

    table.clear(SpinCommand.ToMultiply)

    Success("Cleared all spin tasks.")
end)

AddCMD("keycodes", "Shows all available keycodes.", {}, {}, function(arguments)
    Output(Enum.KeyCode:GetEnumItems())
end)

AddCMD("clearnotifs","Clears all notifications", {}, {}, function(arguments)
    for _,v in ipairs(notifications_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "NotificationFrame" then
            local Status = v:FindFirstChild("StatusFrame")
            local Text = v:FindFirstChild("NotificationText")

            if Status and Text then
                task.spawn(CloseNotification, v, Status, Text)
            end
        end
    end
end)

AddCMD("findplayer", "Finds a player based on a key or keys.", {}, {"key"}, function(arguments)
    local Found = FindPlayers(unpack(arguments))

    for _,v in pairs(Found) do
        Info("Found player "..v.Name)
    end
end)

AddCMD("getselectors", "Gets all player selectors and displays it in a GUI.", {}, {}, function(arguments)
    local Selectors = {}

    for Name, _ in pairs(PlayerSelectors) do
        Selectors[#Selectors+1] = Name
    end

    Output(Selectors)
end)

AddCMD("tptool", "A tool that teleports you to your mouse.", {}, {}, function(arguments)
	local Tool: Tool = Instance.new("Tool", LocalPlayer.Backpack)
	Tool.RequiresHandle = false
	Tool.Name = "Teleport"
	Tool.ToolTip = "Raven Base's teleport tool"

    local MousePart = Instance.new("Part", GetCoreGui())
    MousePart.Name = "RavenMouse"
    MousePart.Color = Color3.fromRGB(126, 42, 223)
    MousePart.Anchored = true
    MousePart.CanCollide = false
    MousePart.CanQuery = false
    MousePart.CanTouch = false
    MousePart.Shape = Enum.PartType.Ball
    MousePart.Size = Vector3.new(.5,.5,.5)

    local Highlight = Instance.new("Highlight", MousePart)
    Highlight.Adornee = MousePart
    Highlight.OutlineColor = Color3.fromRGB(126, 42, 223)
    Highlight.FillColor = Color3.fromRGB(126, 42, 223)
    Highlight.FillTransparency = 0
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	
	local Activated; Activated = Tool.Activated:Connect(function()
		local Mouse = LocalPlayer:GetMouse()
		local Character = LocalPlayer.Character
		local Root: BasePart? = Character and Character:FindFirstChild("HumanoidRootPart")
		
		if Root and Mouse.Target then Root.CFrame = Mouse.Hit end
	end)
	
	local Holding = false
	
	local Equipped = Tool.Equipped:Connect(function()
		Holding = true
	end)
	
	local Unequipped = Tool.Unequipped:Connect(function()
		Holding = false

        if MousePart.Parent then
            MousePart.Parent = GetCoreGui()
        end
	end)

    local RenderStepped = RunService.RenderStepped:Connect(function(_)
        if Holding then
            local Mouse = LocalPlayer:GetMouse()

            if Mouse.Target then
                if MousePart.Parent ~= workspace then
                    MousePart.Parent = workspace
                end

                MousePart.CFrame = Mouse.Hit
            else
                MousePart.Parent = GetCoreGui()
            end
        end
    end)
	
	local AncestryChanged; AncestryChanged = Tool.AncestryChanged:Connect(function(child, parent)
		if child == Tool and parent == workspace or not parent then
			Activated:Disconnect()
			AncestryChanged:Disconnect()
			Unequipped:Disconnect()
			Equipped:Disconnect()
            RenderStepped:Disconnect()
			Tool:Destroy()
            MousePart:Destroy()
		end
	end)
end)

AddCMD("reset", "Sets the Humanoid state to Dead.", {}, {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    else
        Error("Couldn't find Humanoid/Character.")
    end
end)

AddCMD("view", "Views a player.", {}, {"player"}, function(arguments)
    local Player = arguments and arguments[1]
    local Targets = Player and FindPlayers(Player)
    local Target = Targets and Targets[1]

    if Target and workspace.CurrentCamera then
        local Character = Target.Character
        local Humanoid = Character and Character:FindFirstChild("Humanoid")

        if Humanoid then
            workspace.CurrentCamera.CameraSubject = Humanoid
        end
    end
end)

AddCMD("unview", "Sets the camera to your Humanoid.", {"fixcam"}, {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid and workspace.CurrentCamera then
        workspace.CurrentCamera.CameraSubject = Humanoid
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end)

AddCMD("rejoin", "Rejoins the game.", {"rj"}, {}, function(arguments)
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local Succ
    local Err

    if #Players:GetPlayers() > 1 then
        Succ, Err = pcall(function() TeleportService:TeleportToPlaceInstance(PlaceId, JobId) end)
    else
        Succ, Err = pcall(function() TeleportService:Teleport(game.PlaceId) end)
        LocalPlayer:Kick()
    end

    if not Succ and Err ~= nil and tostring(Err) then
        Error("Error: "..Err)
    else
        Success("Rejoining..")
    end
end)

AddCMD("rejoincode", "Gets the rejoin code and copies it to clipboard.", {}, {}, function(arguments)
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    if CanAccessCoreGui and setclipboard then
        setclipboard(
            "game:GetService(\"TeleportService\"):TeleportToPlaceInstance("..PlaceId..",\""..JobId.."\")"
        )
        Success("Copied rejoin code to clipboard!")
    end
end)

AddCMD("copypos", "Copies the position of a player's root to your clipboard.", {"getpos"}, {"player"}, function(arguments)
    if setclipboard then
        local Targets = FindPlayers(arguments[1])

        if #Targets >= 1 then
            local Target = Targets[1]
            local Root: BasePart? = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                setclipboard(Root.Position.X.." "..Root.Position.Y.." "..Root.Position.Z)

                Success("Copied position to clipboard.")
            else
                Error("Couldn't find player's character/root.")
            end
        else
            Error("Couldn't find player.")
        end
    else
        Error("Your executor does not support setclipboard.")
    end
end)

AddCMD("god", "Disables the Dead state of the Humanoid. May not work in some games.", {}, {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        Success("Turned godmode on.")
    end
end)

AddCMD("ungod", "Enables the Dead state of the Humanoid.", {}, {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        Success("Turned godmode off.")
    end
end)

AddCMD("exit", "Exits the game.", {}, {}, function(arguments)
    game:Shutdown()
end)

AddCMD("goto", "Goes to a player.", {}, {"player"}, function(arguments)
    local Targets = arguments and FindPlayers(unpack(arguments))

    if Targets and #Targets >= 1 then
        local Target = Targets[1]
        local TRoot = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if TRoot and Root then
            Root.CFrame = TRoot.CFrame
        end
    end
end)

local EspPlayers = {}

local function InitEspFolder(): Folder
    local Folder = GetCoreGui():FindFirstChild("RAVEN_ESP")
    if not Folder then
        Folder = Instance.new("Folder", GetCoreGui())
        Folder.Name = "RAVEN_ESP"
    end

    return Folder
end

local function InitEspPlayerFolder(player: Player, espFolder: Folder)
    local Folder = espFolder:FindFirstChild(player.Name)

    if not Folder then
        Folder = Instance.new("Folder", espFolder)
        Folder.Name = player.Name
    end

    return Folder
end

local function IsEspPart(part: BasePart)
    for _, Table in pairs(EspPlayers) do
        for Part, _ in pairs(Table.Parts) do
            if Part and Part.Parent and Part == part then
                return true
            end
        end
    end

    return false
end

local function PlayerHasEsp(player: Player)
    for Player, Table in pairs(EspPlayers) do
        if Player == player then
            return true
        end
    end

    return false
end

local function DestroyEspPart(part: Part, player: Player, Table)
    if PlayerHasEsp(player) and IsEspPart(part) then
        if Table.Box then
            Table.Box:Destroy()
        end
        if Table.SizeChanged then
            Table.SizeChanged:Disconnect()
        end

        EspPlayers[player].Parts[part] = nil

        return true
    end

    return false
end

local function DestroyEspPlayer(player: Player, disconnectCharacterAdded: boolean)
    if EspPlayers[player] then
        if EspPlayers[player].TeamChanged then
            EspPlayers[player].TeamChanged:Disconnect()
        end

        if EspPlayers[player].BillboardGui then
            EspPlayers[player].BillboardGui:Destroy()
        end

        if EspPlayers[player].TextLabel then
            EspPlayers[player].TextLabel:Destroy()
        end

        if EspPlayers[player].HeadSizeChanged then
            EspPlayers[player].HeadSizeChanged:Disconnect()
        end

        if EspPlayers[player].HealthChanged then
            EspPlayers[player].HealthChanged:Disconnect()
        end

        if EspPlayers[player].CharacterAdded and disconnectCharacterAdded then
            EspPlayers[player].CharacterAdded:Disconnect()
        end

        for Part, Table in pairs(EspPlayers[player].Parts) do
            DestroyEspPart(Part, player, Table)
        end

        local EspFolder = GetCoreGui():FindFirstChild("RAVEN_ESP")
        local PlayerFolder = EspFolder:FindFirstChild(player.Name)

        if PlayerFolder then
            PlayerFolder:Destroy()
        end
    end
end

local function InitEsp(player: Player, character: Model)
    local EspFolder = InitEspFolder()
    local Folder = InitEspPlayerFolder(player, EspFolder)

    local Head: BasePart? = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    local Humanoid: Humanoid? = character:FindFirstChild("Humanoid")

    EspPlayers[player] = {}
    EspPlayers[player].Parts = {}

    if Head and Humanoid then
        local BillboardGui = Instance.new("BillboardGui", Folder)
        EspPlayers[player].BillboardGui = BillboardGui
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Adornee = Head
        BillboardGui.StudsOffset = Vector3.new(0, Head.Size.Y * 2, 0)
        BillboardGui.ResetOnSpawn = false
        BillboardGui.Size = UDim2.fromOffset(300, 50)

        local TextLabel = Instance.new("TextLabel", BillboardGui)
        EspPlayers[player].TextLabel = TextLabel
        TextLabel.BackgroundTransparency = 1
        TextLabel.FontFace = Font.fromEnum(Enum.Font.Arimo)
        TextLabel.TextStrokeTransparency = .5
        TextLabel.TextStrokeColor3 = Color3.fromRGB(126, 42, 223)
        TextLabel.RichText = true
        TextLabel.TextScaled = true
        TextLabel.Size = UDim2.fromScale(1,1)
        TextLabel.Text = "Username: "..player.Name.." | DisplayName: "..player.DisplayName.." | Health: 100"

        EspPlayers[player].HeadSizeChanged = Head:GetPropertyChangedSignal("Size"):Connect(function()
            BillboardGui.StudsOffset = Vector3.new(0, Head.Size.Y * 2, 0)
        end)

        EspPlayers[player].HealthChanged = Humanoid.HealthChanged:Connect(function(_)
            TextLabel.Text = "Username: "..player.Name.." | DisplayName: "..player.DisplayName.." | Health: "..Humanoid.Health
        end)
    end


    for i,v: BasePart in ipairs(character:GetDescendants()) do
        if v:IsA("BasePart") and not IsEspPart(v) then
            local BoxHandleAdornment: BoxHandleAdornment = Instance.new("BoxHandleAdornment", Folder)
            BoxHandleAdornment.Adornee = v
            BoxHandleAdornment.AlwaysOnTop = true
            BoxHandleAdornment.Color3 = player.Team and player.TeamColor.Color or Color3.fromRGB(126, 42, 223)
            BoxHandleAdornment.Transparency = .5
            BoxHandleAdornment.ZIndex = 10

            EspPlayers[player].Parts[v] = {}

            EspPlayers[player].Parts[v].Box = BoxHandleAdornment

            EspPlayers[player].Parts[v].SizeChanged = v:GetPropertyChangedSignal("Size"):Connect(function()
                if PlayerHasEsp(player) and IsEspPart(v) and BoxHandleAdornment.Parent then
                    BoxHandleAdornment.Size = v.Size
                elseif IsEspPart(v) then
                    DestroyEspPart(v, player)
                end
            end)
        end
    end

    EspPlayers[player].TeamChanged = player:GetPropertyChangedSignal("Team"):Connect(function()
        if PlayerHasEsp(player) then
            for _, Table in pairs(EspPlayers[player].Parts) do
                Table.Box.Color3 = player.Team and player.TeamColor.Color or Color3.fromRGB(126, 42, 223)
            end
        end
    end)
end

AddCMD("esp", "Enables ESP, which allows you to see players through walls.", {}, {"player"}, function(arguments)
    local Targets = arguments and FindPlayers(unpack(arguments))

    if Targets and #Targets > 0 then
        for _,Target: Player in pairs(Targets) do
            if PlayerHasEsp(Target) then
                DestroyEspPlayer(Target)
            end
            
            if Target.Character then
                InitEsp(Target, Target.Character)
            end

            EspPlayers[Target].CharacterAdded = Target.CharacterAdded:Connect(function(character)
                DestroyEspPlayer(Target, false)

                task.wait(.5)

                InitEsp(Target, character)
            end)
        end
    end
end)

AddCMD("unesp", "Disables ESP", {}, {}, function(arguments)
    for Player, Table in pairs(EspPlayers) do
        DestroyEspPlayer(Player, true)

        
    end

    local EspFolder = GetCoreGui():FindFirstChild("RAVEN_ESP")

    if EspFolder then
        EspFolder:ClearAllChildren()
    end

    table.clear(EspPlayers)
end)

local Fling = {}
Fling.FlingCon = nil
Fling.OgCFrame = nil
Fling.LinearVelocity = nil
Fling.Attachment0 = nil

local function ReadjustAfterFling(root: BasePart, humanoid: Humanoid?)
    local BeforeReadjusting = tick()

    if humanoid and workspace.CurrentCamera then
        workspace.CurrentCamera.CameraSubject = humanoid
    end

    local Correct = 0

    repeat task.wait()
        root.AssemblyLinearVelocity = Vector3.new(0,0,0)
        root.AssemblyAngularVelocity = Vector3.new(0,0,0)
        root.CFrame = Fling.OgCFrame

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Seated)
        end
        task.wait()
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        if (root.Position - Fling.OgCFrame.Position).Magnitude < 3 then
            Correct += 1
        end
    until Correct > 100 or tick() > BeforeReadjusting + 10
    Success("Stopped readjusting.")
end

local FlingOffsets = {
    CFrame.new(0, 0, 1),
    CFrame.new(1, 0, 1),
    CFrame.new(0, 0, 0),
    CFrame.new(-1, 0, -1),
    CFrame.new(1, 0, -1),
    CFrame.new(-1, 0, 1),
    CFrame.new(0, 0, 2),
    CFrame.new(0, 0, -2),
    CFrame.new(0, 0, 3),
    CFrame.new(0, 0, -3)
}

AddCMD("fling", "Flings a player.", {}, {"player"}, function(arguments)
    if not Fling.Flinging then
        local Targets = FindPlayers(unpack(arguments))

        if #Targets > 0 then
            Fling.Flinging = true

            local TargetIndex = 1
            local OffsetIndex = 0
            local Angle = CFrame.Angles(0,0,0)

            Fling.FlingCon = RunService.Heartbeat:Connect(function()
                local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if Root then
                    if not Fling.OgCFrame then
                        Fling.OgCFrame = Root.CFrame
                    end

                    if not Exists(Fling.LinearVelocity) then
                        Fling.LinearVelocity = Instance.new("LinearVelocity", Root)
                        
                        if Exists(Fling.Attachment0) then
                            Fling.Attachment0:Destroy()
                        end

                        Fling.Attachment0 = Instance.new("Attachment", Root)

                        Fling.LinearVelocity.Attachment0 = Fling.Attachment0
                        Fling.LinearVelocity.MaxForce = math.huge
                        Fling.LinearVelocity.VectorVelocity = Vector3.new(9e9,9e9,9e9)
                    end
                    Angle *= CFrame.Angles(30,30,30)

                    OffsetIndex += 1
                    if OffsetIndex > #FlingOffsets then
                        OffsetIndex = 1
                    end

                    local Target = Targets[TargetIndex]

                    local TRoot = Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
                    local THum = Target and Target.Character and Target.Character:FindFirstChildWhichIsA("Humanoid")

                    if TRoot and (#Targets > 1 and TRoot.AssemblyLinearVelocity.Magnitude < 300 or #Targets == 1) then
                        if THum then
                            Root.CFrame = TRoot.CFrame * CFrame.new(THum.MoveDirection * TRoot.AssemblyLinearVelocity.Magnitude / 1.2) * FlingOffsets[OffsetIndex] * Angle
                        else
                            Root.CFrame = TRoot.CFrame * FlingOffsets[OffsetIndex] * Angle
                        end

                        if THum and workspace.CurrentCamera then
                            workspace.CurrentCamera.CameraSubject = THum
                        end
                    elseif not Exists(Target) and #Targets == 1 then
                        Info("Player left.")

                        RunCMD("unfling", {})
                        return
                    else
                        if TargetIndex == #Targets then
                            TargetIndex = 1
                        else
                            TargetIndex += 1
                        end
                    end
                end
            end)

            Success("Started flinging.")
        end
    else
        Error("You are already flinging someone.")
    end
end)

AddCMD("unfling", "Stops flinging all targets.", {}, {}, function(arguments)
    if Fling.Flinging then
        if Fling.FlingCon then
            Fling.FlingCon:Disconnect()
        end
        if Exists(Fling.Attachment0) then
            Fling.Attachment0:Destroy()
        end
        if Exists(Fling.LinearVelocity) then
            Fling.LinearVelocity:Destroy()
        end

        Fling.Flinging = false

        Success("Stopped flinging. Readjusting to original position if you have a root.")

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Root then
            local Humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            ReadjustAfterFling(Root, Humanoid)
        end
    else
        Error("You are not flinging anyone.")
    end
end)

local Touchfling = {}
Touchfling.Enabled = false
Touchfling.Heartbeat = nil

AddCMD("touchfling", "Flings everyone who touches your character without having to teleport.", {"walkfling","hiddenfling"}, {"power (number/none)"}, function(arguments)
    if not Touchfling.Enabled then
        local Power = arguments[1] and tonumber(arguments[1]) or 10e4

        if Power and Power > 0 then
            Touchfling.Enabled = true

            Touchfling.Heartbeat = RunService.Heartbeat:Connect(function()
                local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if Root then
                    local LastVelocity = Root.AssemblyLinearVelocity

                    Root.AssemblyLinearVelocity = LastVelocity * Vector3.new(Power,Power,Power)

                    RunService.RenderStepped:Wait()

                    Root.AssemblyLinearVelocity = LastVelocity
                end
            end)

            Success("Enabled touchfling.")
        else
            Error("You cannot have a negative power.")
        end
    else
        Error("You are already using touchfling. Try using \"untouchfling\".")
    end
end)

AddCMD("untouchfling", "Stops touchfling.", {"unwalkfling","unhiddenfling"}, {}, function(arguments)
    if Touchfling.Enabled then
        Touchfling.Heartbeat:Disconnect()
        Touchfling.Enabled = false

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Root then
            local Correct = 0

            Info("Stabilizing root's velocity..")

            repeat task.wait()
                Root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                Root.AssemblyAngularVelocity = Vector3.new(0,0,0)

                if Root.AssemblyLinearVelocity.Magnitude < 1 then
                    Correct += 1
                end
            until Correct > 25

            Success("Done.")
        end

        Success("Disabled touchfling.")
    else
        Error("Touchfling is already off.")
    end
end)

AddCMD("refresh", "Resets your character and then teleports you back to your original position.", {}, {}, function(arguments)
    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root and Humanoid then
        Info("Refreshing.")

        local OgCF = Root.CFrame
        Humanoid.Health = 0
        
        local Character = LocalPlayer.CharacterAdded:Wait()
        Character:WaitForChild("HumanoidRootPart").CFrame = OgCF

        Success("Refreshed.")
    else
        Error("Couldn't find Root/Humanoid.")
    end
end)

AddCMD("freeze", "Anchors your root.", {"fr"}, {}, function(arguments)
    local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root then
        Root.Anchored = true
    end
end)

AddCMD("unfreeze", "Unanchors your root.", {"unfr"}, {}, function(arguments)
    local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root then
        Root.Anchored = false
    end
end)

module.BringUA = {}

local BringUAModes = {}

local function GetUAMode(name: string)
    return BringUAModes[name]
end

function module.BringUA:GetUAMode(...)
    return GetUAMode(...)
end

local function AddUAMode(name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> (), initFunction: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> ())
    if GetUAMode(name:lower()) then
        Error("Couldn't add UA mode. \""..name.."\" already exists!")
    else
        local Table = {}
        Table.Function = func
        Table.Description = description
        Table.Init = initFunction

        BringUAModes[name:lower()] = Table
    end
end

function module.BringUA:AddUAMode(...)
    return AddUAMode(...)
end

local function ReplaceUAMode(name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> (), initFunction: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> ())
    local Table = GetUAMode(name)
    if Table then
        BringUAModes[name] = nil
        
        AddUAMode(name, description, func)

        return true
    else
        Error("Cannot replace UAMode \""..name.."\"! It does not exist.")

        return false
    end
end

function module.BringUA:ReplaceUAMode(...)
    return ReplaceUAMode(...)
end

local function RandomAngle()
    return CFrame.Angles(math.rad(math.random(-360, 360)),math.rad(math.random(-360, 360)),math.rad(math.random(-360, 360))) 
end

AddUAMode("normal", "The normal BringUA mode. Brings all of the parts to the position.", function(positionForce, orientationForce, center, _, _, part)
    positionForce.Position = center
    orientationForce.CFrame = CFrame.new(Vector3.zero, center)

    part.CanCollide = false
end, function(positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number)
    positionForce.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
    positionForce.MaxForce = math.huge
    positionForce.MaxVelocity = math.huge

    orientationForce.MaxAngularVelocity = math.huge
    orientationForce.MaxTorque = math.huge

    positionForce.RigidityEnabled = true
    orientationForce.RigidityEnabled = true
end)

AddUAMode("circle", "Arranges all of the parts in a circle.", function(positionForce, orientationForce, center, parts, partIndex, part, persistentVars, size, speed)
    local NumOfParts = 0

    for _ in pairs(parts) do
        NumOfParts += 1
    end

    local Circle = math.pi * 2
    local Angle = partIndex * (Circle / NumOfParts) + math.rad(persistentVars.Rotation)

    local X = math.cos(Angle) * size
    local Z = math.sin(Angle) * size

    local Cf = CFrame.new(center + Vector3.new(X, 0, Z), center)

    positionForce.Position = Cf.Position
    orientationForce.CFrame = Cf.Rotation

    persistentVars.Rotation += speed ~= 0 and speed or .1

    part.CanCollide = false
end, function(positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number)
    positionForce.MaxForce = math.huge
    positionForce.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
    positionForce.MaxVelocity = math.huge

    positionForce.Responsiveness = 30

    orientationForce.MaxAngularVelocity = math.huge
    orientationForce.MaxTorque = math.huge

    orientationForce.RigidityEnabled = true

    persistentVars.Rotation = 0
end)

AddUAMode("blackhole", "Arranges all of the parts in a layered circle.", function(positionForce, orientationForce, center, parts, partIndex, part, persistentVars, size, speed)
    if not persistentVars.Layer[part] then
        local Random = Random.new()
        persistentVars.Layer[part] = Random:NextInteger(0, size / 1.3)
    end

    local NumOfParts = 0

    for _ in pairs(parts) do
        NumOfParts += 1
    end

    local Circle = math.pi * 2
    local Angle = partIndex * (Circle / NumOfParts) + math.rad(persistentVars.Rotation)

    local X = math.cos(Angle) * (size - persistentVars.Layer[part])
    local Z = math.sin(Angle) * (size - persistentVars.Layer[part])

    local Cf = CFrame.new(center + Vector3.new(X, 0, Z), center)

    positionForce.Position = Cf.Position
    orientationForce.CFrame = Cf.Rotation

    persistentVars.Rotation += speed ~= 0 and speed or .1

    part.CanCollide = false
end, function(positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number)
    positionForce.MaxForce = math.huge
    positionForce.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
    positionForce.MaxVelocity = math.huge

    positionForce.Responsiveness = 30

    orientationForce.MaxAngularVelocity = math.huge
    orientationForce.MaxTorque = math.huge

    orientationForce.RigidityEnabled = true

    persistentVars.Rotation = 0

    persistentVars.Layer = {}
end)

AddUAMode("rotating", "Like normal but the parts rotate.", function(positionForce, orientationForce, center, _, _, part, persistentVars, _, speed)
    if not persistentVars[part] then
        persistentVars[part] = RandomAngle()
    end
    
    positionForce.Position = center
    orientationForce.CFrame = persistentVars[part]

    persistentVars[part] *= CFrame.Angles(speed,speed,speed)

    part.CanCollide = false
end, function(positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number)
    positionForce.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
    positionForce.MaxForce = math.huge
    positionForce.MaxVelocity = math.huge

    orientationForce.MaxAngularVelocity = math.huge
    orientationForce.MaxTorque = math.huge

    positionForce.RigidityEnabled = true
    orientationForce.RigidityEnabled = true
end)

local function FibonacciSpiralSpheres(Points: number)
	local Vectors = {}
	local GR = (math.sqrt(5) + 1) / 2
	local GA = (2 - GR) * (2 * math.pi)
	
	for i = 1, Points do
		local Lat = math.asin(-1 + 2 * i / (Points + 1))
		local Lon = GA * i
		
		local X = math.cos(Lon) * math.cos(Lat)
		local Y = math.sin(Lon) * math.cos(Lat)
		local Z = math.sin(Lat)
		
		table.insert(Vectors, Vector3.new(X, Y, Z))
	end
	
	return Vectors
end

AddUAMode("sphere", "Surrounds the center with a sphere of parts.", function(positionForce, orientationForce, center, parts, partIndex, part, persistentVars, size, speed)
    if not persistentVars.Angle[part] then
        persistentVars.Angle[part] = RandomAngle()
    end

    local NumOfParts = 0

    for _ in pairs(parts) do
        NumOfParts += 1
    end

    local Sphere = FibonacciSpiralSpheres(NumOfParts)

    local Position = center + Sphere[partIndex].Unit * size

    positionForce.Position = Position
    orientationForce.CFrame = persistentVars.Angle[part]

    part.CanCollide = false

    persistentVars.Angle[part] *= CFrame.Angles(speed, speed, speed)
end, function(positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number)
    positionForce.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
    positionForce.MaxForce = math.huge
    positionForce.MaxVelocity = math.huge

    orientationForce.MaxAngularVelocity = math.huge
    orientationForce.MaxTorque = math.huge

    positionForce.RigidityEnabled = true
    orientationForce.RigidityEnabled = true

    persistentVars.Angle = {}
end)

AddCMD("listuamodes", "Lists all BringUA modes.", {}, {}, function(arguments)
    local data = {}

    for Name, Table in pairs(BringUAModes) do
        data[#data+1] = Name..": "..Table.Description
    end

    Output(data)
end)

local BringUA = {}
BringUA.Enabled = false
BringUA.Heartbeat = nil
BringUA.Parts = {}

AddCMD("bringua", "Brings unanchored parts using the specified center and mode.", {"unbringunanchored"}, {"player","mode","size","speed","center x","center y","center z"}, function(arguments)
    local Targets = arguments[1] and FindPlayers(arguments[1])
    local Target = Targets and #Targets > 0 and Targets[1]

    local Mode = arguments[2]
    local Size = arguments[3] and tonumber(arguments[3])
    Size = Size ~= 0 and Size or 25
    local Speed = arguments[4] and tonumber(arguments[4])
    local X,Y,Z = arguments[5] and tonumber(arguments[5]),arguments[6] and tonumber(arguments[6]),arguments[7] and tonumber(arguments[7])

    if Target and Mode and Size and Size >= 0 and Speed and Speed >= 0 then
        local CenterSpecified = X and Y and Z
        X,Y,Z = CenterSpecified and tonumber(X), CenterSpecified and tonumber(Y), CenterSpecified and tonumber(Z)
        local Center = X and Y and Z and Vector3.new(X,Y,Z)

        Mode = GetUAMode(Mode)

        if Mode then
            if BringUA.Enabled then
                RunCMD("unbringua", {})
                task.wait()
            end

            BringUA.Enabled = true

            local Persistent = {}

            BringUA.Heartbeat = RunService.Heartbeat:Connect(function()
                local Character: Model? = Target.Character
                local Root: BasePart? = Character and Target.Character:FindFirstChild("HumanoidRootPart")

                if Root then
                    for _, v: Part | MeshPart in ipairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(Character) then
                            if v.Parent:FindFirstChildWhichIsA("Humanoid") then continue end

                            if not BringUA.Parts[v] then
                                BringUA.Parts[v] = {}

                                local Index = 1
                                for Part, _ in pairs(BringUA.Parts) do
                                    if Part == v then break end
                                    Index += 1
                                end

                                local AlignPosition, AlignOrientation = Instance.new("AlignPosition", v), Instance.new("AlignOrientation", v)
                                local Attachment0 = Instance.new("Attachment", v)

                                BringUA.Parts[v].AlignPosition = AlignPosition
                                BringUA.Parts[v].AlignOrientation = AlignOrientation
                                BringUA.Parts[v].Attachment0 = Attachment0
                                BringUA.Parts[v].Index = Index

                                AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
                                AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment

                                AlignPosition.Attachment0 = Attachment0
                                AlignOrientation.Attachment0 = Attachment0

                                BringUA.Parts[v].Initialized = true

                                Mode.Init(
                                    AlignPosition,
                                    AlignOrientation,
                                    Center or Root.Position,
                                    BringUA.Parts,
                                    Index,
                                    v,
                                    Persistent,
                                    Size,
                                    Speed
                                )
                            end
                        end
                    end

                    for Part, Table in pairs(BringUA.Parts) do
                        if not Exists(Part) then
                            BringUA.Parts[Part] = nil
                            continue
                        end
                        
                        Mode.Function(
                            Table.AlignPosition,
                            Table.AlignOrientation,
                            Center or Root.Position,
                            BringUA.Parts,
                            Table.Index,
                            Part,
                            Persistent,
                            Size,
                            Speed
                        )
                    end
                end
            end)

            Success("Enabled BringUA.")
        else
            Error("Couldn't find specified mode. You can list modes with \"listuamodes\".")
        end
    elseif not Target then
        Error("Couldn't find target player.")
    elseif not Mode then
        Error("No mode specified. You can list modes with \"listuamodes\".")
    elseif not Size then
        Error("No size specified. Please specify a size, some modes may need it.")
    elseif Size < 0 then
        Error("You cannot have a negative size.")
    elseif not Speed then
        Error("No speed specified. Please specify a speed, some modes may need it.")
    elseif Speed < 0 then
        Error("You cannot have a negative speed.")
    end
end)

AddCMD("unbringua", "Stops bringing unanchored parts.", {"unbringunanchored"}, {}, function(arguments)
    if BringUA.Enabled then
        BringUA.Enabled = false

        for Part, Table in pairs(BringUA.Parts) do
            if Table.AlignPosition then
                Table.AlignPosition:Destroy()
            end
            if Table.AlignOrientation then
                Table.AlignOrientation:Destroy()
            end
            if Table.Attachment0 then
                Table.Attachment0:Destroy()
            end

            Part.CanCollide = true
        end

        table.clear(BringUA.Parts)

        if BringUA.Heartbeat then
            BringUA.Heartbeat:Disconnect()
        end

        Success("Disabled BringUA.")
    else
        Error("BringUA is already disabled.")
    end
end)

AddCMD("invisicam", "Activates the invisicam occlusion module.", {"inviscam"}, {}, function(arguments)
    LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
end)

AddCMD("uninvisicam", "Activates the invisicam occlusion module.", {"viscam"}, {}, function(arguments)
    LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
end)

local NetBypass = {}
NetBypass.Enabled = false
NetBypass.RenderStepped = nil

AddCMD("netbypass", "Constantly changes your simulationradius to math.huge.", {}, {}, function(arguments)
    if not NetBypass.Enabled then
        local setsimulationradius = setsimulationradius or function(n)
            LocalPlayer.SimulationRadius = n
        end
        NetBypass.Enabled = true

        NetBypass.RenderStepped = RunService.RenderStepped:Connect(function()
            setsimulationradius(math.huge)
        end)

        Success("Enabled netbypass.")
    else
        Error("Netbypass is already enabled.")
    end
end)

AddCMD("hiddensay", "Says something but in the system channel", {"hsay", "h"}, {"message"}, function(arguments)
    local Message = #arguments > 0 and table.concat(arguments, "")
    if Message then Say(Message, true) end
end)

AddCMD("unnetbypass", "Disables netbypass.", {}, {}, function(arguments)
    if NetBypass.Enabled then
        NetBypass.Enabled = false

        if NetBypass.RenderStepped then
            NetBypass.RenderStepped:Disconnect()
        end

        Success("Disabled netbypass.")
    else
        Error("Netbypass is already disabled.")
    end
end)

local NoVelocity = false

AddCMD("novelocity", "Repeatedly sets your root velocity to 0.", {}, {}, function(arguments)
    if NoVelocity then Error("Novelocity is already on."); return end
    NoVelocity = true

    Success("Turned novelocity on.")
    while NoVelocity do
        task.wait()
        local Root: BasePart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Root then
            Root.AssemblyLinearVelocity = Vector3.new(0,0,0)
            Root.AssemblyAngularVelocity = Vector3.new(0,0,0)
        end
    end
end)

AddCMD("yesvelocity", "Disables novelocity.", {}, {}, function(arguments)
    if not NoVelocity then Error("Novelocity is already off."); return end
    NoVelocity = false
    Success("Turned novelocity off.")
end)

local Spam = false

AddCMD("spam", "Spams a message every specified interval", {}, {"hidden (true/false)","interval","message"}, function(arguments)
    local Hidden = ToBool(arguments[1])
    local Interval = arguments[2] and tonumber(arguments[2])
    local Message = {}
    table.move(arguments, 3, #arguments, 1, Message)

    if Interval and #Message > 0 then
        Message = table.concat(Message, " ")

        Spam = true

        while Spam do
            task.wait(Interval)

            Say(Message, Hidden)
        end
    elseif not Interval then
        Error("No interval (number) supplied.")
    elseif #Message == 0 then
        Error("No message supplied.")
    end
end)

AddCMD("unspam", "Stops spamming.", {}, {}, function(arguments)
    if Spam then
        Spam = false

        Success("Stopped spamming.")
    else
        Error("You are not spamming.")
    end
end)

local NoclipCon = nil

AddCMD("noclip", "Noclips your character.", {}, {}, function(arguments)
    if not NoclipCon then
        NoclipCon = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            
            if Character then
                for i,v in ipairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)

        Success("Turned noclip on.")
    else
        Error("Noclip is already on.")
    end
end)

AddCMD("clip", "Stops noclipping.", {}, {}, function(arguments)
    if NoclipCon then
        NoclipCon:Disconnect()
        NoclipCon = nil

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Root then
            Root.CanCollide = true
        end

        Success("Turned noclip off.")
    else
        Error("Noclip is already off.")
    end
end)

AddCMD("ws", "Changes your walkspeed.", {}, {"speed"}, function(arguments)
    local Speed = arguments[1] and tonumber(arguments[1]) or 16

    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

    if Humanoid then
        Humanoid.WalkSpeed = Speed
    end
end)

AddCMD("jp", "Changes your jumppower.", {}, {"power"}, function(arguments)
    local Power = arguments[1] and tonumber(arguments[1]) or 50

    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

    if Humanoid then
        if Humanoid.UseJumpPower then
            Humanoid.JumpPower = Power
        else
            Humanoid.JumpHeight = Power
        end
    end
end)

local Invisible = {}
Invisible.InvisibleHighlights = {}

AddCMD("invisible", "Makes your character invisible to others", {}, {}, function(arguments)
    if not Invisible.Enabled then
        local Character: Model? = LocalPlayer.Character
        local Root: BasePart? = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid: Humanoid? = Character:FindFirstChildWhichIsA("Humanoid")
        local Torso: BasePart? = Humanoid.RigType == Enum.HumanoidRigType.R15 and Character:FindFirstChild("UpperTorso")
        local LowerTorso: BasePart? = Humanoid.RigType == Enum.HumanoidRigType.R15 and Character:FindFirstChild("LowerTorso")

        if Root and Humanoid and Humanoid.Health > 0 then
            if Humanoid.RigType == Enum.HumanoidRigType.R15 and (not Torso or not LowerTorso) then
                Error("Couldn't find torso.")
                return
            end

            Invisible.Enabled = true

            Root.Archivable = true

            local OGCFrame = Root.CFrame

            Character:PivotTo(CFrame.new(0,15e15,0))
            task.wait(.3)

            Root.Parent = ReplicatedStorage
            Invisible.InvisibleRoot = Root

            local CRoot: BasePart = Root:Clone()
            CRoot.Parent = Character

            Invisible.InvisibleCRoot = CRoot
            Invisible.InvisibleCharacter = Character

            task.wait(.1)

            repeat task.wait()
                CRoot.AssemblyAngularVelocity = Vector3.zero
                CRoot.AssemblyLinearVelocity = Vector3.zero

                Character:PivotTo(OGCFrame)
                CRoot.CFrame = OGCFrame
            until (CRoot.Position - OGCFrame.Position).Magnitude < 1

            if Humanoid.RigType == Enum.HumanoidRigType.R15 then
                local AlignPosition = Instance.new("AlignPosition", CRoot)
                AlignPosition.RigidityEnabled = true
                AlignPosition.ReactionForceEnabled = true

                local AlignOrientation = Instance.new("AlignOrientation", Torso)
                AlignOrientation.RigidityEnabled = true

                local Attachment = Instance.new("Attachment", Torso)
                local Attachment2 = Instance.new("Attachment", CRoot)

                Invisible.TorsoForce = AlignPosition
                Invisible.TorsoAttachment = Attachment
                Invisible.CRootAttachment = Attachment2

                AlignPosition.Attachment0 = Attachment
                AlignPosition.Attachment1 = Attachment2

                AlignOrientation.Attachment0 = Attachment
                AlignOrientation.Attachment1 = Attachment2

                Invisible.TorsoOrientation = AlignOrientation

                local NoGettingUp = false

                Invisible.TorsoHeartbeat = RunService.Heartbeat:Connect(function()
                    if Invisible.Enabled and Character.Parent then
                        for i,v in ipairs(Character:GetDescendants()) do
                            if v ~= CRoot and v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        AlignPosition.Position = CRoot.Position + Vector3.new(0, LowerTorso.Size.Y, 0)
                        AlignOrientation.CFrame = CRoot.CFrame

                        if Humanoid:GetState() == Enum.HumanoidStateType.GettingUp and not NoGettingUp then
                            NoGettingUp = true

                            Info("Getting back up..")

                            AlignPosition.ReactionForceEnabled = false

                            task.wait(.5)

                            AlignPosition.ReactionForceEnabled = true

                            task.wait(.5)

                            Success("Done!")

                            NoGettingUp = false
                        end
                    end
                end)
            end

            for _, v: BasePart | Decal in ipairs(Character:GetDescendants()) do
                if v:IsA("BasePart") and v ~= CRoot then
                    v.Transparency = .5
                    
                    local Highlight = Instance.new("Highlight", v)
                    Invisible.InvisibleHighlights[#Invisible.InvisibleHighlights+1] = Highlight
                    
                    Highlight.Adornee = v
                    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                    Highlight.OutlineTransparency = 0
                    Highlight.OutlineColor = Color3.new(0.423529, 0.384314, 1)
                    Highlight.FillTransparency = 1
                end
            end

            local CharacterAdded; CharacterAdded = LocalPlayer.CharacterAdded:Connect(function()
                Invisible.Enabled = false

                if Invisible.InvisibleCRoot then
                    Invisible.InvisibleCRoot:Destroy()
                    Invisible.InvisibleCRoot = nil
                end
                if Invisible.InvisibleRoot then
                    Invisible.InvisibleRoot:Destroy()
                    Invisible.InvisibleRoot = nil
                end
                if Invisible.InvisibleCharacter then
                    Invisible.InvisibleCharacter = nil
                end
                if Invisible.TorsoAttachment then
                    Invisible.TorsoAttachment = nil
                end
                if Invisible.CRootAttachment then
                    Invisible.CRootAttachment = nil
                end
                if Invisible.TorsoForce then
                    Invisible.TorsoForce = nil
                end
                if Invisible.TorsoOrientation then
                    Invisible.TorsoOrientation = nil
                end
                if Invisible.TorsoHeartbeat then
                    Invisible.TorsoHeartbeat:Disconnect()
                    Invisible.TorsoHeartbeat = nil
                end
                
                table.clear(Invisible.InvisibleHighlights)

                CharacterAdded:Disconnect()
            end)

            Invisible.CharacterAdded = CharacterAdded

            Success("Turned on invisibility.")
        else
            Error("Couldn't find root, humanoid, or humanoid is dead.")
        end
    else
        Error("You're already invisible. Try running the command \"visible\".")
    end
end)

AddCMD("visible", "Makes your character visible again.", {}, {}, function(arguments)
    if Invisible.Enabled then
        local Goto = nil
        if Invisible.InvisibleCRoot then
            Goto = Invisible.InvisibleCRoot.CFrame
            
            Invisible.InvisibleCRoot:Destroy()
            Invisible.InvisibleCRoot = nil
        end
        if Invisible.TorsoAttachment then
            Invisible.TorsoAttachment:Destroy()
            Invisible.TorsoAttachment = nil
        end
        if Invisible.TorsoForce then
            Invisible.TorsoForce:Destroy()
            Invisible.TorsoForce = nil
        end
        if Invisible.TorsoHeartbeat then
            Invisible.TorsoHeartbeat:Disconnect()
            Invisible.TorsoHeartbeat = nil
        end
        if Invisible.TorsoOrientation then
            Invisible.TorsoOrientation:Destroy()
            Invisible.TorsoOrientation = nil
        end
        if Invisible.CRootAttachment then
            Invisible.CRootAttachment:Destroy()
            Invisible.CRootAttachment = nil
        end

        if Invisible.InvisibleRoot and Invisible.InvisibleCharacter then
            Invisible.InvisibleRoot.Parent = Invisible.InvisibleCharacter

            Goto = Goto or CFrame.new(0,0,0)

            repeat task.wait()
                Invisible.InvisibleRoot.AssemblyAngularVelocity = Vector3.zero
                Invisible.InvisibleRoot.AssemblyLinearVelocity = Vector3.zero

                Invisible.InvisibleRoot.CFrame = Goto
            until (Invisible.InvisibleRoot.Position - Goto.Position).Magnitude < 1
        end

        if Invisible.InvisibleCharacter then
            for _, v in ipairs(Invisible.InvisibleCharacter:GetDescendants()) do
                if v:IsA("BasePart") and v ~= Invisible.InvisibleRoot then
                    v.Transparency = 0
                end
            end
        end

        Invisible.InvisibleRoot = nil
        Invisible.InvisibleCharacter = nil

        for _, v in pairs(Invisible.InvisibleHighlights) do
            if v and v.Parent then
                v:Destroy()
            end
        end

        table.clear(Invisible.InvisibleHighlights)

        if Invisible.CharacterAdded then
            Invisible.CharacterAdded:Disconnect()
            Invisible.CharacterAdded = nil
        end

        Invisible.Enabled = false

        Success("Turned off invisibility.")
    else
        Error("Invisible is already off.")
    end
end)

local LoopWSCon = nil
local LoopJPCon = nil

AddCMD("loopws","Changes your walkspeed constantly.", {}, {"speed"}, function(arguments)
    local Speed = arguments[1] and tonumber(arguments[1]) or 30

    if not LoopWSCon then
        LoopWSCon = RunService.Heartbeat:Connect(function()
            local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            
            if Humanoid then
                Humanoid.WalkSpeed = Speed
            end
        end)

        Success("Enabled loopws.")
    else
        Error("LoopWS is already on. Try running \"unloopws\".")
    end
end)

AddCMD("loopjp","Changes your jumppower constantly.", {}, {"power"}, function(arguments)
    local Power = arguments[1] and tonumber(arguments[1]) or 30
    
    if not LoopJPCon then
        LoopJPCon = RunService.Heartbeat:Connect(function()
            local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            
            if Humanoid then
                Humanoid.JumpPower = Power
            end
        end)

        Success("Enabled loopjp.")
    else
        Error("LoopJP is already on. Try running \"unloopjp\".")
    end
end)

AddCMD("unloopws", "Stops changing your walkspeed.", {}, {}, function(arguments)
    if LoopWSCon then
        LoopWSCon:Disconnect()
        LoopWSCon = nil

        Success("Disabled loopws.")
    else
        Error("LoopWS is already off.")
    end
end)

AddCMD("unloopjp", "Stops changing your jumppower.", {}, {}, function(arguments)
    if LoopJPCon then
        LoopJPCon:Disconnect()
        LoopJPCon = nil

        Success("Disabled loopjp.")
    else
        Error("LoopJP is already off.")
    end
end)

local CommandLoops = {}

AddCMD("loopcommand", "Loops a command", {"loopcmd"}, {"delay", "command", "arguments"}, function(arguments)
    local Delay = arguments[1] and tonumber(arguments[1]) or .1
    local Command = arguments[2] and GetCMD(arguments[2]:lower())
    local Arguments = {}

    if #arguments > 2 then
        table.move(arguments, 3, #arguments, 1,  Arguments)
    end

    if Command then
        local CommandLoop = {}
        CommandLoop.Description = "Command: "..arguments[2]:lower()
        CommandLoop.Enabled = true
        CommandLoop.LoopTask = task.spawn(function()
            while CommandLoop.Enabled do
                Command.Function(Arguments)

                local Before = tick()
                repeat task.wait() until tick() > Before + Delay or not CommandLoop.Enabled
            end
        end)

        CommandLoops[#CommandLoops+1] = CommandLoop

        Success("Started looping command.")
    else
        Error("Command not found.")
    end
end)

AddCMD("listloopcommands", "Lists all currently looping commands.", {"listloopcmds", "listlooping", "listloopingcommands", "listloopingcmds"}, {}, function(arguments)
    local Data = {"Looping commands:"}

    for i, CommandLoop in pairs(CommandLoops) do
        Data[#Data+1] = tostring(i)..". "..CommandLoop.Description
    end

    Output(Data)
end)

AddCMD("unloopcommand", "Stops looping a command at the specified index. Use listloopcommands to get the desired index of the looping command.", {"unloopcmd"}, {"index"}, function(arguments)
    local Index = arguments[1] and tonumber(arguments[1])

    if Index then
        if CommandLoops[Index] then
            CommandLoops[Index].Enabled = false

            Success("Stopped looping command.")

            table.remove(CommandLoops, Index)
        else
            Error("Couldn't find index in CommandLoops. Try using \"listloopcommands\" to list all loops.")
        end
    else
        Error("No index specified.")
    end
end)

AddCMD("sit", "Sits.", {}, {}, function(arguments)
    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

    if Humanoid then
        Humanoid.Sit = true
    end
end)

local CoreGuis = {
    ["backpack"] = Enum.CoreGuiType.Backpack,
    ["chat"] = Enum.CoreGuiType.Chat,
    ["all"] = Enum.CoreGuiType.All,
    ["emotes"] = Enum.CoreGuiType.EmotesMenu,
    ["selfview"] = Enum.CoreGuiType.SelfView,
    ["playerlist"] = Enum.CoreGuiType.PlayerList,
    ["reset"] = -1,
    ["captures"] = Enum.CoreGuiType.Captures,
    ["health"] = Enum.CoreGuiType.Health
}

AddCMD("enablecore", "Enables a coregui", {}, {"gui (backpack/reset/playerlist/all/emotes/selfview/captures/health/chat)"}, function(arguments)
    local Type = arguments[1] and CoreGuis[arguments[1]]

    if Type and Type ~= -1 then
        StarterGui:SetCoreGuiEnabled(Type, true)

        Success("Enabled CoreGui \""..arguments[1].."\".")
    else
        local Succ, Err = pcall(function()
            StarterGui:SetCore("ResetButtonCallback", true)
        end)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        else
            Success("Enabled CoreGui \"reset\".")
        end
    end
end)

AddCMD("disablecore", "Disables a coregui", {}, {"gui (backpack/reset/playerlist/all/emotes/selfview/captures/health/chat)"}, function(arguments)
    local Type = arguments[1] and CoreGuis[arguments[1]]

    if Type and Type ~= -1 then
        StarterGui:SetCoreGuiEnabled(Type, false)

        Success("Disabled CoreGui \""..arguments[1].."\".")
    else
        local Succ, Err = pcall(function()
            StarterGui:SetCore("ResetButtonCallback", false)
        end)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        else
            Success("Disabled CoreGui \"reset\".")
        end
    end
end)

local ChatLogsCons = {}

local function AddChatCon(player: Player)
    Debug("adding chatlogs connection for "..player.Name)
    ChatLogsCons[#ChatLogsCons+1] = player.Chatted:Connect(function(msg, recipient)
        Debug("chatlogs message detected from "..player.Name..": \""..msg.."\"")
        AddChatLog(msg, player)
    end)
end

AddCMD("chatlogs", "Displays a GUI where chat messages get stored in.", {}, {}, function(arguments)
    if #ChatLogsCons == 0 then
        local Succ, Err = pcall(function()
            if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
                ChatLogsCons[#ChatLogsCons+1] = Players.PlayerAdded:Connect(function(player)
                    AddChatCon(player)
                end)
                for _, Player in ipairs(Players:GetPlayers()) do
                    AddChatCon(Player)
                end
            else
                ChatLogsCons[#ChatLogsCons+1] = TextChatService.MessageReceived:Connect(function(message)
                    if message.TextSource then
                        local Player = Players:GetPlayerByUserId(message.TextSource.UserId)
                        if Player then
                            AddChatLog(message.Text, Player)
                        end
                    end
                end)
            end

            chat_logs_frame.Visible = true
        end)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        end
    else
        chat_logs_frame.Visible = true
    end
end)

AddCMD("resetincomingmessage", "On certain games this allows you to see hidden messages.", {}, {}, function(arguments)
    if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
        Error("You are on LegacyChatService.")
        return
    end

    TextChatService.OnIncomingMessage = function(message) end

    Success("Reset OnIncomingMessage.")
end)

AddCMD("unchatlogs", "Stop recording chatlogs.", {}, {}, function(arguments)
    if #ChatLogsCons > 0 then
        for _, Con in pairs(ChatLogsCons) do
            if Con then
                Con:Disconnect()
            end
        end
        table.clear(ChatLogsCons)
        ClearChatLogs()

        Success("Disabled chatlogs.")
    else
        Error("Chatlogs are already disabled.")
    end
end)

local DeathTP = {}
DeathTP.Enabled = false
DeathTP.Heartbeat = nil
DeathTP.CharacterAdded = nil

AddCMD("deathtp", "Teleports you back to your original position when you die.", {}, {}, function(arguments)
    if not DeathTP.Enabled then
        DeathTP.Enabled = true

        local Waiting = false
        local LastPos = nil

        DeathTP.Heartbeat = RunService.Heartbeat:Connect(function()
            if Waiting then return end

            local Character = LocalPlayer.Character
            local Root,Humanoid = Character and Character:FindFirstChild("HumanoidRootPart"), Character and Character:FindFirstChildWhichIsA("Humanoid")

            if Humanoid and Root and Humanoid.Health > 0 and workspace.CurrentCamera then
                LastPos = Root.CFrame
            end
        end)

        DeathTP.CharacterAdded = LocalPlayer.CharacterAdded:Connect(function(character: Model)
            Waiting = true

            local Root = character:WaitForChild("HumanoidRootPart")

            if LastPos then Root.CFrame = LastPos end

            Waiting = false
        end)

        Success("Enabled DeathTP.")
    else
        Error("DeathTP is already enabled.")
    end
end)

AddCMD("undeathtp", "Disables deathtp.", {}, {}, function(arguments)
    if DeathTP.Enabled then
        DeathTP.Enabled = false

        if DeathTP.Heartbeat then
            DeathTP.Heartbeat:Disconnect()
        end
        if DeathTP.CharacterAdded then
            DeathTP.CharacterAdded:Disconnect()
        end

        Success("Disabled DeathTP.")
    else
        Error("DeathTP is already disabled.")
    end
end)

local DeletePlayer = {}
DeletePlayer.Cons = {}
DeletePlayer.Players = {}

DeletePlayer.Effects = {}

local function AddDeletePlayerEffect(func: (Clone: Model) -> ())
    DeletePlayer.Effects[#DeletePlayer.Effects+1] = func
end

local function RandomDeletePlayerEffect()
    return DeletePlayer.Effects[math.random(1, #DeletePlayer.Effects)]
end

module.DeletePlayer = {}

function module.DeletePlayer:AddEffect(...)
    return AddDeletePlayerEffect(...)
end

AddDeletePlayerEffect(function(Clone)
    local Humanoid = Clone:FindFirstChildWhichIsA("Humanoid")

    if Humanoid then
        Humanoid.Health = 0
    end

    for _, v: BasePart in ipairs(Clone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = false
            if v.Name ~= "HumanoidRootPart" then
                v.CanCollide = true
            else
                v.CanCollide = false
            end

            for _, joint in ipairs(v:GetJoints()) do
                joint.Enabled = false
            end
        end 
    end

    local Sound = Instance.new("Sound", GetCoreGui())

    Sound.SoundId = "rbxassetid://17755696142"
    Sound:Play()

    Sound.Ended:Wait()

    Clone:Destroy()
    Sound:Destroy()
end)

AddDeletePlayerEffect(function(Clone)
    local Tween = nil

    local Sound = Instance.new("Sound", GetCoreGui())
    Sound.SoundId = "rbxassetid://9057675920"

    for i, v: BasePart in ipairs(Clone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = true

            local Light = Instance.new("SpotLight", v)
            Light.Color = Color3.new(0.568627, 0.866666, 0.984313)
            Light.Brightness = 3

            Tween = TweenService:Create(
                v,
                TweenInfo.new(1),
                {["CFrame"] = v.CFrame * CFrame.new(math.random(-10,10), math.random(-10,10), math.random(-10,10)) * CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360)), ["Transparency"] = 1}
            )
            Tween:Play()
        end
    end

    Sound:Play()

    Tween.Completed:Wait()

    Clone:Destroy()

    Sound.Ended:Wait()
    Sound:Destroy()
end)

AddDeletePlayerEffect(function(Clone)
    local Root = Clone:FindFirstChild("HumanoidRootPart")
    local Humanoid = Clone:FindFirstChildWhichIsA("Humanoid")

    if Humanoid then
        Humanoid.Health = 0
    end

    for _, v: BasePart in ipairs(Clone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = false
            if v.Name ~= "HumanoidRootPart" then
                v.CanCollide = true
            else
                v.CanCollide = false
            end

            for _, joint in ipairs(v:GetJoints()) do
                joint.Enabled = false
            end
        end 
    end

    if Root then
        local Sound = Instance.new("Sound", GetCoreGui())
        Sound.SoundId = "rbxassetid://71379251021209"

        Sound:Play()

        local Explosion = Instance.new("Explosion", Root)
        Explosion.Position = Root.Position
        Explosion.ExplosionType = Enum.ExplosionType.NoCraters
        Explosion.DestroyJointRadiusPercent = 0
        
        Sound.Ended:Wait()

        Clone:Destroy()
        Sound:Destroy()
    end
end)

AddDeletePlayerEffect(function(Clone)
    local Fire,HitFade,Reload = Instance.new("Sound", GetCoreGui()), Instance.new("Sound", GetCoreGui()), Instance.new("Sound", GetCoreGui())

    Fire.SoundId = "http://www.roblox.com/asset?id=130113322"
    HitFade.SoundId = "http://www.roblox.com/asset?id=130113415"
    Reload.SoundId = "http://www.roblox.com/asset?id=130113370"

    Fire:Play()

    task.wait(.5)

    HitFade:Play()

    for i,v in ipairs(Clone:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = true

            local Light = Instance.new("PointLight", v)
            Light.Range += 2
            Light.Color = Color3.fromRGB(0,255,255)
            
            local SelectionBox = Instance.new("SelectionBox", v)
            SelectionBox.Adornee = v
            SelectionBox.Color3 = BrickColor.new("Toothpaste").Color

            local Tween = TweenService:Create(
                v,
                TweenInfo.new(.5),
                {["Transparency"] = 1}
            )
            
            Tween:Play()

            task.spawn(function()
                Tween.Completed:Wait()

                Tween = TweenService:Create(
                    SelectionBox,
                    TweenInfo.new(.5),
                    {["Transparency"] = 1}
                )
                
                Tween:Play()
            end)
        end
    end

    task.wait(.6)

    Reload:Play()

    Reload.Ended:Wait()

    task.wait(.5)

    Reload:Destroy()
    Fire:Destroy()
    HitFade:Destroy()

    Clone:Destroy()
end)

local function IsDeleted(player: Player)
    for i, _ in pairs(DeletePlayer.Players) do
        if i == player then
            return true
        end
    end

    return false
end

local function GetDeletedCharacter(player: Player)
    for i,v in pairs(DeletePlayer.Players) do
        if i == player then
            return v
        end
    end

    return nil
end

AddCMD("deleteplayer", "Removes a player or players from your client. (WARNING: This will replace OnIncomingMessage, which might break some game's functionality like chat messages.)", {"blockplayer","removeplayer"}, {"player"}, function(arguments)
    local Targets = FindPlayers(unpack(arguments))

    if #Targets > 0 then
        for _, v in pairs(Targets) do
            if v ~= LocalPlayer then
                DeletePlayer.Players[v] = v.Character or v.CharacterAdded:Wait()

                v.Character.Archivable = true

                local Clone = v.Character:Clone()

                v.Character.Parent = ReplicatedStorage

                DeletePlayer.Cons[#DeletePlayer.Cons+1] = v.CharacterAdded:Connect(function(Character)
                    DeletePlayer.Players[v] = Character
                    Character.Parent = ReplicatedStorage
                end)

                Clone.Parent = workspace

                task.spawn(function()
                    RandomDeletePlayerEffect()(Clone)
                end)

                Success("Added \""..v.Name.."\" to the deleteplayer list.")
            end
        end

        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.OnIncomingMessage = function(message: TextChatMessage)
                local UserId = message.TextSource and message.TextSource.UserId
                local Player = UserId and Players:GetPlayerByUserId(UserId)

                if Player and IsDeleted(Player) then
                    message.Text = ""
                end
            end
        end
    else
        Error("No players specified.")
    end
end)

AddCMD("undeleteplayer", "Re-adds a player or players.", {"unblockplayer","unremoveplayer"}, {"player"}, function(arguments)
    local Targets = FindPlayers(unpack(arguments))

    if #Targets > 0 then
        for _, Target in pairs(Targets) do
            if IsDeleted(Target) then
                local Character = GetDeletedCharacter(Target)

                if Exists(Character) and Character.Parent ~= workspace then
                    Character.Parent = workspace
                end

                DeletePlayer.Players[Target] = nil

                Success("Removed \""..Target.Name.."\" from the deleteplayer list.")
            end
        end
    else
        Error("No targets specified.")
    end
end)

local AntiIdleTriggered = false

AddCMD("antiidle", "Prevents being kicked for idleing. (EXPERIMENTAL)", {}, {}, function(arguments)
    if getconnections and not AntiIdleTriggered then
        for i,v in pairs(getconnections(LocalPlayer.Idled)) do
            if v.State == Enum.ConnectionState.Connected then
                v:Disable()
            end
        end

        AntiIdleTriggered = true
    elseif AntiIdleTriggered then
        Error("Antiidle was already triggered. Rejoin to turn it off.")
    else
        Error("Your exploit does not support getconnections.")
    end
end)

local FlyHeartbeatCon = nil

AddCMD("fly", "Activates fly.", {}, {"speed/none"}, function(arguments)
    if not FlyHeartbeatCon then
        local Speed = arguments[1] and tonumber(arguments[1]) or 20

        FlyHeartbeatCon = RunService.Heartbeat:Connect(function(delta)
            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local Humanoid: Humanoid? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

            if Root and Humanoid then
                Humanoid.PlatformStand = true
                
                local AlignPosition = Root:FindFirstChild("RAVEN_FLY") or Instance.new("AlignPosition", Root)
                local AlignOrientation = Root:FindFirstChild("RAVEN_FLY_GYRO") or Instance.new("AlignOrientation", Root)

                if AlignPosition.Name ~= "RAVEN_FLY" then
                    AlignPosition.Name = "RAVEN_FLY"

                    AlignPosition.MaxVelocity = math.huge
                    AlignPosition.MaxAxesForce = Vector3.new(math.huge, math.huge, math.huge)
                    AlignPosition.MaxForce = math.huge

                    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
                    AlignPosition.Responsiveness = Speed
                end

                if not AlignPosition.Attachment0 then
                    AlignPosition.Attachment0 = Instance.new("Attachment", Root)
                    AlignPosition.Attachment0.Name = "RAVEN_FLY_ATTACHMENT"
                end

                local Camera = workspace.CurrentCamera

                if AlignOrientation ~= "RAVEN_FLY_GYRO" then
                    AlignOrientation.Name = "RAVEN_FLY_GYRO"

                    AlignOrientation.MaxAngularVelocity = math.huge
                    AlignOrientation.MaxTorque = math.huge
                    
                    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
                    AlignOrientation.Responsiveness = 15
                end

                if not AlignOrientation.Attachment0 then
                    AlignOrientation.Attachment0 = Instance.new("Attachment", Root)
                    AlignOrientation.Attachment0.Name = "RAVEN_FLY_ATTACHMENT"
                end

                AlignOrientation.CFrame = Camera.CFrame

                local Rotation = Camera.CFrame.Rotation
                local Direction = Rotation:VectorToObjectSpace(Humanoid.MoveDirection * Speed)

                AlignPosition.Position = Root.Position

                if Direction.Magnitude ~= 0 then
                    AlignPosition.Position += Rotation:VectorToWorldSpace(
                        Vector3.new(Direction.X, 0, Direction.Z).Unit * Direction.Magnitude
                    )
                end

                if Humanoid.Jump then
                    AlignPosition.Position += Camera.CFrame.UpVector * Speed
                end
            end
        end)

        Success("Enabled fly.")
    else
        Error("Fly is already enabled.")
    end
end)

AddCMD("unfly", "Deactivates fly.", {}, {}, function(arguments)
    if FlyHeartbeatCon then
        FlyHeartbeatCon:Disconnect()
        FlyHeartbeatCon = nil

        local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Humanoid then
            Humanoid.PlatformStand = false
        end

        if Root then
            for i, v: Instance in ipairs(Root:GetChildren()) do
                if v.Name == "RAVEN_FLY_GYRO" or v.Name == "RAVEN_FLY" or v.Name == "RAVEN_FLY_ATTACHMENT" then
                    v:Destroy()
                end
            end
        end

        Success("Disabled fly.")
    else
        Error("Fly is already disabled")
    end
end)

AddCMD("stun", "Enables platformstand.", {}, {}, function(arguments)
    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if Humanoid then Humanoid.PlatformStand = true end
end)

AddCMD("unstun", "Disables platformstand.", {}, {}, function(arguments)
    local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if Humanoid then Humanoid.PlatformStand = false end
end)

local GrabTools = {} 
GrabTools.Enabled = false
GrabTools.Heartbeat = nil

AddCMD("grabtools", "Enables grabtools", {}, {}, function(arguments)
    if not GrabTools.Enabled then
        GrabTools.Enabled = true

        GrabTools.Heartbeat = RunService.Heartbeat:Connect(function()
            local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

            if Humanoid then
                for i,v in ipairs(workspace:GetChildren()) do
                    if v:IsA("Tool") then
                        Humanoid:EquipTool(v)
                    end
                end
            end
        end)

        Success("Enabled Grabtools.")
    else
        Error("Grabtools is already enabled.")
    end
end)

AddCMD("ungrabtools", "Disables grabtools.", {}, {}, function(arguments)
    if GrabTools.Enabled then
        GrabTools.Enabled = false

        if GrabTools.Heartbeat ~= nil then
            GrabTools.Heartbeat:Disconnect()
        end

        Success("Disabled grabtools.")
    else
        Error("Grabtools is already disabled.")
    end
end)

BotUtils.Bots = {} -- These and BotUtils.Admins are player usernames. This is so they can both be saved.
BotUtils.Admins = {}
BotUtils.AdminChatted = nil
BotUtils.BotChatted = nil

module.BotUtils = {}
module.BotUtils.Bots = BotUtils.Bots
module.BotUtils.Admins = BotUtils.Admins

module.BotUtils.BotIndex = nil

local function SerializeStatus(color: Color3)
    local Name = "Info"

    for SName, Status in Statuses do
        if Status == color then
            Name = SName
            break
        end
    end

    return Name
end

local function UnserializeStatus(name: string)
    local Color = Statuses.Info

    for SName, Status in Statuses do
        if SName == name then
            Color = Status
            break
        end
    end

    return Color
end

local function AlertAdmin(data: string, name: string, color: Color3?)
    color = color or Statuses.Info

    local Color = SerializeStatus(color)

    local Json = HttpService:JSONEncode({
        Status = Color,
        Data = data,
        Name = name
    })

    Say(Json:gsub("\n", " "), true)
end

function module.BotUtils:AlertAdmin(...)
    return AlertAdmin(...)
end

function module:EnableBotMode(...)
    BotUtils.BotMode = true
end

function module:DisableBotMode(...)
    BotUtils.BotMode = false
end

local function ClearChatFilter()
    Say(".", true)
end

local function JsonBots()
    local Table = {}

    for _, Name in pairs(BotUtils.Bots) do
        Table[#Table + 1] = Name
    end

    return HttpService:JSONEncode(Table)
end

AddCMD("savebots", "Saves bots to a file.", {}, {}, function(arguments)
    if writefile and isfile and readfile then
        if #BotUtils.Bots > 0 then
            if not isfile("RAVEN_SAVED_BOTS") then
                writefile("RAVEN_SAVED_BOTS", JsonBots())

                Success("Saved bots.")
                return
            end

            local Contents: string = readfile("RAVEN_SAVED_BOTS")
            local Decoded = nil

            pcall(function()
                Decoded = HttpService:JSONDecode(Contents)
            end)

            local Json = JsonBots()

            if Decoded and #Decoded > 0 then
                local ToAdd = {}
                for _, Name in pairs(BotUtils.Bots) do
                    local Index = table.find(Decoded, Name)

                    if not Index then
                        ToAdd[#ToAdd+1] = Name
                    end
                end

                table.move(ToAdd, 1, #ToAdd, #Decoded, Decoded)

                writefile("RAVEN_SAVED_BOTS", HttpService:JSONEncode(Decoded))
            else
                writefile("RAVEN_SAVED_BOTS", JsonBots())
            end

            Success("Saved bots.")
        else
            Error("No bots to save.")
        end
    else
        Error("Your exploit does not support writefile/isfile/appendfile/readfile.")
    end
end)

AddCMD("clearsavedbots", "Deletes the file with saved bots in it.", {}, {}, function(arguments)
    if isfile and delfile then
        if isfile("RAVEN_SAVED_BOTS") then
            delfile("RAVEN_SAVED_BOTS")

            Success("Cleared saved bots.")
        else
            Error("You have not saved any bots yet.")
        end
    else
        Error("Your exploit does not support isfile or delfile.")
    end
end)

AddCMD("runasbot", "Runs a command as a bot command.", {"b"}, {"command", "arguments"}, function(arguments)
    if #arguments > 0 then
        Say(BotUtils.Prefix..table.concat(arguments, " "), true)
        ClearChatFilter()
    end
end)

AddCMD("say", "Sends something in chat", {}, {"message"}, function(arguments)
    local Message = #arguments > 0 and table.concat(arguments, " ")

    if Message then
        Say(Message, false)
    end
end)

local function UpdateBotIndex()
    local Before = BotUtils.BotIndex
    Say(BotUtils.Prefix.."BIND", true);
    task.wait(.5)
    ClearChatFilter()

    if Before == BotUtils.BotIndex then
        return false
    else
        return true
    end
end

AddCMD("testbot", "A test bot command used in the development of Raven.", {}, {}, function(arguments)
    UpdateBotIndex()

    Info("Your bot index is "..tostring(BotUtils.BotIndex))
end, true)

AddCMD("botmode", "Toggles BotMode. Use this when you want to use bot commands.", {}, {}, function(arguments)
    BotUtils.BotMode = not BotUtils.BotMode

    if BotUtils.BotMode then
        Info("Turned on BotMode.")
    else
        Info("Turned off BotMode.")
    end
end)

local Swim = false

AddCMD("swim", "Makes you swim in mid-air", {}, {}, function(arguments)
    if Swim then Error("Swim is already enabled."); return end

    Swim = true

    local LinearVelocity: LinearVelocity
    local Attachment0: Attachment
    local Attachment1: Attachment

    Success("Started swimming.")

    while Swim do
        RunService.RenderStepped:Wait()
        local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        local Root: BasePart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Humanoid and Root then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

            if not Exists(LinearVelocity) then
                if Exists(Attachment0) then Attachment0:Destroy() end
                if Exists(Attachment1) then Attachment1:Destroy() end

                LinearVelocity = Instance.new("LinearVelocity", Root)
                LinearVelocity.MaxForce = math.huge
                LinearVelocity.MaxAxesForce = Vector3.new(math.huge,math.huge,math.huge)
                LinearVelocity.Enabled = true
                LinearVelocity.ReactionForceEnabled = true

                Attachment0 = Instance.new("Attachment", Root)
                LinearVelocity.Attachment0 = Attachment0
                Attachment1 = Instance.new("Attachment", Root)
                LinearVelocity.Attachment1 = Attachment1
            end
            LinearVelocity.VectorVelocity = Humanoid.MoveDirection * Humanoid.WalkSpeed

            if Humanoid.Jump then
                LinearVelocity.VectorVelocity += Vector3.new(0, Humanoid.WalkSpeed, 0)
            end
        end
    end

    if LocalPlayer.Character then
        local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end

    if Exists(LinearVelocity) then
        LinearVelocity:Destroy()
    end
    if Exists(Attachment0) then Attachment0:Destroy() end
    if Exists(Attachment1) then Attachment1:Destroy() end
end)

AddCMD("unswim", "Stops swimming", {}, {}, function(arguments)
    if not Swim then Error("You are not swimming."); return end

    Swim = false
    Success("Stopped swimming.")
end)

-- local function BotChatted(player, message)
--     local IsBot = false
--     local BotIndex = nil

--     for i, name in pairs(BotUtils.Bots) do
--         if name == player.Name then
--             IsBot = true
--             BotIndex = i
--             break
--         end
--     end

--     if IsBot then
--         local Decoded = nil
--         local Succ, _ = pcall(function()
--             Decoded = HttpService:JSONDecode(message)
--         end)

--         if Decoded and Succ then
--             if Decoded.Status and Decoded.Data and Decoded.Name then
--                 if Decoded.Name == LocalPlayer.Name then
--                     local Color = UnserializeStatus(Decoded.Status)
                    
--                     Notify(Decoded.Data, Color, 4)
--                 end
--             end
--         elseif message:find(BotUtils.Prefix) and BotIndex ~= nil then
--             local PrefixSplit = message:split(BotUtils.Prefix)
            
--             if PrefixSplit and #PrefixSplit > 0 then
--                 local Command = PrefixSplit[2]

--                 if Command == "BIND" then
--                     Say(BotUtils.Prefix.."BIND".." "..BotIndex, true)
--                 end
--             end
--         end
--     end
-- end

-- local function InitializeBotChatted()
--     if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
--         local Succ, _ = pcall(function()
--             BotUtils.BotChatted = Players.PlayerChatted:Connect(function(chatType, player: Player, message: string, _)
--                 BotChatted(player, message)
--             end)
--         end)

--         if not Succ then
--             Error("Your exploit does not support PlayerChatted.")
--             return false
--         else
--             return true
--         end
--     else
--         BotUtils.BotChatted = TextChatService.MessageReceived:Connect(function(message)
--             local Player = message.TextSource and Players:GetPlayerByUserId(message.TextSource.UserId)
--             if Player then
--                 BotChatted(Player, message.Text)
--             end
--         end)
--         return true
--     end
-- end

-- AddCMD("addbot", "Adds a bot. This only works when the target has Raven loaded on their client, and they have added you as an admin.", {}, {"player"}, function(arguments)
--     local Targets = arguments[1] and FindPlayers(arguments[1])

--     if #Targets > 0 then
--         if Targets[1] == LocalPlayer then
--             Error("You cannot add yourself as a bot.")
--             return
--         end

--         if table.find(BotUtils.Bots, Targets[1].Name) then
--             Error("That player is already added as a bot.")
--             return
--         end

--         if BotUtils.BotChatted == nil then
--             if not InitializeBotChatted() then
--                 return
--             end
--         end
--         BotUtils.Bots[#BotUtils.Bots+1] = Targets[1].Name

--         Success("Added bot.")
--     else
--         Error("No target found.")
--     end
-- end)

-- AddCMD("removebot", "Removes a bot.", {}, {"name"}, function(arguments)
--     if arguments[1] then
--         local Target = nil
--         local Index = nil

--         for i, Name: string in pairs(BotUtils.Bots) do
--             if arguments[1] == Name or Name:sub(1, arguments[1]:len()) == arguments[1] then
--                 Target = Name
--                 Index = i
--             end
--         end

--         if Target ~= nil and Index ~= nil then
--             table.remove(BotUtils.Bots, Index)

--             if #BotUtils.Bots == 0 and BotUtils.BotChatted then
--                 BotUtils.BotChatted:Disconnect()
--                 BotUtils.BotChatted = nil
--             end

--             Success("Removed bot.")
--         else
--             Error("Couldn't find bot.")
--         end
--     else
--         Error("No target specified.") 
--     end
-- end)

-- AddCMD("clearbots", "Removes all bots.", {}, {}, function(arguments)
--     table.clear(BotUtils.Bots)

--     if BotUtils.BotChatted ~= nil then
--         BotUtils.BotChatted:Disconnect()
--         BotUtils.BotChatted = nil
--     end

--     Success("Cleared bots.")
-- end)

-- local function AdminChatted(player, message)
--     if message:find(BotUtils.Prefix) then
--         local IsAdmin = false

--         for _, name in pairs(BotUtils.Admins) do
--             if name == player.Name then
--                 IsAdmin = true
--                 break
--             end
--         end

--         if IsAdmin then
--             local PrefixSplit = message:split(BotUtils.Prefix)
--             local FullCommand = PrefixSplit[2]

--             local SpaceSplit = FullCommand:split(" ")
--             local Arguments = {}
--             local StringCommand = #SpaceSplit > 0 and SpaceSplit[1] or FullCommand
            
--             if #SpaceSplit > 0 then
--                 table.move(SpaceSplit, 2, #SpaceSplit, 1, Arguments)
--             end

--             local Command = nil

--             for Name: string, Table: CommandTable in pairs(Commands) do
--                 if Name == StringCommand or Name:sub(1, #StringCommand) == StringCommand then
--                     Command = Table
--                     break
--                 end
--             end

--             if Command then
--                 local Succ, Err = pcall(Command.Function, Arguments)

--                 if not Succ then
--                     if tostring(Err) then
--                         AlertAdmin("Error: "..tostring(Err), player.Name, Statuses.Error)
--                     else
--                         AlertAdmin("Unknown error.", player.Name, Statuses.Error)
--                     end
--                 end
--             elseif StringCommand == "BIND" then
--                 local BotIndex = Arguments and Arguments[1] and tonumber(Arguments[1])

--                 if BotIndex then
--                     BotUtils.BotIndex = BotIndex
--                 end
--             else
--                 AlertAdmin("Command not found.", player.Name, Statuses.Error)
--             end

--             ClearChatFilter()
--         end
--     end
-- end

-- local function InitializeAdminChatted()
--     if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
--         local Succ, _ = pcall(function()
--             BotUtils.AdminChatted = Players.PlayerChatted:Connect(function(chatType, player: Player, message: string, _)
--                 AdminChatted(player, message)
--             end)
--         end)

--         if not Succ then
--             Error("Your exploit does not support PlayerChatted.")
--             return false
--         else
--             return true
--         end
--     else
--         BotUtils.AdminChatted = TextChatService.MessageReceived:Connect(function(message)
--             local Player = message.TextSource and Players:GetPlayerByUserId(message.TextSource.UserId)
--             if Player then
--                 AdminChatted(Player, message.Text)
--             end
--         end)
--         return true
--     end
-- end

-- AddCMD("addadmin", "Adds an admin. Make sure you really want this person to be in control of your client.", {}, {"player"}, function(arguments)
--     local Targets = arguments[1] and FindPlayers(arguments[1])

--     if #Targets > 0 then
--         if Targets[1] == LocalPlayer then
--             Error("You cannot add yourself as an admin.")
--             return
--         end

--         if table.find(BotUtils.Admins, Targets[1].Name) then
--             Error("That player is already added as a admin.")
--             return
--         end

--         if BotUtils.AdminChatted == nil then
--             if not InitializeAdminChatted() then
--                 return
--             end
--         end

--         BotUtils.Admins[#BotUtils.Admins+1] = Targets[1].Name

--         Success("Added admin.")
--     else
--         Error("No target found.")
--     end
-- end)

-- AddCMD("removeadmin", "Removes an admin.", {}, {"name"}, function(arguments)
--     if arguments[1] then
--         local Target = nil
--         local Index = nil

--         for i, Name: string in pairs(BotUtils.Admins) do
--             if arguments[1] == Name or Name:sub(1, arguments[1]:len()) == arguments[1] then
--                 Target = Name
--                 Index = i
--             end
--         end

--         if Target ~= nil and Index ~= nil then
--             table.remove(BotUtils.Admins, Index)

--             if #BotUtils.Admins == 0 and BotUtils.AdminChatted then
--                 BotUtils.AdminChatted:Disconnect()
--                 BotUtils.AdminChatted = nil
--             end

--             Success("Removed admin.")
--         else
--             Error("Couldn't find admin.")
--         end
--     else
--         Error("No target specified.") 
--     end
-- end)

-- local function JsonAdmins()
--     local Table = {}

--     for _, Name in pairs(BotUtils.Admins) do
--         Table[#Table + 1] = Name
--     end

--     return HttpService:JSONEncode(Table)
-- end

-- AddCMD("saveadmins", "Saves admins to a file.", {}, {}, function(arguments)
--     if writefile and isfile and readfile then
--         if #BotUtils.Admins > 0 then
--             if not isfile("RAVEN_SAVED_ADMINS") then
--                 writefile("RAVEN_SAVED_ADMINS", JsonAdmins())

--                 Success("Saved admins.")
--                 return
--             end

--             local Contents: string = readfile("RAVEN_SAVED_ADMINS")
--             local Decoded = nil

--             pcall(function()
--                 Decoded = HttpService:JSONDecode(Contents)
--             end)

--             local Json = JsonAdmins()

--             if Decoded and #Decoded > 0 then
--                 local ToAdd = {}
--                 for _, Name in pairs(BotUtils.Admins) do
--                     local Index = table.find(Decoded, Name)

--                     if not Index then
--                         ToAdd[#ToAdd+1] = Name
--                     end
--                 end

--                 table.move(ToAdd, 1, #ToAdd, #Decoded, Decoded)

--                 writefile("RAVEN_SAVED_ADMINS", HttpService:JSONEncode(Decoded))
--             else
--                 writefile("RAVEN_SAVED_ADMINS", JsonAdmins())
--             end

--             Success("Saved admins.")
--         else
--             Error("No admins to save.")
--         end
--     else
--         Error("Your exploit does not support writefile/isfile/appendfile/readfile.")
--     end
-- end)

-- AddCMD("clearsavedadmins", "Deletes the file with saved admins in it.", {}, {}, function(arguments)
--     if isfile and delfile then
--         if isfile("RAVEN_SAVED_ADMINS") then
--             delfile("RAVEN_SAVED_ADMINS")

--             Success("Cleared saved admins.")
--         else
--             Error("You have not saved any admins yet.")
--         end
--     else
--         Error("Your exploit does not support isfile or delfile.")
--     end
-- end)

-- AddCMD("clearadmins", "Removes all admins.", {}, {}, function(arguments)
--     table.clear(BotUtils.Admins)

--     if BotUtils.AdminChatted ~= nil then
--         BotUtils.AdminChatted:Disconnect()
--         BotUtils.AdminChatted = nil
--     end

--     Success("Cleared admins.")
-- end)

-- AddCMD("listbots", "Lists all bots and puts them in a GUI.", {}, {}, function(arguments)
--     local data = {"All bots:"}

--     table.move(BotUtils.Bots, 1, #BotUtils.Bots, 2, data)

--     Output(data)
-- end)

-- AddCMD("listadmins", "Lists all admins and puts them in a GUI.", {}, {}, function(arguments)
--     local data = {"All admins:"}

--     table.move(BotUtils.Admins, 1, #BotUtils.Admins, 2, data)

--     Output(data)
-- end)

--[[


DO NOT PUT ANY COMMANDS PAST THIS POINT (except for loadmodule)


]]

AddCMD("loadmodule", "Loads a Raven module. (A lua script in the workspace folder of your exploit)", {}, {"name"}, function(arguments)
    if isfile and readfile then
        local Name = arguments[1]

        if Name and isfile(Name) then
            loadstring(readfile(Name))()(module)
        else
            Error("Module not found.")
        end
    else
        Error("Your exploit does not support isfile or readfile.")
    end
end)

if readfile and isfile then -- Load saved openbind if there is any.
    if isfile("RAVEN_OPENBIND") then
        local bind = readfile("RAVEN_OPENBIND")

        OpenBind = bind
    end
end

if readfile and isfile then
    if isfile("RAVEN_SAVED_ALIASES") then  -- Load saved aliases.
        local SavedAliasesData: string = readfile("RAVEN_SAVED_ALIASES")

        if SavedAliasesData:len() > 0 then
            local Lines = SavedAliasesData:split("\n")

            for _, Line in pairs(Lines) do
                local Split = Line:split("=")
                if Split and #Split == 2 then
                    local Command = Split[1]
                    local Aliases = Split[2]
                    local CommandTable: CommandTable? = GetCMD(Command)

                    if CommandTable then -- Don't throw an error here if it doesn't exist. It might be a command in another Raven script, so skip it instead.
                        CommandTable.Aliases = Aliases:split(";")
                    end
                end
            end
        end
    end

    -- if isfile("RAVEN_SAVED_BOTS") then
    --     local Contents: string = readfile("RAVEN_SAVED_BOTS")
    --     local Table = nil

    --     pcall(function()
    --         Table = HttpService:JSONDecode(Contents)
    --     end)

    --     if Table ~= nil and #Table > 0 then
    --         local ToRemove = {}
    --         for i, Name in pairs(Table) do
    --             if Name == LocalPlayer.Name then
    --                 ToRemove[#ToRemove+1] = i
    --             end
    --         end

    --         for _, i in pairs(ToRemove) do
    --             table.remove(Table, i)
    --         end

    --         table.move(Table, 1, #Table, 1, BotUtils.Bots)

    --         InitializeBotChatted()
    --     end
    -- end

    -- if isfile("RAVEN_SAVED_ADMINS") then
    --     local Contents: string = readfile("RAVEN_SAVED_ADMINS")
    --     local Table = nil

    --     pcall(function()
    --         Table = HttpService:JSONDecode(Contents)
    --     end)

    --     if Table and #Table > 0 then
    --         local ToRemove = {}
    --         for i, Name in pairs(Table) do
    --             if Name == LocalPlayer.Name then
    --                 ToRemove[#ToRemove+1] = i
    --             end
    --         end

    --         for _, i in pairs(ToRemove) do
    --             table.remove(Table, i)
    --         end

    --         table.move(Table, 1, #Table, 1, BotUtils.Admins)

    --         InitializeAdminChatted()
    --     end
    -- end
end

local function UpdateName()
    local version = tostring(module.VERSION)

    if module.VERSION == -1 then
        version = "BASE"
    elseif module.VERSION == -2 then
        version = "DEV BASE"
    end

    title_label.Text = module.Name.." | Version "..version
end

task.spawn(function()
    task.wait(.1)

    UpdateName()

    toggle_button.Interactable = false

    do -- Welcome Animation
        welcome_label.Visible = true

        local version = tostring(module.VERSION)

        if module.VERSION == -1 then
            version = "BASE"
        elseif module.VERSION == -2 then
            version = "DEV BASE"
        end

        title_label.Text = module.Name.." | Version "..version

        GuiOpen = true

        local GotoClosed = TweenService:Create(
            main_frame,
            TweenInfo.new(.1, Enum.EasingStyle.Exponential),
            {["Position"] = ClosedPosition}
        )

        GotoClosed:Play()
        slide:Play()
        GotoClosed.Completed:Wait()

        task.wait(1)

        local GotoOpen = TweenService:Create(
            main_frame,
            TweenInfo.new(1, Enum.EasingStyle.Exponential),
            {["Position"] = OpenPosition}
        )

        GotoOpen:Play()
        toggle_button.Text = "Ʌ"
        GotoOpen.Completed:Wait()

        local WelcomeClose = TweenService:Create(
            welcome_label,
            TweenInfo.new(2, Enum.EasingStyle.Exponential),
            {["Size"] = UDim2.fromScale(0,0)}
        )

        WelcomeClose:Play()
    end

    toggle_button.Interactable = true
end)

if getgenv then
    getgenv().RAVEN_LOADED = true
end

function module:UpdateName()
    UpdateName()
end

return module