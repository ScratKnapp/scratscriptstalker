PLUGIN.name = "Health and Damage"
PLUGIN.description = "Adds script HP and commands to apply damage."
PLUGIN.author = "Scrat Knapp"

ix.char.RegisterVar("Currenthp", {
  field = "currenthp",
  fieldType = ix.type.number,
  default = 100,
  isLocal = true,
  bNoDisplay = true
})

ix.char.RegisterVar("Maxhp", {
  field = "maxhp",
  fieldType = ix.type.number,
  default = 100,
  isLocal = true,
  bNoDisplay = true
})

ix.char.RegisterVar("Maxhpboost", {
  field = "maxhpboost",
  fieldType = ix.type.number,
  default = 0,
  isLocal = true,
  bNoDisplay = true
})

if (SERVER) then
  ix.log.AddType("damage", function(client, target, actiontype, damage, status)
      return string.format("%s has %s %s damage %s", target:GetName(), actiontype, damage, status)
  end)
end


ix.command.Add("GetResistance", {
	description = "Get total given resistance for character",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string,
    bit.bor(ix.type.bool, ix.type.optional)
	},
	OnRun = function(self, client, target, key, headonly)

    key = string.lower(key)
    key = key:gsub("^%l", string.upper)
		
    local resistance = target:GetResistance(key, headonly)



    return target:GetName() .. " has " .. resistance*100 .. "% resistance for " .. key .. "."
		
	end
})

ix.command.Add("Damage", {
	description = "Inflict non-bullet damage on a player.",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string,
    ix.type.number,
    bit.bor(ix.type.bool, ix.type.optional)
	},
	OnRun = function(self, client, target, damagetype, damage, headonly)

    damagetype = string.lower(damagetype)
    damagetype = damagetype:gsub("^%l", string.upper)

    local res = {
      ["Impact"] = 0,
      ["Rupture"] = 0,
      ["Shock"] = 0,
      ["Burn"] = 0,
      ["Radiation"] = 0,
      ["Chemical"] = 0,
      ["Psi"] = 0,
    }

    local validtype = false

    for k, _ in pairs(res) do
      if damagetype == k then validtype = true end 
    end
    
    if not validtype then return "Invalid type. Must be: Impact, Rupture, Shock, Burn, Chemical, Radiation, or Psi." end 

    local targethead = ""
    if headonly then targethead = " to the head" end

    target:GetPlayer():Notify("You're hit with " .. damage .. " " .. damagetype .. " damage " .. targethead .. "!"  )

    local resistance = target:GetResistance(damagetype, headonly)

    target:GetPlayer():Notify("Your protection reduces the damage by " .. resistance*100 .. "%!")
    
    damage = damage * (1 - resistance)
    damage = math.floor(damage)

    target:GetPlayer():Notify("You take " .. damage .. " damage!")

    local armordamageamount = math.floor(damage / 10)

    target:DamageArmorScale(armordamageamount, headonly)




    target:AdjustHealth("hurt", damage)

		
	end
})

ix.command.Add("DamageBullet", {
	description = "Inflict bullet damage on a player.",
	adminOnly = true,
	arguments = {
		ix.type.character,
    ix.type.number,
    ix.type.number,
    ix.type.number,
    bit.bor(ix.type.bool, ix.type.optional)
	},
	OnRun = function(self, client, target, br, pierce, bluntforce, headshot)

    local inventory = target:GetInventory()
    local player = target:GetPlayer()
    local playerbr = 0
    local headshotstring = ""
    if headshot then headshotstring = " in the head" end

    player:Notify("You're hit by a bullet" .. headshotstring .. "!")

    for k, v in pairs (inventory:GetItems()) do
      if(!v:GetData("equip", false)) then continue end --ignores unequipped items
      if headshot and v.isBodyArmor then continue end -- Ignores body armor if shot in the head (artifacts affect your full body)
      if not headshot and v.isHelmet then continue end -- Ignores helmet armor if it hits your body
  
      local br = v:GetData("ballisticRating")
      if br then
        playerbr = playerbr + br
      end
    end


    if br > playerbr then 

      player:Notify("It pierces your armor!")

      
      local bulletresist = target:GetResistance("Bullet", headshot)
      local bluntresist = target:GetResistance("Impact", headshot)

      player:Notify("Your armor reduces the ballistic damage by " .. bulletresist*100  .."% and blunt force trauma by " .. bluntresist*100 .. "%!")
      local bulletdamage = pierce * (1 - bulletresist)
      local bluntdamage = bluntforce * (1 - bluntresist)

      player:Notify("You take " .. bulletdamage .. " ballistic damage and " .. bluntdamage .. " blunt force trauma damage!")

      
      local armordamageamount = math.floor((bulletdamage + bluntdamage) / 10)

      target:DamageArmorScale(armordamageamount, headshot)

      target:AdjustHealth("hurt", bluntdamage + bulletdamage)


    else

      player:Notify("It fails to pierce your armor!")
      local bluntresist = target:GetResistance("Impact")
      player:Notify("Your armor reduces the remaining blunt force trauma by " .. bluntresist*100 .. "%!")

      local bluntdamage = bluntforce * (1 - bluntresist)
      player:Notify("You take " .. bluntdamage .. " blunt force trauma damage!")

      local armordamageamount = math.floor(bluntdamage / 10)

      target:AdjustHealth("hurt", bluntdamage)


    end 
		

	end
})


ix.command.Add("Heal", {
  description = "Heal player by given amount.",
  adminOnly = true,
  arguments = {ix.type.character, ix.type.number},
  OnRun = function(self, client, target, amount)
      local char = target
      local player = target:GetPlayer()

      char:AdjustHealth("heal", amount)
      return "Healed " .. char:GetName() .. " by " .. amount .. " points."

  end
})

ix.command.Add("Status", {
  description = "Get your current health and total protection levels..",
  adminOnly = true,
  OnRun = function(self, client)
    local char = client:GetCharacter()

    local str = "Health: " .. char:GetCurrenthp() .. "/" .. client:GetTotalHp() .. "\n"

    local res = {
      ["Impact"] = 0,
      ["Rupture"] = 0,
      ["Bullet"] = 0,
      ["Shock"] = 0,
      ["Burn"] = 0,
      ["Radiation"] = 0,
      ["Chemical"] = 0,
      ["Psi"] = 0,
    }

   

    for k, _ in pairs(res) do

      str = str ..k.. ": " .. char:GetResistance(k) * 100 .. "%\n"
    end 

        
    return str



  end
})


local charMeta = ix.meta.character


local playerMeta = FindMetaTable("Player")

function playerMeta:GetTotalHp()
  local maxhp = self:GetCharacter():GetMaxhp() + self:GetCharacter():GetMaxhpboost()
 -- self:SetMaxHealth(maxhp)
return maxhp
end

function charMeta:GetResistance(key, headonly)

  local resistances = {
    [key] = 0
  }

  local inventory = self:GetInventory()

  for k, v in pairs (inventory:GetItems()) do
    if(!v:GetData("equip", false)) then continue end --ignores unequipped items
    if headonly and v.isBodyArmor then continue end -- Ignores body armor if set to only check for head protection (artifacts affect your full body)

    local res = v.res
    if res and res[key] then
      
      local durabilitychange = v:GetData("durability", 100) / 100
      resistances[key] = resistances[key] + math.Round((res[key] * durabilitychange), 2)
    end

  end

  if resistances[key] > 0.85 then resistances[key] = 0.85 end 

  
  return resistances[key]
end 

function charMeta:AdjustHealth(type, amount)
  local char = self
  local player = self:GetPlayer()

  -- A player is considered staggered if they're at or below 80% HP, Stunned if at or below 40% HP, and Incapped at 0% HP. Find out what these tresholds are by comparing them to player's max hp.
  maxhp = player:GetTotalHp()
  stagger = maxhp * 0.80
  stun = maxhp * 0.40
  incap = 0

  -- If hurt, reduce player HP by damage amount. If the amount would drop them below 0, put them to zero as we don't use negative HP here. Script HP already has this in place.
  if type == "hurt" then
      char:SetCurrenthp(char:GetCurrenthp() - amount)
      if char:GetCurrenthp() < 0 then char:SetCurrenthp(0) end
      player:SetHealth(player:Health() - amount)
  end 

  -- If heal, increase player HP by damage amount. If the amount would put them above their current maximum, just set them to the maximum as we don't use overheals here.
  if type == "heal" then
      if (char:GetCurrenthp() + amount > player:GetTotalHp()) then
          char:SetCurrenthp(player:GetTotalHp())
          player:SetHealth(player:GetTotalHp())
      else
          char:SetCurrenthp(char:GetCurrenthp() + amount)
          player:SetHealth(player:Health() + amount)
      end
  end 

  newhp = char:GetCurrenthp()

  -- Based on new health after hurt/heal, give a status message and apply debuffs to stats. If health goes down, remove lighter debuffs and replace with worse ones. As health goes up, reduce 

  if newhp == 0 then
      player:Notify("You're incapacitated and unable to fight, requiring stabilization.")

      if type == "heal" then
          ix.log.Add(client, "damage", char, "healed", amount, "and is currently Incapacitated.")
      else
          ix.log.Add(client, "damage", char, "taken", amount, "and is currently Incapacitated.")
      end 

      char:AddBoost("incap", "fortitude", -4)
      char:AddBoost("incap", "reflex", -4)
      char:AddBoost("incap", "observation", -4)
      char:AddBoost("incap", "strength", -4)

      char:RemoveBoost("stun", "fortitude")
      char:RemoveBoost("stun", "reflex")
      char:RemoveBoost("stun", "observation")
      char:RemoveBoost("stun", "strength")
      return

  elseif newhp <= stun then
      player:Notify("You're stunned by incoming damage and take a notable hit to your stats.")
   
      if type == "heal" then
          ix.log.Add(client, "damage", char, "healed", amount, "and is currently Stunned.")
      else
          ix.log.Add(client, "damage", char, "taken", amount, "and is currently Stunned.")
      end 

      char:AddBoost("stun", "fortitude", -3)
      char:AddBoost("stun", "reflex", -3)
      char:AddBoost("stun", "observation", -3)
      char:AddBoost("stun", "strength", -3)

      char:RemoveBoost("stagger", "fortitude")
      char:RemoveBoost("stagger", "reflex")
      char:RemoveBoost("stagger", "observation")
      char:RemoveBoost("stagger", "strength")
      
      char:RemoveBoost("incap", "fortitude")
      char:RemoveBoost("incap", "reflex")
      char:RemoveBoost("incap", "observation")
      char:RemoveBoost("incap", "strength")
      
      return

  elseif newhp <= stagger then
      player:Notify("You're staggered by incoming damage and take a slight hit to your stats.")
     
      if type == "heal" then
          ix.log.Add(client, "damage", char, "healed", amount, "and is currently Staggered.")
      else
          ix.log.Add(client, "damage", char, "taken", amount, "and is currently Staggered.")
      end 

      char:AddBoost("stagger", "fortitude", -1)
      char:AddBoost("stagger", "reflex", -1)
      char:AddBoost("stagger", "observation", -1)
      char:AddBoost("stagger", "strength", -1)

      char:RemoveBoost("incap", "fortitude")
      char:RemoveBoost("incap", "reflex")
      char:RemoveBoost("incap", "observation")
      char:RemoveBoost("incap", "strength")
      
      char:RemoveBoost("stun", "fortitude")
      char:RemoveBoost("stun", "reflex")
      char:RemoveBoost("stun", "observation")
      char:RemoveBoost("stun", "strength")
  
      return

  else
      if type == "heal" then
          ix.log.Add(client, "damage", char, "healed", amount, ".")
      else
          ix.log.Add(client, "damage", char, "taken", amount, ".")
      end 

      char:RemoveBoost("incap", "fortitude")
      char:RemoveBoost("incap", "reflex")
      char:RemoveBoost("incap", "observation")
      char:RemoveBoost("incap", "strength")
      
      char:RemoveBoost("stun", "fortitude")
      char:RemoveBoost("stun", "reflex")
      char:RemoveBoost("stun", "observation")
      char:RemoveBoost("stun", "strength")

      char:RemoveBoost("stagger", "fortitude")
      char:RemoveBoost("stagger", "reflex")
      char:RemoveBoost("stagger", "observation")
      char:RemoveBoost("stagger", "strength")
  end 
end 


function charMeta:DamageArmorScale(amount, headonly)

  local bodywear 
  local headwear
  local inventory = self:GetInventory()

  for k, v in pairs (inventory:GetItems()) do
    if(!v:GetData("equip", false)) then continue end --ignores unequipped items
    if headonly and v.isBodyArmor then continue end

    if v.isBodyArmor then bodywear = v end 
    if v.isHelmet then headwear = v end
  end


  if bodywear then

    local durability = bodywear:GetData("durability", 100)

    local damagefactor = 1
    if durability < 80 and durability > 59 then damagefactor = 2 end
    if durability < 59 and durability > 39 then damagefactor = 3 end 
    if durability < 39 then damagefactor = 4 end 

    local totaldamage = amount * damagefactor
    bodywear:SetData("durability", durability - totaldamage)

  end 

  if bodywear then

    local durability = bodywear:GetData("durability", 100)

    local damagefactor = 1
    if durability < 80 and durability > 59 then damagefactor = 2 end
    if durability < 59 and durability > 39 then damagefactor = 3 end 
    if durability < 39 then damagefactor = 4 end 

    local totaldamage = amount * damagefactor
    bodywear:SetData("durability", durability - totaldamage)

    if bodywear:GetData("durability") < 0 then bodywear:SetData("durability", 0) end 

  end 

  if headwear then

    local durability = headwear:GetData("durability", 100)

    local damagefactor = 1
    if durability < 80 and durability > 59 then damagefactor = 2 end
    if durability < 59 and durability > 39 then damagefactor = 3 end 
    if durability < 39 then damagefactor = 4 end 

    local totaldamage = amount * damagefactor
    headwear:SetData("durability", durability - totaldamage)
    if headwear:GetData("durability") < 0 then headwear:SetData("durability", 0) end

  end 

end 




