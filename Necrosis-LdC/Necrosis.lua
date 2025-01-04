--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]

------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic)
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2010-11-13 23:18:46 +0100 (sam., 13 nov. 2010) $
------------------------------------------------------------------------------------------------------

-- Variables globales
NecrosisConfig = {}

-- Variables locales
local Local = {}
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTIONS LOCALES
------------------------------------------------------------------------------------------------------

-- Création de deux fonctions, new et del
-- new crée un tableau temporaire, del le détruit
-- Ces tableaux temporaires sont stockés pour être réutilisés sans être obligés de les recréer.
local new, del
do
	local cache = setmetatable({}, {__mode='k'})
	function new(populate, ...)
		local tbl
		local t = next(cache)
		if ( t ) then
			cache[t] = nil
			tbl = t
		else
			tbl = {}
		end
		if ( populate ) then
			local num = select("#", ...)
			if ( populate == "hash" ) then
				assert(math.fmod(num, 2) == 0)
				local key
				for i = 1, num do
					local v = select(i, ...)
					if not ( math.fmod(i, 2) == 0 ) then
						key = v
					else
						tbl[key] = v
						key = nil
					end
				end
			elseif ( populate == "array" ) then
				for i = 1, num do
					local v = select(i, ...)
					table.insert(tbl, i, v)
				end
			end
		end
		return tbl
	end
	function del(t)
		for k in next, t do
			t[k] = nil
		end
		cache[t] = true
	end
end

-- Define a metatable which will be applied to any table object that uses it. || Métatable permettant d'utiliser les tableaux qui l'utilisent comme des objets
-- Common functions = :insert, :remove & :sort || Je définis les opérations :insert, :remove et :sort
-- Any table declared as follows "a = setmetatable({}, metatable)" will be able to use the common functions. || Tout tableau qui aura pour déclaration a = setmetatable({}, metatable) pourra utiliser ces opérateurs
local metatable = {
	__index = {
		["insert"] = table.insert,
		["remove"] = table.remove,
		["sort"] = table.sort,
	}
}

-- Create the spell metatable. || Création de la métatable contenant les sorts de nécrosis
Necrosis.Spell = setmetatable({}, metatable)

------------------------------------------------------------------------------------------------------
-- DECLARATION OF VARIABLES || DÉCLARATION DES VARIABLES
------------------------------------------------------------------------------------------------------

-- Detection of initialisation || Détection des initialisations du mod
Local.LoggedIn = true
Local.InWorld = true

-- Events utilised by Necrosis || Events utilisés dans Necrosis
Local.Events = {
	"BAG_UPDATE",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_DEAD",
	"PLAYER_ALIVE",
	"PLAYER_UNGHOST",
	"UNIT_PET",
	"UNIT_SPELLCAST_FAILED",
	"UNIT_SPELLCAST_INTERRUPTED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_SPELLCAST_SENT",
	"UNIT_POWER",
	"UNIT_HEALTH",
	"LEARNED_SPELL_IN_TAB",
	"PLAYER_TARGET_CHANGED",
	"TRADE_REQUEST",
	"TRADE_REQUEST_CANCEL",
	"TRADE_ACCEPT_UPDATE",
	"TRADE_SHOW",
	"TRADE_CLOSED",
	"COMBAT_LOG_EVENT_UNFILTERED"
}

-- Configuration defaults || Configuration par défaut
-- To be used if the configuration savedvariables is missing, or if the NecrosisConfig.Version number is changed. || Se charge en cas d'absence de configuration ou de changement de version
Local.DefaultConfig = {
	ShadowTranceAlert = true,
	ShowSpellTimers = true,
	AntiFearAlert = true,
	CreatureAlert = true,
	NecrosisLockServ = true,
	NecrosisAngle = 90,
	StonePosition = {1, 2, 4, 3, 5, 6, 7},
		-- 1 = Healthstone
		-- 2 = Soulstone
		-- 3 = Buff menu
		-- 4 = Mounts
		-- 5 = Demon menu
		-- 6 = Curse menu
		-- 7 = Metamorphosis menu
	CurseSpellPosition = {1, 2, 3, 4, 5, 6, 7},
		-- 1 = Weakness || Faiblesse
		-- 2 = Agony || Agonie
		-- 3 = Tongues || Langage
		-- 4 = Exhaustion || Fatigue
		-- 5 = Elements
		-- 6 = Doom || Funeste
		-- 7 = Corruption (not really a curse, but hey - its useful :)
	DemonSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11},
		-- 1 = Fel Domination || Domination corrompue
		-- 2 = Summon Imp
		-- 3 = Summon Voidwalker || Marcheur
		-- 4 = Summon Succubus
		-- 5 = Summon Felhunter
		-- 6 = Gangregarde
		-- 7 = Infernal
		-- 8 = Doomguard
		-- 9 = Enslave || Asservissement
		-- 10 = Sacrifice
		-- 11 = Demonic Empowerment || Renforcement
	BuffSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9},
		-- 1 = Demon Armor || Armure
		-- 2 = Fel Armor || Gangrarmure
		-- 3 = Unending Breath || Respiration
		-- 4 = Eye of Kilrogg
		-- 5 = Ritual of Summoning || TP
		-- 6 = Soul Link || Lien Spirituel
		-- 7 = Shadow Ward || Protection contre l'ombre
		-- 8 = Demonic Empowerment || Renforcement démoniaque --
		-- 9 = Banish || Bannir
	NecrosisToolTip = true,

	MainSpell = 53,

	PetMenuPos = {x=1, y=0, direction=1},
	PetMenuDecalage = {x=1, y=0},

	BuffMenuPos = {x=1, y=0, direction=1},
	BuffMenuDecalage = {x=1, y=26},

	CurseMenuPos = {x=1, y=0, direction=1},
	CurseMenuDecalage = {x=1, y=-26},

	MetamorphosisMenuPos = {x=1, y=0, direction=1},
	MetamorphosisMenuDecalage = {x=1, y=-26},

	ChatMsg = true,
	ChatType = true,
	Language = GetLocale(),
	ShowCount = true,
	CountType = 1,
	ShadowTranceScale = 100,
	NecrosisButtonScale = 90,
	NecrosisColor = "Rose",
	Sound = true,
	SpellTimerPos = 1,
	SpellTimerJust = "LEFT",
	Circle = 1,
	TimerType = 1,
	SensListe = 1,
	PetName = {},
	DemonSummon = true,
	BanishScale = 100,
	ItemSwitchCombat = {},
	FramePosition = {
		["NecrosisSpellTimerButton"] = {"CENTER", "UIParent", "CENTER", 100, 300},
		["NecrosisButton"] = {"CENTER", "UIParent", "CENTER", 0, -200},
		["NecrosisCreatureAlertButton"] = {"CENTER", "UIParent", "CENTER", -60, 0},
		["NecrosisAntiFearButton"] = {"CENTER", "UIParent", "CENTER", -20, 0},
		["NecrosisShadowTranceButton"] = {"CENTER", "UIParent", "CENTER", 20, 0},
		["NecrosisBacklashButton"] = {"CENTER", "UIParent", "CENTER", 60, 0},
		["NecrosisHealthstoneButton"] = {"CENTER", "UIParent", "CENTER", -53,-100},
		["NecrosisSoulstoneButton"] = {"CENTER", "UIParent", "CENTER", -17,-100},
		["NecrosisBuffMenuButton"] = {"CENTER", "UIParent", "CENTER", 17,-100},
		["NecrosisMountButton"] = {"CENTER", "UIParent", "CENTER", 53,-100},
		["NecrosisPetMenuButton"] = {"CENTER", "UIParent", "CENTER", 87,-100},
		["NecrosisCurseMenuButton"] = {"CENTER", "UIParent", "CENTER", 121,-100},
		["NecrosisMetamorphosisButton"] = {"CENTER", "UIParent", "CENTER", 155,-100},
	},
}

-- Variables des sorts castés (nom, rang, cible, niveau de la cible)
Local.SpellCasted = {}

-- Variables des timers
Local.TimerManagement = {
	-- Sorts à timer
	SpellTimer = setmetatable({}, metatable),
	-- Association des timers aux Frames
	TimerTable = setmetatable({}, metatable),
	-- Groupes de timers par mobs
	SpellGroup = setmetatable(
		{
			{Name = "Rez", SubName = " ", Visible = 0},
			{Name = "Main", SubName = " ", Visible = 0},
			{Name = "Cooldown", SubName = " ", Visible = 0}
		},
		metatable
	),
	-- Dernier sort casté
	LastSpell = {}
}

-- Variables des messages d'invocation
Local.SpeechManagement = {
	-- Derniers messages sélectionnés
	-- Added 'RoS = 0' by Draven (April 3rd, 2008)
	LastSpeech = {Pet = 0, Steed = 0, Rez = 0, TP = 0, RoS = 0},
	-- Messages à utiliser après la réussite du sort
	SpellSucceed = {
		-- Added 'RoS = setmetatable({}, metatable),' by Draven (April 3rd, 2008)
		RoS = setmetatable({}, metatable),
		Pet = setmetatable({}, metatable),
		Steed = setmetatable({}, metatable),
		Rez = setmetatable({}, metatable),
		TP = setmetatable({}, metatable),
		Sacrifice = setmetatable({}, metatable)
	},
}

-- Variables utilisées pour la gestion des boutons d'invocation et d'utilisation des pierres
Local.Stone = {
	Soul = {Mode = 1, Location = {}},
	Health = {Mode = 1, Location = {}},
	Hearth = {Location = {}},
}

-- Variables utilisées dans la gestion des démons
Local.Summon = {}

-- Liste des boutons disponibles dans chaque menu
Local.Menu = {
	Pet = setmetatable({}, metatable),
	Buff = setmetatable({}, metatable),
	Curse = setmetatable({}, metatable)
}

-- Variable des Buffs Actifs
Local.BuffActif = {}
Local.BuffActif.MountChange = true

-- Variable de l'état des boutons (grisés ou non)
Local.Desatured = {}

-- Dernière image utilisée pour la sphere
Local.LastSphereSkin = "Aucune"

-- Variables des échanges de pierres de soins
Local.Trade = {}

-- Variables utilisées pour les avertissements
-- Antifear et Cible démoniaque ou élémentaire
Local.Warning = {
	Antifear = {
		Toggle = 2,
		Icon = {"", "Immu", "Prot"}
	}
}

-- Temps écoulé entre deux event OnUpdate
Local.LastUpdate = {0, 0}

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS APPLIQUEES A L'ENTREE DANS LE JEU
------------------------------------------------------------------------------------------------------


-- Fonction appliquée au chargement
function Necrosis:OnLoad()

	local _, Classe = UnitClass("player")
	if Classe == "WARLOCK" then

		-- Initialisation du mod
		self:Initialize(Local.DefaultConfig)

		-- Enregistrement des events utilisés
		NecrosisButton:RegisterEvent("PLAYER_ENTERING_WORLD")
		NecrosisButton:RegisterEvent("PLAYER_LEAVING_WORLD")
		for i in ipairs(Local.Events) do
			NecrosisButton:RegisterEvent(Local.Events[i])
		end

		-- Easter Egg
		if UnitName("player") == "Licyon" then
			SendChatMessage("Je suis le pire noob de la terre, et Lomig est mon maitre !", "GUILD")
			SendChatMessage("Il n'y a pas plus cr\195\169tin que Lycion... Virez moi !", "OFFICER")
			SendChatMessage("Lycion floode Cyrax by Lomig", "WHISPER", "Common", "Cyrax")
		end

		-- Détection du Type de démon présent à la connexion
		Local.Summon.DemonType = UnitCreatureFamily("pet")
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS
------------------------------------------------------------------------------------------------------

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function Necrosis:OnUpdate(frame, elapsed)
	Local.LastUpdate[1] = Local.LastUpdate[1] + elapsed
	Local.LastUpdate[2] = Local.LastUpdate[2] + elapsed

	-- Si défilement lisse des timers, on les met à jours le plus vite possible
	if NecrosisConfig.Smooth then
		NecrosisUpdateTimer(Local.TimerManagement.SpellTimer)
	end

	-- Si timers textes, on les met à jour très vite également
	if NecrosisConfig.TimerType == 2 then
		self:TextTimerUpdate(Local.TimerManagement.SpellTimer, Local.TimerManagement.SpellGroup)
	end

	-- Changement du bouton de monture quand le Démoniste est démonté
	if Local.BuffActif.MountChange and _G["NecrosisMountButton"] then
		if not Local.BuffActif.Mount and IsMounted() then
			NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02")
			NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
			Local.BuffActif.Mount = true
		elseif Local.BuffActif.Mount and not IsMounted() then
			NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-01")
			Local.BuffActif.Mount = false
		end
		Local.BuffActif.MountChange = false
	end

	-- Toutes les secondes
	if Local.LastUpdate[1] > 1 then
		-- Parcours du tableau des Timers
		if Local.TimerManagement.SpellTimer[1] then
			for index = 1, #Local.TimerManagement.SpellTimer, 1 do
				if Local.TimerManagement.SpellTimer[index] then
					-- On enlève les timers terminés
					local TimeLocal = GetTime()
					if TimeLocal >= (Local.TimerManagement.SpellTimer[index].TimeMax - 0.5) then
						local StoneFade = false
						local MetamorphosisFade = false
						-- Si le timer était celui de la Pierre d'âme, on prévient le Démoniste
						if Local.TimerManagement.SpellTimer[index].Name == self.Spell[11].Name then
							self:Msg(self.ChatMessage.Information.SoulstoneEnd)
							if NecrosisConfig.Sound then PlaySoundFile(self.Sound.SoulstoneEnd) end
							StoneFade = true
						elseif Local.TimerManagement.SpellTimer[index].Name == self.Spell[9].Name then
							Local.TimerManagement.Banish = false
						elseif Local.TimerManagement.SpellTimer[index].Name == self.Spell[27].Name then
							MetamorphosisFade = true
						end
						-- Sinon on enlève le timer silencieusement (mais pas en cas d'enslave)
						if not (Local.TimerManagement.SpellTimer[index].Name == self.Spell[10].Name) then
							Local.TimerManagement = self:RetraitTimerParIndex(index, Local.TimerManagement)
							index = 0
							if StoneFade then
								-- On met à jour l'apparence du bouton de la pierre d'âme
								self:UpdateIcons()
							elseif MetamorphosisFade then
								-- On met à jour l'apparence du bouton de métamorphose
								self:UpdateMana("Metamorphose")
							end
							break
						end
					end
				end
			end
		end
		Local.LastUpdate[1] = 0
	-- Toutes les demies secondes
	elseif Local.LastUpdate[2] > 0.5 then
		-- Si défilement normal des timers graphiques, alors on met à jour toutes les 0.5 secondes
		if not NecrosisConfig.Smooth then
			NecrosisUpdateTimer(Local.TimerManagement.SpellTimer)
		end

		-- Si configuré, affichage des avertissements d'Antifear
		if NecrosisConfig.AntiFearAlert then
			self:ShowAntiFearWarning()
		end
		-- Si configuré, on transfome la Sphere en Chrono de Rez
		if (NecrosisConfig.CountType == 3 or NecrosisConfig.Circle == 2)
			and (Local.Stone.Soul.Mode == 3 or Local.Stone.Soul.Mode == 4)
			then
				Local.LastSphereSkin = self:RezTimerUpdate(
					Local.TimerManagement.SpellTimer, Local.LastSphereSkin
				)
		end
		Local.LastUpdate[2] = 0
	end
end

-- Fonction lancée selon l'événement intercepté
function Necrosis:OnEvent(frame, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...

	if (event == "PLAYER_ENTERING_WORLD") then
		Local.InWorld = true
	elseif (event == "PLAYER_LEAVING_WORLD") then
		Local.InWorld = false
	end

	-- Le jeu est-il bien chargé ?
	if not Local.InWorld then
		return
	end

	-- Si le contenu des sacs a changé, on vérifie que les Fragments d'âme sont toujours dans le bon sac
	if (event == "BAG_UPDATE") then
		self:BagExplore(arg1)
	-- Si le joueur gagne ou perd de la mana
	elseif (event == "UNIT_POWER") and arg1 == "player" then
		self:UpdateMana(nil, arg2)
	-- Si le joueur gagneou perd de la vie
	elseif (event == "UNIT_HEALTH") and arg1 == "player" then
		self:UpdateHealth()
	-- Si le joueur meurt
	elseif (event == "PLAYER_DEAD") then
		-- On cache éventuellement les boutons de Crépuscule ou Contrecoup.
		Local.Dead = true
		NecrosisShadowTranceButton:Hide()
		NecrosisBacklashButton:Hide()
		-- On grise tous les boutons de sort
		if _G["NecrosisMountButton"] then
			NecrosisMountButton:GetNormalTexture():SetDesaturated(1)
		end
		if _G["NecrosisMetamorphosisButton"] then
			NecrosisMetamorphosisButton:GetNormalTexture():SetDesaturated(1)
		end
		for i = 1, 15, 1 do
			if _G["NecrosisBuffMenu"..i] then
				_G["NecrosisBuffMenu"..i]:GetNormalTexture():SetDesaturated(1)
			end
			if _G["NecrosisPetMenu"..i] then
				_G["NecrosisPetMenu"..i]:GetNormalTexture():SetDesaturated(1)
			end
			if _G["NecrosisCurseMenu"..i] then
				_G["NecrosisCurseMenu"..i]:GetNormalTexture():SetDesaturated(1)
			end
		end
	-- Si le joueur ressucite
	elseif 	(event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST") then
		-- On dégrise tous les boutons de sort
		if _G["NecrosisMountButton"] then
			NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
		end
		if _G["NecrosisMetamorphosisButton"] then
			NecrosisMetamorphosisButton:GetNormalTexture():SetDesaturated(nil)
		end
		for i = 1, 15, 1 do
			if _G["NecrosisBuffMenu"..i] then
				_G["NecrosisBuffMenu"..i]:GetNormalTexture():SetDesaturated(nil)
			end
			if _G["NecrosisPetMenu"..i] then
				_G["NecrosisPetMenu"..i]:GetNormalTexture():SetDesaturated(nil)
			end
			if _G["NecrosisCurseMenu"..i] then
				_G["NecrosisCurseMenu"..i]:GetNormalTexture():SetDesaturated(nil)
			end
		end
		-- On réinitialise la liste des boutons grisés
		Local.Desatured = {}
		Local.Dead = false
	-- Gestion de l'incantation des sorts réussie
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") and arg1 == "player" then
		_, Local.SpellCasted.Name = arg1, arg2
		self:SpellManagement()
	-- Quand le démoniste commence à incanter un sort, on intercepte le nom de celui-ci
	-- On sauve également le nom de la cible du sort ainsi que son niveau
	elseif (event == "UNIT_SPELLCAST_SENT") then
		_, Local.SpellCasted.Name, Local.SpellCasted.Rank, Local.SpellCasted.TargetName = arg1, arg2, arg3, arg4
		if (not Local.SpellCasted.TargetName or Local.SpellCasted.TargetName == "") and UnitName("target") then
			Local.SpellCasted.TargetName = UnitName("target")
		elseif not Local.SpellCasted.TargetName then
			Local.SpellCasted.TargetName = ""
		end
		Local.SpellCasted.TargetLevel = UnitLevel("target")
		if not Local.SpellCasted.TargetLevel then
			Local.SpellCasted.TargetLevel = ""
		end
		Local.SpeechManagement = self:Speech_It(Local.SpellCasted, Local.SpeechManagement, metatable)

	-- Quand le démoniste stoppe son incantation, on relache le nom de celui-ci
	elseif (event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED") and arg1 == player then
		Local.SpellCasted = {}
	-- Flag si une fenetre de Trade est ouverte, afin de pouvoir trader automatiquement les pierres de soin
	elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
		Local.Trade.Request = true
	elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
		Local.Trade.Request = false
	elseif event=="TRADE_ACCEPT_UPDATE" then
		if Local.Trade.Request and Local.Trade.Complete then
			AcceptTrade()
			Local.Trade.Request = false
			Local.Trade.Complete = false
		end
	-- AntiFear button hide on target change
	elseif event == "PLAYER_TARGET_CHANGED" then
		if NecrosisConfig.AntiFearAlert and Local.Warning.Antifear.Immune then
			Local.Warning.Antifear.Immune = false
		end
		if NecrosisConfig.CreatureAlert
			and UnitCanAttack("player", "target")
			and not UnitIsDead("target") then
				Local.Warning.Banishable = true
				if UnitCreatureType("target") == self.Unit.Demon then
					NecrosisCreatureAlertButton:Show()
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\DemonAlert")
				elseif UnitCreatureType("target") == self.Unit.Elemental then
					NecrosisCreatureAlertButton:Show()
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ElemAlert")
				end
		elseif Local.Warning.Banishable then
			Local.Warning.Banishable = false
			NecrosisCreatureAlertButton:Hide()
		end

	-- Si le Démoniste apprend un nouveau sort / rang de sort, on récupère la nouvelle liste des sorts
	-- Si le Démoniste apprend un nouveau sort de buff ou d'invocation, on recrée les boutons
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		for index in ipairs(self.Spell) do
			self.Spell[index].Name = nil
		end
		self.Spell[11].Name = GetSpellInfo(self.Spell[11].Id)
		self:SpellSetup()
		self:CreateMenu()
		self:ButtonSetup()

	-- A la fin du combat, on arrête de signaler le Crépuscule
	-- On enlève les timers de sorts ainsi que les noms des mobs
	elseif (event == "PLAYER_REGEN_ENABLED") then
		Local.PlayerInCombat = false
		Local.TimerManagement = self:RetraitTimerCombat(Local.TimerManagement)

		-- On redéfinit les attributs des boutons de sorts de manière situationnelle
		self:NoCombatAttribute(Local.Stone.Soul.Mode, Local.Menu.Pet, Local.Menu.Buff, Local.Menu.Curse)
		self:UpdateIcons()

	-- Quand le démoniste change de démon
	elseif (event == "UNIT_PET" and arg1 == "player") then
		self:ChangeDemon()

	-- Lecture du journal de combat
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		-- Détection de la transe de l'ombre et de  Contrecoup
		if arg2 == "SPELL_AURA_APPLIED" and arg6 == UnitGUID("player") then
			Local.BuffActif.MountChange = true
			self:SelfEffect("BUFF", arg10)
		-- Détection de la fin de la transe de l'ombre et de Contrecoup
		elseif arg2 == "SPELL_AURA_REMOVED" and arg6 == UnitGUID("player") then
			Local.BuffActif.MountChange = true
			self:SelfEffect("DEBUFF", arg10)
		-- Détection du Déban
		elseif arg2 == "SPELL_AURA_REMOVED" and arg6 == UnitGUID("focus") and Local.TimerManagement.Banish and arg10 == self.Spell[9].Name then
				self:Msg("BAN ! BAN ! BAN !")
				self:RetraitTimerParNom(self.Spell[9], Local.TimerManagement)
				Local.TimerManagement.Banish = false
		-- Détection des résists / immunes
		elseif arg2 == "SPELL_MISSED" and arg3 == UnitGUID("player") and arg6 == UnitGUID("target") then
			if NecrosisConfig.AntiFearAlert
				and (arg10 == self.Spell[13].Name or arg10 == self.Spell[19].Name)
				and arg12 == "IMMUNE"
				then
					Local.Warning.Antifear.Immune = true
			end
			if arg10 == Local.TimerManagement.LastSpell.Name
				and GetTime() <= (Local.TimerManagement.LastSpell.Time + 1.5)
				then
					self:RetraitTimerParIndex(Local.TimerManagement.LastSpell.Index, Local.TimerManagement)
			end
		end

	-- Si on rentre en combat
	elseif event == "PLAYER_REGEN_DISABLED" then
		Local.PlayerInCombat = true
		-- On ferme le menu des options
		if _G["NecrosisGeneralFrame"] and NecrosisGeneralFrame:IsVisible() then
			NecrosisGeneralFrame:Hide()
		end
		-- On annule les attributs des boutons de sorts de manière situationnelle
		self:InCombatAttribute(Local.Menu.Pet, Local.Menu.Buff, Local.Menu.Curse)
	end
	return
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS "ON EVENT"
------------------------------------------------------------------------------------------------------

-- Events : PLAYER_ENTERING_WORLD et PLAYER_LEAVING_WORLD
-- Fonction appliquée à chaque écran de chargement
-- Quand on sort d'une zone, on arrête de surveiller les envents
-- Quand on rentre dans une zone, on reprend la surveillance
-- Cela permet d'éviter un temps de chargement trop long du mod
function Necrosis:RegisterManagement(RegistrationType)
	if RegistrationType == "IN" then
		for i in ipairs(Local.Events) do
			NecrosisButton:RegisterEvent(Local.Events[i])
		end
	else
		for i in ipairs(Local.Events) do
			NecrosisButton:UnregisterEvent(Local.Events[i])
		end
	end
	return
end

-- event : UNIT_PET
-- Permet de timer les asservissements, ainsi que de prévenir pour les ruptures d'asservissement
-- Change également le nom du pet au remplacement de celui-ci
function Necrosis:ChangeDemon()
	-- Si le nouveau démon est un démon asservi, on place un timer de 5 minutes
	if (self:UnitHasEffect("pet", self.Spell[10].Name)) then
		if (not Local.Summon.DemonEnslaved) then
			Local.Summon.DemonEnslaved = true
			Local.TimerManagement = self:InsertTimerParTable(10, "","", Local.TimerManagement)
		end
	else
		-- Quand le démon asservi est perdu, on retire le Timer et on prévient le Démoniste
		if (Local.Summon.DemonEnslaved) then
			Local.Summon.DemonEnslaved = false
			Local.TimerManagement = self:RetraitTimerParNom(self.Spell[10].Name, Local.TimerManagement)
			if NecrosisConfig.Sound then PlaySoundFile(self.Sound.EnslaveEnd) end
			self:Msg(self.ChatMessage.Information.EnslaveBreak, "USER")
		end
	end

	-- Si le démon n'est pas asservi on définit son titre, et on met à jour son nom dans Necrosis
	Local.Summon.LastDemonType = Local.Summon.DemonType
	Local.Summon.DemonType = UnitCreatureFamily("pet")
	for i = 1, #self.Translation.DemonName, 1 do
		if Local.Summon.DemonType == self.Translation.DemonName[i] and not (NecrosisConfig.PetName[i] or (UnitName("pet") == UNKNOWNOBJECT)) then
			NecrosisConfig.PetName[i] = UnitName("pet")
			self:Localization()
			break
		end
	end
	self:UpdateMana()

	return
end

-- events : CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS, CHAT_MSG_SPELL_AURA_GONE_SELF et CHAT_MSG_SPELL_BREAK_AURA
-- Permet de gérer les effets apparaissants et disparaissants sur le démoniste
-- Basé sur le CombatLog
function Necrosis:SelfEffect(action, nom)

	if action == "BUFF" then
		-- Changement du bouton de la domination corrompue si celle-ci est activée + Timer de cooldown
		if  nom == self.Spell[15].Name then
			Local.BuffActif.Domination = true
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-02")
				NecrosisPetMenu1:GetNormalTexture():SetDesaturated(nil)
			end
		-- Changement du bouton du lien spirituel si celui-ci est activé
		elseif nom == self.Spell[38].Name then
			Local.BuffActif.SoulLink = true
			if _G["NecrosisBuffMenu6"] then
				NecrosisBuffMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\SoulLink-02")
				NecrosisBuffMenu6:GetNormalTexture():SetDesaturated(nil)
			end
		-- si Contrecoup, pouf on affiche l'icone et on proc le son
		-- if By-effect, pouf one posts the icon and one proc the sound
		elseif nom == self.Translation.Proc.Backlash and NecrosisConfig.ShadowTranceAlert then
			self:Msg(self.ProcText.Backlash, "USER")
			if NecrosisConfig.Sound then PlaySoundFile(self.Sound.Backlash) end
			NecrosisBacklashButton:Show()
		-- si Crépuscule, pouf on affiche l'icone et on proc le son
		-- if Twilight/Nightfall, pouf one posts the icon and one proc the sound
		elseif nom == self.Translation.Proc.ShadowTrance and NecrosisConfig.ShadowTranceAlert then
			self:Msg(self.ProcText.ShadowTrance, "USER")
			if NecrosisConfig.Sound then PlaySoundFile(self.Sound.ShadowTrance) end
			NecrosisShadowTranceButton:Show()
		end
	else
		-- Changement du bouton de Domination quand le Démoniste n'est plus sous son emprise
		if  nom == self.Spell[15].Name then
			Local.BuffActif.Domination = false
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01")
			end
		-- Changement du bouton du Lien Spirituel quand le Démoniste n'est plus sous son emprise
		elseif nom == self.Spell[38].Name then
			Local.BuffActif.SoulLink = false
			if _G["NecrosisBuffMenu6"] then
				NecrosisBuffMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\SoulLink-01")
			end
		-- hide the shadowtrance (nightfall) or backlash buttons when the state is ended.
		elseif nom == self.Translation.Proc.ShadowTrance or nom == self.Translation.Proc.Backlash then
			NecrosisShadowTranceButton:Hide()
			NecrosisBacklashButton:Hide()
		end
	end
	self:UpdateMana()
	return
end

-- event : UNIT_SPELLCAST_SUCCEEDED
-- manages everything related to successful spell casts || Permet de gérer tout ce qui touche aux sorts une fois leur incantation réussie
function Necrosis:SpellManagement()
	local SortActif = false
	if (Local.SpellCasted.Name) then
		-- Messages Posts Cast (Démons et TP)
		Local.SpeechManagement.SpellSucceed = self:Speech_Then(Local.SpellCasted, Local.SpeechManagement.DemonName, Local.SpeechManagement.SpellSucceed)

		-- special case: Haunt refreshes Corruption (if present) on a target
		if (Local.SpellCasted.Name == self.Spell[42].Name) then
			-- check if the target is afflicted with Corruption
			if (self:UnitHasEffect("target", self.Spell[14].Name)) then
			  Local.TimerManagement.LastSpell.Time = GetTime()

				-- remove the old corruption timer
				Local.TimerManagement = self:RetraitTimerParNom(self.Spell[14].Name, Local.TimerManagement)

				-- insert a new Corruption timer
				Local.TimerManagement = self:InsertTimerParTable(14, Local.SpellCasted.TargetName, Local.SpellCasted.TargetLevel, Local.TimerManagement)
			end
		end

		-- Create a timer when a soulstone has been used || Si le sort lancé à été une Résurrection de Pierre d'âme, on place un timer
		if (Local.SpellCasted.Name == self.Spell[11].Name) then
			if Local.SpellCasted.TargetName == UnitName("player") then
				Local.SpellCasted.TargetName = ""
			end
			Local.TimerManagement = self:InsertTimerParTable(11, Local.SpellCasted.TargetName, "", Local.TimerManagement)
		-- Create a timer if a healthstone was used || Si le sort était une pierre de soin
		elseif Local.SpellCasted.Name == self.Translation.Item.Healthstone then
			Local.TimerManagement = self:InsertTimerStone("Healthstone", nil, nil, Local.TimerManagement)
		-- Create a timer for any other spell cast (if valid) || Pour les autres sorts castés, tentative de timer si valable
		else
			for spell=1, #self.Spell, 1 do
				if Local.SpellCasted.Name == self.Spell[spell].Name and not (spell == 10) then
					-- update the timer if it already exists || Si le timer existe déjà sur la cible, on le met à jour
					if Local.TimerManagement.SpellTimer[1] then
						for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name
								and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
								and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
								and not (self.Spell[spell].Type == 4)	-- not a curse
								and not (self.Spell[spell].Type == 5) -- not corruption
								and not (spell == 16)
								then
								-- Si c'est sort lancé déjà présent sur un mob, on remet le timer à fond
								if not (spell == 9) or (spell == 9 and not self:UnitHasEffect("focus", Local.SpellCasted.Name)) then
									Local.TimerManagement.SpellTimer[thisspell].Time = self.Spell[spell].Length
									Local.TimerManagement.SpellTimer[thisspell].TimeMax = floor(GetTime() + self.Spell[spell].Length)
									if (spell == 9) and (Local.SpellCasted.Rank:find("1")) then
										Local.TimerManagement.SpellTimer[thisspell].Time = 20
										Local.TimerManagement.SpellTimer[thisspell].TimeMax = floor(GetTime() + 20)
									end
								end
								SortActif = true
								break
							end

							-- if lifetap has been cast, then remove the old timer
							if ((Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name) and (spell == 41)) then
								Local.TimerManagement = self:RetraitTimerParIndex(thisspell, Local.TimerManagement)
								SortActif = true
								break
							end

							-- if we have banished a new target, then remove the previous timer. || Si c'est un banish sur une nouvelle cible, on supprime le timer précédent
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name and spell == 9
								and not
									(Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel)
								then
								Local.TimerManagement = self:RetraitTimerParIndex(thisspell, Local.TimerManagement)
								SortActif = false
								break
							end

							-- if we have cast fear, then remove the previous timer || Si c'est un fear, on supprime le timer du fear précédent
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name and spell == 13 then
								Local.TimerManagement = self:RetraitTimerParIndex(thisspell, Local.TimerManagement)
								SortActif = false
								break
							end

							if SortActif then
								break
							end
						end
						-- Si le timer est une malédiction, on enlève la précédente malédiction sur la cible
						-- If the timer is a curse, one removes the preceding curse on the target
						if (self.Spell[spell].Type == 4) or (spell == 16) then
							for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
								-- Mais on garde le cooldown de la malédiction funeste
								if Local.TimerManagement.SpellTimer[thisspell].Name == self.Spell[16].Name then
									Local.TimerManagement.SpellTimer[thisspell].Target = Local.SpellCasted.TargetName
									Local.TimerManagement.SpellTimer[thisspell].TargetLevel = Local.SpellCasted.TargetLevel
								end
								if Local.TimerManagement.SpellTimer[thisspell].Type == 4
									and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
									then
									Local.TimerManagement = self:RetraitTimerParIndex(thisspell, Local.TimerManagement)
									break
								end
							end
							SortActif = false
						-- if its a corruption timer, remove the previous one || Si le timer est une corruption, on enlève la précédente corruption sur la cible
						elseif (self.Spell[spell].Type == 5) then
							for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
								if Local.TimerManagement.SpellTimer[thisspell].Type == 5
									and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
									then
									Local.TimerManagement = self:RetraitTimerParIndex(thisspell, Local.TimerManagement)
									break
								end
							end
							SortActif = false
						end
					end
					if not SortActif
						and not (self.Spell[spell].Type == 0)
						and not (spell == 10)
						then

						if (spell == 9) then
							if Local.SpellCasted.Rank:find("1") then
								self.Spell[spell].Length = 20
							else
								self.Spell[spell].Length = 30
							end
							Local.TimerManagement.Banish = true
						end

						-- now insert a timer for the spell that has been casted
						Local.TimerManagement = self:InsertTimerParTable(spell, Local.SpellCasted.TargetName, Local.SpellCasted.TargetLevel, Local.TimerManagement)
						break
					end
				end
			end
		end
	end
	Local.SpellCasted = {}
	return
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE L'INTERFACE -- LIENS XML
------------------------------------------------------------------------------------------------------

-- Fonction permettant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis:OnDragStart(button)
	button:StartMoving()
end

-- Fonction arrêtant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis:OnDragStop(button)
	-- On arrête le déplacement de manière effective
	button:StopMovingOrSizing()
	-- On sauvegarde l'emplacement du bouton
	local NomBouton = button:GetName()
	local AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY = button:GetPoint()
	if not BoutonParent then
		BoutonParent = "UIParent"
	else
		BoutonParent = BoutonParent:GetName()
	end
	NecrosisConfig.FramePosition[NomBouton] = {AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY}
end

-- Fonction gérant les bulles d'aide
function Necrosis:BuildTooltip(button, Type, anchor, sens)

	-- Si l'affichage des bulles d'aide est désactivé, Bye bye !
	if not NecrosisConfig.NecrosisToolTip then
		return
	end

	-- Si la bulle d'aide est associée à un bouton de menu, on change l'ancrage de la tooltip suivant son sens
	if sens then
		if (sens == "Pet" and NecrosisConfig.PetMenuPos.direction < 0)
			or
				(sens == "Buff" and NecrosisConfig.BuffMenuPos.direction < 0)
			or
				(sens == "Curse" and NecrosisConfig.CurseMenuPos.direction < 0)
			or
				(sens == "Timer" and NecrosisConfig.SpellTimerJust == "RIGHT")
			or
				(sens == "Metamorphosis" and NecrosisConfig.MetamorphosisMenuPos.direction < 0)
			then
				anchor = "ANCHOR_LEFT"
		end
	end

	-- On regarde si la domination corrompue, le gardien de l'ombre ou l'amplification de malédiction sont up (pour tooltips)
	local start, duration, start2, duration2, start3, duration3, startMetamorphose, durationMetamorphose
	if self.Spell[15].Name then
		start, duration = GetSpellCooldown(self.Spell[15].Id)
	else
		start = 1
		duration = 1
	end
	if self.Spell[43].Name then
		start2, duration2 = GetSpellCooldown(self.Spell[43].Id)
		if not start2 then start2 = 1 end
		if not duration2 then duration2 = 1 end
	else
		start2 = 1
		duration2 = 1
	end
	if self.Spell[50].Name then
		start3, duration3 = GetSpellCooldown(self.Spell[50].Id)
	else
		start3 = 1
		duration3 = 1
	end
	if self.Spell[27].Name then
		startMetamorphose, durationMetamorphose = GetSpellCooldown(self.Spell[27].Id)
	else
		startMetamorphose = 1
		durationMetamorphose = 1
	end

	-- Création des bulles d'aides....
	GameTooltip:SetOwner(button, anchor)
	GameTooltip:SetText(self.TooltipData[Type].Label)
	-- ..... pour le bouton principal
	if (Type == "Main") then
		GameTooltip:AddLine(self.TooltipData.Main.Soulshard.."Not Yet")
		local SoulOnHand = false
		local HealthOnHand = false
		if Local.Stone.Soul.OnHand then SoulOnHand = true end
		if Local.Stone.Health.OnHand then HealthOnHand = true end
		GameTooltip:AddLine(self.TooltipData.Main.Soulstone..self.TooltipData[Type].Stone[SoulOnHand])
		GameTooltip:AddLine(self.TooltipData.Main.Healthstone..self.TooltipData[Type].Stone[HealthOnHand])
		-- Affichage du nom du démon, ou s'il est asservi, ou "Aucun" si aucun démon n'est présent
		if (Local.Summon.DemonType) then
			GameTooltip:AddLine(self.TooltipData.Main.CurrentDemon..Local.Summon.DemonType)
		elseif Local.Summon.DemonEnslaved then
			GameTooltip:AddLine(self.TooltipData.Main.EnslavedDemon)
		else
			GameTooltip:AddLine(self.TooltipData.Main.NoCurrentDemon)
		end
	-- ..... pour les boutons de pierre
	elseif Type:find("stone") then
		-- Pierre d'âme
		if (Type == "Soulstone") then
			-- On affiche le nom de la pierre et l'action que produira le clic sur le bouton
			-- Et aussi le Temps de recharge
			if Local.Stone.Soul.Mode == 1 or Local.Stone.Soul.Mode == 3 then
				GameTooltip:AddLine(self.Spell[51].Mana.." Mana")
			end
			self:MoneyToggle()
			NecrosisTooltip:SetBagItem(Local.Stone.Soul.Location[1], Local.Stone.Soul.Location[2])
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText())
			GameTooltip:AddLine(self.TooltipData[Type].Text[Local.Stone.Soul.Mode])
			GameTooltip:AddLine(self.TooltipData[Type].Ritual)
			if itemName:find(self.Translation.Misc.Cooldown) then
				GameTooltip:AddLine(itemName)
			end
		-- Pierre de vie
		elseif (Type == "Healthstone") then
			-- Idem
			if Local.Stone.Health.Mode == 1 then
				GameTooltip:AddLine(self.Spell[52].Mana.." Mana")
			end
			self:MoneyToggle()
			NecrosisTooltip:SetBagItem(Local.Stone.Health.Location[1], Local.Stone.Health.Location[2])
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText())
			GameTooltip:AddLine(self.TooltipData[Type].Text[Local.Stone.Health.Mode])
			if Local.Stone.Health.Mode == 2 then
				GameTooltip:AddLine(self.TooltipData[Type].Text2)
			end
			if itemName:find(self.Translation.Misc.Cooldown) then
				GameTooltip:AddLine(itemName)
			end
			if  not (start3 > 0 and duration3 > 0) then
				GameTooltip:AddLine(self.TooltipData[Type].Ritual)
			end
		end
	-- .... pour la Métamorphose
	elseif (Type == "Metamorphosis") then
		if startMetamorphose > 0 and durationMetamorphose > 0 then
			local seconde = durationMetamorphose - ( GetTime() - startMetamorphose)
			local affiche
			affiche = tostring(floor(seconde)).." sec"
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	-- ..... pour le bouton des Timers
	elseif (Type == "SpellTimer") then
		self:MoneyToggle()
		NecrosisTooltip:SetBagItem(Local.Stone.Hearth.Location[1], Local.Stone.Hearth.Location[2])
		local itemName = tostring(NecrosisTooltipTextLeft5:GetText())
		GameTooltip:AddLine(self.TooltipData[Type].Text)
		if itemName:find(self.Translation.Misc.Cooldown) then
			GameTooltip:AddLine(self.Translation.Item.Hearthstone.." - "..itemName)
		else
			GameTooltip:AddLine(self.TooltipData[Type].Right..GetBindLocation())
		end

	-- ..... pour le bouton de la Transe de l'ombre
	elseif (Type == "ShadowTrance") or (Type == "Backlash") then
		GameTooltip:SetText(self.TooltipData[Type].Label.."          |CFF808080"..self.Spell[45].Rank.."|r")
	-- ..... pour les autres buffs et démons, le coût en mana...
	elseif (Type == "Enslave") then
		GameTooltip:AddLine(self.Spell[35].Mana.." Mana")
	elseif (Type == "Mount") and self.Spell[2].Name then
		if (NecrosisConfig.LeftMount) then
			local leftMountName = GetSpellInfo(NecrosisConfig.LeftMount);
			GameTooltip:AddLine(leftMountName);
		else
			--use tooltip for default mounts
			GameTooltip:AddLine(self.TooltipData[Type].Text);
		end
		if (NecrosisConfig.RightMount) then
			local rightMountName = GetSpellInfo(NecrosisConfig.RightMount)
			GameTooltip:AddLine(rightMountName);
		end

	elseif (Type == "Armor") then
		if self.Spell[31].Name then
			GameTooltip:AddLine(self.Spell[31].Mana.." Mana")
		else
			GameTooltip:AddLine(self.Spell[36].Mana.." Mana")
		end
	elseif (Type == "FelArmor") then
		GameTooltip:AddLine(self.Spell[47].Mana.." Mana")
	elseif (Type == "Aqua") then
		GameTooltip:AddLine(self.Spell[32].Mana.." Mana")
	elseif (Type == "Kilrogg") then
		GameTooltip:AddLine(self.Spell[34].Mana.." Mana")
	elseif (Type == "Banish") then
		GameTooltip:AddLine(self.Spell[9].Mana.." Mana")
	elseif (Type == "Weakness") then
		GameTooltip:AddLine(self.Spell[23].Mana.." Mana")
	elseif (Type == "Agony") then
		GameTooltip:AddLine(self.Spell[22].Mana.." Mana")
	elseif (Type == "Tongues") then
		GameTooltip:AddLine(self.Spell[25].Mana.." Mana")
	elseif (Type == "Exhaust") then
		GameTooltip:AddLine(self.Spell[40].Mana.." Mana")
	elseif (Type == "Elements") then
		GameTooltip:AddLine(self.Spell[26].Mana.." Mana")
	elseif (Type == "Doom") then
		GameTooltip:AddLine(self.Spell[16].Mana.." Mana")
	elseif (Type == "Corruption") then
		GameTooltip:AddLine(self.Spell[14].Mana.." Mana")
	elseif (Type == "TP") then
		GameTooltip:AddLine(self.Spell[37].Mana.." Mana")
	elseif (Type == "SoulLink") then
		GameTooltip:AddLine(self.Spell[38].Mana.." Mana")
	elseif (Type == "ShadowProtection") then
		GameTooltip:AddLine(self.Spell[43].Mana.." Mana")
		if start2 > 0 and duration2 > 0 then
			local seconde = duration2 - ( GetTime() - start2)
			local affiche
			affiche = tostring(floor(seconde)).." sec"
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	elseif (Type == "Domination") then
		if start > 0 and duration > 0 then
			local seconde = duration - ( GetTime() - start)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec"
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60)
				if seconde <= 9 then
					time = "0"..tostring(floor(seconde))
				else
					time = tostring(floor(seconde))
				end
				affiche = minute..":"..time
			end
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	elseif (Type == "Imp") then
		GameTooltip:AddLine(self.Spell[3].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(self.TooltipData.DominationCooldown)
		end

	elseif (Type == "Voidwalker") then
		GameTooltip:AddLine(self.Spell[4].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(self.TooltipData.DominationCooldown)
		end
	elseif (Type == "Succubus") then
		GameTooltip:AddLine(self.Spell[5].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(self.TooltipData.DominationCooldown)
		end
	elseif (Type == "Felhunter") then
		GameTooltip:AddLine(self.Spell[6].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(self.TooltipData.DominationCooldown)
		end
	elseif (Type == "Felguard") then
		GameTooltip:AddLine(self.Spell[7].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(self.TooltipData.DominationCooldown)
		end
	elseif (Type == "Infernal") then
		GameTooltip:AddLine(self.Spell[8].Mana.." Mana")
	elseif (Type == "Doomguard") then
		GameTooltip:AddLine(self.Spell[30].Mana.." Mana")
	elseif (Type == "BuffMenu") then
		if Local.PlayerInCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(self.TooltipData[Type].Text2)
		else
			GameTooltip:AddLine(self.TooltipData[Type].Text)
		end
	elseif (Type == "CurseMenu") then
		if Local.PlayerInCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(self.TooltipData[Type].Text2)
		else
			GameTooltip:AddLine(self.TooltipData[Type].Text)
		end
	elseif (Type == "PetMenu") then
		if Local.PlayerInCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(self.TooltipData[Type].Text2)
		else
			GameTooltip:AddLine(self.TooltipData[Type].Text)
		end
	end
	-- Et hop, affichage !
	GameTooltip:Show()
end

-- Fonction mettant à jour les boutons Necrosis et donnant l'état du bouton de la pierre d'âme
function Necrosis:UpdateIcons()

	-- Pierre d'âme
	-----------------------------------------------

	-- On se renseigne pour savoir si une pierre d'âme a été utilisée --> vérification dans les timers
	local SoulstoneInUse = false
	if Local.TimerManagement.SpellTimer then
		for index = 1, #Local.TimerManagement.SpellTimer, 1 do
			if (Local.TimerManagement.SpellTimer[index].Name == self.Spell[11].Name)  and Local.TimerManagement.SpellTimer[index].TimeMax > 0 then
				SoulstoneInUse = true
				break
			end
		end
	end

	-- Si la Pierre n'a pas été utilisée, et qu'il n'y a pas de pierre en inventaire -> Mode 1
	if not (Local.Stone.Soul.OnHand or SoulstoneInUse) then
		Local.Stone.Soul.Mode = 1
	end

	-- Si la Pierre n'a pas été utilisée, mais qu'il y a une pierre en inventaire
	if Local.Stone.Soul.OnHand and (not SoulstoneInUse) then
		-- Si la pierre en inventaire contient un timer, et qu'on sort d'un RL --> Mode 4
		local start, duration = GetContainerItemCooldown(Local.Stone.Soul.Location[1],Local.Stone.Soul.Location[2])
		if Local.LoggedIn and start > 0 and duration > 0 then
			Local.TimerManagement = self:InsertTimerStone("Soulstone", start, duration, Local.TimerManagement)
			Local.Stone.Soul.Mode = 4
			Local.LoggedIn = false
		-- Si la pierre ne contient pas de timer, ou qu'on ne sort pas d'un RL --> Mode 2
		else
			Local.Stone.Soul.Mode = 2
			Local.LoggedIn = false
		end
	end

	-- Si la Pierre a été utilisée mais qu'il n'y a pas de pierre en inventaire --> Mode 3
	if (not Local.Stone.Soul.OnHand) and SoulstoneInUse then
		Local.Stone.Soul.Mode = 3
	end

	-- Si la Pierre a été utilisée et qu'il y a une pierre en inventaire
	if Local.Stone.Soul.OnHand and SoulstoneInUse then
			Local.Stone.Soul.Mode = 4
	end

	-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
	if self.Spell[51].Name and NecrosisConfig.ItemSwitchCombat[2] and (Local.Stone.Soul.Mode == 1 or Local.Stone.Soul.Mode == 3) then
		self:SoulstoneUpdateAttribute("NoStone")
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SoulstoneButton-0"..Local.Stone.Soul.Mode)
	end

	-- Pierre de vie
	-----------------------------------------------

	-- Mode "j'en ai une" (2) / "j'en ai pas" (1)
	if (Local.Stone.Health.OnHand) then
		Local.Stone.Health.Mode = 2
	else
		Local.Stone.Health.Mode = 1
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if self.Spell[52].Name and NecrosisConfig.ItemSwitchCombat[1] then
			self:HealthstoneUpdateAttribute("NoStone")
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\HealthstoneButton-0"..Local.Stone.Health.Mode)
	end
end

-- Update de la sphere en fonction de la vie
function Necrosis:UpdateHealth()
	local health = UnitHealth("player")
	if NecrosisConfig.Circle == 4 then
		local healthMax = UnitHealthMax("player")
		if health == healthMax then
			if not (Local.LastSphereSkin == NecrosisConfig.NecrosisColor.."\\Shard32") then
				Local.LastSphereSkin = NecrosisConfig.NecrosisColor.."\\Shard32"
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..Local.LastSphereSkin)
			end
		else
			local taux = math.floor(health / (healthMax / 16))
			if not (Local.LastSphereSkin == NecrosisConfig.NecrosisColor.."\\Shard"..taux) then
				Local.LastSphereSkin = NecrosisConfig.NecrosisColor.."\\Shard"..taux
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..Local.LastSphereSkin)
			end
		end
	end
	-- Si l'intérieur de la pierre affiche la vie
	if NecrosisConfig.CountType == 5 then
		NecrosisShardCount:SetText(health)
	end
end

-- Update des boutons en fonction de la mana
function Necrosis:UpdateMana(Metamorphose, Power)
	if Local.Dead then return end

	-- Si l'event UNIT_POWER est dû à un changement de fragments d'âmes
	if Power == "SOUL_SHARDS" then
		local shardCount = UnitPower("player", 7)

		-- On met le compteur numérique à jour s'il affiche les fragments
		if NecrosisConfig.CountType == 1 then
			NecrosisShardCount:SetText(shardCount)
		end

		-- On met la sphere à jour si elle affiche les fragments
		if NecrosisConfig.Circle == 1 then
			local ShardThird = new("array",
				0, 5, 10, 16
			)
			if not (Local.LastSphereSkin == NecrosisConfig.NecrosisColor.."\\Shard"..ShardThird[shardCount+1]) then
				Local.LastSphereSkin = NecrosisConfig.NecrosisColor.."\\Shard"..ShardThird[shardCount+1]
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..Local.LastSphereSkin)
			end
			del(ShardThird)
		end
	end

	local mana = UnitMana("player")
	local manaMax = UnitManaMax("player")

	-- Si le pourtour de la pierre affiche la mana
	if NecrosisConfig.Circle == 3 then
		if mana == manaMax then
			if not (Local.LastSphereSkin == NecrosisConfig.NecrosisColor.."\\Shard32") then
				Local.LastSphereSkin = NecrosisConfig.NecrosisColor.."\\Shard32"
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..Local.LastSphereSkin)
			end
		else
			local taux = math.floor(mana / (manaMax / 16))
			if not (Local.LastSphereSkin == NecrosisConfig.NecrosisColor.."\\Shard"..taux) then
				Local.LastSphereSkin = NecrosisConfig.NecrosisColor.."\\Shard"..taux
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..Local.LastSphereSkin)
			end
		end
	end

	-- Si l'intérieur de la pierre affiche la mana
	if NecrosisConfig.CountType == 4 then
		NecrosisShardCount:SetText(mana)
	end

	-- Si cooldown de domination corrompue on grise
	if _G["NecrosisPetMenu1"] and self.Spell[15].Name and not Local.BuffActif.Domination then
		local start, duration = GetSpellCooldown(self.Spell[15].Id)
		if start > 0 and duration > 0 then
			if not Local.Desatured["Domination"] then
				NecrosisPetMenu1:GetNormalTexture():SetDesaturated(1)
				Local.Desatured["Domination"] = true
			end
		else
			if Local.Desatured["Domination"] then
				NecrosisPetMenu1:GetNormalTexture():SetDesaturated(nil)
				Local.Desatured["Domination"] = false
			end
		end
	end

	-- Si cooldown de métamorphose, on grise
	if _G["NecrosisMetamorphosisButton"] and self.Spell[27].Name then
		local start, duration = GetSpellCooldown(self.Spell[27].Id)
		if not Metamorphose and (start > 0 and duration > 0) then
			if not Local.Desatured["Metamorphose"] then
				NecrosisMetamorphosisButton:GetNormalTexture():SetDesaturated(1)
				Local.Desatured["Metamorphose"] = true
			end
		else
			if Local.Desatured["Metamorphose"] then
				NecrosisMetamorphosisButton:GetNormalTexture():SetDesaturated(nil)
				Local.Desatured["Metamorphose"] = false
			end
		end
	end

	-- Si cooldown de gardien de l'ombre on grise
	if _G["NecrosisBuffMenu8"] and self.Spell[43].Name then
		local start, duration = GetSpellCooldown(self.Spell[43].Id)
		if self.Spell[43].Mana > mana and start > 0 and duration > 0 then
			if not Local.Desatured["Gardien"] then
				NecrosisBuffMenu8:GetNormalTexture():SetDesaturated(1)
				Local.Desatured["Gardien"] = true
			end
		else
			if Local.Desatured["Gardien"] then
				NecrosisBuffMenu8:GetNormalTexture():SetDesaturated(nil)
				Local.Desatured["Gardien"] = false
			end
		end
	end


	-- Bouton des démons
	-----------------------------------------------

	local ManaPet = new("array",
		true, true, true, true, true, true, true
	)

	if mana then
	-- Coloration du bouton en grisé si pas assez de mana
		if self.Spell[3].Name then
			if self.Spell[3].Mana > mana then
				for i = 1, 7, 1 do
					ManaPet[i] = false
				end
			elseif self.Spell[4].Name then
				if self.Spell[4].Mana > mana then
					for i = 2, 7, 1 do
						ManaPet[i] = false
					end
				elseif self.Spell[8].Name then
					if self.Spell[8].Mana > mana then
							ManaPet[7] = false
							ManaPet[8] = false
					elseif self.Spell[30].Name then
						if self.Spell[30].Mana > mana then
							ManaPet[8] = false
						end
					end
				end
			end
		end
	end

	-- Texturage des boutons de pet
	local PetNameHere = new("array",
		"Imp-0", "Voidwalker-0", "Succubus-0", "Felhunter-0", "Felguard-0", "Infernal-0", "Doomguard-0"
	)
	for i = 1, #PetNameHere, 1 do
		local PetManaButton = _G["NecrosisPetMenu"..(i + 1)]
		if PetManaButton
			and Local.Summon.LastDemonType
			and Local.Summon.LastDemonType == self.Translation.DemonName[i]
			and not (Local.Summon.LastDemonType == Local.Summon.DemonType)
			then
				PetManaButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\"..PetNameHere[i].."1")
				Local.Summon.LastDemonType = nil
		end
		if PetManaButton
			and Local.Summon.DemonType
			and Local.Summon.DemonType == self.Translation.DemonName[i]
			then
				PetManaButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\"..PetNameHere[i].."2")
		elseif PetManaButton and ManaPet[i] then
			if Local.Desatured["NecrosisPetMenu"..(i + 1)] then
				PetManaButton:GetNormalTexture():SetDesaturated(nil)
				Local.Desatured["NecrosisPetMenu"..(i + 1)] = false
			end
		elseif PetManaButton then
			if not Local.Desatured["NecrosisPetMenu"..(i + 1)] then
				PetManaButton:GetNormalTexture():SetDesaturated(1)
				Local.Desatured["NecrosisPetMenu"..(i + 1)] = true
			end
		end
	end
	del(PetNameHere)
	del(ManaPet)


	-- Bouton des buffs
	-----------------------------------------------

	if mana then
	-- Coloration du bouton en grisé si pas assez de mana
		if self.Spell[35].Name then
			if self.Spell[35].Mana > mana then
				if not Local.Desatured["Enslave"] then
					if _G["NecrosisPetMenu9"] then
						NecrosisPetMenu9:GetNormalTexture():SetDesaturated(1)
					end
					Local.Desatured["Enslave"] = true
				end
			else
				if Local.Desatured["Enslave"]then
					if _G["NecrosisPetMenu9"] then
						NecrosisPetMenu9:GetNormalTexture():SetDesaturated(nil)
					end
					Local.Desatured["Enslave"] = false
				end
			end
		end
		if _G["NecrosisBuffMenu1"] and self.Spell[31].Name then
			if self.Spell[31].Mana > mana then
				if  not Local.Desatured["Armor"] then
					NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(1)
					Local.Desatured["Armor"] = true
				end
			else
				if Local.Desatured["Armor"] then
					NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(nil)
					Local.Desatured["Armor"] = false
				end
			end
		elseif _G["NecrosisBuffMenu1"] and self.Spell[36].Name then
			if self.Spell[36].Mana > mana then
				if not Local.Desatured["Armor"] then
					NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(1)
					Local.Desatured["Armor"] = true
				end
			else
				if Local.Desatured["Armor"] then
					NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(nil)
					Local.Desatured["Armor"] = false
				end
			end
		elseif _G["NecrosisBuffMenu7"] and self.Spell[38].Name and not Local.BuffActif.SoulLink then
			if self.Spell[38].Mana > mana then
				if not Local.Desatured["SoulLink"] then
					NecrosisBuffMenu7:GetNormalTexture():SetDesaturated(1)
					Local.Desatured["SoulLink"] = true
				end
			else
				if Local.Desatured["SoulLink"] then
					NecrosisBuffMenu7:GetNormalTexture():SetDesaturated(nil)
					Local.Desatured["SoulLink"] = false
				end
			end
		end

		local BoutonNumber = new("array",
			2, 3, 5, 6, 11
		)
		local SortNumber = new("array",
			47, 32, 34, 37, 9
		)
		for i = 1, #SortNumber, 1 do
			local f = _G["NecrosisBuffMenu"..BoutonNumber[i]]
			if f and self.Spell[SortNumber[i]].Name then
				if self.Spell[SortNumber[i]].Mana > mana then
					if not Local.Desatured["NecrosisBuffMenu"..BoutonNumber[i]] then
						f:GetNormalTexture():SetDesaturated(1)
						Local.Desatured["NecrosisBuffMenu"..BoutonNumber[i]] = true
					end
				else
					if Local.Desatured["NecrosisBuffMenu"..BoutonNumber[i]] then
						f:GetNormalTexture():SetDesaturated(nil)
						Local.Desatured["NecrosisBuffMenu"..BoutonNumber[i]] = false
					end
				end
			end
		end
		del(BoutonNumber)
		del(SortNumber)

		if _G["NecrosisPetMenu10"] and self.Spell[44].Name then
			if not UnitExists("pet") then
				if not Local.Desatured["Sacrifice"] then
					NecrosisPetMenu10:GetNormalTexture():SetDesaturated(1)
					Local.Desatured["Sacrifice"] = true
				end
			else
				if Local.Desatured["Sacrifice"] then
					NecrosisPetMenu10:GetNormalTexture():SetDesaturated(nil)
					Local.Desatured["Sacrifice"] = false
				end
			end
		end

	end

	-- Bouton des curses
	-----------------------------------------------

	if mana then
		local SpellMana = new("array",
			23, -- curse of weakness
			22, -- curse of agony
			25, -- curse of tongues
			40, -- curse of exhaustion
			26, -- curse of the elements
			16, -- curse of doom
			14  -- corruption
		)

		-- Coloration du bouton en grisé si pas assez de mana
		for i = 1, #SpellMana, 1 do
			local f = _G["NecrosisCurseMenu"..i+1]
			if f and self.Spell[SpellMana[i]].Name then
				if self.Spell[SpellMana[i]].Mana > mana then
					if not Local.Desatured["NecrosisCurseMenu"..i+1] then
						f:GetNormalTexture():SetDesaturated(1)
						Local.Desatured["NecrosisCurseMenu"..i+1] = true
					end
				else
					if Local.Desatured["NecrosisCurseMenu"..i+1] then
						f:GetNormalTexture():SetDesaturated(nil)
						Local.Desatured["NecrosisCurseMenu"..i+1] = false
					end
				end
			end
		end
		del(SpellMana)
	end


	-- Bouton des Timers
	-----------------------------------------------
	if Local.Stone.Hearth.Location[1] then
		local start, duration, enable = GetContainerItemCooldown(Local.Stone.Hearth.Location[1], Local.Stone.Hearth.Location[2])
		if duration > 20 and start > 0 then
			if not Local.Stone.Hearth.Cooldown then
				NecrosisSpellTimerButton:GetNormalTexture():SetDesaturated(1)
				Local.Stone.Hearth.Cooldown = true
			end
		else
			if Local.Stone.Hearth.Cooldown then
				NecrosisSpellTimerButton:GetNormalTexture():SetDesaturated(nil)
				Local.Stone.Hearth.Cooldown = false
			end
		end
	end
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS MANAGING STONES & SHARDS || FONCTIONS DES PIERRES ET DES FRAGMENTS
------------------------------------------------------------------------------------------------------

-- Explore bags for stones & shards || Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function Necrosis:BagExplore(arg)

	if not arg then
		Local.Stone.Soul.OnHand = nil
		Local.Stone.Health.OnHand = nil
		Local.Stone.Hearth.OnHand = nil
		-- search all bags || Parcours des sacs
		for container = 0, 4, 1 do
			-- Parcours des emplacements des sacs
			for slot=1, GetContainerNumSlots(container), 1 do
				self:MoneyToggle()
				NecrosisTooltip:SetBagItem(container, slot)
				local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
				-- if there is an item located in that bag slot || Dans le cas d'un emplacement non vide
				if itemName then
					-- check if its a soulstone || Si c'est une pierre d'âme, on note son existence et son emplacement
					if itemName == self.Translation.Item.Soulstone then
						Local.Stone.Soul.OnHand = container
						Local.Stone.Soul.Location = {container,slot}
						NecrosisConfig.ItemSwitchCombat[2] = itemName

						-- update its button attributes on the sphere || On attache des actions au bouton de la pierre
						self:SoulstoneUpdateAttribute()
					-- check if its a healthstone || Même chose pour une pierre de soin
					elseif itemName == self.Translation.Item.Healthstone then
						Local.Stone.Health.OnHand = container
						Local.Stone.Health.Location = {container,slot}
						NecrosisConfig.ItemSwitchCombat[1] = itemName

						-- update its button attributes on the sphere || On attache des actions au bouton de la pierre
						self:HealthstoneUpdateAttribute()
					-- check if its a hearthstone || et enfin la pierre de foyer
					elseif itemName:find(self.Translation.Item.Hearthstone) then
						Local.Stone.Hearth.OnHand = container
						Local.Stone.Hearth.Location = {container,slot}
					end
				end
			end
		end
	else
		if Local.Stone.Soul.OnHand == arg then Local.Stone.Soul.OnHand = nil end
		if Local.Stone.Health.OnHand == arg then Local.Stone.Health.OnHand = nil end
		if Local.Stone.Hearth.OnHand == arg then Local.Stone.Hearth.OnHand = nil end
		for slot=1, GetContainerNumSlots(arg), 1 do
			self:MoneyToggle()
			NecrosisTooltip:SetBagItem(arg, slot)
			local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
			-- if there is an item located in that bag slot || Dans le cas d'un emplacement non vide
			if itemName then
				-- check if its a soulstone || Si c'est une pierre d'âme, on note son existence et son emplacement
				if itemName == self.Translation.Item.Soulstone then
					Local.Stone.Soul.OnHand = arg
					Local.Stone.Soul.Location = {arg,slot}
					NecrosisConfig.ItemSwitchCombat[2] = itemName

					-- update its button attributes on the sphere || On attache des actions au bouton de la pierre
					self:SoulstoneUpdateAttribute()
				-- check if its a healthstone || Même chose pour une pierre de soin
				elseif itemName == self.Translation.Item.Healthstone then
					Local.Stone.Health.OnHand = arg
					Local.Stone.Health.Location = {arg,slot}
					NecrosisConfig.ItemSwitchCombat[1] = itemName

					-- update its button attributes on the sphere || On attache des actions au bouton de la pierre
					self:HealthstoneUpdateAttribute()
				-- check if its a hearthstone || et enfin la pierre de foyer
				elseif itemName:find(self.Translation.Item.Hearthstone) then
					Local.Stone.Hearth.OnHand = arg
					Local.Stone.Hearth.Location = {arg,slot}
				end
			end
		end
	end

	-- update icons and we're done || Et on met le tout à jour !
	self:UpdateIcons()
end


------------------------------------------------------------------------------------------------------
-- VARIOUS FUNCTIONS || FONCTIONS DES SORTS
------------------------------------------------------------------------------------------------------

-- Display or Hide buttons depending on spell availability || Affiche ou masque les boutons de sort à chaque nouveau sort appris
function Necrosis:ButtonSetup()
	local NBRScale = (100 + (NecrosisConfig.NecrosisButtonScale - 85)) / 100
	if NecrosisConfig.NecrosisButtonScale <= 95 then
		NBRScale = 1.1
	end

	local ButtonName = new("array",
		"NecrosisHealthstoneButton",
		"NecrosisSoulstoneButton",
		"NecrosisBuffMenuButton",
		"NecrosisMountButton",
		"NecrosisPetMenuButton",
		"NecrosisCurseMenuButton",
		"NecrosisMetamorphosisButton"
	)

	for index, valeur in ipairs(ButtonName) do
		local f = _G[valeur]
		if f then f:Hide() end
	end

	local SpellExist = new("array",
		self.Spell[52].Name,
		self.Spell[51].Name,
		Local.Menu.Buff[1],
		Local.Summon.SteedAvailable,
		Local.Menu.Pet[1],
		Local.Menu.Curse[1],
		self.Spell[27].Name
	)

	if NecrosisConfig.NecrosisLockServ then
		local indexScale = -36
		for index=1, #NecrosisConfig.StonePosition, 1 do
			for button = 1, #NecrosisConfig.StonePosition, 1 do
				if math.abs(NecrosisConfig.StonePosition[index]) == button
					and NecrosisConfig.StonePosition[button] > 0
					and SpellExist[button] then
						local f = _G[ButtonName[button]]
						if not f then
							f = self:CreateSphereButtons(ButtonName[button])
							self:StoneAttribute(Local.Summon.SteedAvailable)
						end
						f:ClearAllPoints()
						f:SetPoint(
							"CENTER", "NecrosisButton", "CENTER",
							((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle - indexScale)),
							((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle - indexScale))
						)
						f:Show()
						indexScale = indexScale + 36
						break
				end
			end
		end
	else
		for index=1, #NecrosisConfig.StonePosition, 1 do
			for button = 1, #NecrosisConfig.StonePosition, 1 do
				if math.abs(NecrosisConfig.StonePosition[index]) == button
					and NecrosisConfig.StonePosition[button] > 0
					and SpellExist[button] then
						local f = _G[ButtonName[button]]
						if not f then
							f = self:CreateSphereButtons(ButtonName[button])
							self:StoneAttribute(Local.Summon.SteedAvailable)
						end
						f:ClearAllPoints()
						f:SetPoint(
							NecrosisConfig.FramePosition[ButtonName[button]][1],
							NecrosisConfig.FramePosition[ButtonName[button]][2],
							NecrosisConfig.FramePosition[ButtonName[button]][3],
							NecrosisConfig.FramePosition[ButtonName[button]][4],
							NecrosisConfig.FramePosition[ButtonName[button]][5]
						)
						f:Show()
						break
				end
			end
		end
	end
	del(ButtonName)
	del(SpellExist)
end


-- My favourite feature! Create a list of spells known by the warlock sorted by name & rank || Ma fonction préférée ! Elle fait la liste des sorts connus par le démo, et les classe par rang.
function Necrosis:SpellSetup()

	local spellSlot = 1


	-- On parcourt les sorts du démoniste
	-- Si un sort du grimoire est dans la liste des sorts, on le nomme, et on calcule son coût en mana
	while true do
		local _, spellId = GetSpellBookItemInfo(spellSlot, BOOKTYPE_SPELL)

		if not spellId then
			do break end
		end

		for i=1, #self.Spell, 1 do
			if self.Spell[i].Id == spellId then
				do
					local spellName, _, _, ManaCost = GetSpellInfo(spellId)
					self.Spell[i].Name = spellName
					self.Spell[i].Mana = tonumber(ManaCost)
					break
				end
			end
		end
		spellSlot = spellSlot + 1
	end


	-- WoW 3.0 :  Les montures se retrouvent dans une interface à part
	if GetNumCompanions("MOUNT") > 0 then
		for i = 1, GetNumCompanions("MOUNT"), 1 do
			local _, NomCheval, SpellCheval = Necrosis:GetCompanionInfo("MOUNT", i)
			if SpellCheval == self.Spell[1].Id then
				self.Spell[1].Name = NomCheval
			end
			if SpellCheval == self.Spell[2].Id then
				self.Spell[2].Name = NomCheval
			end
		end
	end

	-- associate the mounts to the sphere button || Association du sort de monture correct au bouton
	if self.Spell[1].Name or self.Spell[2].Name then
		Local.Summon.SteedAvailable = true
	else
		Local.Summon.SteedAvailable = false
	end

	if not InCombatLockdown() then
		self:MainButtonAttribute()
		self:BuffSpellAttribute()
		self:PetSpellAttribute()
		self:CurseSpellAttribute()
		self:StoneAttribute(Local.Summon.SteedAvailable)
	end

	Necrosis:BindName()
end

-- extract an attribute from a spell || Fonction d'extraction d'attribut de sort
-- F(Type=string, string, int) -> Spell=table
function Necrosis:FindSpellAttribute(Type, attribute, array)
	for index=1, #self.Spell, 1 do
		if self.Spell[index][Type]:find(attribute) then return self.Spell[index][array] end
	end
	return nil
end

------------------------------------------------------------------------------------------------------
-- MISCELLANEOUS FUNCTIONS || FONCTIONS DIVERSES
------------------------------------------------------------------------------------------------------

-- function to check the presence of a debuff on the unit || Fonction pour savoir si une unité subit un effet
-- F(string, string)->bool
function Necrosis:UnitHasEffect(unit, effect)
	local index = 1
	while UnitDebuff(unit, index) do
		self:MoneyToggle()
		NecrosisTooltip:SetUnitDebuff(unit, index)
		local DebuffName = tostring(NecrosisTooltipTextLeft1:GetText())
   		if DebuffName:find(effect) then
			return true
		end
		index = index + 1
	end
	return false
end

-- Function to check the presence of a buff on the unit.
-- Strictly identical to UnitHasEffect, but as WoW distinguishes Buff and DeBuff, so we have to.
function Necrosis:UnitHasBuff(unit, effect)
	local index = 1
	while UnitBuff(unit, index) do
	-- Here we'll cheat a little. checking a buff or debuff return the internal spell name, and not the name we give at start
		-- So we use an API widget that will use the internal name to return the known name.
		-- For example, the "Curse of Agony" spell is internaly known as "Spell_Shadow_CurseOfSargeras". Much easier to use the first one than the internal one.
		self:MoneyToggle()
		NecrosisTooltip:SetUnitBuff(unit, index)
		local BuffName = tostring(NecrosisTooltipTextLeft1:GetText())
   		if BuffName:find(effect) then
			return true
		end
		index = index + 1
	end
	return false
end


-- Display the antifear button / warning || Affiche ou cache le bouton de détection de la peur suivant la cible.
function Necrosis:ShowAntiFearWarning()
	local Actif = false -- must be False, or a number from 1 to Local.Warning.Antifear.Icon[] max element.

	-- Checking if we have a target. Any fear need a target to be casted on
	if UnitExists("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") then
		-- Checking if the target has natural immunity (only NPC target)
		if not UnitIsPlayer("target") and UnitCreatureType("target") == self.Unit.Undead then
			Actif = 2 -- Immun
		end

		-- We'll start to parse the target buffs, as his class doesn't give him natural permanent immunity
		if not Actif then
			for index=1, #self.AntiFear.Buff, 1 do
				if self:UnitHasBuff("target",self.AntiFear.Buff[index]) then
					Actif = 3 -- Prot
					break
				end
			end

			-- No buff found, let's try the debuffs
			for index=1, #self.AntiFear.Debuff, 1 do
				if self:UnitHasEffect("target",self.AntiFear.Debuff[index]) then
					Actif = 3 -- Prot
					break
				end
			end
		end

		-- an immunity has been detected before, but we still don't know why => show the button anyway
		if Local.Warning.Antifear.Immune and not Actif then
			Actif = 1
		end
	end

	if Actif then
		-- Antifear button is currently not visible, we have to change that
		if not Local.Warning.Antifear.Actif then
			Local.Warning.Antifear.Actif = true
			self:Msg(self.ChatMessage.Information.FearProtect, "USER")
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..Local.Warning.Antifear.Icon[Actif].."-02")
			if NecrosisConfig.Sound then PlaySoundFile(self.Sound.Fear) end
			ShowUIPanel(NecrosisAntiFearButton)
			Local.Warning.Antifear.Blink = GetTime() + 0.6
			Local.Warning.Antifear.Toggle = 2

		-- Timer to make the button blink
		elseif GetTime() >= Local.Warning.Antifear.Blink then
			if Local.Warning.Antifear.Toggle == 1 then
				Local.Warning.Antifear.Toggle = 2
			else
				Local.Warning.Antifear.Toggle = 1
			end
			Local.Warning.Antifear.Blink = GetTime() + 0.4
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..Local.Warning.Antifear.Icon[Actif].."-0"..Local.Warning.Antifear.Toggle)
		end

	elseif Local.Warning.Antifear.Actif then	-- No antifear on target, but the button is still visible => gonna hide it
		Local.Warning.Antifear.Actif = false
		HideUIPanel(NecrosisAntiFearButton)
	end
end

-- trade healthstone (out of combat) || Fonction pour gérer l'échange de pierre (hors combat)
function Necrosis:TradeStone()
		-- if a friendly target is selected then trade the stone || Dans ce cas si un pj allié est sélectionné, on lui donne la pierre
		-- else use it || Sinon, on l'utilise
		if Local.Trade.Request and Local.Stone.Health.OnHand and not Local.Trade.Complete then
			PickupContainerItem(Local.Stone.Health.Location[1], Local.Stone.Health.Location[2])
			ClickTradeButton(1)
			Local.Trade.Complete = true
			return
		elseif UnitExists("target") and UnitIsPlayer("target")
		and not (UnitCanAttack("player", "target") or UnitName("target") == UnitName("player")) then
				PickupContainerItem(Local.Stone.Health.Location[1], Local.Stone.Health.Location[2])
				if CursorHasItem() then
					DropItemOnUnit("target")
					Local.Trade.Complete = true
				end
				return
		end
end

function Necrosis:MoneyToggle()
	for index=1, 10 do
		local text = _G["NecrosisTooltipTextLeft"..index]
			if text then text:SetText(nil) end
			text = _G["NecrosisTooltipTextRight"..index]
			if text then text:SetText(nil) end
	end
	NecrosisTooltip:Hide()
	NecrosisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
end

function Necrosis:GameTooltip_ClearMoney()
    -- Intentionally empty don't clear money while we use hidden tooltips
end


-- restore buttons to default positions || Fonction (XML) pour rétablir les points d'attache par défaut des boutons
function Necrosis:ClearAllPoints()
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:ClearAllPoints() end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:ClearAllPoints() end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:ClearAllPoints() end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:ClearAllPoints() end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:ClearAllPoints() end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:ClearAllPoints() end
	if  _G["NecrosisMetamorphosisButton"] then NecrosisMetamorphosisButton:ClearAllPoints() end
end

-- Disable drag functionality || Fonction (XML) pour étendre la propriété NoDrag() du bouton principal de Necrosis sur tout ses boutons
function Necrosis:NoDrag()
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag("") end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("")end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag("") end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag("") end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag("") end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag("") end
	if  _G["NecrosisMetamorphosisButton"] then NecrosisMetamorphosisButton:RegisterForDrag("") end
end

-- Enable drag functionality || Fonction (XML) inverse de celle du dessus
function Necrosis:Drag()
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisMetamorphosisButton"] then NecrosisMetamorphosisButton:RegisterForDrag("LeftButton") end
end


-- Rebuild the menus at mod startup or when the spellbook changes || A chaque changement du livre des sorts, au démarrage du mod, ainsi qu'au changement de sens du menu on reconstruit les menus des sorts
function Necrosis:CreateMenu()
	Local.Menu.Pet = setmetatable({}, metatable)
	Local.Menu.Curse = setmetatable({}, metatable)
	Local.Menu.Buff = setmetatable({}, metatable)
	local menuVariable = nil
	local PetButtonPosition = "Button"
	local BuffButtonPosition = "Button"
	local CurseButtonPosition = "Button"

	-- Hide all the pet demon buttons || On cache toutes les icones des démons
	for i = 1, #NecrosisConfig.DemonSpellPosition, 1 do
		menuVariable = _G["NecrosisPetMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end
	-- Hide the general buff spell buttons || On cache toutes les icones des sorts
	for i = 1, #NecrosisConfig.BuffSpellPosition, 1 do
		menuVariable = _G["NecrosisBuffMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end
	-- Hide the curse buttons || On cache toutes les icones des curses
	for i = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		menuVariable = _G["NecrosisCurseMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end
	if NecrosisConfig.StonePosition[5] > 0 then
		local MenuID = new("array",
			15, 3, 4, 5, 6, 7, 8, 30, 35, 44, 24
		)
		-- On ordonne et on affiche les boutons dans le menu des démons
		for index = 1, #NecrosisConfig.DemonSpellPosition, 1 do
			-- Si le sort d'invocation existe, on affiche le bouton dans le menu des pets
			for spell = 1, #NecrosisConfig.DemonSpellPosition, 1 do
				if math.abs(NecrosisConfig.DemonSpellPosition[index]) == spell
					and NecrosisConfig.DemonSpellPosition[spell] > 0
					and self.Spell[ MenuID[spell] ].Name then
						-- Création à la demande du bouton du menu des démons
						if not _G["NecrosisPetMenuButton"] then
							_ = self:CreateSphereButtons("PetMenu")
						end
						menuVariable = self:CreateMenuPet(spell)
						menuVariable:ClearAllPoints()
						menuVariable:SetPoint(
							"CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER",
							NecrosisConfig.PetMenuPos.direction * NecrosisConfig.PetMenuPos.x * 32,
							NecrosisConfig.PetMenuPos.y * 32
						)
						PetButtonPosition = spell
						Local.Menu.Pet:insert(menuVariable)
						break
				end
			end
		end
		del(MenuID)

		-- display the pets menu button || Maintenant que tous les boutons de pet sont placés les uns à côté des autres, on affiche les disponibles
		if Local.Menu.Pet[1] then
			Local.Menu.Pet[1]:ClearAllPoints()
			Local.Menu.Pet[1]:SetPoint(
				"CENTER", "NecrosisPetMenuButton", "CENTER",
				NecrosisConfig.PetMenuPos.direction * NecrosisConfig.PetMenuPos.x * 32 + NecrosisConfig.PetMenuDecalage.x,
				NecrosisConfig.PetMenuPos.y * 32 + NecrosisConfig.PetMenuDecalage.y
			)
			-- secure the menu || Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
			for i = 1, #Local.Menu.Pet, 1 do
				Local.Menu.Pet[i]:SetParent(NecrosisPetMenuButton)
				-- Close the menu when a child button is clicked || Si le menu se ferme à l'appui d'un bouton, alors il se ferme à l'appui d'un bouton !
				NecrosisPetMenuButton:WrapScript(Local.Menu.Pet[i], "OnClick", [[
					if self:GetParent():GetAttribute("state") == "Ouvert" then
						self:GetParent():SetAttribute("state", "Ferme")
					end
				]])
				NecrosisPetMenuButton:WrapScript(Local.Menu.Pet[i], "OnEnter", [[
					self:GetParent():SetAttribute("mousehere", true)
				]])
				NecrosisPetMenuButton:WrapScript(Local.Menu.Pet[i], "OnLeave", [[
					self:GetParent():SetAttribute("mousehere", false)
					local stateMenu = self:GetParent():GetAttribute("state")
					if not (stateMenu == "Bloque" or stateMenu == "Combat" or stateMenu == "ClicDroit") then
						self:GetParent():SetAttribute("state", "Refresh")
					end
				]])
				if NecrosisConfig.BlockedMenu or not NecrosisConfig.ClosingMenu then
					NecrosisPetMenuButton:UnwrapScript(Local.Menu.Pet[i], "OnClick")
				end
			end
			self:MenuAttribute("NecrosisPetMenuButton")
			self:PetSpellAttribute()
		end
	end

	if NecrosisConfig.StonePosition[3] > 0 then
		-- setup the buttons available on the buffs menu || On ordonne et on affiche les boutons dans le menu des buffs
		local MenuID = new("array",
			31, 47, 32, 34, 37, 38, 43, 24, 9
		)
		for index = 1, #NecrosisConfig.BuffSpellPosition, 1 do
			-- display the button if the spell is known || Si le buff existe, on affiche le bouton dans le menu des buffs
			if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 1
				and NecrosisConfig.BuffSpellPosition[1] > 0
				and (self.Spell[31].Name or self.Spell[36].Name) then
					-- Create on demand || Création à la demande du bouton du menu des Buffs
					if not _G["NecrosisBuffMenuButton"] then
						_ = self:CreateSphereButtons("BuffMenu")
					end
					menuVariable = self:CreateMenuBuff(1)
					menuVariable:ClearAllPoints()
					menuVariable:SetPoint(
						"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
						NecrosisConfig.BuffMenuPos.direction * NecrosisConfig.BuffMenuPos.x * 32,
						NecrosisConfig.BuffMenuPos.y * 32
					)
					BuffButtonPosition = 1
					Local.Menu.Buff:insert(menuVariable)
			else
				for spell = 2, #NecrosisConfig.BuffSpellPosition, 1 do
					if math.abs(NecrosisConfig.BuffSpellPosition[index]) == spell
						and NecrosisConfig.BuffSpellPosition[spell] > 0
						and self.Spell[ MenuID[spell] ].Name then
							-- Create on demand || Création à la demande du bouton du menu des Buffs
							if not _G["NecrosisBuffMenuButton"] then
								_ = self:CreateSphereButtons("BuffMenu")
							end
							menuVariable = self:CreateMenuBuff(spell)
							menuVariable:ClearAllPoints()
							menuVariable:SetPoint(
								"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
								NecrosisConfig.BuffMenuPos.direction * NecrosisConfig.BuffMenuPos.x * 32,
								NecrosisConfig.BuffMenuPos.y * 32
							)
							BuffButtonPosition = spell
							Local.Menu.Buff:insert(menuVariable)
							break
					end
				end
			end
		end
		del(MenuID)

		-- display the buffs menu button on the sphere || Maintenant que tous les boutons de buff sont placés les uns à côté des autres, on affiche les disponibles
		if Local.Menu.Buff[1] then
			Local.Menu.Buff[1]:ClearAllPoints()
			Local.Menu.Buff[1]:SetPoint(
				"CENTER", "NecrosisBuffMenuButton", "CENTER",
				NecrosisConfig.BuffMenuPos.direction * NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.BuffMenuDecalage.x,
				NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.BuffMenuDecalage.y
			)
			-- secure the menu || Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
			for i = 1, #Local.Menu.Buff, 1 do
				Local.Menu.Buff[i]:SetParent(NecrosisBuffMenuButton)
				-- Close the menu upon button Click || Si le menu se ferme à l'appui d'un bouton, alors il se ferme à l'appui d'un bouton !
				NecrosisBuffMenuButton:WrapScript(Local.Menu.Buff[i], "OnClick", [[
					if self:GetParent():GetAttribute("state") == "Ouvert" then
						self:GetParent():SetAttribute("state", "Ferme")
					end
				]])
				NecrosisBuffMenuButton:WrapScript(Local.Menu.Buff[i], "OnEnter", [[
					self:GetParent():SetAttribute("mousehere", true)
				]])
				NecrosisBuffMenuButton:WrapScript(Local.Menu.Buff[i], "OnLeave", [[
					self:GetParent():SetAttribute("mousehere", false)
					local stateMenu = self:GetParent():GetAttribute("state")
					if not (stateMenu == "Bloque" or stateMenu == "Combat" or stateMenu == "ClicDroit") then
						self:GetParent():SetAttribute("state", "Refresh")
					end
				]])
				if NecrosisConfig.BlockedMenu or not NecrosisConfig.ClosingMenu then
					NecrosisBuffMenuButton:UnwrapScript(Local.Menu.Buff[i], "OnClick")
				end
			end
			self:MenuAttribute("NecrosisBuffMenuButton")
			self:BuffSpellAttribute()
		end
	end


	if NecrosisConfig.StonePosition[6] > 0 then
		-- setup the buttons to be displayed on the curse menu || On ordonne et on affiche les boutons dans le menu des malédictions
		-- MenuID contient l'emplacement des sorts en question dans la table des sorts de Necrosis.
		local MenuID = new("array",
			23, -- curse of weakness
			22, -- curse of agony
			25, -- curse of tongues
			40, -- curse of exhaustion
			26, -- curse of the elements
			16, -- curse of doom
			14 -- corruption
		)
		for index = 1, #NecrosisConfig.CurseSpellPosition, 1 do
			for sort = 1, #NecrosisConfig.CurseSpellPosition, 1 do
				-- Si la Malédiction existe, on affiche le bouton dans le menu des curses
				if math.abs(NecrosisConfig.CurseSpellPosition[index]) == sort
					and NecrosisConfig.CurseSpellPosition[sort] > 0
					and self.Spell[MenuID[sort]].Name then
						-- Création à la demande du bouton du menu des malédictions
						if not _G["NecrosisCurseMenuButton"] then
							_ = self:CreateSphereButtons("CurseMenu")
						end
						menuVariable = self:CreateMenuCurse(sort)
						menuVariable:ClearAllPoints()
						menuVariable:SetPoint(
							"CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER",
							NecrosisConfig.CurseMenuPos.direction * NecrosisConfig.CurseMenuPos.x * 32,
							NecrosisConfig.CurseMenuPos.y * 32
						)
						CurseButtonPosition = sort
						Local.Menu.Curse:insert(menuVariable)
						break
				end
			end
		end
		del(MenuID)

		-- display the curse menu button on the sphere || Maintenant que tous les boutons de curse sont placés les uns à côté des autres, on affiche les disponibles
		if Local.Menu.Curse[1] then
			Local.Menu.Curse[1]:ClearAllPoints()
			Local.Menu.Curse[1]:SetPoint(
				"CENTER", "NecrosisCurseMenuButton", "CENTER",
				NecrosisConfig.CurseMenuPos.direction * NecrosisConfig.CurseMenuPos.x * 32 + NecrosisConfig.CurseMenuDecalage.x,
				NecrosisConfig.CurseMenuPos.y * 32 + NecrosisConfig.CurseMenuDecalage.y
			)
			-- secure the menu || Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
			for i = 1, #Local.Menu.Curse, 1 do
				Local.Menu.Curse[i]:SetParent(NecrosisCurseMenuButton)
				-- respond to clicks || Si le menu se ferme à l'appui d'un bouton, alors il se ferme à l'appui d'un bouton !
				NecrosisCurseMenuButton:WrapScript(Local.Menu.Curse[i], "OnClick", [[
					if self:GetParent():GetAttribute("state") == "Ouvert" then
						self:GetParent():SetAttribute("state","Ferme")
					end
				]])
				NecrosisCurseMenuButton:WrapScript(Local.Menu.Curse[i], "OnEnter", [[
					self:GetParent():SetAttribute("mousehere", true)
				]])
				NecrosisCurseMenuButton:WrapScript(Local.Menu.Curse[i], "OnLeave", [[
					self:GetParent():SetAttribute("mousehere", false)
					local stateMenu = self:GetParent():GetAttribute("state")
					if not (stateMenu == "Bloque" or stateMenu == "Combat" or stateMenu == "ClicDroit") then
						self:GetParent():SetAttribute("state", "Refresh")
					end
				]])
				if NecrosisConfig.BlockedMenu or not NecrosisConfig.ClosingMenu then
					NecrosisCurseMenuButton:UnwrapScript(Local.Menu.Curse[i], "OnClick")
				end
			end
			self:MenuAttribute("NecrosisCurseMenuButton")
			self:CurseSpellAttribute()
		end
	end

	-- always keep menus Open (if enabled) || On bloque le menu en position ouverte si configuré
	if NecrosisConfig.BlockedMenu then
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
	end
end

-- Reset Necrosis to default position || Fonction pour ramener tout au centre de l'écran
function Necrosis:Recall()
	local ui = new("array",
		"NecrosisButton",
		"NecrosisSpellTimerButton",
		"NecrosisAntiFearButton",
		"NecrosisCreatureAlertButton",
		"NecrosisBacklashButton",
		"NecrosisShadowTranceButton"
	)
	local pos = new("array",
		{0, -100},
		{0, 100},
		{20, 0},
		{60, 0},
		{-60, 0},
		{-20, 0}
	)
	for i = 1, #ui, 1 do
		local f = _G[ui[i]]
		f:ClearAllPoints()
		f:SetPoint("CENTER", "UIParent", "CENTER", pos[i][1], pos[i][2])
		f:Show()
		self:OnDragStop(f)
	end
	del(ui)
	del(pos)
end

-- display the timers on the left or right || Fonction permettant le renversement des timers sur la gauche / la droite
function Necrosis:SymetrieTimer(bool)
	local num
	if bool then
		NecrosisConfig.SpellTimerPos = -1
		NecrosisConfig.SpellTimerJust = "RIGHT"
		num = 1
		while _G["NecrosisTimerFrame"..num.."OutText"] do
			_G["NecrosisTimerFrame"..num.."OutText"]:ClearAllPoints()
			_G["NecrosisTimerFrame"..num.."OutText"]:SetPoint(
				"RIGHT",
				_G["NecrosisTimerFrame"..num],
				"LEFT",
				-5, 1
			)
			_G["NecrosisTimerFrame"..num.."OutText"]:SetJustifyH("RIGHT")
			num = num + 1
		end
	else
		NecrosisConfig.SpellTimerPos = 1
		NecrosisConfig.SpellTimerJust = "LEFT"
		num = 1
		while _G["NecrosisTimerFrame"..num.."OutText"] do
			_G["NecrosisTimerFrame"..num.."OutText"]:ClearAllPoints()
			_G["NecrosisTimerFrame"..num.."OutText"]:SetPoint(
				"LEFT",
				_G["NecrosisTimerFrame"..num],
				"RIGHT",
				5, 1
			)
			_G["NecrosisTimerFrame"..num.."OutText"]:SetJustifyH("LEFT")
			num = num + 1
		end
	end
	if _G["NecrosisTimerFrame0"] then
		NecrosisTimerFrame0:ClearAllPoints()
		NecrosisTimerFrame0:SetPoint(
			NecrosisConfig.SpellTimerJust,
			NecrosisSpellTimerButton,
			"CENTER",
			NecrosisConfig.SpellTimerPos * 20, 0
		)
	end
	if _G["NecrosisListSpells"] then
		NecrosisListSpells:ClearAllPoints()
		NecrosisListSpells:SetJustifyH(NecrosisConfig.SpellTimerJust)
		NecrosisListSpells:SetPoint(
			"TOP"..NecrosisConfig.SpellTimerJust,
			NecrosisSpellTimerButton,
			"CENTER",
			NecrosisConfig.SpellTimerPos * 23, 10
		)
	end
end

function NecrosisTimer(nom, duree)
	local Cible = UnitName("target")
	local Niveau = UnitLevel("target")
	local truc = 6
	if not Cible then
		Cible = ""
		truc = 2
	end
	if not Niveau then
		Niveau = ""
	end

	Local.TimerManagement = NecrosisTimerX(nom, duree, truc, Cible, Niveau, Local.TimerManagement)
end

function Necrosis:SetOfxy(menu)
	if menu == "Buff" and _G["NecrosisBuffMenuButton"] then
		Local.Menu.Buff[1]:ClearAllPoints()
		Local.Menu.Buff[1]:SetPoint(
			"CENTER", "NecrosisBuffMenuButton", "CENTER",
			NecrosisConfig.BuffMenuPos.direction * NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.BuffMenuDecalage.x,
			NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.BuffMenuDecalage.y
		)
	elseif menu == "Pet" and _G["NecrosisPetMenuButton"] then
		Local.Menu.Pet[1]:ClearAllPoints()
		Local.Menu.Pet[1]:SetPoint(
			"CENTER", "NecrosisPetMenuButton", "CENTER",
			NecrosisConfig.PetMenuPos.direction * NecrosisConfig.PetMenuPos.x * 32 + NecrosisConfig.PetMenuDecalage.x,
			NecrosisConfig.PetMenuPos.y * 32 + NecrosisConfig.PetMenuDecalage.y
		)
	elseif menu == "Curse" and _G["NecrosisCurseMenuButton"] then
		Local.Menu.Curse[1]:ClearAllPoints()
		Local.Menu.Curse[1]:SetPoint(
			"CENTER", "NecrosisCurseMenuButton", "CENTER",
			NecrosisConfig.CurseMenuPos.direction * NecrosisConfig.CurseMenuPos.x * 32 + NecrosisConfig.CurseMenuDecalage.x,
			NecrosisConfig.CurseMenuPos.y * 32 + NecrosisConfig.CurseMenuDecalage.y
		)
	end
end

-- This function fixes a problem with the Blizzard API "GetCompanionInfo", which will return a different name for some mounts in the game.
-- example: the bronze drake (spell 59569)
--      -> GetCompanionInfo will return this as "Bronze Drake Mount" (wrong)
--      -> GetSpellInfo will return this as "Bronze Drake" (correct)
function Necrosis:GetCompanionInfo(type, id)
	local creatureID, creatureName, creatureSpellID, icon, issummoned = GetCompanionInfo(type, id)

	if creatureSpellID then
		-- get the correct (localised) name
		creatureName = GetSpellInfo(creatureSpellID)
	end

	return creatureID, creatureName, creatureSpellID, icon, issummoned
end