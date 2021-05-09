local select = select

local T, C, L = Tukui:unpack();
local Panels = T.Panels;

local Class = select(2, UnitClass("player"))
local ClassColor = T.Colors.class[Class]

local Texture = T.GetTexture(C["Textures"].QuestProgressTexture)
local R, G, B = unpack(T.Colors.class[T.MyClass])

local locpanel = CreateFrame("Frame", "locpanel", UIParent)
locpanel:SetTemplate()
locpanel:SetSize(420, 22)
locpanel:SetPoint("TOP", UIParent, "TOP", 0, -14)
locpanel:SetFrameLevel(0)
locpanel:SetFrameStrata("BACKGROUND")
locpanel:EnableMouse(false)
locpanel:SetAlpha(1)

local locbar = CreateFrame("StatusBar", "locbar", UIParent)
locbar:SetTemplate()
locbar:SetFrameStrata("BACKGROUND")
locbar:SetFrameLevel(1)
locbar:SetPoint("TOP", UIParent, "TOP", 0, -17)
locbar:SetMinMaxValues(0, 100);
locbar:SetValue(35);
locbar:SetSize(410, 16)
locbar:SetStatusBarTexture(Texture)
locbar:SetStatusBarColor(1, 1, 0, 0.8)

local LocationText = locbar:CreateFontString(nil, "OVERLAY")
LocationText:SetFont(C["Medias"].Font, 14, "OUTLINE")
LocationText:SetTextColor(1, 1, 0)
LocationText:SetText("0 %")
LocationText:SetPoint("CENTER", locbar, "CENTER", 0, 0)
LocationText:SetJustifyH("CENTER")

local frame, events = CreateFrame("Frame"), {};

C_WowTokenPublic.UpdateMarketPrice();
local PGGold = math.floor(math.abs((GetMoney() / 100 / 100)));
local tokenPrice = C_WowTokenPublic.GetCurrentMarketPrice();
if tokenPrice == nil then
    tokenPrice = 0;
else
    tokenPrice = tokenPrice / 100 / 100;
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("PLAYER_MONEY");
frame:RegisterEvent("PLAYER_TRADE_MONEY");

local function eventHandler(self, event, ...)

    if event == "PLAYER_TRADE_MONEY" then
        PGGold = math.floor(math.abs((GetMoney() / 100 / 100)));
        C_WowTokenPublic.UpdateMarketPrice();
        tokenPrice = C_WowTokenPublic.GetCurrentMarketPrice();
        if tokenPrice == nil then
            C_WowTokenPublic.UpdateMarketPrice();
        else
            tokenPrice = tokenPrice / 100 / 100;
        end

        locbar:SetMinMaxValues(0, tokenPrice);
        locbar:SetValue(PGGold);

        local percentage = math.floor(((PGGold * 100) / tokenPrice) * 10) / 10;
        if(percentage < 0) then percentage = 100; end

        LocationText:SetText(percentage.." %")
    end
    if event == "PLAYER_MONEY" then
        PGGold = math.floor(math.abs((GetMoney() / 100 / 100)));
        C_WowTokenPublic.UpdateMarketPrice();
        tokenPrice = C_WowTokenPublic.GetCurrentMarketPrice();
        if tokenPrice == nil then
            C_WowTokenPublic.UpdateMarketPrice();
        else
            tokenPrice = tokenPrice / 100 / 100;
        end

        locbar:SetMinMaxValues(0, tokenPrice);
        locbar:SetValue(PGGold);

        local percentage = math.floor(((PGGold * 100) / tokenPrice) * 10) / 10;
        if(percentage < 0) then percentage = 100; end

        LocationText:SetText(percentage.." %")
    end
    if event == "PLAYER_ENTERING_WORLD" then
        PGGold = math.floor(math.abs((GetMoney() / 100 / 100)));
        C_WowTokenPublic.UpdateMarketPrice();
        tokenPrice = C_WowTokenPublic.GetCurrentMarketPrice();
        if tokenPrice == nil then
            C_WowTokenPublic.UpdateMarketPrice();
        else
            tokenPrice = tokenPrice / 100 / 100;
        end

        locbar:SetMinMaxValues(0, tokenPrice);
        locbar:SetValue(PGGold);

        local percentage = math.floor(((PGGold * 100) / tokenPrice) * 10) / 10;
        if(percentage < 0) then percentage = 100; end

        LocationText:SetText(percentage.." %")
    end

end

frame:SetScript("OnEvent", eventHandler);