-- RAVEN
-- made by @bob448 or bobmichealson8 on scriptblox

-- A command-based system which can be used to create other scripts
-- This is the official base version of Raven!

if getgenv and getgenv().RAVEN_LOADED then
    error("Raven is already loaded.")
end

local module = {}

module.Name = "Raven"
module.VERSION = -1

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local TextChannels
local RBXGeneral: TextChannel? = nil
local RBXSystem: TextChannel? = nil

task.spawn(function()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChannels = TextChatService:WaitForChild("TextChannels")
        RBXGeneral = TextChannels:WaitForChild("RBXGeneral")
        RBXSystem = TextChannels:WaitForChild("RBXSystem")
    end
end)

local ClosedPosition = UDim2.new(.5, 0, 0, -244)
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
    GetCoreGui()
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

local Mobile = UserInputService.TouchEnabled

RunService.Heartbeat:Connect(function(delta)
    Mobile = UserInputService.TouchEnabled
end)

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

	game:GetService("UserInputService").InputChanged:Connect(function(input)
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
main_frame.Position = UDim2.new(0.5, 0, 0, -270)
main_frame.Size = UDim2.new(0, 475, 0, 240)
main_frame.Visible = true
main_frame.Name = "MainFrame"
main_frame.Parent = raven

local uicorner = Instance.new("UICorner")
uicorner.Parent = main_frame

local welcome_label = Instance.new("TextLabel")
welcome_label.Font = Enum.Font.Arimo
welcome_label.Text = "Welcome To Raven!"
welcome_label.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
welcome_label.TextSize = 50
welcome_label.TextStrokeColor3 = Color3.new(0.443137, 0.305882, 1)
welcome_label.TextWrapped = true
welcome_label.BackgroundColor3 = Color3.new(0, 0, 0)
welcome_label.BackgroundTransparency = 0
welcome_label.BorderColor3 = Color3.new(0, 0, 0)
welcome_label.BorderSizePixel = 0
welcome_label.Position = UDim2.new(.5, 0, .5, 0)
welcome_label.Size = UDim2.new(1, 0, 1, 0)
welcome_label.Visible = false
welcome_label.AnchorPoint = Vector2.new(.5,.5)
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
command_box.Font = Enum.Font.Arimo
command_box.PlaceholderColor3 = Color3.new(0.423529, 0.423529, 0.423529)
command_box.PlaceholderText = "Enter Command Here.."
command_box.RichText = true
command_box.Text = ""
command_box.TextColor3 = Color3.new(0.423529, 0.321569, 0.764706)
command_box.TextSize = 30
command_box.TextWrapped = true
command_box.BackgroundColor3 = Color3.new(0.0941177, 0.0941177, 0.0941177)
command_box.BorderColor3 = Color3.new(0, 0, 0)
command_box.BorderSizePixel = 0
command_box.Position = UDim2.new(0.0210526325, 0, 0.17302078, 0)
command_box.Size = UDim2.new(0.957894802, 0, 0.694077313, 0)
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
title_label.Font = Enum.Font.Arimo
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
title_label.Position = UDim2.new(-0.00210526306, 0, 0, 0)
title_label.Size = UDim2.new(1.00210524, 0, 0.17302078, 0)
title_label.Visible = true
title_label.Name = "TitleLabel"
title_label.Parent = main_frame

local help_label = Instance.new("TextLabel")
help_label.Font = Enum.Font.Arimo
help_label.Text = "Type \"cmds\" into the command prompt above to begin.\
Incomplete commands will be autocompleted for you."
help_label.TextColor3 = Color3.new(0.494118, 0.164706, 0.87451)
help_label.TextScaled = true
help_label.TextSize = 14
help_label.TextStrokeColor3 = Color3.new(0.494118, 0.164706, 0.87451)
help_label.TextStrokeTransparency = 0.5
help_label.TextWrapped = true
help_label.BackgroundColor3 = Color3.new(1, 1, 1)
help_label.BackgroundTransparency = 1
help_label.BorderColor3 = Color3.new(0, 0, 0)
help_label.BorderSizePixel = 0
help_label.Position = UDim2.new(0, 0, 0.867098212, 0)
help_label.Size = UDim2.new(1, 0, 0.132901862, 0)
help_label.Visible = true
help_label.ZIndex = 2
help_label.Name = "HelpLabel"
help_label.Parent = main_frame

local toggle_button = Instance.new("TextButton")
toggle_button.Font = Enum.Font.Arimo
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

local function ToggleButtonPressed(_inputObject, _clickCount)
    if toggle_button.Interactable then
        local SizeTween = TweenService:Create(
            toggle_button,
            TweenInfo.new(.1),
            {["Size"] = MultiplyUDim2(NormalToggleButtonSize, 1.5)}
        )

        SizeTween:Play()
        click:Play()

        if GuiOpen then
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

        if GuiOpen then
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

        GuiOpen = not GuiOpen
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
        return Notify("Could not display notification.", Statuses.Error)
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

    if not Notif or not Notif.Parent then return end

    CloseNotification(Notif, Status, Text)
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
    task.spawn(Notify, data, Statuses.Error, time)
end

local function Warn(data: string, time: number?)
    task.spawn(Notify, data, Statuses.Warning, time)
end

local function Info(data: string, time: number?)
    task.spawn(Notify, data, nil, time)
end

local function Debug(data: string, time: number?)
    if DebugMode then
        task.spawn(Notify, data, Statuses.Debug, time)
    end
end

local function Success(data: string, time: number?)
    task.spawn(Notify, data, Statuses.Success, time)
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
                "System"
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

function module.Player:Say(...)
    return Say(...)
end

local Commands = {}

module.Commands = Commands

type CommandTable = {Function: ({string?}) -> (any?), Aliases: {string?}, Arguments: {string?}, Description: string}

local function AddCMD(name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?))
    if not Commands[name:lower()] then
        for i,v in pairs(aliases) do
            aliases[i] = v:lower()
        end

        local Table: CommandTable = {}
        Table.Function = func
        Table.Description = description
        Table.Arguments = arguments
        Table.Aliases = aliases

        Commands[name:lower()] = Table
    else
        Error("Could not add command \""..name.."\". Command already exists!")
    end
end

function module:AddCMD(...)
    return AddCMD(...)
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

local function ReplaceCMD(name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?))
    if Commands[name:lower()] then
        Commands[name:lower()] = nil

        AddCMD(name, description, arguments, aliases, func)
    else
        Error("Could not replace command \""..name.."\". Command does not exist.")
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
    ClearOutput()
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
        return #PlayerList > 1 and {PlayerList[math.random(1, #PlayerList + 1)]} or {PlayerList[1]}
    end
}

module.Player = {}
module.Player.PlayerSelectors = PlayerSelectors

local function FindPlayers(...: string): {Player?}
    local Found = {}
    local Args = {...}

    for _, key in pairs(Args) do
        local IsSelector = false
        for i,v in pairs(PlayerSelectors) do
            if i == key then
                local Result = v()
                table.move(Result, 1, #Result, 1, Found)

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
            local Command: string = v:GetTags()[1]

            if search_commands_box.Text:len() > 0 and Command:sub(1, search_commands_box.Text:len()) == search_commands_box.Text then
                v.Visible = true
            elseif search_commands_box.Text:len() > 0 then
                v.Visible = false
            else
                v.Visible = true
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

command_box.FocusLost:Connect(function(enterPressed, _)
    if enterPressed then
        local String = command_box.Text
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

        local Succ, Err = pcall(Table.Function, Arguments)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        end
    end
end)

AddCMD("debugon", "Turns on debug mode. Used in development for other commands.", {}, {}, function(arguments)
    DebugMode = true
end)

AddCMD("debugoff", "Turns off debug mode.", {}, {}, function(arguments)
    DebugMode = false
end)

AddCMD("test", "A test command used in development of Raven.", {"testalias"}, {}, function(arguments)
    for i,v in pairs(arguments) do
        Debug("Argument "..i..": "..v)
    end
    Success("Successfully ran the test command!")
end)

AddCMD("cmds", "Gets all commands and displays in in a GUI.", {}, {}, function(_)
    commands_frame.Visible = true

    for _,v: Instance in ipairs(commands_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "CommandFrame" then
            v:Destroy()
        end
    end
    
    for Name: string, Table: CommandTable in pairs(Commands) do
        local Command: Frame = command_frame:Clone()
        local Label: TextLabel = Command:WaitForChild("CommandLabel")
        Command:AddTag(Name)

        Command.Parent = commands_scrolling_frame

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

        Label.Text = Name..": "..Table.Description.." | Arguments: "..Arguments.." | Aliases: "..Aliases
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
            else
                command_box:CaptureFocus()
                task.wait()
                command_box.Text = ""
            end
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

AddCMD("rejoin", "Rejoins the game.", {}, {}, function(arguments)
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    local Succ, Err = TeleportService:TeleportToPlaceInstance(PlaceId, JobId)

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
            "game.TeleportService:TeleportToPlaceInstance("..PlaceId..",\""..JobId.."\")"
        )
        Success("Copied rejoin code to clipboard!")
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

local function DestroyEspPart(part: Part, player: Player)
    if PlayerHasEsp(player) and IsEspPart(part) then
        local Table = EspPlayers[player].Parts[part]
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

local function DestroyEspPlayer(player: Player)
    if PlayerHasEsp(player) then
        for Part, Table in pairs(EspPlayers[player].Parts) do
            DestroyEspPart(Part, player)
        end

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

        if EspPlayers[player].CharacterAdded then
            EspPlayers[player].CharacterAdded:Disconnect()
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

            local PartTable = EspPlayers[player].Parts[v]

            PartTable.Box = BoxHandleAdornment

            PartTable.SizeChanged = v:GetPropertyChangedSignal("Size"):Connect(function()
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
                InitEsp(Target, character)
            end)
        end
    end
end)

AddCMD("unesp", "Disables ESP", {}, {}, function(arguments)
    for Player, Table in pairs(EspPlayers) do
        if Player then
            DestroyEspPlayer(Player)
        end
    end

    local EspFolder = GetCoreGui():FindFirstChild("RAVEN_ESP")

    if EspFolder then
        EspFolder:ClearAllChildren()
    end

    table.clear(EspPlayers)
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

local Spam = false

AddCMD("spam", "Spams a message every specified interval", {}, {"hidden (true/false)","interval","message"}, function(arguments)
    local Hidden = ToBool(arguments[1])
    local Interval = arguments[2] and tonumber(arguments[2])
    local Message = {}
    table.move(arguments, 2, #arguments, 1, Message)

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
        Humanoid.WalkSpeed = Power
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
    else
        Error("LoopJP is already on. Try running \"unloopjp\".")
    end
end)

AddCMD("unloopws", "Stops changing your walkspeed.", {}, {}, function(arguments)
    if LoopWSCon then
        LoopWSCon:Disconnect()
        LoopWSCon = nil
    else
        Error("LoopWS is already off.")
    end
end)

AddCMD("unloopjp", "Stops changing your jumppower.", {}, {}, function(arguments)
    if LoopJPCon then
        LoopJPCon:Disconnect()
        LoopJPCon = nil
    else
        Error("LoopJP is already off.")
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

local ChatLogsCon = nil

AddCMD("chatlogs", "Displays a GUI where chat messages get stored in.", {}, {}, function(arguments)
    if not ChatLogsCon then
        local Succ, Err = pcall(function()
            ChatLogsCon = Players.PlayerChatted:Connect(function(chatType: Enum.PlayerChatType, player: Player, message: string, targetPlayer: Player)
                AddChatLog(message, player)
            end)

            chat_logs_frame.Visible = true
        end)

        if not Succ and Err ~= nil and tostring(Err) then
            Error("Error: "..Err)
        end
    else
        chat_logs_frame.Visible = true
    end
end)

AddCMD("unchatlogs", "Stop recording chatlogs.", {}, {}, function(arguments)
    if ChatLogsCon then
        ChatLogsCon:Disconnect()
        ChatLogsCon = nil
        ClearChatLogs()
    else
        Error("Chatlogs are already disabled.")
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

if readfile and isfile then -- Load saved aliases.
    if isfile("RAVEN_SAVED_ALIASES") then
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