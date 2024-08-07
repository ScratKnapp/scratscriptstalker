local PLUGIN = PLUGIN

ENT.Type = "nextbot"
ENT.Base = "ix_combat_base"
ENT.PrintName = "Tushkano"
ENT.Category = "Helix - Combat Entities - Mutants"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.name = "Tushkano"

ENT.models = {
    "models/stalkertnb/rodent1.mdl"
}



ENT.WalkAnim = "walk"
ENT.RunAnim = "run"
ENT.IdleAnim = "idle"
ENT.AttackAnim = "attack3"
ENT.CrouchAnim = "idle"
ENT.StandAnim = "idle"

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


