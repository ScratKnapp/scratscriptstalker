local PLUGIN = PLUGIN

ENT.Type = "nextbot"
ENT.Base = "ix_combat_base"
ENT.PrintName = "Loner Expert"
ENT.Category = "Helix - Combat Entities - Loner"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.name = "A Loner."
ENT.description = "Lonely Lonely!"



ENT.models = {
    "models/nasca/stalker/male_seva_lone.mdl",
    "models/nasca/stalker/male_psz12d_lone.mdl",
    "models/nasca/stalker/male_exo_lone.mdl",
    "models/nasca/stalker/male_berill5m_lone.mdl",
    "models/silver/stalker/female_seva_lone.mdl",
    "models/nasca/stalker/male_cs3a.mdl",
    "models/silver/stalker/female_cs3a_lone.mdl",
}


ENT.skin = table.Random({0, 1, 2, 3, 4}) 

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
    "models/tnb/weapons/w_hk416.mdl",
    "models/tnb/weapons/w_m249.mdl",
    "models/tnb/weapons/w_fal.mdl",
    "models/tnb/weapons/w_svd.mdl",
    "models/tnb/weapons/w_vss.mdl",
    "models/tnb/weapons/w_spas12.mdl",
    "models/tnb/weapons/w_aek.mdl",
    "models/tnb/weapons/w_groza.mdl",
    "models/tnb/weapons/w_saiga12.mdl",
    "models/tnb/weapons/w_p90.mdl",
    "models/tnb/weapons/w_dp27.mdl",
}


if (SERVER) then
    function ENT:CustomInitialize()

        local firstname = table.Random(PLUGIN.firstnamesnormal)
        local lastname = table.Random(PLUGIN.lastnamesnormal)

        if string.find(self:GetModel(), "female") then firstname = table.Random(PLUGIN.femalenamesfirst) lastname = table.Random(PLUGIN.femalenameslast) end 

        self:SetDescription("Expert")

        self:SetCEntName(firstname .. " " .. lastname)

        
        local chosenweapon = table.Random(riflegrip)
        self:SetCEntWeaponModel(chosenweapon)

        if string.find(self:GetModel(), "exo") then self:SetCEntBodyGroups("1") end 
    

        self:SetCEntSkin(self.skin)
    end
end



