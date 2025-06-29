-- RAVEN
-- made by @bob448 or bobmichealson8 on scriptblox

-- A command-based system which can be used to create other scripts
-- This is the official base version of Raven!

local VERSION = -1

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _CoreGui = game:GetService("CoreGui")
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

do
    local TestInstance = Instance.new("ScreenGui")

    local success, _ = pcall(function()
        TestInstance.Parent = _CoreGui
    end)

    CanAccessCoreGui = success

    TestInstance:Destroy()
end

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

local raven_lite = Instance.new("ScreenGui")
raven_lite.IgnoreGuiInset = true
raven_lite.ResetOnSpawn = false
raven_lite.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
raven_lite.Name = "RavenLite"
raven_lite.Parent = GetCoreGui()

local main_frame = Instance.new("Frame")
main_frame.AnchorPoint = Vector2.new(0.5, 0)
main_frame.BackgroundColor3 = Color3.new(0, 0, 0)
main_frame.BorderColor3 = Color3.new(0, 0, 0)
main_frame.BorderSizePixel = 0
main_frame.Position = UDim2.new(0.5, 0, 0, -270)
main_frame.Size = UDim2.new(0, 475, 0, 240)
main_frame.Visible = true
main_frame.Name = "MainFrame"
main_frame.Parent = raven_lite

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
commands_frame.Parent = raven_lite

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
notifications_frame.Parent = raven_lite

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
click.Parent = raven_lite

local slide = Instance.new("Sound")
slide.RollOffMode = Enum.RollOffMode.InverseTapered
slide.SoundId = "rbxassetid://18919544132"
slide.Name = "Slide"
slide.Parent = raven_lite

AnimateGradient(animated_commands_gradient, 10)
AnimateGradient(animated_main_gradient, 10)
AnimateGradient(animated_command_gradient, 10)
AnimateGradient(animated_toggle_gradient, 10)
AnimateGradient(animated_close_commands_gradient, 10)

Draggable(commands_frame, commands_frame)

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

local Statuses = {
    Error = Color3.new(0.725490, 0, 0.301960),
    Warning = Color3.new(0.901960, 0.890196, 0.341176),
    Info = status_frame.BackgroundColor3,
    Debug = Color3.new(0.992156, 0.717647, 0.490196),
    Success = Color3.new(0.611764, 0.847058, 0.552941)
}

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

    CloseNotification(Notif, Status)
end

local DebugMode = false

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

local Commands = {}

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

local function GetCMD(name: string)
    for Name, Table in pairs(Commands) do
        if name == Name then
            return Table
        end
    end
    
    return nil
end

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
            Arguments += "["..arg.."]"..i ~= #Table.Arguments and " " or ""
        end

        if Arguments:len() == 0 then
            Arguments = "None"
        end

        Label.Text = Name..": "..Table.Description.." | Arguments: "..Arguments
    end
end)

AddCMD("clearnotifs","Clears all notifications", {}, function(arguments)
    for i,v in ipairs(notifications_frame:GetChildren()) do
        if v:IsA("Frame") and v.Name == "NotificationFrame" then
            local Status = v:FindFirstChild("StatusFrame")
            local Text = v:FindFirstChild("NotificationText")

            if Status and Text then
                task.spawn(CloseNotification, v, Status, Text)
            end
        end
    end
end)

local CloseCommandsButtonNormalSize = closecommands_button.Size
local CommandFrameNormalSize = commands_frame.Size

search_commands_box:GetPropertyChangedSignal("Text"):Connect(function()
    for i,v: Frame in ipairs(commands_scrolling_frame:GetChildren()) do
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

    for i,v: Instance in ipairs(commands_scrolling_frame:GetChildren()) do
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

        local Success, Err = pcall(Table.Function, Arguments)

        if not Success then
            Error("Error: "..tostring(Err))
        end
    end
end)

toggle_button.Interactable = false

do -- Welcome Animation
    welcome_label.Visible = true

    local version = tostring(VERSION)

    if VERSION == -1 then
        version = "BASE"
    elseif VERSION == -2 then
        version = "DEV BASE"
    end

    title_label.Text = "Raven | Version "..version

    GuiOpen = true

    local GotoClosed = TweenService:Create(
        main_frame,
        TweenInfo.new(slide.TimeLength, Enum.EasingStyle.Exponential),
        {["Position"] = ClosedPosition}
    )

    GotoClosed:Play()
    slide:Play()
    GotoClosed.Completed:Wait()

    task.wait(1)

    local GotoOpen = TweenService:Create(
        main_frame,
        TweenInfo.new(2, Enum.EasingStyle.Exponential),
        {["Position"] = OpenPosition}
    )

    GotoOpen:Play()
    toggle_button.Text = "Ʌ"
    GotoOpen.Completed:Wait()

    local WelcomeClose = TweenService:Create(
        welcome_label,
        TweenInfo.new(3, Enum.EasingStyle.Exponential),
        {["Size"] = UDim2.fromScale(0,0)}
    )

    WelcomeClose:Play()
    WelcomeClose.Completed:Wait()
end

toggle_button.Interactable = true