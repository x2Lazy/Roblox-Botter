repeat wait() until game:IsLoaded() == true
wait(10)
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
repeat wait() until localplayer.Character and localplayer.Character.HumanoidRootPart
local HumanoidRootPart = localplayer.Character:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")

_G.INFO = {
	Owners = { -- Permission list for the bots.
		["Quandaledingle_Owl"]="" 
	},
	BozoLoop = false,
	FollowPlayer = "",
	LoopGoTo = "",
	LoopSay = "",
	Unlocked=false, -- Permissions unlocked (Gives everyone permission)
	ChatMode="General", -- "General" -- "All"  ||  This is the chat mode (Advanced users only)
}

local function GetPlayer(Player,Name)
	if not Name then
		return Player.Name
	end
	if string.lower(Name) == "me" then
		return Player.Name
	end
	for _, Player2 in pairs(players:GetPlayers()) do
		if (string.lower(Name) == string.sub(string.lower(Player2.Name), 1, #Name)) then
			return Player2.Name
		end
	end
end

local function ChatEvent(Msg,Player)
	local Args = string.split(Msg,", ")
	if _G.INFO.Owners[Player.Name] or _G.INFO.Unlocked == true then
		if Args[1] == "Unlock" then
			if Args[2] == "true" then
				_G.INFO.Unlocked = true
			else
				_G.INFO.Unlocked = false
			end
		end
		if Args[1] == "Come" then
			if not Args[2] then
				_G.INFO.LoopGoTo = ""
				HumanoidRootPart.CFrame = players[GetPlayer(Player,Args[2])].Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-10,10),0,math.random(-10,10))
			else
				print("Going to ",GetPlayer(Player,Args[2]))
				_G.INFO.LoopGoTo = GetPlayer(Player,Args[2])
				_G.INFO.FollowPlayer = ""
			end
		end
		if Args[1] == "Say" then
			if Args[2] == "loop" then
				_G.INFO.LoopSay = Args[3]
				_G.INFO.BozoLoop = false
			else
				_G.INFO.LoopSay = ""
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Args[2], _G.INFO.ChatMode)
			end
		end
		if Args[1] == "chatmode" then
			_G.INFO.ChatMode = Args[2]
		end
		if Args[1] == "Bo" then
			if not Args[2] then
				_G.INFO.LoopSay = ""
				_G.INFO.BozoLoop = true
			else
				_G.INFO.BozoLoop = false
			end
		end
		if Args[1] == "Rejoin" then
			if #players:GetPlayers() <= 1 then
				players.LocalPlayer:Kick("\nRejoining...")
				wait()
				TeleportService:Teleport(game.PlaceId, localplayer)
			else
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localplayer)
			end
		end
		if Args[1] == "Follow" then
			if Args[2] and Args[2] == "stop" then
				_G.INFO.FollowPlayer = ""
			else
				_G.INFO.FollowPlayer = GetPlayer(Player,Args[2])
			end
		end
	end
end

if syn then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/AnthonyIsntHere/anthonysrepository/main/scripts/AntiChatLogger.lua",true))() -- Disables chat log.
end

if not _G.INFO.Owners[localplayer.Name] then
	if setfpscap then
		setfpscap(15)
	end
	StarterGui:SetCoreGuiEnabled('PlayerList', false)
	localplayer.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
		localplayer.Character.Humanoid:MoveTo(HumanoidRootPart.Position+Vector3.new(0.1,0,0))
	end)

	UserSettings():GetService("UserGameSettings").MasterVolume = 0
	settings().Rendering.QualityLevel = 1
	workspace.CurrentCamera.FieldOfView = 15

	local Terrain = workspace:FindFirstChildOfClass('Terrain')
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 9e9
	UserSettings():GetService("UserGameSettings").MasterVolume = 0
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,v in pairs(game.Lighting:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v:Remove()
		end
	end

	spawn(function()
		while true do
			wait(math.random(0.5,1.5))
			if _G.INFO.BozoLoop == true then
				ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Bozo detected", _G.INFO.ChatMode)
			end
			pcall(function()
				if _G.INFO.LoopSay ~= "" then
					ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.INFO.LoopSay, _G.INFO.ChatMode)
				end
				if _G.INFO.LoopGoTo ~= "" then
					HumanoidRootPart.CFrame = players[_G.INFO.LoopGoTo].Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-3,3),0,math.random(-3,3))
				end
				if _G.INFO.FollowPlayer ~= "" then
					localplayer.Character.Humanoid.WalkToPoint = players[_G.INFO.FollowPlayer].Character.HumanoidRootPart.Position
				end
			end)
		end
	end)

	spawn(function()
		while wait(5) do
			pcall(function()
				HumanoidRootPart = localplayer.Character.HumanoidRootPart 
			end)
		end
	end)

	local chatEvents = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
	local messageDoneFiltering = chatEvents:WaitForChild("OnMessageDoneFiltering")
	local players = game:GetService("Players")

	messageDoneFiltering.OnClientEvent:Connect(function(message)
		local player = players:FindFirstChild(message.FromSpeaker)
		local message = message.Message or ""

		if player then
			ChatEvent(message,player)
		end
	end)


	print("Bot Controler loaded!")
else
	UserSettings():GetService("UserGameSettings").MasterVolume = 1
end
