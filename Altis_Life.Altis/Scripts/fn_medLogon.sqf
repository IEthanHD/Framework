/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Axeme King
 * All Rights Reserved.
 */

if (Trinity_Is_timer) exitWith {hint"Request Denied. You must wait before....";};
[] call AX_fnc_timer;


//--- Include My Bezzies Macros
#include "..\script_macros.hpp"

//--- Privatise Variables
private ["_handle","_skinName"];

//--- Check If Blacklisted
if (life_blacklisted) exitWith {
    ["Blacklisted",false,true] call BIS_fnc_endMission;
    sleep 30;
};

//--- Check Whitelisting
if ((FETCH_CONST(life_coplevel) isEqualTo 0) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
    ["NotWhitelisted",false,true] call BIS_fnc_endMission;
    sleep 35;
};

//-- Change Vars
Trinity_Is_Civ = false;
Trinity_Is_Cop = false;
Trinity_Is_Medic = true;

//--- Hint
hint "Verified Request. Loading Cop... Please Be Patient...";

//--- Reinstate Hud
[] call life_fnc_hudUpdate;

//-- Set Vars
player setVariable ["rank",(FETCH_CONST(life_coplevel)),false];
player setVariable ["rank",(FETCH_CONST(life_mediclevel)),true];

//--- Save Current Gear
Trinity_Civ_Current_Gear_UniformItems = uniformItems player;
Trinity_Civ_Current_Gear_VestItems = vestItems player;
Trinity_Civ_Current_Gear_BackpackItems = backpackItems player;
Trinity_Civ_Current_Gear_PWeapon = primaryWeapon player;
Trinity_Civ_Current_Gear_SWeapon = handgunWeapon player;
Trinity_Civ_Current_Gear_PWeaponMag = (getarray (configFile >> "CFGWeapons" >> Trinity_Civ_Current_Gear_PWeapon >> "magazines") select 0);
Trinity_Civ_Current_Gear_SWeaponMag = (getarray (configFile >> "CFGWeapons" >> Trinity_Civ_Current_Gear_SWeapon >> "magazines") select 0);
Trinity_Civ_Current_Gear_PWeaponItems = primaryWeaponItems player;
Trinity_Civ_Current_Gear_SWeaponItems = handgunItems player;
Trinity_Civ_Current_Gear_Uniform = uniform player;
Trinity_Civ_Current_Gear_Vest = vest player;
Trinity_Civ_Current_Gear_Backpack = backpack player;
Trinity_Civ_Current_Gear_Headgear = headgear player;
Trinity_Civ_Current_Gear_Goggles = goggles player;

//--- Strip
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadGear player;
removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;

//--- Add clothing shit
player forceAddUniform "U_Rangemaster";
player addGoggles "G_Tactical_Clear";
player addBackpack "B_Carryall_cbr";
player addItemToBackpack "ToolKit";
player addItemToBackpack "ToolKit";
player addItemToBackpack "FirstAidKit";
player addItemToBackpack "FirstAidKit";

//--- Add items
player linkItem "ItemMap";
player linkItem "ItemGPS";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "NVGoggles_OPFOR";
player addWeapon "Rangefinder";

//--- Virtual items
[ true, "water", 2 ] call life_fnc_handleInv;
[ true, "rabbit", 2 ] call life_fnc_handleInv;
[ true, "spikeStrip", 1 ] call life_fnc_handleInv;

//--- Skin Player
[] call life_fnc_playerSkins;

//--- Save Gear
[] call life_fnc_saveGear;

//--- Reinstate Hud
[] call life_fnc_hudUpdate;

//--- Make Backpack Invisible
[] spawn
{
	private["_bp","_load","_cfg"];
	while{true} do
	{
		waitUntil {backpack player != ""};
	﻿	_bp = backpack player;
		_cfg = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload");
		_load = round(_cfg / 8);
		life_maxWeight = life_maxWeight + _load;
		if(Trinity_Is_Cop) then {(unitBackpack player) setObjectTextureGlobal [1,""];};
		waitUntil {backpack player != _bp};
		if(backpack player == "") then 
		{
		﻿	life_maxWeight = life_maxWeight;
		};
	};
};

