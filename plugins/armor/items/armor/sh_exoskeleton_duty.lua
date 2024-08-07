ITEM.name = "TB-3d Exoskeleton"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.replacements = "models/nasca/stalker/male_exo_duty.mdl"
TEM.description = "A set of TB-3d heavy armor."
ITEM.longdesc = "This suit of armor was originally created for military use but never entered mass production due to prohibitive costs and design problems. Nonetheless, Duty makes use of it due to its excellent protective qualities in combat. Faction technicians have modified the suit, sacrificing space for artifacts in favor of even heavier armor. An attached Exoskeleton provides extra strength required for even more protective layers."
ITEM.width = 3
ITEM.height = 3
ITEM.price = 250000
ITEM.flag = "A"
ITEM.br = 0.6
ITEM.fbr = 11
ITEM.ar = 0.2
ITEM.far = 3
ITEM.isGasmask = true
ITEM.isHelmet = false
ITEM.isArmor = true
ITEM.overlayPath = "vgui/overlays/hud_merc"
ITEM.img = Material("vgui/hud/xm40.png")
ITEM.artifactcontainers = {"1"}
ITEM.noBusiness = true
ITEM.weight = 26
ITEM.weightClass = 5
ITEM.ballisticRating = 59
ITEM.res = {
	["Impact"] = 0.37,
	["Rupture"] = 0.38,
	["Bullet"] = 0.34,
	["Shock"] = 0.13,
	["Burn"] = 0.21,
	["Radiation"] = 0.10,
	["Chemical"] = 0.05,
	["Psi"] = 0.10,
}
ITEM.newSkin = 0
ITEM.bodyGroups = {
	["Servomotors"] = 1,
}