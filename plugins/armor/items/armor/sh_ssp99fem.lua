ITEM.name = "SSP-99 Ecologist Suit (Female)"
ITEM.model = "models/kek1ch/ecolog_outfit_orange.mdl"
ITEM.replacements = "models/silver/stalker/female_ssp_eco.mdl"
ITEM.description= "An advanced environmental suit."
ITEM.longdesc = "A personal protection suit specially designed for the Zone conditions. It is used by scientific expeditions and the stalkers who cooperate with them. It has an integrated air conditioning and filtering system. It is chemically, electrically, and thermally resistant, and provides good protection from biological anomalies and radiation. However, it is not designed for combat, so it provides protection for neither bullets nor fragmentation."
ITEM.width = 2
ITEM.height = 2
ITEM.price = 135000
ITEM.flag = "A"
ITEM.br = 0.15
ITEM.fbr = 1
ITEM.ar = 0.80
ITEM.far = 6
ITEM.isArmor = true
ITEM.radProt = 0.8
ITEM.repairCost = ITEM.price/100*1
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.img = Material("vgui/hud/ssp99.png")
ITEM.noBusiness = true
ITEM.artifactcontainers = {"5"}
ITEM.weightClass = 2
ITEM.ballisticRating = 8
ITEM.res = {
	["Impact"] = 0.06,
	["Rupture"] = 0.07,
	["Bullet"] = 0.01,
	["Shock"] = 0.10,
	["Burn"] = 0.82,
	["Radiation"] = 0.10,
	["Chemical"] = 0.10,
	["Psi"] = 0.13,
}


ITEM.newSkin = 0
ITEM.bodygroup = {0}
ITEM.bodygroupsub = {0}