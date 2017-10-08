-----------------------------------------------
--Config
-----------------------------------------------
-- Background (Value between 0-1)
backdropalpha = 0

-- Shadows/Outline
outline = false
dropshadow = true

-- Edit box positioned top (true/false)
editboxtop = true

-- Change the fontsize
fontsize = 15

-- Sticky Channels (1/0 = On/Off)
Officer = 1
Raid = 1
Guild = 1
Party = 1
Channel = 1
Battleground = 1
Whisper = 1

font = "Fonts/ARIALN.TTF"

-----------------------------------------------
--Config End
-----------------------------------------------
texture = 'Interface\\Buttons\\WHITE8x8'

ChatTypeInfo['CHANNEL'].sticky = Channel
ChatTypeInfo['GUILD'].sticky = Guild
ChatTypeInfo['OFFICER'].sticky = Officer
ChatTypeInfo['PARTY'].sticky = Party
ChatTypeInfo['RAID'].sticky = Raid
ChatTypeInfo['WHISPER'].sticky = Whisper

ChatFrameMenuButton.Show = ChatFrameMenuButton.Hide 
ChatFrameMenuButton:Hide() 
QuickJoinToastButton.Show = QuickJoinToastButton.Hide 
QuickJoinToastButton:Hide()
BNToastFrame:SetClampedToScreen(true)

_G.CHAT_WHISPER_INFORM_GET = 'To  %s:\32'
_G.CHAT_WHISPER_GET = 'From  %s:\32'
_G.CHAT_YELL_GET = '%s:\32'
_G.CHAT_SAY_GET = '%s:\32'
_G.CHAT_GUILD_GET = '|Hchannel:Guild|hGuild |h %s:\32'
_G.CHAT_PARTY_GET = '|Hchannel:Party|hParty |h %s:\32'
_G.CHAT_PARTY_LEADER_GET = '|Hchannel:party|hParty |h %s:\32'
_G.CHAT_PARTY_GUIDE_GET = '|Hchannel:PARTY|hParty |h %s:\32'
_G.CHAT_OFFICER_GET = '|Hchannel:o|hOfficer |h %s:\32'
_G.CHAT_RAID_GET = '|Hchannel:raid|hRaid |h %s:\32'
_G.CHAT_RAID_LEADER_GET = '[|Hchannel:raid|hRaid|h] %s:\32'
_G.CHAT_RAID_WARNING_GET = '[RW] %s:\32'

-- Break the Chat Tabs
CHAT_FRAME_FADE_OUT_TIME = 0
CHAT_TAB_HIDE_DELAY = 0
CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 0

local DefaultSetItemRef = SetItemRef
-- Change everything
local gsub = _G.string.gsub
local newAddMsg = {}
local function AddMessage(frame, text, ...) -- Thank you to funkydude for helping me understand gsub.
	text = gsub(text, "%[%d+%. General.-%]", "General ")
    text = gsub(text, "%[%d+%. Trade.-%]", "Trade ")
    text = gsub(text, "%[%d+%. WorldDefense%]", "Defense ")
    text = gsub(text, "%[%d+%. LocalDefense.-%]", "Local ")
    text = gsub(text, "%[%d+%. LookingForGroup%]", "LFG ")
    text = gsub(text, "%[%d+%. GuildRecruitment.-%]", "Guild Recruit ")
    text = gsub(text, "Joined Channel:", "+")
    text = gsub(text, "Left Channel:", "- ")
    text = gsub(text, "Changed Channel:", ">")
	text = gsub(text, "%[(%d0?)%. .-%]", "%1 ")
    text = gsub(text, '([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r')
                    -- ([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r')
	return newAddMsg[frame:GetName()](frame, text, ...)
end

local function DoNothing() end
-- TEST SHIT RIGHT HERE
local k = {"Left", "Mid", "Right", "FocusLeft", "FocusMid", "FocusRight"}
for j = 1, table.getn(k) do
                _G["ChatFrame1EditBox"..k[j]]:Hide()
                _G["ChatFrame1EditBox"..k[j]].Show = DoNothing
end

for i = 1, NUM_CHAT_WINDOWS do
    local editbox = _G['ChatFrame'..i..'EditBox']
    local tex=({_G["ChatFrame"..i.."EditBox"]:GetRegions()})
    local cf = _G['ChatFrame'..i]
    local f = _G["ChatFrame"..i.."ButtonFrame"]
    local resize = _G["ChatFrame"..i.."ResizeButton"]
    f.Show = f.Hide 
    f:Hide()
    editbox:SetAltArrowKeyMode(false)
    editbox:ClearAllPoints()
    if editboxtop==true then
        editbox:SetPoint('BOTTOMLEFT', _G.ChatFrame1, 'TOPLEFT', -4, 6)
        editbox:SetPoint('BOTTOMRIGHT', _G.ChatFrame1, 'TOPRIGHT', 6, 6)
        editbox:SetPoint('TOPLEFT', _G.ChatFrame1, 'TOPLEFT', -4, 30)
        editbox:SetPoint('TOPRIGHT', _G.ChatFrame1, 'TOPRIGHT', 6, 30)
    else
        editbox:SetPoint('TOPLEFT', _G.ChatFrame1, 'BOTTOMLEFT', -4, -6)
        editbox:SetPoint('TOPRIGHT', _G.ChatFrame1, 'BOTTOMRIGHT', 6, -6)
        editbox:SetPoint('BOTTOMLEFT', _G.ChatFrame1, 'BOTTOMLEFT', -4, -30)
        editbox:SetPoint('BOTTOMRIGHT', _G.ChatFrame1, 'BOTTOMRIGHT', 6, -30)
    end
    editbox:SetFont(font, fontsize+1)
    editbox:SetBackdrop({bgFile = texture, edgeFile = texture, edgeSize = 2, insets = {top = 2, left = 2, bottom = 2, right = 2}})
    editbox:SetBackdropColor(0,0,0,.8)
    editbox:SetBackdropBorderColor(0,0,0,1)
    --tex[6]:SetAlpha(0) tex[7]:SetAlpha(0) tex[8]:SetAlpha(0) tex[9]:SetAlpha(0) tex[10]:SetAlpha(0) tex[11]:SetAlpha(0)
    cf:SetMinResize(0,0)
	cf:SetMaxResize(0,0)
    cf:SetFading(false)							
	cf:SetClampRectInsets(0,0,0,0)
    cf:SetFrameStrata("LOW")
	_G["ChatFrame"..i.."TabLeft"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabMiddle"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabRight"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabSelectedMiddle"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabSelectedRight"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabSelectedLeft"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabHighlightLeft"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabHighlightRight"]:SetTexture(nil)
	_G["ChatFrame"..i.."TabHighlightMiddle"]:SetTexture(nil)
    local cft = CreateFrame("Frame","ChatBox",cf)
    cft:SetPoint("BOTTOMLEFT", cf, -4, -4)
    cft:SetPoint("TOPRIGHT", cf, 6, 4)
    cft:SetBackdrop({bgFile = texture, edgeFile = texture, edgeSize = 2, insets = {top = 0, left = 0, bottom = 0, right = 0}})
    cft:SetFrameStrata("BACKGROUND")
    if backdropalpha==1 then
        cft:SetBackdropColor(0,0,0,backdropalpha-.2)
        cft:SetBackdropBorderColor(0,0,0,backdropalpha)
    elseif backdropalpha==0 then
        cft:SetBackdropColor(0,0,0,backdropalpha)
        cft:SetBackdropBorderColor(0,0,0,backdropalpha)
    else
        cft:SetBackdropColor(0,0,0,backdropalpha)
        cft:SetBackdropBorderColor(0,0,0,backdropalpha+.2)
    end
    resize:SetPoint("BOTTOMRIGHT", cf, "BOTTOMRIGHT", 9,-5)
    resize:SetScale(.5)
    resize:SetAlpha(0.1)
    for g = 1, #CHAT_FRAME_TEXTURES do
        _G["ChatFrame"..i..CHAT_FRAME_TEXTURES[g]]:SetTexture(nil)
    end
    if i ~= 2 then
		local f = _G[format("%s%d", "ChatFrame", i)]
		newAddMsg[format("%s%d", "ChatFrame", i)] = f.AddMessage
		f.AddMessage = AddMessage
	end
    if (outline==true) then
        cf:SetFont(font, fontsize, "OUTLINE")
        cf:SetShadowOffset(0, 0)
    elseif (dropshadow==true) then
        cf:SetFont(font, fontsize)
        cf:SetShadowOffset(1, -1)
    else
        cf:SetFont(font, fontsize)
        cf:SetShadowOffset(0, 0)
    end
end

function SetItemRef(link, ...)
  local type, value = link:match("(%a+):(.+)")
  if IsAltKeyDown() and type == "player" then
    InviteUnit(value:match("([^:]+)"))
  elseif (type == "url") then
    local eb = _G['ChatFrame1EditBox']
    if not eb then return end
    eb:SetText(value)
    eb:SetFocus()
    eb:HighlightText()
    if not eb:IsShown() then eb:Show() 
        eb:SetFocus()
        end
  else
    return DefaultSetItemRef(link, ...)
  end
end
