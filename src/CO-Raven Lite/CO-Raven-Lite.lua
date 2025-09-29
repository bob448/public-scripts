-- CO-RAVEN LITE
-- made by @bob448 or bobmichealson8 on scriptblox

-- A Chosen One Script.

if game.PlaceId ~= 11137575513 and game.PlaceId ~= 12943245078 then
    task.spawn(loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/refs/heads/main/src/Raven-Base/raven-base.lua")))
    error("Current PlaceId is not in The Chosen One. Loading Raven Base instead.")
end

local function GetService(name: string)
    return game:GetService(name)
end

local StarterGui: StarterGui = GetService("StarterGui")
local HttpService: HttpService = GetService("HttpService")
local Lighting: Lighting = GetService("Lighting")
local ReplicatedStorage: ReplicatedStorage = GetService("ReplicatedStorage")
local RunService: RunService = GetService("RunService")
local Teams: Teams = GetService("Teams")
local Players: Players = GetService("Players")
local LocalPlayer: Player = Players.LocalPlayer
local TextChatService: TextChatService = GetService("TextChatService")
local UserInputService: UserInputService = GetService("UserInputService")

local function LoopThroughTables(...: {any?})
    local Tables = {...}
    local LoopThrough = {}

    for _, Table in Tables do
        if #Table and #Table > 0 then
            table.move(Table, 1, #Table, #LoopThrough+1, LoopThrough)
        end
    end

    return LoopThrough
end

type CommandTable = {Function: ({string?}) -> (any?), Aliases: {string?}, Arguments: {string?}, Description: string, ModuleAdded: boolean}
type RavenMod = {
    Name: string,
    VERSION: number,
    GetCoreGui: () -> (CoreGui | PlayerGui),
    CanAccessCoreGui: boolean,
    SetOpenBind: (key: string?) -> (),
    UpdateName: () -> (),
    Notif: {
        Statuses: {
            Error: Color3,
            Warning: Color3,
            Info: Color3,
            Debug: Color3,
            Success: Color3
        },
        CloseNotification: (Frame, Frame, TextLabel) -> (),
        Notify: (data: string, status: Color3?, time: number?) -> (),
        Error: (data: string, time: number?) -> (),
        Warn: (data: string, time: number?) -> (),
        Info: (data: string, time: number?) -> (),
        Debug: (data: string, time: number?) -> (),
        Success: (data: string, time: number?) -> ()
    },
    Debug: {
        GetDebugMode: () -> (boolean),
        SetDebugMode: (boolean) -> ()
    },
    Commands: {},
    AddCMD: (name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?), botcommand: boolean?) -> (),
    GetCMD: (name: string) -> (CommandTable),
    ReplaceCMD: (name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?), botcommand: boolean?) -> (),
    RunCMD: (name: string, arguments: {string?}) -> (any?),
    Output: {
        ClearOutput: () -> (),
        OutputData: (data: {any?}) -> ()
    },
    Player: {
        PlayerSelectors: {
            () -> ({Player?})
        },
        FindPlayers: () -> ({Player?}),
        Say: (message: string, hidden: boolean?) -> ()
    },
    Command: {
        AutoCompleteCommand: (data: string) -> (string?)
    },
    Gui: {
        Draggable: (mainframe: any, dragframe: any) -> (),
        AnimateGradient: (uigradient: UIGradient, speed: number) -> (RBXScriptConnection),
        BounceButton: (button: TextButton | ImageButton, OgSize: UDim2) -> ()
    },
    IsMobile: boolean,
    Instance: {
        Exists: (inst: Instance?) -> (boolean)
    },
    BringUA: {
        GetUAMode: (name: string) -> (any?),
        AddUAMode: (name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> (), initFunction: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, persistentVars: {}, size: number, speed: number) -> ()) -> (),
        ReplaceUAMode: (name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> (), initFunction: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, persistentVars: {}, size: number, speed: number) -> ()) -> (boolean)
    },
    DeletePlayer: {
        AddEffect: (Clone: Model) -> ()
    },
    BotUtils: {
        AlertAdmin: (data: string, name: string, color: Color3?) -> (),
        EnableBotMode: () -> (),
        DisableBotMode: () -> ()
    }
}

local Raven: RavenMod = loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/main/src/Raven-Base/raven-base.lua"))()
Raven.Name = "CO-Raven Lite"
Raven.VERSION = 1.9

local RavenGUI = Raven:GetCoreGui():WaitForChild("Raven")

local cancel_selection_button = Instance.new("TextButton")
cancel_selection_button.Font = Enum.Font.Arial
cancel_selection_button.Text = "Cancel"
cancel_selection_button.TextColor3 = Color3.new(1, 1, 1)
cancel_selection_button.TextScaled = true
cancel_selection_button.TextSize = 14
cancel_selection_button.TextStrokeColor3 = Color3.new(1, 0, 0)
cancel_selection_button.TextStrokeTransparency = 0.5
cancel_selection_button.TextWrapped = true
cancel_selection_button.AnchorPoint = Vector2.new(0.5, 0)
cancel_selection_button.BackgroundColor3 = Color3.new(0, 0, 0)
cancel_selection_button.BorderColor3 = Color3.new(0, 0, 0)
cancel_selection_button.BorderSizePixel = 0
cancel_selection_button.Position = UDim2.new(0.5, 0, 0.803030312, 0)
cancel_selection_button.Size = UDim2.new(0, 200, 0, 24)
cancel_selection_button.Visible = false
cancel_selection_button.Name = "CancelSelectionButton"
cancel_selection_button.Parent = RavenGUI

local uistroke = Instance.new("UIStroke")
uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke.Thickness = 5
uistroke.Parent = cancel_selection_button

local animated_close_gradient = Instance.new("UIGradient")
animated_close_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_close_gradient.Name = "AnimatedCloseGradient"
animated_close_gradient.Parent = uistroke

local uicorner = Instance.new("UICorner")
uicorner.Parent = cancel_selection_button

local confirm_selection_button = Instance.new("TextButton")
confirm_selection_button.Font = Enum.Font.Arial
confirm_selection_button.Text = "Confirm"
confirm_selection_button.TextColor3 = Color3.new(1, 1, 1)
confirm_selection_button.TextScaled = true
confirm_selection_button.TextSize = 14
confirm_selection_button.TextStrokeColor3 = Color3.new(0.145098, 0.67451, 0)
confirm_selection_button.TextStrokeTransparency = 0.5
confirm_selection_button.TextWrapped = true
confirm_selection_button.AnchorPoint = Vector2.new(0.5, 0)
confirm_selection_button.BackgroundColor3 = Color3.new(0, 0, 0)
confirm_selection_button.BorderColor3 = Color3.new(0, 0, 0)
confirm_selection_button.BorderSizePixel = 0
confirm_selection_button.Position = UDim2.new(0.5, 0, 0.748196244, 0)
confirm_selection_button.Size = UDim2.new(0, 200, 0, 24)
confirm_selection_button.Visible = false
confirm_selection_button.Name = "ConfirmSelectionButton"
confirm_selection_button.Parent = RavenGUI

local uistroke = Instance.new("UIStroke")
uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uistroke.Color = Color3.new(0.494118, 0.164706, 0.87451)
uistroke.Thickness = 5
uistroke.Parent = confirm_selection_button

local animated_confirm_gradient = Instance.new("UIGradient")
animated_confirm_gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.494118, 0.164706, 0.87451)), ColorSequenceKeypoint.new(0.46885815262794495, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0.494118, 0.164706, 0.87451))})
animated_confirm_gradient.Name = "AnimatedConfirmGradient"
animated_confirm_gradient.Parent = uistroke

local uicorner = Instance.new("UICorner")
uicorner.Parent = confirm_selection_button

local AntiFreezeCon: RBXScriptConnection? = nil

Raven:AddCMD("antifreeze", "Tries to avoid freeze by enlighten or admin.", {}, {}, function(arguments)
    if not AntiFreezeCon then
        local NoReset = false

        AntiFreezeCon = nil

        AntiFreezeCon = RunService.Heartbeat:Connect(function()
            local Character: Model? = LocalPlayer.Character
            if Character and Character:FindFirstChild("Hielo") and not NoReset then
                local Humanoid: Humanoid? = Character:FindFirstChildWhichIsA("Humanoid")
                local Root: BasePart? = Character:FindFirstChild("HumanoidRootPart")

                if Humanoid and Root then
                    NoReset = true

                    local OGPos = Root.CFrame
                    Humanoid:ChangeState(Enum.HumanoidStateType.Dead)

                    Character = LocalPlayer.CharacterAdded:Wait()
                    Root = Character:WaitForChild("HumanoidRootPart")

                    Root.CFrame = OGPos

                    NoReset = false
                end
            end
        end)

        Raven.Notif:Success("Turned on antifreeze.")
    else
        Raven.Notif:Error("Antifreeze is already on.")
    end
end)

Raven:AddCMD("unantifreeze", "Turns off antifreeze.", {}, {}, function(arguments)
    if AntiFreezeCon then
        AntiFreezeCon:Disconnect()
        AntiFreezeCon = nil
        
        Raven.Notif:Success("Turned off antifreeze.")
    else
        Raven.Notif:Error("Antifreeze is already off.")
    end
end)

local AntiBringCon: RBXScriptConnection? = nil

Raven:AddCMD("antibring", "Tries to avoid bringing by checking distances traveled.", {}, {}, function(arguments)
    if not AntiBringCon then
        local Movements: {CFrame?} = {}
        local Disable = false

        AntiBringCon = RunService.Heartbeat:Connect(function(delta)
            if Disable then return end

            local Character = LocalPlayer.Character
            local Root: Part = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChild("Humanoid")

            if Root and Humanoid and Humanoid.Health > 0 then
                Movements[#Movements+1] = Root.CFrame

                if #Movements > 15 then
                    table.remove(Movements, 1)
                end

                if #Movements >= 15 and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and not Humanoid.PlatformStand then
                    if (Movements[15].Position - Movements[1].Position).Magnitude > Humanoid.WalkSpeed + (Humanoid.UseJumpPower and Humanoid.JumpPower / 8 or Humanoid.JumpHeight) then
                        local Pos: CFrame = Movements[1]
                        table.clear(Movements)

                        Disable = true

                        repeat task.wait()
                            Root.CFrame = Pos
                        until not Raven.Instance:Exists(Character) or (Root.Position - Pos.Position).Magnitude <= 1

                        Disable = false
                    end
                end
            else
                table.clear(Movements)
                Disable = true
                task.wait(.3) -- for deathtp
                Disable = false
            end
        end)
        
        Raven.Notif:Success("Turned on antibring.")
    else
        Raven.Notif:Error("Antibring is already on!")
    end
end)

Raven:AddCMD("unantibring", "Turns off antibring.", {}, {}, function(arguments)
    if AntiBringCon then
        AntiBringCon:Disconnect()
        AntiBringCon = nil
        Raven.Notif:Success("Turned off antibring.")
    else
        Raven.Notif:Error("Antibring is already off.")
    end
end)

local function InitBuildTools(parent: Instance, includeHandle: boolean)
    local build = Instance.new("Tool")
    build.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    build.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    build.WorldPivot = CFrame.fromMatrix(Vector3.new(87.37981414794922, 0.841164231300354, 78.57115173339844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    build.Name = "Build"
    build.Parent = parent

    local preview_6 = Instance.new("SelectionBox")
    preview_6.LineThickness = 0.05000000074505806
    preview_6.SurfaceColor3 = Color3.new(0.501961, 1, 0.501961)
    preview_6.SurfaceTransparency = 0.5
    preview_6.Color3 = Color3.new(0.501961, 1, 0.501961)
    preview_6.Visible = true
    preview_6.Name = "Preview"
    preview_6.Parent = build

    local delete = Instance.new("Tool")
    delete.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    delete.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    delete.WorldPivot = CFrame.fromMatrix(Vector3.new(85.87981414794922, 11.94116497039795, 78.97115325927734), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    delete.Name = "Delete"
    delete.Parent = parent

    local preview_5 = Instance.new("SelectionBox")
    preview_5.LineThickness = 0.05000000074505806
    preview_5.SurfaceColor3 = Color3.new(1, 0.501961, 0.501961)
    preview_5.SurfaceTransparency = 0.5
    preview_5.Color3 = Color3.new(1, 0.501961, 0.501961)
    preview_5.Visible = true
    preview_5.Name = "Preview"
    preview_5.Parent = delete

    local shape = Instance.new("Tool")
    shape.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    shape.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    shape.WorldPivot = CFrame.fromMatrix(Vector3.new(85.87981414794922, 11.94116497039795, 78.97115325927734), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    shape.Name = "Shape"
    shape.Parent = parent

    local preview_3 = Instance.new("SelectionBox")
    preview_3.LineThickness = 0.05000000074505806
    preview_3.SurfaceColor3 = Color3.new(0, 0.501961, 1)
    preview_3.SurfaceTransparency = 0.5
    preview_3.Color3 = Color3.new(0, 0.501961, 1)
    preview_3.Visible = true
    preview_3.Name = "Preview"
    preview_3.Parent = shape

    local paint = Instance.new("Tool")
    paint.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    paint.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    paint.WorldPivot = CFrame.fromMatrix(Vector3.new(85.87981414794922, 11.94116497039795, 78.97115325927734), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    paint.Name = "Paint"
    paint.Parent = parent

    local preview_4 = Instance.new("SelectionBox")
    preview_4.LineThickness = 0.05000000074505806
    preview_4.SurfaceColor3 = Color3.new(0.623529, 0.631373, 0.67451)
    preview_4.SurfaceTransparency = 0.5
    preview_4.Color3 = Color3.new(0.623529, 0.631373, 0.67451)
    preview_4.Visible = true
    preview_4.Name = "Preview"
    preview_4.Parent = paint

    local sign = Instance.new("Tool")
    sign.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    sign.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    sign.WorldPivot = CFrame.fromMatrix(Vector3.new(85.87981414794922, 11.94116497039795, 78.97115325927734), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    sign.Name = "Sign"
    sign.Parent = parent

    local preview = Instance.new("SelectionBox")
    preview.LineThickness = 0.05000000074505806
    preview.SurfaceColor3 = Color3.new(0.494118, 0.407843, 0.247059)
    preview.SurfaceTransparency = 0.5
    preview.Color3 = Color3.new(0.494118, 0.407843, 0.247059)
    preview.Visible = true
    preview.Name = "Preview"
    preview.Parent = sign

    local shovel = Instance.new("Tool")
    shovel.Grip = CFrame.fromMatrix(Vector3.new(0, 0, 0.4000000059604645), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    shovel.GripPos = Vector3.new(0, 0, 0.4000000059604645)
    shovel.WorldPivot = CFrame.fromMatrix(Vector3.new(85.87981414794922, 11.94116497039795, 78.97115325927734), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
    shovel.Name = "Shovel"
    shovel.Parent = parent

    local preview_2 = Instance.new("SelectionBox")
    preview_2.LineThickness = 0.05000000074505806
    preview_2.SurfaceColor3 = Color3.new(0.854902, 0.521569, 0.254902)
    preview_2.SurfaceTransparency = 0.5
    preview_2.Color3 = Color3.new(0.854902, 0.521569, 0.254902)
    preview_2.Visible = true
    preview_2.Name = "Preview"
    preview_2.Parent = shovel

    if includeHandle then
        local handle = Instance.new("Part")
        handle.Anchored = false
        handle.AssemblyAngularVelocity = Vector3.new(1, 1, 1)
        handle.BottomSurface = Enum.SurfaceType.Smooth
        handle.BrickColor = BrickColor.new(0.4941176772117615, 0.4078431725502014, 0.24705883860588074)
        handle.CFrame = CFrame.fromMatrix(Vector3.new(8.412849426269531, 12.203357696533203, -24.174400329589844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle.Color = Color3.new(0.494118, 0.407843, 0.247059)
        handle.Material = Enum.Material.SmoothPlastic
        handle.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle.TopSurface = Enum.SurfaceType.Smooth
        handle.Name = "Handle"
        handle.Parent = sign

        local handle_2 = Instance.new("Part")
        handle_2.Anchored = false
        handle_2.AssemblyAngularVelocity = Vector3.new(1, 1, 1)
        handle_2.BottomSurface = Enum.SurfaceType.Smooth
        handle_2.BrickColor = BrickColor.new(0.8549020290374756, 0.5215686559677124, 0.2549019753932953)
        handle_2.CFrame = CFrame.fromMatrix(Vector3.new(8.412849426269531, 12.203357696533203, -24.174400329589844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle_2.Color = Color3.new(0.854902, 0.521569, 0.254902)
        handle_2.Material = Enum.Material.SmoothPlastic
        handle_2.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle_2.TopSurface = Enum.SurfaceType.Smooth
        handle_2.Name = "Handle"
        handle_2.Parent = shovel

        local handle_3 = Instance.new("Part")
        handle_3.Anchored = false
        handle_3.AssemblyAngularVelocity = Vector3.new(1, 1, 1)
        handle_3.BottomSurface = Enum.SurfaceType.Smooth
        handle_3.BrickColor = BrickColor.new(0.05098039656877518, 0.4117647409439087, 0.6745098233222961)
        handle_3.CFrame = CFrame.fromMatrix(Vector3.new(8.412849426269531, 12.203357696533203, -24.174400329589844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle_3.Color = Color3.new(0.0509804, 0.411765, 0.67451)
        handle_3.Material = Enum.Material.SmoothPlastic
        handle_3.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle_3.TopSurface = Enum.SurfaceType.Smooth
        handle_3.Name = "Handle"
        handle_3.Parent = shape

        local handle_4 = Instance.new("Part")
        handle_4.Anchored = false
        handle_4.AssemblyAngularVelocity = Vector3.new(1, 1, 1)
        handle_4.BottomSurface = Enum.SurfaceType.Smooth
        handle_4.BrickColor = BrickColor.new(0.6235294342041016, 0.6313725709915161, 0.6745098233222961)
        handle_4.CFrame = CFrame.fromMatrix(Vector3.new(8.412849426269531, 12.203357696533203, -24.174400329589844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle_4.Color = Color3.new(0.623529, 0.631373, 0.67451)
        handle_4.Material = Enum.Material.SmoothPlastic
        handle_4.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle_4.TopSurface = Enum.SurfaceType.Smooth
        handle_4.Name = "Handle"
        handle_4.Parent = paint

        local handle_5 = Instance.new("Part")
        handle_5.Anchored = false
        handle_5.AssemblyAngularVelocity = Vector3.new(1, 1, 1)
        handle_5.BottomSurface = Enum.SurfaceType.Smooth
        handle_5.BrickColor = BrickColor.new(0.7686275243759155, 0.1568627506494522, 0.1098039299249649)
        handle_5.CFrame = CFrame.fromMatrix(Vector3.new(8.412849426269531, 12.203357696533203, -24.174400329589844), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle_5.Color = Color3.new(0.768627, 0.156863, 0.109804)
        handle_5.Material = Enum.Material.SmoothPlastic
        handle_5.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle_5.TopSurface = Enum.SurfaceType.Smooth
        handle_5.Name = "Handle"
        handle_5.Parent = delete

        local handle_6 = Instance.new("Part")
        handle_6.Anchored = false
        handle_6.BottomSurface = Enum.SurfaceType.Smooth
        handle_6.BrickColor = BrickColor.new(0.29411765933036804, 0.5921568870544434, 0.29411765933036804)
        handle_6.CFrame = CFrame.fromMatrix(Vector3.new(9.912849426269531, 1.1033567190170288, -24.57440185546875), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, 0, 1))
        handle_6.Color = Color3.new(0.294118, 0.592157, 0.294118)
        handle_6.Material = Enum.Material.SmoothPlastic
        handle_6.Size = Vector3.new(0.800000011920929, 0.800000011920929, 0.800000011920929)
        handle_6.TopSurface = Enum.SurfaceType.Smooth
        handle_6.Name = "Handle"
        handle_6.Parent = build

        build:AddTag("The Chosen One by TomazDev") -- Enable animations
        delete:AddTag("The Chosen One by TomazDev")
        shape:AddTag("The Chosen One by TomazDev")
        sign:AddTag("The Chosen One by TomazDev")
        shovel:AddTag("The Chosen One by TomazDev")
        paint:AddTag("The Chosen One by TomazDev")
    else
        build.RequiresHandle = false
        delete.RequiresHandle = false
        shape.RequiresHandle = false
        paint.RequiresHandle = false
        sign.RequiresHandle = false
        shovel.RequiresHandle = false
    end

    return {build, delete, shape, paint, sign, shovel}
end

local function GetRemoteFromTool(tool: Tool)
    local Script = tool:FindFirstChild("Script") or tool:FindFirstChildWhichIsA("LocalScript")
    
    return Script and (Script:FindFirstChild("Event") or Script:FindFirstChildWhichIsA("RemoteEvent"))
end

local function GetOtherPlayerToolRemote(name: string)
    for i,v: Player in ipairs(Players:GetPlayers()) do
        if v.Character then
            local LoopThrough = {}
            local CharacterChildren = v.Character:GetChildren()
            local BackpackChildren = v.Backpack:GetChildren()

            table.move(CharacterChildren, 1, #CharacterChildren, 1, LoopThrough)
            table.move(BackpackChildren, 1, #BackpackChildren, 1, LoopThrough)

            local Remotes = {}

            for i,v in pairs(LoopThrough) do
                if v and v.Name == name then
                    local Remote = GetRemoteFromTool(v)

                    if Remote then
                        Remotes[#Remotes+1] = Remote
                    end
                end
            end

            if #Remotes == 1 then
                return Remotes[1]
            elseif #Remotes > 0 then
                return Remotes[math.random(1, #Remotes)]
            end
        end
    end

    return nil
end

local Equipped = {}
Equipped["Build"] = function()
    return LocalPlayer.PlayerGui:WaitForChild("Build")
end
Equipped["Paint"] = function()
    return LocalPlayer.PlayerGui:WaitForChild("Paint")
end
Equipped["Shape"] = function()
    return LocalPlayer.PlayerGui:WaitForChild("Shape")
end
Equipped["Shovel"] = function()
    return LocalPlayer.PlayerGui:WaitForChild("Shovel")
end
Equipped["Delete"] = function() end
Equipped["Sign"] = function() end

local Activated = {}

Activated["Build"] = function(tool: Tool)
    local Gui = Equipped.Build()
    local Button: TextButton = Gui:WaitForChild("Button")
    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.TargetSurface,
            Mouse.Hit.Position,
            Button.Text
        )
    elseif not Remote then
        Raven.Notif:Error("No build remote found.")
    end
end

Activated["Delete"] = function(tool: Tool)
    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.Hit.Position
        )
    elseif not Remote then
        Raven.Notif:Error("No delete remote found.")
    end
end

Activated["Paint"] = function(tool: Tool)
    local Gui = Equipped.Paint()
    local Color: ObjectValue = Gui:WaitForChild("Color")
    local Mater: ObjectValue = Gui:WaitForChild("Mater")
    local Button: TextButton = Gui:WaitForChild("Button")
    local SprayText: TextBox = Gui:WaitForChild("MaterUI"):WaitForChild("Spray"):WaitForChild("Input")

    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.TargetSurface,
            Mouse.Hit.Position,
            Button.Text:find("both") and "both \240\159\164\157" or Button.Text,
            Color.Value.BackgroundColor3,
            Mater.Value.Text,
            SprayText.Text
        )
    elseif not Remote then
        Raven.Notif:Error("No paint remote found.")
    end
end

Activated["Shape"] = function(tool: Tool)
    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Gui = Equipped.Shape()
    local Button: TextButton = Gui:WaitForChild("Button")

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.TargetSurface,
            Mouse.Hit.Position,
            Button.Text
        )
    elseif not Remote then
        Raven.Notif:Error("No shape remote found.")
    end
end

Activated["Shovel"] = function(tool: Tool)
    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Gui = Equipped.Shovel()
    local Button: TextButton = Gui:WaitForChild("Button")

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.TargetSurface,
            Mouse.Hit.Position,
            Button.Text
        )
    elseif not Remote then
        Raven.Notif:Error("No shovel remote found.")
    end
end

Activated["Sign"] = function(tool: Tool)
    local Remote: RemoteEvent = GetOtherPlayerToolRemote(tool.Name)

    local Mouse = LocalPlayer:GetMouse()

    if Remote and Mouse.Target and tool.Preview.Adornee then
        Remote:FireServer(
            Mouse.Target,
            Mouse.TargetSurface,
            Mouse.Hit.Position
        )
    elseif not Remote then
        Raven.Notif:Error("No sign remote found.")
    end
end

local function PartInPlayer(part: BasePart): boolean
    for i,v in ipairs(Players:GetPlayers()) do
        if v.Character then
            if part:IsDescendantOf(v.Character) then
                return true
            end
        end
    end
    return false
end

-- Decompiled with Medal's Decompiler. (Modified by SignalHub)
-- Decompiled at: 9/22/2025, 9:41:53 AM
-- Cached decompilation

-- Requiring the module was crashing the game in some
-- executors, so having the decompiled function instead,
-- personally, is an okay fix.
local function GetPos(p1, p2, p3, p4) --[[ Name: GetPosition ]] --[[ Line: 1 ]]
    local v5 = p2 / 1
    local v6 = p2 / 2
    local v7 = p2 / 4
    local v8 = p4 - v6
    if p1 == "Fill" then
        if p3.Name == "Back" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.Z
        elseif p3.Name == "Bottom" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.Y
        elseif p3.Name == "Front" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.Z
        elseif p3.Name == "Left" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.X
        elseif p3.Name == "Right" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.X
        elseif p3.Name == "Top" then
            v8 = v8 + Vector3.FromNormalId(p3) * v7.Y
        end;
    elseif p1 == "Dig" then
        if p3.Name == "Back" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.Z - Vector3.new(0, 0, v5.Z))
        elseif p3.Name == "Bottom" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.Y + Vector3.new(0, v5.Y, 0))
        elseif p3.Name == "Front" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.Z + Vector3.new(0, 0, v5.Z))
        elseif p3.Name == "Left" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.X + Vector3.new(v5.X, 0, 0))
        elseif p3.Name == "Right" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.X - Vector3.new(v5.X, 0, 0))
        elseif p3.Name == "Top" then
            v8 = v8 + (Vector3.FromNormalId(p3) * v7.Y - Vector3.new(0, v5.Y, 0))
        end;
    end;
    return Vector3.new(math.round(v8.X / v5.X) * v5.X, math.round(v8.Y / v5.Y) * v5.Y, math.round(v8.Z / v5.Z) * v5.Z) + v6;
end

local function InitBuildScripts(tools: {Tool})
    for i, tool:Tool in pairs(tools) do
        local SelectionBox: SelectionBox = tool:WaitForChild("Preview")
        local Hovering = false
        local Brick = ReplicatedStorage:FindFirstChild("Brick")

        local HoverCon = RunService.RenderStepped:Connect(function()
            if not Hovering then return end

            local Mouse = LocalPlayer:GetMouse()

            if not Mouse.Target or PartInPlayer(Mouse.Target) then
                SelectionBox.Adornee = nil
                SelectionBox.Visible = false
                return
            end

            SelectionBox.Visible = true
            if tool.Name == "Build" then
                local Gui = Equipped["Build"]()
                local Button: TextButton = Gui:WaitForChild("Button")

                if Mouse.Target.Name == "Brick" and Button.Text == "normal" then
                    SelectionBox.Adornee = Mouse.Target
                else
                    SelectionBox.Adornee = Brick
                end
            else
                if Mouse.Target.Name == "Brick" then
                    SelectionBox.Adornee = Mouse.Target
                else
                    SelectionBox.Adornee = Brick
                end
            end

            if Mouse.Target then
                Brick.Position = GetPos("Dig", Brick.Size, Mouse.TargetSurface, Mouse.Hit.Position)
            end

            if tool.Name == "Build" then
                local Gui = Equipped["Build"]()
                local Button: TextButton = Gui:WaitForChild("Button")

                if Button.Text == "normal" then
                    Brick.Size = Vector3.new(4,4,4)
                else
                    Brick.Size = Vector3.new(1,1,1)
                end
            else
                Brick.Size = Vector3.new(4,4,4)
            end
        end)

        local EquippedCon = tool.Equipped:Connect(function(mouse)
            local Gui = Equipped[tool.Name]()
            if Gui then
                Gui.Enabled = true
            end
            Hovering = true
        end)
        local function unequipped()
            Hovering = false
            SelectionBox.Adornee = nil
            SelectionBox.Visible = false
            local Gui = Equipped[tool.Name]()
            if Gui then
                Gui.Enabled = false
            end
        end
        local Unequipped = tool.Unequipped:Connect(unequipped)
        local Deactivated = tool.Deactivated:Connect(function()
            Activated[tool.Name](tool)
        end)

        local AncestryChanged; AncestryChanged = tool.AncestryChanged:Connect(function(child,parent)
            if tool.Parent ~= LocalPlayer.Backpack and tool.Parent ~= LocalPlayer.Character and tool.Parent ~= ReplicatedStorage then
                unequipped()
                tool:Destroy()
                EquippedCon:Disconnect()
                Unequipped:Disconnect()
                Deactivated:Disconnect()
                AncestryChanged:Disconnect()
                HoverCon:Disconnect()
            end
        end)
    end
end

local function ToBool(str: string)
    return str == "true"
end

Raven:AddCMD("clientbkit", "Adds some client-sided buildtools to your backpack.", {}, {"handle (true/false)"}, function(arguments)
    local HasHandle = arguments[1] and ToBool(arguments[1]) or arguments[1] == nil

    if Raven.Instance:Exists(LocalPlayer.Character) then
        local Tools = InitBuildTools(LocalPlayer.Backpack, HasHandle)
        InitBuildScripts(Tools)

        Raven.Notif:Success("Successfully initialized client-sided building tools.")
    else
        Raven.Notif:Error("Could not find character.")
    end
end)

local BreakBkitTools = {
    "Build",
    "Delete",
    "Shape",
    "Paint",
    "Sign",
    "Shovel"
}

local BreakBkitPlayers = {}

Raven:AddCMD("breakbkit", "Spams a player or a group of player's remotes so they exhaust.", {}, {"player"}, function(arguments)
    local Targets = arguments and Raven.Player:FindPlayers(unpack(arguments))

    if #Targets > 0 then
        for i,v in pairs(Targets) do
            if v and v.Character then
                BreakBkitPlayers[v] = {}

                BreakBkitPlayers[v].RenderStepped = RunService.RenderStepped:Connect(function(_)
                    if v.Character then
                        local LoopThrough = {}
                        local CharacterChildren = v.Character:GetChildren()
                        local BackpackChildren = v.Backpack:GetChildren()

                        table.move(CharacterChildren, 1, #CharacterChildren, 1, LoopThrough)
                        table.move(BackpackChildren, 1, #BackpackChildren, 1, LoopThrough)

                        for i, tool: Tool in pairs(LoopThrough) do
                            if tool and tool:IsA("Tool") and table.find(BreakBkitTools, tool.Name) then
                                local Remote = GetRemoteFromTool(tool)

                                if Remote then
                                    Remote:FireServer()
                                end
                            end
                        end
                    end
                end)

                Raven.Notif:Success("Added "..v.Name.." to the BreakBkit list.")
            end
        end
    else
        Raven.Notif:Error("No targets found.")
    end
end)

Raven:AddCMD("unbreakbkit", "Stops spamming remotes.", {}, {}, function(arguments)
    for i,v in pairs(BreakBkitPlayers) do
        if v.RenderStepped then
            v.RenderStepped:Disconnect()
        end
    end
    
    table.clear(BreakBkitPlayers)

    Raven.Notif:Success("Turned off breakbkit.")
end)

local PermAdminCon = nil

Raven:AddCMD("permadmin", "Spams reset in the system channel whenever enlighten is in your backpack or character.", {}, {}, function(arguments)
    if not PermAdminCon then
        PermAdminCon = RunService.RenderStepped:Connect(function()
            local Character = LocalPlayer.Character
            local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

            if Character and LocalPlayer.Team ~= Teams.Chosen and Humanoid then
                local Arkenstone = Character:FindFirstChild("The Arkenstone") or LocalPlayer.Backpack:FindFirstChild("The Arkenstone")
                if Arkenstone then
                    Humanoid:EquipTool(Arkenstone)

                    Raven.Player:Say(";reset me")
                end
            end
        end)

        Raven.Notif:Success("Activated permadmin.")
    else
        Raven.Notif:Error("Permadmin is already on. Try running \"unpermadmin\".")
    end
end)

Raven:AddCMD("unpermadmin", "Stops permadmin.", {}, {}, function(arguments)
    if PermAdminCon then
        PermAdminCon:Disconnect()
        PermAdminCon = nil

        Raven.Notif:Success("Stopped permadmin.")
    else
        Raven.Notif:Error("Permadmin is already off.")
    end
end)

local DisableToxic = {}
DisableToxic.Heartbeat = nil
DisableToxic.Enabled = false

Raven:AddCMD("disabletoxic", "Disables toxic blocks.", {}, {}, function(arguments)
    if not DisableToxic.Enabled then
        DisableToxic.Enabled = true

        DisableToxic.Heartbeat = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character

            if Character then
                local Toxify = Character:FindFirstChild("Toxify")

                if Toxify then
                    Toxify.Enabled = false
                end
            end
        end)

        Raven.Notif:Success("Turned on disabletoxic.")
    else
        Raven.Notif:Error("Disabletoxic is already turned on.")
    end
end)

Raven:AddCMD("enabletoxic", "Enables toxic blocks.", {}, {}, function(arguments)
    if DisableToxic.Enabled then
        DisableToxic.Enabled = false

        if DisableToxic.Heartbeat then
            DisableToxic.Heartbeat:Disconnect()
        end

        local Character = LocalPlayer.Character

        if Character then
            local Toxify = Character:FindFirstChild("Toxify")

            if Toxify then
                Toxify.Enabled = true
            end
        end

        Raven.Notif:Success("Turned off disabletoxic.")
    else
        Raven.Notif:Error("Disabletoxic is already turned off.")
    end
end)

Raven:AddCMD("disablefly", "Disables built in fly.", {}, {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        LocalPlayer:SetAttribute("Flying", false)

        Raven.Notif:Success("Disabled fly.")
    end
end)

Raven:AddCMD("enablefly", "Enables built in fly.", {}, {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        LocalPlayer:SetAttribute("Flying", true)

        Raven.Notif:Success("Enabled fly.")
    end
end)

Raven:AddCMD("unblind", "Unblinds you.", {}, {}, function(arguments)
    local BlindGUI = LocalPlayer.PlayerGui:FindFirstChild("Blind")
    local Blur = Lighting:FindFirstChild("Blur")
    local Fog = Lighting:FindFirstChild("Fog")

    if BlindGUI then
        BlindGUI.Enabled = false
    end
    if Blur then
        Blur.Enabled = false
    end
    if Fog then
        Fog.Density = 0
        Fog.Offset = 0
        Fog.Glare = 0
        Fog.Haze = 0
    end
end)

Raven:AddCMD("antiafk", "Deletes the System remote, making it so you can't lose time while unfocused.", {}, {}, function(arguments)
    local System: RemoteEvent = ReplicatedStorage:FindFirstChild("System")

    if System then
        System:FireServer("Unfocused")
        task.wait()
        System:FireServer("Focused")
        task.wait()
        System:Destroy()


        Raven.Notif:Success("Enabled antiafk.")
    else
        Raven.Notif:Error("Antiafk was already triggered before.")
    end
end)

local DeleteAuraCon = nil
local DeleteAuraHighlights = {}

Raven:AddCMD("deleteaura", "Deletes parts within the distance limit.", {}, {}, function(arguments)
    if not DeleteAuraCon then
        local Queue = {}
        local Waiting = false

        DeleteAuraCon = RunService.Heartbeat:Connect(function(delta)
            if Waiting then return end

            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local Remotes = {}

                for i, v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        local LoopThrough = LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())

                        for _, v: Tool in pairs(LoopThrough) do
                            if v:IsA("Tool") and v.Name == "Delete" then
                                local Remote = GetRemoteFromTool(v)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                if #Remotes > 0 then
                    for _, v: BasePart in ipairs(workspace.Bricks:GetDescendants()) do
                        if #Queue > 25 then
                            break
                        end
                        if v:IsA("BasePart") and LocalPlayer:DistanceFromCharacter(v.Position) <= 23 and not table.find(Queue, v) then
                            Queue[#Queue+1] = v
                        end
                    end

                    if #Queue > 0 then
                        for i, Brick in pairs(Queue) do
                            if Brick and LocalPlayer:DistanceFromCharacter(Brick.Position) <= 23 then
                                if not DeleteAuraHighlights[Brick] then
                                    local DeleteHighlight = Instance.new("Highlight")
                                    DeleteHighlight.Adornee = Brick
                                    DeleteHighlight.FillColor = Color3.new(1, 0.301960, 0.301960)
                                    DeleteHighlight.FillTransparency = .5
                                    DeleteHighlight.OutlineTransparency = 1
                                    DeleteHighlight.Parent = Brick

                                    DeleteAuraHighlights[Brick] = DeleteHighlight
                                end

                                local Remote = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]

                                Remote:FireServer(
                                    Brick,
                                    Brick.Position
                                )
                            else
                                Queue[i] = nil
                            end
                        end

                        Waiting = true

                        task.wait(.1)

                        for i, Brick in pairs(Queue) do
                            if not Raven.Instance:Exists(Brick) then
                                Queue[i] = nil
                            elseif DeleteAuraHighlights[Brick] then
                                DeleteAuraHighlights[Brick]:Destroy()
                                DeleteAuraHighlights[Brick] = nil
                            end
                        end

                        Waiting = false
                    end
                end
            end
        end)
        Raven.Notif:Success("Enabled delete aura.")
    else
        Raven.Notif:Error("Delete aura is already on. Try executing the command \"undeleteaura\".")
    end
end)

Raven:AddCMD("undeleteaura", "Turns off deleteaura.", {}, {}, function(arguments)
    if DeleteAuraCon then
        DeleteAuraCon:Disconnect()
        DeleteAuraCon = nil

        for _, v in pairs(DeleteAuraHighlights) do
            if v and v.Parent then
                v:Destroy()
            end
        end

        table.clear(DeleteAuraHighlights)

        Raven.Notif:Success("Disabled delete aura.")
    else
        Raven.Notif:Error("Delete aura is already disabled.") 
    end
end)

local AntiDrag = {}
AntiDrag.Enabled = false
AntiDrag.Heartbeat = nil

Raven:AddCMD("antidrag", "Tries to avoid being dragged by admin or enlightened.", {}, {}, function(arguments)
     if not AntiDrag.Enabled then
        local LastDragFrame = nil
        AntiDrag.Enabled = true
        AntiDrag.Heartbeat = RunService.Heartbeat:Connect(function()
            local Dragger: DragDetector? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Dragger")
            local Humanoid: Humanoid? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

            if Dragger then
                Dragger.ResponseStyle = Enum.DragDetectorResponseStyle.Custom

                if LastDragFrame ~= nil and LastDragFrame ~= Dragger.DragFrame then
                    if Humanoid then
                        Humanoid.PlatformStand = false
                        Humanoid.Sit = false

                        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end

                LastDragFrame = Dragger.DragFrame
            end
        end)

        Raven.Notif:Success("Enabled antidrag.")
    else
        Raven.Notif:Error("Antidrag is already enabled. Try running \"unantidrag\".")
    end
end)

Raven:AddCMD("unantidrag", "Stops antidrag.", {}, {}, function(arguments)
    if AntiDrag.Enabled then
        AntiDrag.Enabled = false
        
        if AntiDrag.Heartbeat then
            AntiDrag.Heartbeat:Disconnect()
        end

        local Dragger: DragDetector? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Dragger")

        if Dragger then
            Dragger.ResponseStyle = Enum.DragDetectorResponseStyle.Physical
        end

        Raven.Notif:Success("Turned off antidrag.")
    else
        Raven.Notif:Error("Antidrag is already off.")
    end
end)

local UnanchorAuraCon = nil
local UnanchorAuraHighlights = {}

Raven:AddCMD("unanchoraura", "Unanchors parts within the distance limit.", {}, {}, function(arguments)
    if not UnanchorAuraCon then
        local Queue = {}
        local Waiting = false

        UnanchorAuraCon = RunService.Heartbeat:Connect(function(delta)
            if Waiting then return end

            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local Remotes = {}

                for i, v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        local LoopThrough = LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())

                        for _, v: Tool in pairs(LoopThrough) do
                            if v:IsA("Tool") and v.Name == "Paint" then
                                local Remote = GetRemoteFromTool(v)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                if #Remotes > 0 then
                    for _, v: BasePart in ipairs(workspace.Bricks:GetDescendants()) do
                        if #Queue > 5 then
                            break
                        end
                        if v:IsA("BasePart") and v.Anchored and LocalPlayer:DistanceFromCharacter(v.Position) <= 23 and not table.find(Queue, v) then
                            Queue[#Queue+1] = v
                        end
                    end

                    if #Queue > 0 then
                        for i, Brick in pairs(Queue) do
                            if Brick and LocalPlayer:DistanceFromCharacter(Brick.Position) <= 23 and Brick.Anchored then
                                if not UnanchorAuraHighlights[Brick] then
                                    local UnanchorHighlight = Instance.new("Highlight")
                                    UnanchorHighlight.Adornee = Brick
                                    UnanchorHighlight.FillColor = Color3.new(1, 0.772549, 0.376470)
                                    UnanchorHighlight.FillTransparency = .5
                                    UnanchorHighlight.OutlineTransparency = 1
                                    UnanchorHighlight.Parent = Brick

                                    UnanchorAuraHighlights[Brick] = UnanchorHighlight
                                end

                                local Remote = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]

                                Remote:FireServer(
                                    Brick,
                                    Enum.NormalId.Top,
                                    Brick.Position,
                                    "material",
                                    Brick.Color,
                                    "anchor",
                                    ""
                                )
                            else
                                Queue[i] = nil
                            end
                        end

                        Waiting = true

                        task.wait(.1)
                        
                        for i, Brick in pairs(Queue) do
                            if not Raven.Instance:Exists(Brick) then
                                Queue[i] = nil
                            elseif UnanchorAuraHighlights[Brick] then
                                UnanchorAuraHighlights[Brick]:Destroy()
                                UnanchorAuraHighlights[Brick] = nil
                            end
                        end

                        Waiting = false
                    end
                end
            end
        end)
        Raven.Notif:Success("Enabled unanchor aura.")
    else
        Raven.Notif:Error("Unanchor aura is already on. Try executing the command \"stopunanchoraura\".")
    end
end)

Raven:AddCMD("stopunanchoraura", "Turns off unanchoraura.", {}, {}, function(arguments)
    if UnanchorAuraCon then
        UnanchorAuraCon:Disconnect()
        UnanchorAuraCon = nil

        for i,v in pairs(UnanchorAuraHighlights) do
            if v and v.Parent then
                v:Destroy()
            end
        end

        table.clear(UnanchorAuraHighlights)

        Raven.Notif:Success("Disabled unanchor aura.")
    else
        Raven.Notif:Error("Unanchor aura is already disabled.") 
    end
end)

Raven:AddCMD("hiddencommand", "Runs a chosen one command with ;", {}, {"command"}, function(arguments)
    if #arguments > 0 then
        Raven.Player:Say(";"..table.concat(arguments, " "))
    end
end)

local AntiVampireSword = {}
AntiVampireSword.Enabled = false
AntiVampireSword.CharacterAdded = nil

Raven:AddCMD("antivampiresword", "Fixes camera and inventory on spawn.", {"fixonspawn", "antivamp"}, {}, function(arguments)
    if not AntiVampireSword.Enabled then
        AntiVampireSword.Enabled = true

        AntiVampireSword.CharacterAdded = LocalPlayer.CharacterAdded:Connect(function(character)
            local Humanoid = character:WaitForChild("Humanoid")

            if workspace.CurrentCamera then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                workspace.CurrentCamera.CameraSubject = Humanoid
            end

            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        end)

        Raven.Notif:Success("Enabled antivampiresword.")
    else
        Raven.Notif:Error("Antivampiresword is already enabled. Try running \"unantivampiresword\" or \"unantivamp\".")
    end
end)

Raven:AddCMD("unantivampiresword", "Disables antivampiresword.", {"nofixonspawn", "unantivamp", "noantivamp", "noantivampiresword"}, {}, function(arguments)
    if AntiVampireSword.Enabled then
        AntiVampireSword.Enabled = false
        
        if AntiVampireSword.CharacterAdded then
            AntiVampireSword.CharacterAdded:Disconnect()
            AntiVampireSword.CharacterAdded = nil
        end

        Raven.Notif:Success("Disabled antivampiresword.")
    else
        Raven.Notif:Error("Antivampiresword is already disabled.")
    end
end)

local GetGears = {
    11377306,
    101106419,
    11419319,
    94794847,
    31839337,
    13745494,
    168141301,
    11999247,
    121946387,
    10472779,
    11450664,
    12547976,
    11563251,
    16979083,
    83021250,
    35683911,
    82357101,
    162857357,
    58574445,
    104642700,
    233520257,
    120307951,
    159229806,
    69499437,
    99119240,
    139577901,
    93136802,
    73829193,
    80597060,
    80661504,
    108158379,
    2544549379
}

Raven:AddCMD("getgears", "Gets a ton of gears. Only works if you have enlighten.", {}, {}, function(arguments)
    for _, gear in pairs(GetGears) do
        Raven.Player:Say(";gear me "..tostring(gear), true)
        task.wait(.3)
    end
end)

local BuildCircle = false
local CirclePreviews = {}

Raven:AddCMD("circle", "Creates a circle out of detailed parts.", {}, {"radius (max=23)","increase"}, function(arguments)
    local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root and not BuildCircle then
        local Radius = arguments[1] and tonumber(arguments[1]) or 23
        Radius = math.clamp(Radius, 1, 23)
        local Increase = arguments[2] and tonumber(arguments[2]) or Radius * 0.16666
        Increase = math.clamp(Increase, 1, 90)

        Raven.Notif:Success("Started building a circle.")

        BuildCircle = true

        local Queue = 0

        for i=1,5 do
            for i=-180+Increase, 180-Increase, Increase do
                if not BuildCircle then
                    return
                end

                if Queue > 3 then
                    RunService.Heartbeat:Wait()
                    Queue = 0
                end

                local Remotes = {}
                
                for _, v in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        local LoopThrough = LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())

                        for _, tool: Tool in pairs(LoopThrough) do
                            if tool:IsA("Tool") and tool.Name == "Build" then
                                local Remote = GetRemoteFromTool(tool)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                if #Remotes > 0 and Root and Root.Parent then
                    local CFrame = Root.CFrame * CFrame.fromEulerAnglesYXZ(0, math.rad(i), 0) * CFrame.new(0, 0, -Radius)
                    local Remote = Remotes[#Remotes>1 and math.random(1, #Remotes) or 1]

                    Queue += 1

                    local PreviewPart = Instance.new("Part", workspace)
                    PreviewPart.Anchored = true
                    PreviewPart.CanQuery = false
                    PreviewPart.CanTouch = false
                    PreviewPart.CanCollide = false
                    PreviewPart.Color = Color3.new(0.309803, 0.788235, 0.325490)
                    PreviewPart.Size = Vector3.new(1,1,1)
                    PreviewPart.Transparency = .9
                    PreviewPart.Material = Enum.Material.SmoothPlastic

                    PreviewPart.CFrame = CFrame

                    CirclePreviews[#CirclePreviews+1] = PreviewPart

                    Remote:FireServer(
                        workspace.Terrain,
                        Enum.NormalId.Top,
                        CFrame.Position,
                        "detailed"
                    )

                    task.spawn(function()
                        task.wait(.3)
                        if PreviewPart.Parent then
                            PreviewPart:Destroy()
                        end
                    end)
                elseif #Remotes == 0 then
                    Raven.Notif:Error("Stopped. Couldn't find a build remote.")
                    BuildCircle = false

                    return
                else
                    Raven.Notif:Error("Couldn't find HumanoidRootPart.")
                    BuildCircle = false

                    return
                end
            end
        end

        Raven.Notif:Success("Completed building a circle.")

        BuildCircle = false
    elseif BuildCircle then
        Raven.Notif:Error("You are already building a circle.")
    end
end)

Raven:AddCMD("uncircle", "Stops building a circle if you are.", {}, {}, function(arguments)
    if BuildCircle then
        BuildCircle = false

        for i,v in pairs(CirclePreviews) do
            if v.Parent then
                v:Destroy()
            end
        end

        table.clear(CirclePreviews)

        Raven.Notif:Success("Stopped building a circle.")
    else
        Raven.Notif:Error("You are not building a circle.")
    end
end)

local BuildSphere = false
local SpherePreviews = {}

Raven:AddCMD("sphere", "Creates a sphere out of detailed parts.", {}, {"radius (max=23)","increase"}, function(arguments)
    local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root and not BuildSphere then
        local Radius = arguments[1] and tonumber(arguments[1]) or 23
        Radius = math.clamp(Radius, 1, 23)
        local Increase = arguments[2] and tonumber(arguments[2]) or Radius * 0.16666
        Increase = math.clamp(Increase, 1, 90)

        Raven.Notif:Success("Started building a sphere.")

        BuildSphere = true

        local Queue = 0

        for i=1, 7 do
            for y=-90+Increase, 90-Increase, Increase do
                for x=0, 360-Increase, Increase do
                    if not BuildSphere then
                        return
                    end

                    if Queue > 15 then
                        RunService.Heartbeat:Wait()
                        Queue = 0
                    end

                    local Remotes = {}
                    
                    for _, v in ipairs(Players:GetPlayers()) do
                        if v.Character then
                            local LoopThrough = LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())

                            for _, tool: Tool in pairs(LoopThrough) do
                                if tool:IsA("Tool") and tool.Name == "Build" then
                                    local Remote = GetRemoteFromTool(tool)

                                    if Remote then Remotes[#Remotes+1] = Remote end
                                end
                            end
                        end
                    end

                    if #Remotes > 0 and Root and Root.Parent then
                        local CFrame = Root.CFrame * CFrame.fromEulerAnglesYXZ(math.rad(y), math.rad(x), 0) * CFrame.new(0, 0, -Radius)
                        local Remote = Remotes[#Remotes>1 and math.random(1, #Remotes) or 1]

                        Queue += 1

                        local PreviewPart = Instance.new("Part", workspace)
                        PreviewPart.Anchored = true
                        PreviewPart.CanQuery = false
                        PreviewPart.CanTouch = false
                        PreviewPart.CanCollide = false
                        PreviewPart.Color = Color3.new(0.309803, 0.788235, 0.325490)
                        PreviewPart.Size = Vector3.new(1,1,1)
                        PreviewPart.Transparency = .9
                        PreviewPart.Material = Enum.Material.SmoothPlastic

                        PreviewPart.CFrame = CFrame

                        SpherePreviews[#SpherePreviews+1] = PreviewPart

                        Remote:FireServer(
                            workspace.Terrain,
                            Enum.NormalId.Top,
                            CFrame.Position,
                            "detailed"
                        )

                        task.spawn(function()
                            task.wait(.3)
                            if PreviewPart.Parent then
                                PreviewPart:Destroy()
                            end
                        end)
                    elseif #Remotes == 0 then
                        Raven.Notif:Error("Stopped. Couldn't find a build remote.")
                        BuildSphere = false

                        return
                    else
                        Raven.Notif:Error("Couldn't find HumanoidRootPart.")
                        BuildSphere = false

                        return
                    end
                end
            end
        end

        Raven.Notif:Success("Completed building a sphere.")
        
        BuildSphere = false
    elseif BuildSphere then
        Raven.Notif:Error("You are already building a sphere.")
    end
end)

Raven:AddCMD("unsphere", "Stops building a sphere if you are.", {}, {}, function(arguments)
    if BuildSphere then
        BuildSphere = false

        for i,v in pairs(SpherePreviews) do
            if v.Parent then
                v:Destroy()
            end
        end

        table.clear(SpherePreviews)

        Raven.Notif:Success("Stopped building a sphere.")
    else
        Raven.Notif:Error("You are not building a sphere.")
    end
end)

local BuildAuraCon = nil
local BuildAuraPreviews = {}

Raven:AddCMD("buildaura", "Starts building signs and blocks in random positions within the distance limit.", {}, {}, function(arguments)
    if not BuildAuraCon then
        local Queue = {}

        BuildAuraCon = RunService.Heartbeat:Connect(function()
            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local Remotes = {}

                for i,v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        for i,v: Tool in pairs(LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())) do
                            if v:IsA("Tool") and (v.Name == "Build" or v.Name == "Sign") then
                                local Remote = GetRemoteFromTool(v)

                                if Remote then Remotes[#Remotes+1] = {v.Name, Remote} end
                            end
                        end
                    end
                end

                if #Remotes > 0 then
                    local RemoteTable = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]
                    local Remote = RemoteTable[2]

                    for _=1, 10 do
                        if #Queue > 10 then
                            break
                        end
                        Queue[#Queue+1] = Root.Position + Vector3.new(math.random(-23,23),math.random(-23,23),math.random(-23,23))
                    end

                    for i, Position in pairs(Queue) do
                        local PreviewBrick = Instance.new("Part", workspace)
                        PreviewBrick.Anchored = true
                        PreviewBrick.Transparency = .9
                        PreviewBrick.Material = workspace.Terrain.Material
                        PreviewBrick.Position = Position
                        PreviewBrick.CanCollide = false
                        PreviewBrick.CanTouch = false
                        PreviewBrick.CanQuery = false

                        BuildAuraPreviews[#BuildAuraPreviews+1] = PreviewBrick

                        if RemoteTable[1] == "Build" then
                            local Roll = math.random(0,2) == 0 and "detailed" or "normal"
                            PreviewBrick.Color = Color3.new(0.309803, 0.788235, 0.325490)

                            Remote:FireServer(
                                workspace.Terrain,
                                Enum.NormalId.Top,
                                Position,
                                Roll
                            )

                            if Roll == "detailed" then
                                PreviewBrick.Size = Vector3.new(1,1,1)
                            else
                                PreviewBrick.Size = Vector3.new(4,4,4)
                            end
                        else
                            PreviewBrick.Color = Color3.new(0.788235, 0.564705, 0.309803)

                            PreviewBrick.Size = Vector3.new(4,4,4)

                            Remote:FireServer(
                                workspace.Terrain,
                                Enum.NormalId.Top,
                                Position
                            )
                        end
                        
                        task.spawn(function()
                            task.wait(.3)
                            table.remove(Queue, i)

                            PreviewBrick:Destroy()
                        end)
                    end
                end
            end
        end)

        Raven.Notif:Success("Turned on buildaura.")
    else
        Raven.Notif:Error("Buildaura is already on. Try running \"unbuildaura\".")
    end
end)

Raven:AddCMD("unbuildaura", "Stops building blocks.", {}, {}, function(arguments)
    if BuildAuraCon then
        BuildAuraCon:Disconnect()
        BuildAuraCon = nil

        for i,v in pairs(BuildAuraPreviews) do
            if v and v.Parent then
                v:Destroy()
            end
        end

        table.clear(BuildAuraPreviews)

        Raven.Notif:Success("Buildaura has been turned off")
    else
        Raven.Notif:Error("Buildaura is already off.")
    end
end)

Raven:AddCMD("unenlighten", "Unenlightens a player (enlightens them and then clearinvs them)", {}, {"player"}, function(arguments)
    local Targets = Raven.Player:FindPlayers(unpack(arguments))

    if #Targets > 0 then
        local HasEnlighten = {}

        for i,v in pairs(Targets) do
            if v and v.Team ~= Teams.Chosen and v ~= LocalPlayer then
                HasEnlighten[#HasEnlighten+1] = v
            end
        end

        local Names = {}
        for _, v in pairs(HasEnlighten) do if v then Names[#Names+1] = v.Name:sub(1, #v.Name-3).."." end end

        Raven.Player:Say(";enlighten "..table.concat(Names, " "), true)

        task.wait(.1)

        while #HasEnlighten > 0 do
            task.wait(.1)

            for i,v in pairs(Targets) do
                local HasEnlightenIndex = table.find(HasEnlighten, v)
                if v and v.Parent and v.Character and HasEnlightenIndex then
                    table.clear(Names)
                    for _, v in pairs(HasEnlighten) do if v then Names[#Names+1] = v.Name:sub(1, math.ceil(v.Name:len()/2)).."." end end

                    if v.Character:FindFirstChild("The Arkenstone") or v.Backpack:FindFirstChild("The Arkenstone") then
                        Raven.Player:Say(";clearinv "..table.concat(Names, " "), true)
                    else
                        table.remove(HasEnlighten, HasEnlightenIndex)
                    end
                end
            end
        end
    end
end)

local AbuseCon = nil
local AbuseCommands = {
    "reset",
    "glitch",
    "freeze",
    "jail",
    "mute",
    "blind",
    "myopic",
    "curse",
    "oof",
    "r6",
    "food"
}

Raven:AddCMD("abuse", "Spams commands on a player or group of players.", {}, {"player"}, function(arguments)
    if not AbuseCon then
        local Targets = Raven.Player:FindPlayers(unpack(arguments))

        if #Targets > 0 then
            AbuseCon = RunService.Heartbeat:Connect(function()
                local Command = AbuseCommands[math.random(1, #AbuseCommands)]

                local Names = {}
                for i,v in pairs(Targets) do
                    if v and v.Parent then
                        Names[#Names+1] = v.Name:sub(1, math.ceil(v.Name:len()/2)).."."
                    else
                        for _, Player in ipairs(Players:GetPlayers()) do
                            if Player.Name == v.Name then
                                Targets[i] = Player
                                break
                            end
                        end
                    end
                end

                if #Names > 0 then
                    Raven.Player:Say(";"..Command.." "..table.concat(Names, " "))
                end
            end)
        end
    else
        Raven.Notif:Error("Abuse is already enabled. Try running \"unabuse\".") 
    end
end)

Raven:AddCMD("abuseall", "Abuses every other player besides yourself.", {"abuseothers","abuseo","abusea"}, {}, function(arguments)
    if not AbuseCon then
        AbuseCon = RunService.Heartbeat:Connect(function()
            local PlayerList = Players:GetPlayers()
            if #PlayerList > 1 then
                local Command = AbuseCommands[math.random(1, #AbuseCommands)]

                Raven.Player:Say(";"..Command.." others")
            end
        end)
    else
        Raven.Notif:Error("Abuse/AbuseAll is already on.")
    end
end)

Raven:AddCMD("unabuse", "Stops spamming commands.", {"unabuseall","unabuseothers","unabuseo","unabusea"}, {}, function(arguments)
    if AbuseCon then
        AbuseCon:Disconnect()
        AbuseCon = nil

        Raven.Notif:Success("Disabled abuse.")
    else
        Raven.Notif:Error("Abuse is already disabled.")
    end
end)

local Trap = {}
Trap.Enabled = false
Trap.Task = nil
Trap.Players = {}
Trap.Previews = {}

local function GetTrapOffsetPositions(Humanoid: Humanoid)
    return {
        Vector3.new(0, -Humanoid.HipHeight, -4),
        Vector3.new(0, -Humanoid.HipHeight, 4),
        Vector3.new(0, Humanoid.HipHeight, -4),
        Vector3.new(0, Humanoid.HipHeight, 4),
        Vector3.new(0, Humanoid.HipHeight, 0),
        Vector3.new(-4, -Humanoid.HipHeight, 0),
        Vector3.new(4, Humanoid.HipHeight, 0),
        Vector3.new(4, -Humanoid.HipHeight, 0),
        Vector3.new(4, Humanoid.HipHeight, 0)
    }
end

Raven:AddCMD("trap", "Traps a player.", {}, {"player"}, function(arguments)
    local Targets = Raven.Player:FindPlayers(unpack(arguments))

    for i,v in pairs(Targets) do
        if not table.find(Trap.Players, v) then
            table.insert(Trap.Players, v)

            Raven.Notif:Success("Added "..v.Name.." to the trap list. Make sure to go close to them so the blocks can be built.")
        end
    end

    if not Trap.Task then
        Trap.Enabled = true

        Trap.Task = task.spawn(function()
            local Queue = {}

            while Trap.Enabled do
                task.wait()

                local Remotes = {}

                for i,v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        for i,Tool: Tool in pairs(LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())) do
                            if Tool:IsA("Tool") and Tool.Name == "Build" then
                                local Remote = GetRemoteFromTool(Tool)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                for i, Target in pairs(Trap.Players) do
                    local Root: BasePart? = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
                    local Humanoid: Humanoid? = Target.Character and Target.Character:FindFirstChildWhichIsA("Humanoid")

                    if Root and Humanoid then
                        local Offsets = GetTrapOffsetPositions(Humanoid)

                        for i,v in pairs(Offsets) do
                            local BlockCFrame = Root.Position + v
                            Queue[#Queue+1] = BlockCFrame
                        end
                    end
                end

                if #Remotes > 0 then
                    for i,v in pairs(Queue) do
                        if i > 15 then
                            break
                        end

                        local Remote = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]

                        local Preview = Instance.new("Part", workspace)
                        Preview.Anchored = true
                        Preview.Color = Color3.new(0.309803, 0.788235, 0.325490)
                        Preview.Transparency = .9
                        Preview.CanCollide = false
                        Preview.CanQuery = false
                        Preview.CanTouch = false
                        Preview.Position = v
                        Preview.Size = Vector3.new(4,4,4)

                        Trap.Previews[#Trap.Previews+1] = Preview

                        Remote:FireServer(
                            workspace.Terrain,
                            Enum.NormalId.Top,
                            v,
                            "normal"
                        )

                        task.spawn(function()
                            task.wait(.3)
                            Preview:Destroy()
                            table.remove(Queue, i)
                        end)
                    end
                end
            end
        end)
    end
end)

Raven:AddCMD("untrap", "Stops trapping.", {}, {}, function(arguments)
    if Trap.Enabled then
        Trap.Enabled = false

        if Trap.Task then
            task.cancel(Trap.Task)
            Trap.Task = nil
        end

        for i,v in pairs(Trap.Previews) do
            if v and v.Parent then
                v:Destroy()
            end
        end

        table.clear(Trap.Previews)
        table.clear(Trap.Players)

        Raven.Notif:Success("Disabled trap.")
    else
        Raven.Notif:Error("Trap is already disabled.")
    end
end)

local function FindFirstDescendant(obj: Instance, name: string)
    if obj then
        for i,v in ipairs(obj:GetDescendants()) do
            if v.Name == name then
                return v
            end
        end
    end

    return nil
end

Raven:AddCMD("muteboombox", "Mutes the player's boombox along with their clones.", {}, {"player"}, function(arguments)
    local Targets = arguments[1] and Raven.Player:FindPlayers(arguments[1])

    local FindAll = arguments[1]:lower() == "all"

    if Targets and #Targets > 0 and not FindAll then
        local Target = Targets[1]

        local Sound: Sound? = Target.Character and FindFirstDescendant(Target.Character, "Sound")

        if Sound and Sound:IsA("Sound") and Sound.Parent.Name == "Handle" then
            Sound:Pause()
        end

        local Clones = workspace:WaitForChild("Clones")

        local TargetClones = Clones:FindFirstChild(Target.Name)

        if TargetClones then
            for i,v: Sound? in ipairs(TargetClones:GetDescendants()) do
                if v:IsA("Sound") and v.Name == "Sound" and v.Parent.Name == "Handle" then
                    v:Pause()
                end
            end
        end

        Raven.Notif:Success("Stopped all boombox sounds of target.")
    elseif FindAll then
        for i,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Sound") and v.Name == "Sound" and v.Parent.Name == "Handle" then
                v:Pause()
            end
        end
    else
        Raven.Notif:Error("Couldn't find target.")
    end
end)

Raven:AddCMD("unmuteboombox", "Unmutes the player's boombox along with their clones.", {}, {"player"}, function(arguments)
    local Targets = arguments[1] and Raven.Player:FindPlayers(arguments[1])

    local FindAll = arguments[1]:lower() == "all"

    if Targets and #Targets > 0 and not FindAll then
        local Target = Targets[1]

        local Sound: Sound? = Target.Character and FindFirstDescendant(Target.Character, "Sound")

        if Sound and Sound:IsA("Sound") and Sound.Parent.Name == "Handle" then
            Sound:Play()
        end

        local Clones = workspace:WaitForChild("Clones")

        local TargetClones = Clones:FindFirstChild(Target.Name)

        if TargetClones then
            for i,v: Sound? in ipairs(TargetClones:GetDescendants()) do
                if v:IsA("Sound") and v.Name == "Sound" and v.Parent.Name == "Handle" then
                    v:Play()
                end
            end
        end

        Raven.Notif:Success("Stopped all boombox sounds of target.")
    elseif FindAll then
        for i,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Sound") and v.Name == "Sound" and v.Parent.Name == "Handle" then
                v:Play()
            end
        end
    else
        Raven.Notif:Error("Couldn't find target.")
    end
end)

local SaveBlocks = {}
SaveBlocks.Selecting = false
SaveBlocks.CancelSelecting = false
SaveBlocks.Click = nil

local CancelSelectionOgSize = cancel_selection_button.Size
local ConfirmSelectionOgSize = confirm_selection_button.Size

cancel_selection_button.Activated:Connect(function()
    if SaveBlocks.Selecting then
        Raven.Gui:BounceButton(cancel_selection_button, CancelSelectionOgSize)

        cancel_selection_button.Visible = false

        SaveBlocks.CancelSelecting = true
        SaveBlocks.Selecting = false
    else
        cancel_selection_button.Visible = false 
    end
end)

confirm_selection_button.Activated:Connect(function()
    if SaveBlocks.Selecting then
        Raven.Gui:BounceButton(confirm_selection_button, ConfirmSelectionOgSize)
        confirm_selection_button.Visible = false

        SaveBlocks.CancelSelecting = false
        SaveBlocks.Selecting = false
    else
        confirm_selection_button.Visible = false 
    end
end)

local function IsSign(brick: Part)
    return brick:HasTag("Sign")
end

local function IsToxic(brick: Part)
    return brick:HasTag("OOF")
end

local function IsBrick(part: Part)
    return part:IsDescendantOf(workspace.Bricks)
end

local SaveBlocksSerializeFunctions = {
    ["CFrame"] = function(prop: CFrame)
        return {
            X = prop.X,
            Y = prop.Y,
            Z = prop.Z
        }
    end,
    ["Vector3"] = function(prop: Vector3)
        return {
            X = prop.X,
            Y = prop.Y,
            Z = prop.Z
        }
    end,
    ["Color3"] = function(prop: Color3)
        return {
            R = prop.R,
            G = prop.G,
            B = prop.B
        }
    end
}

local function SaveBlocksSerializeProperty(prop)
    return SaveBlocksSerializeFunctions[typeof(prop)](prop)
end

local function GetLowerLeftCorner(part: Part)
    local LeftLowerFrontCorner = -part.Size/2
    return LeftLowerFrontCorner + Vector3.new(.5, .5, .5)
end

local function BrickIsNormalSize(brick: Part)
    return brick.Size.X == 4 and brick.Size.Y == 4 and brick.Size.Z == 4
end

local function BrickIsDetailedSize(brick: Part)
    return brick.Size.X == 1 and brick.Size.Y == 1 and brick.Size.Z == 1
end

Raven:AddCMD("saveblocks", "Allows you to select blocks and then save them.", {}, {"file name"}, function(arguments)
    if not SaveBlocks.Selecting then
        if writefile and makefolder and isfolder then
            local FileName: string? = arguments[1]

            if FileName then
                if FileName:len() >= 4 and FileName:sub(FileName:len()-4, FileName:len()) ~= ".json" then
                    FileName = FileName..".json"
                end

                SaveBlocks.Selecting = true

                cancel_selection_button.Visible = true

                local Pos1 = nil
                local Pos2 = nil

                local Pos1Brick = nil
                local Pos2Brick = nil

                local Pos1SelectionBox = Instance.new("SelectionBox", ReplicatedStorage)
                Pos1SelectionBox.LineThickness = 0.05
                Pos1SelectionBox.SurfaceColor3 = Color3.new(0.517647, 1, 0.501960)
                Pos1SelectionBox.SurfaceTransparency = 0.5
                Pos1SelectionBox.Color3 = Color3.new(0.517647, 1, 0.501960)
                Pos1SelectionBox.Visible = true
                Pos1SelectionBox.Name = "Preview1"

                local Pos2SelectionBox = Instance.new("SelectionBox", ReplicatedStorage)
                Pos2SelectionBox.LineThickness = 0.05
                Pos2SelectionBox.SurfaceColor3 = Color3.new(0.909803, 0.372549, 0.372549)
                Pos2SelectionBox.SurfaceTransparency = 0.5
                Pos2SelectionBox.Color3 = Color3.new(0.909803, 0.372549, 0.372549)
                Pos2SelectionBox.Visible = true
                Pos2SelectionBox.Name = "Preview2"

                local SelectionBrick = nil
                local SelectionBrickBox = Instance.new("SelectionBox", ReplicatedStorage)
                SelectionBrickBox.LineThickness = 0.05
                SelectionBrickBox.SurfaceColor3 = Color3.new(0.501960, 0.827450, 1)
                SelectionBrickBox.SurfaceTransparency = 0.5
                SelectionBrickBox.Color3 = Color3.new(0.501960, 0.827450, 1)
                SelectionBrickBox.Visible = true
                SelectionBrickBox.Name = "Preview"

                local SelectionCFrame, SelectionSize = nil, nil

                local function ReinitializeAll()
                    Pos1SelectionBox.Parent = ReplicatedStorage
                    Pos2SelectionBox.Parent = ReplicatedStorage

                    Pos1Brick:Destroy()
                    Pos2Brick:Destroy()

                    Pos1SelectionBox.Adornee = nil
                    Pos2SelectionBox.Adornee = nil

                    SelectionBrickBox.Parent = ReplicatedStorage
                    SelectionBrickBox.Adornee = nil
                    SelectionBrick:Destroy()

                    Pos1 = nil
                    Pos2 = nil
                end

                local function DestroyAll()
                    if Pos1Brick then
                        Pos1Brick:Destroy()
                    end
                    if Pos2Brick then
                        Pos2Brick:Destroy()
                    end

                    Pos1SelectionBox:Destroy()
                    Pos2SelectionBox:Destroy()

                    if SelectionBrick then
                        SelectionBrick:Destroy()
                    end
                    SelectionBrickBox:Destroy()

                    Pos1 = nil
                    Pos2 = nil
                end

                local function SaveBlocksClickedfunction(input, gameProcessed)
                    if not gameProcessed and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        local Mouse = LocalPlayer:GetMouse()

                        if Mouse.Target and Mouse.Target.Anchored then
                            if not Pos1 then
                                local Size = Mouse.Target.Size
                                local CF = Mouse.Target.CFrame

                                if Mouse.Target:IsA("Terrain") or Mouse.Target.Name == "Beach" then
                                    Size = Vector3.new(4,4,4)
                                    local NewPos = GetPos("Dig", Size, Enum.NormalId.Top, Mouse.Hit.Position)

                                    CF = CFrame.new(NewPos)
                                end

                                Pos1Brick = Instance.new("Part", workspace)
                                Pos1Brick.Anchored = true
                                Pos1Brick.Transparency = 1
                                Pos1Brick.Size = Size
                                Pos1Brick.CFrame = CF
                                Pos1Brick.CanCollide = false
                                Pos1Brick.CanQuery = false
                                Pos1Brick.CanTouch = false

                                Pos1SelectionBox.Parent = Pos1Brick
                                Pos1SelectionBox.Adornee = Pos1Brick

                                Pos1 = CF
                            elseif not Pos2 then
                                local Size = Mouse.Target.Size
                                local CF = Mouse.Target.CFrame

                                if Mouse.Target:IsA("Terrain") or Mouse.Target.Name == "Beach" then
                                    Size = Vector3.new(4,4,4)
                                    local NewPos = GetPos("Dig", Size, Enum.NormalId.Top, Mouse.Hit.Position)

                                    CF = CFrame.new(NewPos)
                                end

                                Pos2Brick = Instance.new("Part", workspace)
                                Pos2Brick.Anchored = true
                                Pos2Brick.Transparency = 1
                                Pos2Brick.Size = Size
                                Pos2Brick.CFrame = CF
                                Pos2Brick.CanCollide = false
                                Pos2Brick.CanQuery = false
                                Pos2Brick.CanTouch = false

                                Pos2SelectionBox.Parent = Pos2Brick
                                Pos2SelectionBox.Adornee = Pos2Brick

                                Pos2 = CF

                                SelectionBrick = Instance.new("Part", workspace)
                                SelectionBrick.Transparency = 1
                                SelectionBrick.Anchored = true
                                SelectionBrick.CanCollide = false
                                SelectionBrick.CanQuery = false
                                SelectionBrick.CanTouch = false

                                SelectionBrickBox.Parent = SelectionBrick
                                SelectionBrickBox.Adornee = SelectionBrick

                                SelectionBrick.Transparency = 1

                                local Model = Instance.new("Model", workspace)
                                Pos2Brick.Parent = Model
                                Pos1Brick.Parent = Model
                                Model.PrimaryPart = Pos1Brick

                                SelectionCFrame, SelectionSize = Model:GetBoundingBox()

                                SelectionBrick.CFrame = SelectionCFrame
                                SelectionBrick.Size = SelectionSize

                                confirm_selection_button.Visible = true
                            else
                                ReinitializeAll()
                                confirm_selection_button.Visible = false
                                SaveBlocksClickedfunction(input, gameProcessed)
                            end
                        end
                    end
                end

                SaveBlocks.Click = UserInputService.InputBegan:Connect(SaveBlocksClickedfunction)

                repeat task.wait() until not SaveBlocks.Selecting

                confirm_selection_button.Visible = false
                cancel_selection_button.Visible = false

                SaveBlocks.Click:Disconnect()

                if SaveBlocks.CancelSelecting then
                    DestroyAll()
                else
                    DestroyAll()

                    Raven.Notif:Success("Saving blocks to \""..FileName.."\"..")

                    local Parts = workspace:GetPartBoundsInBox(SelectionCFrame, SelectionSize)

                    local JsonTable = {}

                    for i,v: Part in pairs(Parts) do
                        if not IsBrick(v) then
                            continue
                        end

                        local Sign = IsSign(v)
                        local Text = ""

                        if Sign then
                            local Input = v:FindFirstChild("Input")

                            if Input then
                                local Label: TextBox = Input:FindFirstChild("Label")
                                if Label then Text = Label.Text end
                            else
                                continue -- this is the base of a sign, don't save
                            end
                        end

                        local Toxic = IsToxic(v)

                        if not BrickIsNormalSize(v) and not BrickIsDetailedSize(v) then
                            local LowerLeftCorner = GetLowerLeftCorner(v)

                            for x=0, v.Size.X - 1, 1 do
                                for y=0, v.Size.Y - 1, 1 do
                                    for z=0, v.Size.Z - 1, 1 do
                                        local Offset = Vector3.new(x,y,z)
                                        local NewCFrame = v.CFrame * CFrame.new(LowerLeftCorner + Offset)

                                        JsonTable[#JsonTable+1] = {
                                            CFrame = SaveBlocksSerializeProperty(NewCFrame),
                                            Size = SaveBlocksSerializeProperty(Vector3.new(1,1,1)),
                                            Material = v.Material.Value,
                                            Color = SaveBlocksSerializeProperty(v.Color),
                                            Sign = Sign,
                                            Text = Text,
                                            Toxic = Toxic
                                        }
                                    end
                                end
                            end
                        else
                            JsonTable[#JsonTable+1] = {
                                CFrame = SaveBlocksSerializeProperty(v.CFrame),
                                Size = SaveBlocksSerializeProperty(v.Size),
                                Material = v.Material.Value,
                                Color = SaveBlocksSerializeProperty(v.Color),
                                Sign = Sign,
                                Text = Text,
                                Toxic = Toxic
                            }
                        end
                    end

                    if not isfolder("CORAVEN_SAVED_BLOCKS") then
                        makefolder("CORAVEN_SAVED_BLOCKS")
                    end

                    writefile("CORAVEN_SAVED_BLOCKS/"..FileName, HttpService:JSONEncode(JsonTable))

                    Raven.Notif:Success("Saved selected bricks to file \""..FileName.."\"\n in workspace folder.")
                end
            else
                Raven.Notif:Error("No filename supplied.")
            end
        else
            Raven.Notif:Error("Your executor does not support writefile/isfolder/makefolder.")
        end
    elseif SaveBlocks.Selecting then
        Raven.Notif:Error("You are already selecting blocks to save.")
    end
end)

local LoadBlocks = {}
LoadBlocks.Previews = {}
LoadBlocks.BuildQueue = {}
LoadBlocks.PaintQueue = {}
LoadBlocks.BuiltParts = {}
LoadBlocks.Loading = false
LoadBlocks.Task = nil

local _MatToChosenOneMat = {
    [Enum.Material.Neon.Value] = "neon",
    [Enum.Material.Metal.Value] = "metal",
    [Enum.Material.Asphalt.Value] = "asphalt",
    [Enum.Material.Concrete.Value] = "concrete",
    [Enum.Material.Pavement.Value] = "pavement",
    [Enum.Material.DiamondPlate.Value] = "steel",
    [Enum.Material.Granite.Value] = "granite",
    [Enum.Material.Marble.Value] = "marble",
    [Enum.Material.Pebble.Value] = "pebble",
    [Enum.Material.Slate.Value] = "stone",
    [Enum.Material.Wood.Value] = "wood",
    [Enum.Material.Glass.Value] = "glass",
    [Enum.Material.Snow.Value] = "snow",
    [Enum.Material.Grass.Value] = "grass",
    [Enum.Material.WoodPlanks.Value] = "planks",
    [Enum.Material.Ice.Value] = "ice",
    [Enum.Material.Brick.Value] = "bricks",
    [Enum.Material.CeramicTiles.Value] = "tiles",
    [Enum.Material.Plastic.Value] = "plastic",
    [Enum.Material.SmoothPlastic.Value] = "smooth"
}

local function MatToChosenOneMat(material: Enum.Material)
    return _MatToChosenOneMat[material]
end

Raven:AddCMD("loadblocks", "Loads blocks from a file.", {}, {"file","x offset", "y offset", "z offset"}, function(arguments)
    if readfile and isfile and isfolder then
        local FileName:string = arguments[1]
        local XOffset = arguments[2] and tonumber(arguments[2]) or 0
        local YOffset = arguments[3] and tonumber(arguments[3]) or 0
        local ZOffset = arguments[4] and tonumber(arguments[4]) or 0

        if XOffset % 2 ~= 0 or YOffset % 2 ~= 0 or ZOffset % 2 ~= 0 then
            Raven.Notif:Error("Error: Offsets must be multiples of two. (offsets should be like 2,4,6,8, etc.)")
            return
        end

        if FileName then
            if FileName:len() >= 4 and FileName:sub(FileName:len()-4, FileName:len()) ~= ".json" then
                FileName = FileName..".json"
            end

            if isfolder("CORAVEN_SAVED_BLOCKS") and isfile("CORAVEN_SAVED_BLOCKS/"..FileName) and not LoadBlocks.Loading then
                local Contents: string = readfile("CORAVEN_SAVED_BLOCKS/"..FileName)

                local Json = HttpService:JSONDecode(Contents)

                if #Json > 0 then
                    for _, Part in pairs(Json) do
                        local Preview = Instance.new("Part", workspace)
                        local SelectionBox = Instance.new("SelectionBox", Preview)
                        local PaintPreviewBox = Instance.new("SelectionBox", ReplicatedStorage)
                        PaintPreviewBox.Transparency = 1
                        PaintPreviewBox.SurfaceTransparency = .3
                        PaintPreviewBox.SurfaceColor3 = Color3.fromRGB(150, 150, 150)

                        LoadBlocks.Previews[#LoadBlocks.Previews+1] = PaintPreviewBox

                        SelectionBox.Adornee = Preview
                        SelectionBox.Transparency = 1
                        SelectionBox.SurfaceTransparency = .5
                        SelectionBox.SurfaceColor3 = Color3.fromRGB(150, 150, 150)

                        LoadBlocks.Previews[#LoadBlocks.Previews+1] = Preview
                        LoadBlocks.Previews[#LoadBlocks.Previews+1] = SelectionBox
                        Preview.Anchored = true
                        Preview.CanCollide = false
                        Preview.CanQuery = false
                        Preview.CanTouch = false

                        local CF = CFrame.new(Part.CFrame.X + XOffset, Part.CFrame.Y + YOffset, Part.CFrame.Z + ZOffset)
                        local Size = Vector3.new(Part.Size.X, Part.Size.Y, Part.Size.Z)

                        Preview.CFrame = CF
                        Preview.Size = Size
                        Preview.Transparency = 1

                        local UnserializedPart = {
                            CFrame = CF,
                            Size = Size,
                            Material = Part.Material,
                            Color = Color3.new(Part.Color.R, Part.Color.G, Part.Color.B),
                            Sign = Part.Sign,
                            Text = Part.Text,
                            Toxic = Part.Toxic
                        }

                        LoadBlocks.BuildQueue[#LoadBlocks.BuildQueue+1] = {Preview, SelectionBox, UnserializedPart}
                        LoadBlocks.PaintQueue[#LoadBlocks.PaintQueue+1] = {nil, PaintPreviewBox, UnserializedPart}
                    end

                    LoadBlocks.Loading = true

                    LoadBlocks.Task = task.spawn(function()
                        local Building = true
                        
                        while LoadBlocks.Loading do
                            task.wait()

                            if #LoadBlocks.BuildQueue == 0 and not Building and #LoadBlocks.BuiltParts == 0 then
                                if LoadBlocks.Loading then
                                    Raven.Commands["unloadblocks"].Function()
                                end
                                break
                            elseif #LoadBlocks.BuildQueue == 0 then
                                Building = false

                                for i,v in pairs(LoadBlocks.PaintQueue) do
                                    local SelectionBox = v[2]
                                    local Part = LoadBlocks.BuiltParts[i]

                                    SelectionBox.Parent = Part
                                    SelectionBox.Adornee = Part
                                end
                            end

                            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                            if Root then
                                local Remotes = {}
                                Remotes.Build = {}
                                Remotes.Paint = {}

                                for i,v in ipairs(Players:GetPlayers()) do
                                    if v.Character then
                                        for _, Tool: Tool in pairs(LoopThroughTables(v.Character:GetChildren(), v.Backpack:GetChildren())) do
                                            if Tool:IsA("Tool") then
                                                if Tool.Name == "Paint" or Tool.Name == "Build" then
                                                    local Remote = GetRemoteFromTool(Tool)

                                                    if Remote then
                                                        table.insert(Remotes[Tool.Name], Remote)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end

                                local Camera = workspace.CurrentCamera

                                if Building and #Remotes.Build > 0 or #Remotes.Paint > 0 and Camera then
                                    local Table = Building and LoadBlocks.BuildQueue[1] or LoadBlocks.PaintQueue[1]

                                    local SelectionBox = Table[2]
                                    local Part = Table[3]
                                    local Preview = Table[1]

                                    SelectionBox.SurfaceColor3 = Color3.fromRGB(24,255,0)

                                    local Remote = Building and Remotes.Build[#Remotes.Build > 1 and math.random(1, #Remotes.Build) or 1]
                                    or Remotes.Paint[#Remotes.Paint > 1 and math.random(1, #Remotes.Paint) or 1]

                                    if Building then
                                        Root.CFrame = Part.CFrame * CFrame.new(0, 10, 0)

                                        Camera.CameraSubject = Preview

                                        Remote:FireServer(
                                            workspace.Terrain,
                                            Enum.NormalId.Top,
                                            Part.CFrame.Position,
                                            BrickIsNormalSize(Part) and "normal" or BrickIsDetailedSize(Part) and "detailed" or "detailed"
                                        )

                                        task.wait()

                                        local Parts = workspace:GetPartBoundsInBox(Part.CFrame, Part.Size - Vector3.new(.1,.1,.1))

                                        if #Parts > 0 then
                                            local InCharacter = false
                                            for i,v in pairs(Parts) do
                                                if v:IsDescendantOf(LocalPlayer.Character) then
                                                    InCharacter = true
                                                    break
                                                end
                                            end

                                            if InCharacter then
                                                continue
                                            end

                                            table.remove(LoadBlocks.BuildQueue, 1)

                                            table.remove(LoadBlocks.Previews, table.find(LoadBlocks.Previews, SelectionBox))
                                            SelectionBox:Destroy()

                                            for i,v in pairs(Parts) do
                                                if (Part.CFrame.Position - v.Position).Magnitude <= .5 then
                                                    LoadBlocks.BuiltParts[#LoadBlocks.BuiltParts+1] = v
                                                    break
                                                end
                                            end
                                        end
                                    else
                                        if not Raven.Instance:Exists(LoadBlocks.BuiltParts[1]) then
                                            table.remove(LoadBlocks.BuiltParts, 1)
                                            table.remove(LoadBlocks.PaintQueue, 1)

                                            SelectionBox:Destroy()
                                            table.remove(LoadBlocks.Previews, table.find(LoadBlocks.Previews, SelectionBox))

                                            continue
                                        end

                                        Root.CFrame = Part.CFrame * CFrame.new(0, 10, 0)

                                        Camera.CameraSubject = LoadBlocks.BuiltParts[1]

                                        Remote:FireServer(
                                            LoadBlocks.BuiltParts[1],
                                            Enum.NormalId.Top,
                                            LoadBlocks.BuiltParts[1].Position,
                                            "both \240\159\164\157",
                                            Part.Color,
                                            Part.Toxic and "toxic" or MatToChosenOneMat(Part.Material),
                                            ""
                                        )

                                        task.wait()

                                        if LoadBlocks.BuiltParts[1].Material.Value == Part.Material and LoadBlocks.BuiltParts[1].Color == Part.Color then
                                            SelectionBox:Destroy()
                                            table.remove(LoadBlocks.Previews, table.find(LoadBlocks.Previews, SelectionBox))

                                            table.remove(LoadBlocks.BuiltParts, 1)
                                            table.remove(LoadBlocks.PaintQueue, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    Raven.Notif:Success("Started loading blocks.")
                else
                    Raven.Notif:Error("No parts found in file.") 
                end
            elseif not isfolder("CORAVEN_SAVED_BLOCKS") then
                Raven.Notif:Error("You have not saved blocks yet.")
            else
                Raven.Notif:Error("That is not a file.")
            end
        elseif not FileName then
            Raven.Notif:Error("No filename supplied.")
        elseif LoadBlocks.Loading then
            Raven.Notif:Error("You are already loading blocks.")
        end
    else
        Raven.Notif:Error("Your executor does not support readfile/isfile/isfolder.")
    end
end)

Raven:AddCMD("unloadblocks", "Stops loading blocks.", {}, {}, function(arguments)
    if LoadBlocks.Loading then
        LoadBlocks.Loading = false

        task.wait()

        for i,v in pairs(LoadBlocks.Previews) do
            if v then
                v:Destroy()
            end
        end

        table.clear(LoadBlocks.Previews)
        table.clear(LoadBlocks.BuildQueue)
        table.clear(LoadBlocks.PaintQueue)
        table.clear(LoadBlocks.BuiltParts)

        if workspace.CurrentCamera and LocalPlayer.Character then
            local Humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid then workspace.CurrentCamera.CameraSubject = Humanoid end
        end

        Raven.Notif:Success("Stopped loading blocks.")
    else
        Raven.Notif:Error("You are not loading blocks.") 
    end
end)

Raven:AddCMD("saveimage", "Loads an image file and then converts it into a loadblocks compatible JSON, then saves it to the specified file name.", {}, {"image file", "save file name"}, function(arguments)
    local ImageFileName = arguments[1]
    local SaveFileName = arguments[2]

    local PNGLIB = loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/main/src/CO-Raven%20Lite/Libraries/PNG.lua"))()

    if ImageFileName and SaveFileName then
        if SaveFileName:len() >= 4 and SaveFileName:sub(SaveFileName:len()-4, SaveFileName:len()) ~= ".json" then
            SaveFileName = SaveFileName..".json"
        end
        
        if isfile and readfile and writefile and isfolder and makefolder then
            if isfile(ImageFileName) then
                local ImageBytes = readfile(ImageFileName)
                local Image

                local Succ, Err = pcall(function()
                    Image = PNGLIB.new(ImageBytes)
                end)
                
                if not Succ and Err then
                    Raven.Notif:Error("Error opening image: "..Err)
                elseif Succ then
                    local Width = Image.Width
                    local Height = Image.Height

                    local JsonTable = {}

                    Raven.Notif:Success("Saving image to \""..SaveFileName.."\"..")

                    for y = Height, 0, -1 do
                        for x = Width, 0, -1 do
                            local Color, Alpha = Image:GetPixel(x, y)

                            if Alpha < 50 then
                                continue
                            end

                            local Size = Vector3.new(4,4,4)
                            local PixelPos = Vector3.new((Width - x) * Size.X - 2, (Height - y) * Size.Y - 2, 2)

                            local CF = CFrame.new(
                                PixelPos
                            )

                            JsonTable[#JsonTable+1] = {
                                CFrame = SaveBlocksSerializeProperty(CF),
                                Size = SaveBlocksSerializeProperty(Size),
                                Material = Enum.Material.SmoothPlastic.Value,
                                Color = SaveBlocksSerializeProperty(Color),
                                Sign = false,
                                Text = "",
                                Toxic = false
                            }
                        end
                    end

                    if not isfolder("CORAVEN_SAVED_BLOCKS") then
                        makefolder("CORAVEN_SAVED_BLOCKS")
                    end

                    writefile("CORAVEN_SAVED_BLOCKS/"..SaveFileName, HttpService:JSONEncode(JsonTable))

                    Raven.Notif:Success("Done!")
                elseif not isfile(ImageFileName) then
                    Raven.Notif:Error("The passed image file name is not a file.")
                end
            else
                Raven.Notif:Error("File \""..ImageFileName.."\" not found. Make sure to put it in your workspace folder of your executor.")
            end
        else
            Raven.Notif:Error("Your executor does not support isfile/readfile/writefile/isfolder/makefolder.")
        end
    else
        Raven.Notif:Error("No image file/save file specified.")
    end
end)