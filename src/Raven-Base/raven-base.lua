-- RAVEN
-- made by @bob448 or bobmichealson8 on scriptblox

-- A command-based system which can be used to create other scripts
-- This is the official base version of Raven!

local module = {}

module.Name = "Raven"
module.VERSION = 1

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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
output_label.Text = "Loading Command.."
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

AnimateGradient(animated_commands_gradient, 10)
AnimateGradient(animated_main_gradient, 10)
AnimateGradient(animated_command_gradient, 10)
AnimateGradient(animated_toggle_gradient, 10)
AnimateGradient(animated_close_commands_gradient, 10)
AnimateGradient(animated_output_gradient, 10)
AnimateGradient(animated_close_output_gradient, 10)

Draggable(commands_frame, commands_frame)
Draggable(outputs_frame, outputs_frame)

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

toggle_button.Activated:Connect(function(_inputObject, _clickCount)
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
end)

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
    CloseNotification(...)
end

local function Notify(data: string, status: Color3?, time: number?)
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
    Notify(...)
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
    Error(...)
end
function module.Notif:Warn(...)
    Warn(...)
end
function module.Notif:Info(...)
    Info(...)
end
function module.Notif:Debug(...)
    Debug(...)
end
function module.Notif:Success(...)
    Success(...)
end

local Commands = {}

module.Commands = Commands

type CommandTable = {Function: ({string?}) -> (any?), Arguments: {string?}, Description: string}

local function AddCMD(name: string, description: string, arguments: {string?}, func: ({string?}) -> (any?))
    if not Commands[name:lower()] then
        local Table: CommandTable = {}
        Table.Function = func
        Table.Description = description
        Table.Arguments = arguments

        Commands[name:lower()] = Table
    else
        Error("Could not add command \""..name.."\". Command already exists!")
    end
end

function module:AddCMD(...)
    AddCMD(...)
end

local function GetCMD(name: string)
    for Name, Table in pairs(Commands) do
        if name == Name then
            return Table
        end
    end
    
    return nil
end

function module:GetCMD(...)
    GetCMD(...)
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
    Output(...)
end

local NormalOutputsFrameSize = outputs_frame.Size
local NormalCloseOutputButtonSize = close_output_button.Size

close_output_button.Activated:Connect(function(inputObject, clickCount)
    ClearOutput()

    local CloseTween = TweenService:Create(
        outputs_frame,
        TweenInfo.new(1),
        {Size = UDim2.fromScale(0,0)}
    )

    BounceButton(close_output_button, NormalCloseOutputButtonSize)

    CloseTween:Play()
    CloseTween.Completed:Wait()

    outputs_frame.Visible = false
    outputs_frame.Size = NormalOutputsFrameSize
end)

search_output_box:GetPropertyChangedSignal("Text"):Connect(function()
    for _,v: Frame in ipairs(output_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "OutputFrame" then
            local Text = v:FindFirstChild("OutputLabel")

            if Text and search_output_box.Text:len() > 0 and Text.Text:sub(1, search_output_box.Text:len()) ~= search_output_box.Text then
                v.Visible = false
            elseif Text then
                v.Visible = true
            end
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
    FindPlayers(...)
end

local CloseCommandsButtonNormalSize = closecommands_button.Size
local CommandFrameNormalSize = commands_frame.Size

search_commands_box:GetPropertyChangedSignal("Text"):Connect(function()
    for _,v: Frame in ipairs(commands_scrolling_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "CommandFrame" then
            local Command: string = v:GetTags()[1]

            if search_commands_box.Text:len() > 0 and Command:sub(1, search_commands_box.Text:len()) ~= search_commands_box.Text then
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

    CloseTween:Play()
    CloseTween.Completed:Wait()

    commands_frame.Visible = false
    commands_frame.Size = CommandFrameNormalSize
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

        for Name: string, _ in pairs(Commands) do
            if Name:sub(1, Command:len()) == Command then
                if Shortest and (Name:len() < Shortest:len()) or Shortest == nil then
                    Shortest = Name
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
    AutoCompleteCommand(...)
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

        local Table: CommandTable = Commands[Command:lower()]

        local Succ, Err = pcall(Table.Function, Arguments)

        if not Succ and Err then
            Error("Error: "..tostring(Err))
        end
    end
end)

AddCMD("debugon", "Turns on debug mode. Used in development for other commands.", {}, function(arguments)
    DebugMode = true
end)

AddCMD("debugoff", "Turns off debug mode.", {}, function(arguments)
    DebugMode = false
end)

AddCMD("test", "A test command used in development of Raven.", {}, function(arguments)
    for i,v in pairs(arguments) do
        Debug("Argument "..i..": "..v)
    end
    Success("Successfully ran the test command!")
end)

AddCMD("cmds", "Gets all commands and displays in in a GUI.", {}, function(_)
    commands_frame.Visible = true

    for _,v: Instance in ipairs(commands_frame:GetChildren()) do
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

        Label.Text = Name..": "..Table.Description.." | Arguments: "..Arguments
    end
end)

AddCMD("clearnotifs","Clears all notifications", {}, function(arguments)
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

AddCMD("findplayer", "Finds a player based on a key or keys.", {"key"}, function(arguments)
    local Found = FindPlayers(unpack(arguments))

    for _,v in pairs(Found) do
        Info("Found player "..v.Name)
    end
end)

AddCMD("getselectors", "Gets all player selectors and displays it in a GUI.", {}, function(arguments)
    local Selectors = {}

    for Name, _ in pairs(PlayerSelectors) do
        Selectors[#Selectors+1] = Name
    end

    Output(Selectors)
end)

AddCMD("tptool", "A tool that teleports you to your mouse.", {}, function(arguments)
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

AddCMD("reset", "Sets the Humanoid state to Dead.", {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    else
        Error("Couldn't find Humanoid/Character.")
    end
end)

AddCMD("view", "Views a player.", {"player"}, function(arguments)
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

AddCMD("unview", "Sets the camera to your Humanoid.", {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid and workspace.CurrentCamera then
        workspace.CurrentCamera.CameraSubject = Humanoid
    end
end)

AddCMD("rejoin", "Rejoins the game.", {}, function(arguments)
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    local Succ, Err = TeleportService:TeleportToPlaceInstance(PlaceId, JobId)

    if not Succ and Err then
        Error("Error: "..Err)
    else
        Success("Rejoining..")
    end
end)

AddCMD("rejoincode", "Gets the rejoin code and copies it to clipboard.", {}, function(arguments)
    local PlaceId = game.PlaceId
    local JobId = game.JobId

    if CanAccessCoreGui and setclipboard then
        setclipboard(
            "game.TeleportService:TeleportToPlaceInstance("..PlaceId..",\""..JobId.."\")"
        )
        Success("Copied rejoin code to clipboard!")
    end
end)

AddCMD("god", "Disables the Dead state of the Humanoid. May not work in some games.", {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        Success("Turned godmode on.")
    end
end)

AddCMD("ungod", "Enables the Dead state of the Humanoid.", {}, function(arguments)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        Success("Turned godmode off.")
    end
end)

AddCMD("exit", "Exits the game.", {}, function(arguments)
    game:Shutdown()
end)

AddCMD("goto", "Goes to a player.", {"player"}, function(arguments)
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

AddCMD("esp", "Enables ESP, which allows you to see players through walls.", {"player"}, function(arguments)
    local Targets = arguments and FindPlayers(unpack(arguments))

    if Targets and #Targets > 0 then
        for _,Target: Player in pairs(Targets) do
            if PlayerHasEsp(Target) then
                for Part, _ in pairs(EspPlayers[Target].Parts) do
                    DestroyEspPart(Part, Target)
                end
            end
            
            if Target.Character then
                InitEsp(Target, Target.Character)
            end

            Target.CharacterAdded:Connect(function(character)
                InitEsp(Target, character)
            end)
        end
    end
end)

AddCMD("unesp", "Disables ESP", {}, function(arguments)
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

NoclipCon = nil

AddCMD("noclip", "Noclips your character.", {}, function(arguments)
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
    else
        Error("Noclip is already on.")
    end
end)

AddCMD("clip", "Stops noclipping.", {}, function(arguments)
    if NoclipCon then
        NoclipCon:Disconnect()

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if Root then
            Root.CanCollide = true
        end
    else
        Error("Noclip is already off.")
    end
end)

task.spawn(function()
    task.wait(.1)

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

return module