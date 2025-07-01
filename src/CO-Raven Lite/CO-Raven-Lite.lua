-- CO-RAVEN LITE
-- made by @bob448 or bobmichealson8 on scriptblox

-- A Chosen One Script.

if game.PlaceId ~= 11137575513 and game.PlaceId ~= 12943245078 then
    task.spawn(loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/refs/heads/main/src/Raven-Base/raven-base.lua")))
    error("Current PlaceId is not in The Chosen One. Loading Raven Base instead.")
end

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")

local TextChannels = TextChatService:WaitForChild("TextChannels")
local RBXSystem: TextChannel = TextChannels:WaitForChild("RBXSystem")

type CommandTable = {Function: ({string?}) -> (any?), Arguments: {string?}, Description: string}

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
    AddCMD: (name: string, description: string, arguments: {string?}, func: ({string?}) -> (any?)) -> (),
    GetCMD: (name: string) -> (CommandTable),
    ReplaceCMD: (name: string, description: string, arguments: {string?}, func: ({string?}) -> (any?)) -> (),
    Output: {
        ClearOutput: () -> (),
        OutputData: (data: {any?}) -> ()
    },
    Player: {
        PlayerSelectors: {
            () -> ({Player?})
        },
        FindPlayers: () -> ({Player?})
    },
    Command: {
        AutoCompleteCommand: (data: string) -> (string?)
    }
}

local Raven: RavenMod = loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/main/src/Raven-Base/raven-base.lua"))()
Raven.Name = "CO-Raven Lite"
Raven.VERSION = 1.5

local AntiFreezeCon: RBXScriptConnection? = nil

Raven:AddCMD("antifreeze", "Tries to avoid freeze by enlighten or admin.", {}, function(arguments)
    if not AntiFreezeCon then
        local CurrentCharacter: Model? = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local CurrentHumanoid: Humanoid? = CurrentCharacter:WaitForChild("Humanoid")
        local CurrentRoot: BasePart? = CurrentCharacter:WaitForChild("HumanoidRootPart")

        AntiFreezeCon = nil

        local function CharacterChildAdded(child: Instance)
            if child.Name == "Hielo" and CurrentHumanoid and CurrentRoot then
                if AntiFreezeCon then
                    AntiFreezeCon:Disconnect()
                end
                
                local Pos = CurrentRoot.CFrame

                CurrentHumanoid.Health = 0
                CurrentCharacter = LocalPlayer.CharacterAdded:Wait()
                CurrentHumanoid = CurrentCharacter:WaitForChild("Humanoid")
                CurrentRoot = CurrentCharacter:WaitForChild("HumanoidRootPart")
                
                CurrentRoot.CFrame = Pos

                AntiFreezeCon = CurrentCharacter.ChildAdded:Connect(CharacterChildAdded)
            end
        end

        AntiFreezeCon = CurrentCharacter.ChildAdded:Connect(CharacterChildAdded)

        Raven.Notif:Success("Turned on antifreeze.")
    else
        Raven.Notif:Error("Antifreeze is already on.")
    end
end)

Raven:AddCMD("unantifreeze", "Turns off antifreeze.", {}, function(arguments)
    if AntiFreezeCon then
        AntiFreezeCon:Disconnect()
        AntiFreezeCon = nil
        Raven.Notif:Success("Turned off antifreeze.")
    else
        Raven.Notif:Error("Antifreeze is already off.")
    end
end)

local AntiBringCon: RBXScriptConnection? = nil

Raven:AddCMD("antibring", "Tries to avoid bringing by checking distances traveled.", {}, function(arguments)
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
                        until not Character.Parent or (Root.Position - Pos.Position).Magnitude <= 1

                        Disable = false
                    end
                end
            else
                table.clear(Movements)
            end
        end)
        
        Raven.Notif:Success("Turned on antibring.")
    else
        Raven.Notif:Error("Antibring is already on!")
    end
end)

Raven:AddCMD("unantibring", "Turns off antibring.", {}, function(arguments)
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

            for i,v in pairs(LoopThrough) do
                if v and v.Name == name then
                    local Remote = GetRemoteFromTool(v)

                    if Remote then
                        return Remote
                    end
                end
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

local function InitBuildScripts(tools: {Tool})
    for i, tool:Tool in pairs(tools) do
        local SelectionBox: SelectionBox = tool:WaitForChild("Preview")
        local Hovering = false
        local GetPos = require(ReplicatedStorage:WaitForChild("GetPos"))
        local Brick = ReplicatedStorage:FindFirstChild("Brick")

        local EquippedCon = tool.Equipped:Connect(function(mouse)
            local Gui = Equipped[tool.Name]()
            if Gui then
                Gui.Enabled = true
            end
            Hovering = true
            local Con; Con = RunService.RenderStepped:Connect(function()
                if not Hovering then
                    Con:Disconnect()
                    return
                end

                local Mouse = LocalPlayer:GetMouse()
                if Mouse.Target then
                    local InChar=false
                    for i,v in ipairs(Players:GetPlayers()) do
                        if v.Character then
                            if Mouse.Target:IsDescendantOf(v.Character) then
                                InChar=true
                                break
                            end
                        end
                    end

                    if not InChar then
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
                    else
                        SelectionBox.Adornee = nil
                        SelectionBox.Visible = false
                    end
                else
                    SelectionBox.Adornee = nil
                    SelectionBox.Visible = false
                end
            end)
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
            end
        end)
    end
end

local ClientBkitTools = {}

local function ToBool(str: string)
    return str == "true"
end

Raven:AddCMD("clientbkit", "Adds some client-sided buildtools to your backpack.", {"handle (true/false)"}, function(arguments)
    local Character = LocalPlayer.Character
    local HasHandle = arguments[1] and ToBool(arguments[1]) or arguments[1] == nil

    if Character then
        local Tools = InitBuildTools(LocalPlayer.Backpack, HasHandle)
        InitBuildScripts(Tools)

        table.move(Tools, 1, #Tools, 1, ClientBkitTools)

        Raven.Notif:Success("Successfully initialized client-sided building tools.")
    else
        Raven.Notif:Error("Either could not find character, or clientbkit has already been initialized. Try running \"unclientbkit\".")
    end
end)

Raven:AddCMD("unclientbkit", "Removes the client-sided build tools from your character/backpack", {}, function(arguments)
    for i,v in pairs(ClientBkitTools) do
        if v and v.Parent then
            v:Destroy()
        end
    end

    table.clear(ClientBkitTools)

    Raven.Notif:Success("Cleared your client building tools.")
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

Raven:AddCMD("breakbkit", "Spams a player or a group of player's remotes so they exhaust.", {"player"}, function(arguments)
    local Targets = arguments and Raven.Player:FindPlayers(unpack(arguments))

    for i,v in pairs(Targets) do
        if v and v.Character then
            BreakBkitPlayers[v] = {}

            BreakBkitPlayers[v].Heartbeat = RunService.Heartbeat:Connect(function(_)
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
end)

Raven:AddCMD("unbreakbkit", "Stops spamming remotes.", {}, function(arguments)
    for i,v in pairs(BreakBkitPlayers) do
        if v.Heartbeat then
            v.Heartbeat:Disconnect()
        end
    end
    
    table.clear(BreakBkitPlayers)

    Raven.Notif:Success("Turned off breakbkit.")
end)

local PermAdminCon = nil

Raven:AddCMD("permadmin", "Spams reset in the system channel whenever enlighten is in your backpack or character.", {}, function(arguments)
    if not PermAdminCon then
        PermAdminCon = RunService.RenderStepped:Connect(function()
            local Character = LocalPlayer.Character

            if Character and LocalPlayer.Team ~= Teams.Chosen then
                if Character:FindFirstChild("The Arkenstone") or LocalPlayer.Backpack:FindFirstChild("The Arkenstone") then
                    RBXSystem:SendAsync("reset me")
                end
            end
        end)

        Raven.Notif:Success("Activated permadmin.")
    else
        Raven.Notif:Error("Permadmin is already on. Try running \"unpermadmin\".")
    end
end)

Raven:AddCMD("disabletoxic", "Disables toxic blocks.", {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        local Toxify = Character:FindFirstChild("Toxify")

        if Toxify then
            Toxify.Enabled = false
            
            Raven.Notif:Success("Disabled toxic blocks.")
        end
    end
end)

Raven:AddCMD("enabletoxic", "Enables toxic blocks.", {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        local Toxify = Character:FindFirstChild("Toxify")

        if Toxify then
            Toxify.Enabled = true

            Raven.Notif:Success("Enabled toxic blocks.")
        end
    end
end)

Raven:AddCMD("disablefly", "Disables built in fly.", {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        LocalPlayer:SetAttribute("Flying", false)

        Raven.Notif:Success("Disabled fly.")
    end
end)

Raven:AddCMD("enablefly", "Enables built in fly.", {}, function(arguments)
    local Character = LocalPlayer.Character

    if Character then
        LocalPlayer:SetAttribute("Flying", true)

        Raven.Notif:Success("Enabled fly.")
    end
end)

Raven:AddCMD("unblind", "Unblinds you.", {}, function(arguments)
    local BlindGUI = LocalPlayer.PlayerGui:FindFirstChild("Blind")
    local Blur = Lighting:FindFirstChild("Blur")

    if BlindGUI then
        BlindGUI.Enabled = false
    end
    if Blur then
        Blur.Enabled = false
    end
end)

Raven:AddCMD("antiafk", "Deletes the System remote, making it so you can't lose time while unfocused.", {}, function(arguments)
    local System: RemoteEvent = ReplicatedStorage:FindFirstChild("System")

    if System then
        System:FireServer("Unfocused")
        task.wait()
        System:FireServer("Focused")
        task.wait()
        System:Destroy()


        Raven:Success("Enabled antiafk.")
    else
        Raven:Error("Antiafk was already triggered before.")
    end
end)

local DeleteAuraCon = nil

Raven:AddCMD("deleteaura", "Deletes parts within the distance limit.", {}, function(arguments)
    if not DeleteAuraCon then
        DeleteAuraCon = RunService.Heartbeat:Connect(function(delta)
            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local Remotes = {}

                for i, v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        local LoopThrough = {}
                        local CharacterChildren = v.Character:GetChildren()
                        local BackpackChildren = v.Backpack:GetChildren()

                        table.move(CharacterChildren, 1, #CharacterChildren, 1, LoopThrough)
                        table.move(BackpackChildren, 1, #BackpackChildren, 1, LoopThrough)

                        for _, v: Tool in pairs(LoopThrough) do
                            if v:IsA("Tool") and v.Name == "Delete" then
                                local Remote = GetRemoteFromTool(v)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                if #Remotes > 0 then
                    local Brick = nil
                    local Remote = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]

                    for _, v: BasePart in ipairs(workspace.Bricks:GetDescendants()) do
                        if v:IsA("BasePart") and LocalPlayer:DistanceFromCharacter(v.Position) <= 25 then
                            Brick = v
                            break
                        end
                    end

                    if Brick then
                        Remote:FireServer(
                            Brick,
                            Brick.Position
                        )
                    end
                end
            end
        end)
        Raven.Notif:Success("Enabled delete aura.")
    else
        Raven.Notif:Error("Delete aura is already on. Try executing the command \"undeleteaura\".")
    end
end)

Raven:AddCMD("undeleteaura", "Turns off deleteaura.", {}, function(arguments)
    if DeleteAuraCon then
        DeleteAuraCon:Disconnect()
        DeleteAuraCon = nil

        Raven.Notif:Success("Disabled delete aura.")
    else
        Raven.Notif:Error("Delete aura is already disabled.") 
    end
end)

local UnanchorAuraCon = nil

Raven:AddCMD("unanchoraura", "Unanchors parts within the distance limit.", {}, function(arguments)
    if not UnanchorAuraCon then
        UnanchorAuraCon = RunService.Heartbeat:Connect(function(delta)
            local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if Root then
                local Remotes = {}

                for i, v: Player in ipairs(Players:GetPlayers()) do
                    if v.Character then
                        local LoopThrough = {}
                        local CharacterChildren = v.Character:GetChildren()
                        local BackpackChildren = v.Backpack:GetChildren()

                        table.move(CharacterChildren, 1, #CharacterChildren, 1, LoopThrough)
                        table.move(BackpackChildren, 1, #BackpackChildren, 1, LoopThrough)

                        for _, v: Tool in pairs(LoopThrough) do
                            if v:IsA("Tool") and v.Name == "Paint" then
                                local Remote = GetRemoteFromTool(v)

                                if Remote then Remotes[#Remotes+1] = Remote end
                            end
                        end
                    end
                end

                if #Remotes > 0 then
                    local Brick = nil
                    local Remote = Remotes[#Remotes > 1 and math.random(1, #Remotes) or 1]

                    for _, v: BasePart in ipairs(workspace.Bricks:GetDescendants()) do
                        if v:IsA("BasePart") and LocalPlayer:DistanceFromCharacter(v.Position) <= 25 and v.Anchored then
                            Brick = v
                            break
                        end
                    end

                    if Brick then
                        Remote:FireServer(
                            Brick,
                            Enum.NormalId.Top,
                            Brick.Position,
                            "material",
                            Brick.Color,
                            "anchor",
                            ""
                        )
                    end
                end
            end
        end)
        Raven.Notif:Success("Enabled unanchor aura.")
    else
        Raven.Notif:Error("Unanchor aura is already on. Try executing the command \"stopunanchoraura\".")
    end
end)

Raven:AddCMD("stopunanchoraura", "Turns off unanchoraura.", {}, function(arguments)
    if UnanchorAuraCon then
        UnanchorAuraCon:Disconnect()
        UnanchorAuraCon = nil

        Raven.Notif:Success("Disabled unanchor aura.")
    else
        Raven.Notif:Error("Unanchor aura is already disabled.") 
    end
end)

Raven:AddCMD("hiddencommand", "Says a chosen one command in RBXSystem.", {"command"}, function(arguments)
    if #arguments > 0 then
        RBXSystem:SendAsync(table.concat(arguments, " "))
    end
end)

local function LoopThroughTables(...: {any?})
    local Tables = {...}
    local LoopThrough = {}

    for _, Table in Tables do
        if #Table and #Table > 0 then
            table.move(Table, 1, #Table, 1, LoopThrough)
        end
    end

    return LoopThrough
end

local BuildCircle = false

Raven:AddCMD("circle", "Creates a circle out of detailed parts.", {"radius (max=23)","increase"}, function(arguments)
    local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root and not BuildCircle then
        local Radius = arguments[1] and tonumber(arguments[1]) or 10
        Radius = math.clamp(Radius, 1, 23)
        local Increase = arguments[2] and tonumber(arguments[2]) or Radius * 0.16666
        Increase = math.clamp(Increase, 1, 90)

        Raven.Notif:Success("Started building a circle.")

        BuildCircle = true

        for i=-180+Increase, 180-Increase, Increase do
            if not BuildCircle then
                return
            end

            RunService.Heartbeat:Wait()

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

                Remote:FireServer(
                    workspace.Terrain,
                    Enum.NormalId.Top,
                    CFrame.Position,
                    "detailed"
                )
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

        Raven.Notif:Success("Completed building a circle.")

        BuildCircle = false
    elseif BuildCircle then
        Raven.Notif:Error("You are already building a circle.")
    end
end)

Raven:AddCMD("uncircle", "Stops building a circle if you are.", {}, function(arguments)
    if BuildCircle then
        BuildCircle = false

        Raven.Notif:Success("Stopped building a circle.")
    else
        Raven.Notif:Error("You are not building a circle.")
    end
end)

local BuildSphere = false

Raven:AddCMD("sphere", "Creates a sphere out of detailed parts.", {"radius (max=23)","increase"}, function(arguments)
    local Root: BasePart? = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if Root and not BuildSphere then
        local Radius = arguments[1] and tonumber(arguments[1]) or 10
        Radius = math.clamp(Radius, 1, 23)
        local Increase = arguments[2] and tonumber(arguments[2]) or Radius * 0.16666
        Increase = math.clamp(Increase, 1, 90)

        Raven.Notif:Success("Started building a sphere.")

        BuildSphere = true

        for y=-90+Increase, 90-Increase, Increase do
            for x=0, 360-Increase, Increase do
                if not BuildSphere then
                    return
                end

                RunService.RenderStepped:Wait()

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

                    Remote:FireServer(
                        workspace.Terrain,
                        Enum.NormalId.Top,
                        CFrame.Position,
                        "detailed"
                    )
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

        Raven.Notif:Success("Completed building a sphere.")
        
        BuildSphere = false
    elseif BuildSphere then
        Raven.Notif:Error("You are already building a sphere.")
    end
end)

Raven:AddCMD("unsphere", "Stops building a sphere if you are.", {}, function(arguments)
    if BuildSphere then
        BuildSphere = false

        Raven.Notif:Success("Stopped building a sphere.")
    else
        Raven.Notif:Error("You are not building a sphere.")
    end
end)

Raven:AddCMD("unenlighten", "Unenlightens a player (enlightens them and then clearinvs them)", {"player"}, function(arguments)
    local Targets = Raven.Player:FindPlayers(unpack(arguments))

    if #Targets > 0 then
        local HasEnlighten = false

        local Names = {}
        for i,v in pairs(Targets) do if v then Names[#Names+1] = v.Name end end

        RBXSystem:SendAsync("enlighten "..table.concat(Names, " "))

        task.wait(.1)

        while HasEnlighten do
            task.wait(.2)

            for i,v in pairs(Targets) do
                if v and v.Character then
                    table.clear(Names)
                    for i,v in pairs(Targets) do if v then Names[#Names+1] = v.Name end end

                    if v.Character:FindFirstChild("The Arkenstone") or v.Backpack:FindFirstChild("The Arkenstone") then
                        RBXSystem:SendAsync("clearinv "..table.concat(Names, " "))
                    end
                end
            end
        end
    end
end)