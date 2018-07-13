-- class icons
local Icons = {
	["DRUID"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Druid",
	["HUNTER"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Hunter",
	["MAGE"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Mage",
	["PALADIN"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Paladin",
	["PRIEST"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Priest",
	["ROGUE"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Rogue",
	["SHAMAN"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Shaman",
	["WARLOCK"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Warlock",
	["WARRIOR"] = "Interface\\AddOns\\BlizzPlates\\img\\class\\ClassIcon_Warrior",
}
-- config
pfConfigCreate = CreateFrame("Frame", nil, UIParent)
pfConfigCreate:RegisterEvent("VARIABLES_LOADED")
pfConfigCreate:SetScript("OnEvent", function()
  if not pfNameplates_config then pfNameplates_config = { } end
  pfNameplates_config.clickthrough = pfNameplates_config.clickthrough or 0
  pfNameplates_config.raidiconsize = pfNameplates_config.raidiconsize or 24
  pfNameplates_config.showrank = pfNameplates_config.showrank or 0
  pfNameplates_config.showclass = pfNameplates_config.showclass or 0
  pfNameplates_config.showdebuffs = pfNameplates_config.showdebuffs or 1
  pfNameplates_config.showcastbar = pfNameplates_config.showcastbar or 1
  pfNameplates_config.showcasttext = pfNameplates_config.showcasttext or 0
  pfNameplates_config.onlyplayers = pfNameplates_config.onlyplayers or 0
  pfNameplates_config.showhp = pfNameplates_config.showhp or 0
end)

-- create frame
pfNameplates = CreateFrame("Frame", nil, UIParent)
pfNameplates:RegisterEvent("PLAYER_TARGET_CHANGED")
pfNameplates:RegisterEvent("UNIT_AURA")

SLASH_SHAGUPLATES1 = '/blizzardplates'
function SlashCmdList.SHAGUPLATES(msg)

  local commandlist = { }

  for command in string.gfind(msg, "[^ ]+") do
    table.insert(commandlist, string.lower(command))
  end

  -- help page
  if not commandlist[1] then
    DEFAULT_CHAT_FRAME:AddMessage("|cff135cd3Blizzard|cffffffffPlates Settings:")
    if pfNameplates_config.clickthrough == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("clickthrough: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("clickthrough: |cffff5555disabled")
    end

    if pfNameplates_config.showrank == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showrank: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showrank: |cffff5555disabled")
    end
    
	if pfNameplates_config.showclass == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showclass: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showclass: |cffff5555disabled")
    end
	
    if pfNameplates_config.showdebuffs == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showdebuffs: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showdebuffs: |cffff5555disabled")
    end

    if pfNameplates_config.showcastbar == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showcastbar: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showcastbar: |cffff5555disabled")
    end

    if pfNameplates_config.showcasttext == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showcasttext: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showcasttext: |cffff5555disabled")
    end

    if pfNameplates_config.onlyplayers == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("onlyplayers: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("onlyplayers: |cffff5555disabled")
    end

    if pfNameplates_config.showhp == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("showhp: |cff55ff55enabled")
    else
      DEFAULT_CHAT_FRAME:AddMessage("showhp: |cffff5555disabled")
    end

    DEFAULT_CHAT_FRAME:AddMessage("raidiconsize: |cffffcc00" .. pfNameplates_config.raidiconsize)
    DEFAULT_CHAT_FRAME:AddMessage("|cffcccccc0 = disable. 1 = enable")
    DEFAULT_CHAT_FRAME:AddMessage("|cffcccccce.g: /blizzardplates clickthrough 0")
  end

  if commandlist[1] == "clickthrough" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: clickthrough has been |cff55ff55enabled")
      pfNameplates_config.clickthrough = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: clickthrough has been |cffff5555disabled")
      pfNameplates_config.clickthrough = 0
    end
  end

  if commandlist[1] == "raidiconsize" and commandlist[2] then
    DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: raidiconsize has been set to |cffffcc00" .. commandlist[2])
    pfNameplates_config.raidiconsize = tonumber(commandlist[2])
  end

  if commandlist[1] == "showrank" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showrank has been |cff55ff55enabled")
      pfNameplates_config.showrank = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showrank has been |cffff5555disabled")
      pfNameplates_config.showrank = 0
    end
  end
  
  if commandlist[1] == "showclass" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showclass has been |cff55ff55enabled")
      pfNameplates_config.showclass = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showclass has been |cffff5555disabled")
      pfNameplates_config.showclass = 0
    end
  end
  
  if commandlist[1] == "showdebuffs" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showdebuffs has been |cff55ff55enabled")
      pfNameplates_config.showdebuffs = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showdebuffs has been |cffff5555disabled")
      pfNameplates_config.showdebuffs = 0
    end
  end

  if commandlist[1] == "showcastbar" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showcastbar has been |cff55ff55enabled")
      pfNameplates_config.showcastbar = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showcastbar has been |cffff5555disabled")
      pfNameplates_config.showcastbar = 0
    end
  end

  if commandlist[1] == "showcasttext" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showcasttext has been |cff55ff55enabled")
      pfNameplates_config.showcasttext = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showcasttext has been |cffff5555disabled")
      pfNameplates_config.showcasttext = 0
    end
  end

  if commandlist[1] == "onlyplayers" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: onlyplayers has been |cff55ff55enabled")
      pfNameplates_config.onlyplayers = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: onlyplayers has been |cffff5555disabled")
      pfNameplates_config.onlyplayers = 0
    end
  end

  if commandlist[1] == "showhp" and commandlist[2] then
    if tonumber(commandlist[2]) == 1 then
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showhp has been |cff55ff55enabled")
      pfNameplates_config.showhp = 1
    else
      DEFAULT_CHAT_FRAME:AddMessage("BlizzardPlates: showhp has been |cffff5555disabled")
      pfNameplates_config.showhp = 0
    end
  end
end

-- temporary data per session
pfNameplates.mobs = {}
pfNameplates.targets = {}
pfNameplates.players = {}

function round(input, places)
  if not places then places = 0 end
  if type(input) == "number" and type(places) == "number" then
    local pow = 1
    for i = 1, places do pow = pow * 10 end
    return floor(input * pow + 0.5) / pow
  end
end

pfNameplates:SetScript("OnEvent", function()
    -- current debuffs
    pfNameplates.debuffs = {}
    local i = 1
    local debuff = UnitDebuff("target", i)
    while debuff do
      pfNameplates.debuffs[i] = debuff
      i = i + 1
      debuff = UnitDebuff("target", i)
    end

    -- scan player (target)
    if UnitName("target") ~= nil and pfNameplates.players[UnitName("target")] == nil and pfNameplates.targets[UnitName("target")] == nil then
      if UnitIsPlayer("target") then
        local _, class = UnitClass("target")
        local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("target"))
        pfNameplates.players[UnitName("target")] = {}
        pfNameplates.players[UnitName("target")]["class"] = class
        pfNameplates.players[UnitName("target")]["rank"] = rankNumber
      elseif UnitClassification("target") ~= "normal" then
        local elite = UnitClassification("target")
        pfNameplates.mobs[UnitName("target")] = elite
      end
      pfNameplates.targets[UnitName("target")] = "OK"
    end
end)

pfNameplates:SetScript("OnUpdate", function()
  local frames = { WorldFrame:GetChildren() }
  for _, nameplate in ipairs(frames) do
    local regions = nameplate:GetRegions()
    if regions and regions:GetObjectType() == "Texture" and regions:GetTexture() == "Interface\\Tooltips\\Nameplate-Border" then
      local healthbar = nameplate:GetChildren()
      local border, glow, name, level, levelicon , raidicon = nameplate:GetRegions()

      if pfNameplates_config.onlyplayers == 1 then
        if not pfNameplates.players[name:GetText()] or not pfNameplates.players[name:GetText()]["class"] then
          nameplate:Hide()
        end
      end

      -- scan player (idle targeting)
      if pfNameplates.targets[name:GetText()] == nil and UnitName("target") == nil then
        TargetByName(name:GetText(), true)
        if UnitIsPlayer("target") then
          local _, class = UnitClass("target")
          local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("target"))
          pfNameplates.players[name:GetText()] = {}
          pfNameplates.players[name:GetText()]["class"] = class
          pfNameplates.players[name:GetText()]["rank"] = rankNumber
        elseif UnitClassification("target") ~= "normal" then
          local elite = UnitClassification("target")
          pfNameplates.mobs[name:GetText()] = elite
        end
        pfNameplates.targets[name:GetText()] = "OK"
        ClearTarget()
      end

      -- scan player (mouseover)
      if pfNameplates.players[name:GetText()] == nil and UnitName("mouseover") == name:GetText() and pfNameplates.targets[name:GetText()] == nil then
        if UnitIsPlayer("mouseover") then
          local _, class = UnitClass("mouseover")
          local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("mouseover"))
          pfNameplates.players[name:GetText()] = {}
          pfNameplates.players[name:GetText()]["class"] = class
          pfNameplates.players[name:GetText()]["rank"] = rankNumber
        elseif UnitClassification("mouseover") ~= "normal" then
          local elite = UnitClassification("mouseover")
          pfNameplates.mobs[name:GetText()] = elite
        end
        pfNameplates.targets[name:GetText()] = "OK"
      end

      -- enable clickthrough
      if pfNameplates_config.clickthrough == 1 then
        nameplate:EnableMouse(false)
      else
        nameplate:EnableMouse(true)
      end

      -- healthbar
      healthbar:SetStatusBarTexture("Interface\\AddOns\\BlizzPlates\\img\\bar")
      if healthbar.bg == nil then
        healthbar.bg = healthbar:CreateTexture(nil, "BORDER")
        healthbar.bg:SetTexture(0,0,0,0.90)
        healthbar.bg:ClearAllPoints()
        healthbar.bg:SetPoint("CENTER", healthbar, "CENTER", 0, 0)
        healthbar.bg:SetWidth(healthbar:GetWidth() + 3)
        healthbar.bg:SetHeight(healthbar:GetHeight() + 3)
      end

      if pfNameplates_config.showhp == 1 then
        if healthbar.hptext == nil then
          healthbar.hptext = healthbar:CreateFontString("Status", "DIALOG", "GameFontNormal")
          healthbar.hptext:SetPoint("RIGHT", healthbar, "RIGHT")
          healthbar.hptext:SetNonSpaceWrap(false)
          healthbar.hptext:SetFontObject(GameFontWhite)
          healthbar.hptext:SetTextColor(1,1,1,1)
          healthbar.hptext:SetFont("Interface\\AddOns\\BlizzPlates\\fonts\\arial.ttf", 10)
        end

        local cur, max
        if MobHealth3 then
          cur, max = MobHealth3:GetUnitHealth("target")
          healthbar.hptext:SetText(cur .. " / " .. max .. " ")
        else
          max = healthbar:GetMinMaxValues()
          cur = healthbar:GetValue()
          healthbar.hptext:SetText(cur .. " / " .. max .. " ")
        end
      end
	  
      -- class icons
	  if pfNameplates_config.showclass == 1 then
        if nameplate.classIcon == nil then
            nameplate.classIcon = nameplate:CreateTexture(nil, "BORDER")
            nameplate.classIcon:SetTexture(0,0,0,0)
            nameplate.classIcon:ClearAllPoints();
            nameplate.classIcon:SetPoint("RIGHT", name, "LEFT", -3, 0);
            nameplate.classIcon:SetWidth(12);
            nameplate.classIcon:SetHeight(12);
        end		

        if nameplate.classIconBorder == nil then
            nameplate.classIconBorder = nameplate:CreateTexture(nil, "BACKGROUND")
            nameplate.classIconBorder:SetTexture(0,0,0,0.9)
            nameplate.classIconBorder:SetPoint("CENTER", nameplate.classIcon, "CENTER", 0, 0);
            nameplate.classIconBorder:SetWidth(13.5);
            nameplate.classIconBorder:SetHeight(13.5);
        end		
        nameplate.classIconBorder:Hide();
        nameplate.classIcon:SetTexture(0,0,0,0);
        
        if  pfNameplates.players[name:GetText()] ~= nil and nameplate.classIcon:GetTexture() == "Solid Texture" and string.find(nameplate.classIcon:GetTexture(), "Interface") == nil then
            nameplate.classIcon:SetTexture(Icons[pfNameplates.players[name:GetText()]["class"]]);
            nameplate.classIcon:SetTexCoord(.078, .92, .079, .937)
            nameplate.classIcon:SetAlpha(0.9);
            nameplate.classIconBorder:Show();
        end
	  end
      
      -- rank icons
      if pfNameplates_config.showrank == 1 then
            if (nameplate.rankIcon == nil) then
                nameplate.rankIcon = nameplate:CreateTexture(nil, "BORDER")
            end
            nameplate.rankIcon:SetTexture(0,0,0,0);
            
            if (pfNameplates.players[name:GetText()] ~= nil) and (pfNameplates.players[name:GetText()]["rank"] > 0) and (string.find(nameplate.rankIcon:GetTexture(), "Interface") == nil) then
                nameplate.rankIcon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank",pfNameplates.players[name:GetText()]["rank"]))
                nameplate.rankIcon:ClearAllPoints();
                nameplate.rankIcon:SetPoint("LEFT", name, "RIGHT", 3, 0);
                --[[
                if nameplate.classIcon == nil then
                    nameplate.rankIcon:SetPoint("RIGHT", name, "LEFT", -3, 0);
                else
                    nameplate.rankIcon:SetPoint("RIGHT", nameplate.classIcon, "LEFT", -3, 0);
                end
                ]]--
                nameplate.rankIcon:SetWidth(12);
                nameplate.rankIcon:SetHeight(12);
                nameplate.rankIcon:Show()
            end
      end

      -- raidtarget
      raidicon:ClearAllPoints()
      raidicon:SetWidth(pfNameplates_config.raidiconsize)
      raidicon:SetHeight(pfNameplates_config.raidiconsize)
      raidicon:SetPoint("LEFT", healthbar, "LEFT", -15 - (pfNameplates_config.raidiconsize/2), 10)

      -- debuffs
      if nameplate.debuffs == nil then nameplate.debuffs = {} end
      for j=1, 16, 1 do
        if nameplate.debuffs[j] == nil then
          nameplate.debuffs[j] = nameplate:CreateTexture(nil, "BORDER")
          nameplate.debuffs[j]:SetTexture(0,0,0,0)
          nameplate.debuffs[j]:ClearAllPoints()
          nameplate.debuffs[j]:SetWidth(12)
          nameplate.debuffs[j]:SetHeight(12)
          if j == 1 then
            nameplate.debuffs[j]:SetPoint("TOPLEFT", healthbar, "BOTTOMLEFT", 0, -3)
          elseif j <= 8 then
            nameplate.debuffs[j]:SetPoint("LEFT", nameplate.debuffs[j-1], "RIGHT", 1, 0)
          elseif j > 8 then
            nameplate.debuffs[j]:SetPoint("TOPLEFT", nameplate.debuffs[1], "BOTTOMLEFT", (j-9) * 13, -1)
          end
        end
      end

      if pfNameplates_config.showdebuffs == 1 and UnitExists("target") and healthbar:GetAlpha() == 1 then
        local j = 1
        local k = 1
        for j, e in ipairs(pfNameplates.debuffs) do
          nameplate.debuffs[j]:SetTexture(pfNameplates.debuffs[j])
          nameplate.debuffs[j]:SetTexCoord(.078, .92, .079, .937)
          nameplate.debuffs[j]:SetAlpha(0.9)
          k = k + 1
        end
        for j = k, 16, 1 do
          nameplate.debuffs[j]:SetTexture(nil)
        end
      else
        for j = 1, 16, 1 do
          nameplate.debuffs[j]:SetTexture(nil)
        end
      end
	  

      -- show castbar
      if pfNameplates_config.showcastbar == 1 and pfCastbar.casterDB[name:GetText()] ~= nil and pfCastbar.casterDB[name:GetText()]["cast"] ~= nil then

        -- create frames
        if healthbar.castbar == nil then
          healthbar.castbar = CreateFrame("StatusBar", nil, healthbar)
          healthbar.castbar:SetWidth(110)
          healthbar.castbar:SetHeight(7)
          healthbar.castbar:SetPoint("TOPLEFT", healthbar, "BOTTOMLEFT", 0, -5)
          healthbar.castbar:SetBackdrop({  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                                  insets = {left = -1, right = -1, top = -1, bottom = -1} })
          healthbar.castbar:SetBackdropColor(0,0,0,1)
          healthbar.castbar:SetStatusBarTexture("Interface\\AddOns\\BlizzPlates\\img\\bar")
          healthbar.castbar:SetStatusBarColor(.9,.8,0,1)

          if healthbar.castbar.bg == nil then
            healthbar.castbar.bg = healthbar.castbar:CreateTexture(nil, "BACKGROUND")
            healthbar.castbar.bg:SetTexture(0,0,0,0.90)
            healthbar.castbar.bg:ClearAllPoints()
            healthbar.castbar.bg:SetPoint("CENTER", healthbar.castbar, "CENTER", 0, 0)
            healthbar.castbar.bg:SetWidth(healthbar.castbar:GetWidth() + 3)
            healthbar.castbar.bg:SetHeight(healthbar.castbar:GetHeight() + 3)
          end

          if healthbar.castbar.text == nil then
            healthbar.castbar.text = healthbar.castbar:CreateFontString("Status", "DIALOG", "GameFontNormal")
            healthbar.castbar.text:SetPoint("RIGHT", healthbar.castbar, "LEFT")
            healthbar.castbar.text:SetNonSpaceWrap(false)
            healthbar.castbar.text:SetFontObject(GameFontWhite)
            healthbar.castbar.text:SetTextColor(1,1,1,.5)
            healthbar.castbar.text:SetFont("Interface\\AddOns\\BlizzPlates\\fonts\\arial.ttf", 10, "OUTLINE")
          end

          if healthbar.castbar.spell == nil then
            healthbar.castbar.spell = healthbar.castbar:CreateFontString("Status", "DIALOG", "GameFontNormal")
            healthbar.castbar.spell:SetPoint("CENTER", healthbar.castbar, "CENTER")
            healthbar.castbar.spell:SetNonSpaceWrap(false)
            healthbar.castbar.spell:SetFontObject(GameFontWhite)
            healthbar.castbar.spell:SetTextColor(1,1,1,1)
            healthbar.castbar.spell:SetFont("Interface\\AddOns\\BlizzPlates\\fonts\\arial.ttf", 10, "OUTLINE")
          end

          if healthbar.castbar.icon == nil then
            healthbar.castbar.icon = healthbar.castbar:CreateTexture(nil, "BORDER")
            healthbar.castbar.icon:ClearAllPoints()
            healthbar.castbar.icon:SetPoint("BOTTOMLEFT", healthbar.castbar, "BOTTOMRIGHT", 5, -10)
            healthbar.castbar.icon:SetWidth(18)
            healthbar.castbar.icon:SetHeight(18)
          end

          if healthbar.castbar.icon.bg == nil then
            healthbar.castbar.icon.bg = healthbar.castbar:CreateTexture(nil, "BACKGROUND")
            healthbar.castbar.icon.bg:SetTexture(0,0,0,0.90)
            healthbar.castbar.icon.bg:ClearAllPoints()
            healthbar.castbar.icon.bg:SetPoint("CENTER", healthbar.castbar.icon, "CENTER", 0, 0)
            healthbar.castbar.icon.bg:SetWidth(healthbar.castbar.icon:GetWidth() + 3)
            healthbar.castbar.icon.bg:SetHeight(healthbar.castbar.icon:GetHeight() + 3)
          end
        end

        if pfCastbar.casterDB[name:GetText()]["starttime"] + pfCastbar.casterDB[name:GetText()]["casttime"] <= GetTime() then
          pfCastbar.casterDB[name:GetText()] = nil
          healthbar.castbar:Hide()
        else
          healthbar.castbar:SetMinMaxValues(0,  pfCastbar.casterDB[name:GetText()]["casttime"])
          healthbar.castbar:SetValue(GetTime() -  pfCastbar.casterDB[name:GetText()]["starttime"])
          healthbar.castbar.text:SetText(round( pfCastbar.casterDB[name:GetText()]["starttime"] +  pfCastbar.casterDB[name:GetText()]["casttime"] - GetTime(),1))
          if healthbar.castbar.spell then
            if pfNameplates_config.showcasttext == 1 then
              healthbar.castbar.spell:SetText(pfCastbar.casterDB[name:GetText()]["cast"])
            else
              healthbar.castbar.spell:SetText("")
            end
          end
          healthbar.castbar:Show()
          nameplate.debuffs[1]:SetPoint("TOPLEFT", healthbar.castbar, "BOTTOMLEFT", 0, -3)

          if pfCastbar.casterDB[name:GetText()]["icon"] then
            healthbar.castbar.icon:SetTexture("Interface\\Icons\\" ..  pfCastbar.casterDB[name:GetText()]["icon"])
            healthbar.castbar.icon:SetTexCoord(.1,.9,.1,.9)
          end
        end
      elseif healthbar.castbar then
        healthbar.castbar:Hide()
        nameplate.debuffs[1]:SetPoint("TOPLEFT", healthbar, "BOTTOMLEFT", 0, -3)
      end
    end
  end
end)
