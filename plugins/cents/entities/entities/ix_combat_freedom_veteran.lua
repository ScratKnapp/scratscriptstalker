local PLUGIN = PLUGIN

ENT.Type = "nextbot"
ENT.Base = "ix_combat_base"
ENT.PrintName = "Freedom Veteran"
ENT.Category = "Helix - Combat Entities - Freedom"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.name = "Freedom."
ENT.description = "Dude. WEED. LMAO."

ENT.models = {
    "models/nasca/stalker/male_berill5m_free.mdl",
    "models/nasca/stalker/male_seva_free.mdl",
    "models/silver/stalker/female_seva_free.mdl",
    "models/player/stalker_freedom/freedom_seva/freedom_seva.mdl"

}


ENT.skin = 2

ENT.voicevariant = table.Random({1, 2})

ENT.WalkAnim = "walk_passive"
ENT.RunAnim = "run_passive"
ENT.IdleAnim = "idle_passive"
ENT.AttackAnim = "idle_ar2"
ENT.CrouchAnim = "cidle_all"
ENT.StandAnim = "crouchtostand"

function ENT:OnTakeDamage(dmgInfo)
    return 0
end


local riflegrip = {
    "models/tnb/weapons/w_mossberg.mdl",
    "models/tnb/weapons/w_m4.mdl",
    "models/tnb/weapons/w_g36c.mdl",
    "models/tnb/weapons/w_l85.mdl",
    "models/tnb/weapons/w_sig.mdl",
    "models/tnb/weapons/w_m24.mdl",
    "models/tnb/weapons/w_p90.mdl",
    "models/tnb/weapons/w_fal.mdl"
}

local ranks = {
    "Wardog"
}


if (SERVER) then
    function ENT:CustomInitialize()

        self:SetCombatHealth(50)
        self:SetCombatHealthMax(50)
        self:SetWeaponSkill(0)
        self:SetDodge(0)
    
        self:SetHeadBR(0)
        self:SetHeadBullet(0)
        self:SetHeadImpact(0)
        self:SetHeadRupture(0)
    
        self:SetTorsoBR(0)
        self:SetTorsoBullet(0)
        self:SetTorsoImpact(0)
        self:SetTorsoRupture(0)

        local firstname = ""

        local lastname = table.Random(PLUGIN.lastnamesnormal)

        if string.find(self:GetModel(), "female") then firstname = table.Random(PLUGIN.femalenamesfirst) lastname = table.Random(PLUGIN.femalenameslast) end 

        self:SetDescription("Veteran")

        local rank = table.Random(ranks)

        self:SetCEntName(rank .. " " .. lastname)

        
        local chosenweapon = table.Random(riflegrip)
        self:SetCEntWeaponModel(chosenweapon)
    end
end


