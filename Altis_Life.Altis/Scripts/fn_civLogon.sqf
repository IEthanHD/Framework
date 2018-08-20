/**
 * Copyright © 2018 IEthanHD, IEthanHD Development Studios.
 * Created For Axeme King
 * All Rights Reserved.
 */

if (Trinity_Is_timer) exitWith {hint"Request Denied. You must wait before changing your duty status";};
uiSleep = 1;
[] call AX_fnc_timer;
 
//--- Strip
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadGear player;
removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;

//--- Include My Bezzies Macros
#include "..\script_macros.hpp"

//-- Change Vars
Trinity_Is_Civ = true;
Trinity_Is_Cop = false;
Trinity_Is_Medic = false;

hint "Verified Request. Loading Civ... Please Be Patient...";

//--- Reinstate Hud
[] call life_fnc_hudUpdate;

//-- Set Vars
player setVariable ["rank",(FETCH_CONST(life_coplevel)),false];
player setVariable ["rank",(FETCH_CONST(life_mediclevel)),false];

//--- Apply Old Gear
player forceAddUniform Trinity_Civ_Current_Gear_Uniform;
_count = (count Trinity_Civ_Current_Gear_UniformItems) - 1; 
for "_x" from 0 to _count do { 
		_item = Trinity_Civ_Current_Gear_UniformItems select _x;
		player addItemToUniform _item;
};
player addVest Trinity_Civ_Current_Gear_Vest;
_count = (count Trinity_Civ_Current_Gear_VestItems) - 1; 
for "_x" from 0 to _count do { 
		_item = Trinity_Civ_Current_Gear_VestItems select _x;
		player addItemToVest _item;
};
player addBackpack Trinity_Civ_Current_Gear_Backpack;
_count = (count Trinity_Civ_Current_Gear_BackpackItems) - 1; 
for "_x" from 0 to _count do {
		_item = Trinity_Civ_Current_Gear_BackpackItems select _x;
		player addItemToBackpack _item;
};
player addHeadgear Trinity_Civ_Current_Gear_Headgear;
player addGoggles Trinity_Civ_Current_Gear_Goggles;
[] call life_fnc_playerSkins;
player addWeapon Trinity_Civ_Current_Gear_PWeapon;
player addWeapon Trinity_Civ_Current_Gear_SWeapon;
player addMagazine Trinity_Civ_Current_Gear_PWeaponMag;
player addMagazine Trinity_Civ_Current_Gear_SWeaponMag; {
player addPrimaryWeaponItem _x;
} forEach Trinity_Civ_Current_Gear_PWeaponItems;
{
	player addHandgunItem _x;
} forEach Trinity_Civ_Current_Gear_SWeaponItems;

//--- Skin Player
[] call life_fnc_playerSkins;

//--- Save Gear
[] call life_fnc_saveGear;

//--- Reinstate Hud
[] call life_fnc_hudUpdate;