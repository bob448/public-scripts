local function GetService(name: string)
    return game:GetService(name)
end

local Players = GetService("Players")
local LocalPlayer: Player = Players.LocalPlayer

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

type CommandTable = {Function: ({string?}) -> (any?), Aliases: {string?}, Arguments: {string?}, Description: string}

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
    AddCMD: (name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?)) -> (),
    GetCMD: (name: string) -> (CommandTable),
    ReplaceCMD: (name: string, description: string, aliases: {string?}, arguments: {string?}, func: ({string?}) -> (any?)) -> (),
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
        AddUAMode: (name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> ()) -> (),
        ReplaceUAMode: (name: string, description: string, func: (positionForce: AlignPosition, orientationForce: AlignOrientation, center: Vector3, parts: {BasePart?}, partIndex: number, part: BasePart, persistentVars: {}, size: number, speed: number) -> ()) -> (boolean)
    }
}

local Raven: RavenMod = loadstring(game:HttpGet("https://raw.githubusercontent.com/bob448/public-scripts/main/src/Raven-Base/raven-base.lua"))()
Raven.Name = "1v1MM2 Raven"
Raven.VERSION = 1

local function IsKnife(tool: Tool)
    return tool:FindFirstChild("KnifeScript") ~= nil or tool:FindFirstChild("Dmg") ~= nil
end

local function GetKnifeHandle(tool: Tool)
    if IsKnife(tool) then
        local Handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
        
        if Handle then
            return Handle
        end
    end
end

Raven:AddCMD("kill", "Kills a player with a knife.", {}, {"player"}, function(arguments)
    local Targets = Raven.Player:FindPlayers(unpack(arguments))
    
    if #Targets > 0 and firetouchinterest then
        local Before = tick()
        local MaxTryLimit = 10

        while #Targets > 0 do
            task.wait()

            for i, Target in pairs(Targets) do
                if Target then
                    local Humanoid = Target.Character and Target.Character:FindFirstChildWhichIsA("Humanoid")
                    local Root = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")

                    if Humanoid and Humanoid.Health > 0 and Root then
                        local Character: Model? = LocalPlayer.Character

                        if Character then
                            local KnifeHandle
                            local Knife

                            for _, tool: Tool in pairs(LoopThroughTables(Character:GetChildren(), LocalPlayer.Backpack:GetChildren())) do
                                if tool:IsA("Tool") then
                                    KnifeHandle = GetKnifeHandle(tool)
                                    Knife = tool

                                    if KnifeHandle then break end
                                end
                            end

                            if KnifeHandle then
                                Knife:Activate()

                                firetouchinterest(KnifeHandle, Root, 0)
                                task.wait()
                                firetouchinterest(KnifeHandle, Root, 1)
                            end
                        end
                    else
                        Targets[i] = nil
                    end
                end
            end

            if tick() > Before + MaxTryLimit then
                Raven.Notif:Error("Couldn't kill all players. Reached maximum tries.")
                return
            end
        end

        Raven.Notif:Success("Finished killing players.")
    elseif not firetouchinterest then
        Raven.Notif:Error("Your exploit does not support firetouchinterest.")
    else
        Raven.Notif:Error("No targets found.")
    end
end)