-- made by bobmichealson8 on scriptblox

-- have fun

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local TargetMode = false
local TargetUserName = "USERNAME"

loadstring(game:HttpGet("https://raw.githubusercontent.com/AnthonyIsntHere/anthonysrepository/main/scripts/AntiChatLogger.lua"))() -- anti chat logger by anthonyisnthere

local function say(message)
    local success = false
    if message then
        if TextChatService.ChatVersion==Enum.ChatVersion.LegacyChatService then
            success,_=pcall(function() ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All") end)
        else
            success,_=pcall(function() TextChatService.TextChannels.RBXGeneral:SendAsync(message) end)
        end
    end
    return success
end

local length3insults = {
    "{username}, I'm utterly amazed that you actually managed to press 3 keys with your fingers. With your big brain, you could have done it with your toes, but you didn't. You're a disgrace to humanity.",
    "{username}, I don't think humans have this level of stupidity. You are the lowest life-form on this planet to ever exist. You should be proud.",
    "{username} is a complete genius! They actually managed to press 3 keys with their radioactive, unknown liquid ejecting, finger appendages.",
    "{username} finally figured out how to press 3 keys! I'm so proud of you."
}

local length2insults = {
    "Wow, {username}, your brain finally started to work and came up with a two-letter word. I'm impressed, I thought you were just a moron. (you still are)",
    "{username}, you are probably amazed that you finally managed to press 2 keys with your fingers. Everyone is proud of you.",
    "{username}, you're so comedic that your entire family is laughing at you. You actually managed to press 2 KEYS. You're a genius!",
    "Congratulations, {username}, you actually did it! You pressed 2 keys with your fat, chubby fingers.. good job!"
}

local length1insults = {
    "Congrations {username}, you formed a single letter with your cheese-covered fingers! I'm surprised you even managed to do that, I thought you died from a heartattack already.",
    "With the last bit of energy left in their brain, {username} pressed a single key before they inevitably became braindead.",
    "It's a miracle come true! {username} finally learned how to press a single key! Good job, maybe you'll be able to stand up and go outside in the future!",
    "{username}, you are the genius of the century! How could someone overlook this masterpiece of a human being? Give them an award! They pressed a single key on their own!"
}

local sentenceinsults = {
    "{username} finally learned how to form a sentence! It took them 10 years, but they finally did it! I'm so proud of you!",
    "Wow, {username}, you actually managed to type a sentence with your greasy, fat fingers. You must've woken up that tiny brain of yours.",
    "Give this person an award! {username} deserves to go into the history books for being the first braindead person to type a sentence with their fingers.",
    "CONGRATULATIONS, {username}, YOU WON THE PRIZE OF SUFFOCATING TO DEATH IN OUTER SPACE! YOU ARE THE FIRST LOWER-LIFE FORM TO EVER FORM A SENTENCE WITH YOUR FINGERS!"
}

local chatinsults = {
    "{username} managed to send a message! This person needs to be rewarded for this achievement!",
    "Congratulations, {username}, we're all so proud of you. You actually came out of your vegetative state and managed to overcome your severe brain damage then sent a message!",
    "{username} used all of their brain power to send a message in chat. Good job! Everyone should be clapping right now!",
    "\"{message}\" - 🤓☝",
    "{username}, you're the reason why shampoo has instructions.",
    "{username} is the reason why silica gel packets have \"do not eat\" written on them."
}

local function findInsult(message:string)
    local length = message:len()
    if length==1 then
        if message == "." then
            return "Now how did {username} discover the existence of the period with their deformed head? I could've sworn your brain was completely nonfunctional at this point."
        else
            return length1insults[math.random(1,#length1insults)]
        end
    elseif length==2 then
        return length2insults[math.random(1,#length2insults)]
    elseif length==3 then
        return length3insults[math.random(1,#length3insults)]
    elseif message:find(" ") then
        local split = message:split(" ")
        if #split>=2 then
            local first = split[1]
            local last = split[2]
            if first:len()>=0 and last:len()>=0 then
                return sentenceinsults[math.random(1,#sentenceinsults)]
            end
        end
    end
    return chatinsults[math.random(1,#chatinsults)]
end

local function replaceUsername(message:string,Player:Player,playerMessage:string)
    message = message:gsub("{username}",Player.DisplayName or Player.Name)
    return message:gsub("{message}", playerMessage)
end

Players.PlayerChatted:Connect(function(type,player,message,recipient)
    if player~=LocalPlayer then
        if type==Enum.PlayerChatType.All and not recipient then
            if TargetMode then
                if player.Name ~= TargetUserName or player.DisplayName ~= TargetUserName then
                    return
                end
            end
            local insult = findInsult(message)
            if insult then
                local newMessage = replaceUsername(insult,player,message)
                say(newMessage)
            end
        end
    end
end)