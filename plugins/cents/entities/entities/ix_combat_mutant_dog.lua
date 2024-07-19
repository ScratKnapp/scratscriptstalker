local PLUGIN = PLUGIN

ENT.Type = "nextbot"
ENT.Base = "ix_combat_base"
ENT.PrintName = "Blind Dog"
ENT.Category = "Helix - Combat Entities - Mutants"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.name = "Blind Dog"

ENT.models = {
    "models/wick/dog/wick_blind_dog.mdl"
}

ENT.skin = table.Random({0, 1, 2, 3, 4}) 


ENT.WalkAnim = "stand_walk"
ENT.RunAnim = "stand_run_0"
ENT.IdleAnim = "stand_idle_0"
ENT.AttackAnim = "stand_attack_0"
ENT.CrouchAnim = "stand_idle_0"
ENT.StandAnim = "stand_idle_0"

function ENT:OnTakeDamage(dmgInfo)
    return 0
end


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

        self:SetCEntSkin(self.skin)
    end
end


