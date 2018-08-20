#include "..\..\script_macros.hpp"
/*
    File: fn_handleDamage.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Handles damage, specifically for handling the 'tazer' pistol and nothing else.
*/
//--- Define current damage in variable
private _currentDamage = damage player;

//--- Get parameters
params [

    [ "_unit", objNull, [ objNull ] ],
    [ "_part", "", [ "" ] ],
    [ "_damage", 0, [ 0 ] ],
    [ "_source", objNull, [ objNull ] ],
    [ "_projectile", "", [ "" ] ],
    [ "_index", 0, [ 0 ] ]

];

//--- Define vehicles that people should eject from when being tased
private _ejectFromVehicleArray = [ "B_Quadbike_01_F", "C_Kart_01_F", "C_Kart_01_Fuel_F", "C_Kart_01_Blu_F", "C_Kart_01_Red_F", "C_Kart_01_Vrana_F", "C_Kart_01_green_F", "C_Kart_01_orange_F", "C_Kart_01_white_F", "C_Kart_01_yellow_F", "C_Kart_01_black_F" ];

//--- Incapacitated
if ( _unit getVariable [ "incapacitated", false ] ) exitWith {};

//--- Taser
if (!isNull _source) then {

    //--- Source is not self
    if ( _source != _unit ) then {

        //--- Check for currentWeapon
        if ( currentWeapon _source in [ "hgun_P07_snds_F", "hgun_Pistol_heavy_01_snds_F", "hgun_Pistol_heavy_02_Yorris_F", "SMG_02_ACO_F" ] && _projectile in [ "B_45ACP_Ball", "B_9x21_Ball", "B_9x21_Ball" ] ) then {

            //--- Set Damage to the Player Current Damage
            _damage = _currentDamage;

            //--- Player is alive, is not tased, is not knocked out and is not restrained
            if ( alive player && { !life_istazed } && { !life_isknocked } && { !( _unit getVariable [ "restrained", false ] ) } ) then {

                //--- Set Distance
                private "_distance";
                _distance = 35;

                //--- Check if it's a Sting, if it is: distance == 100 metres
                if ( currentWeapon _source in [ "SMG_02_F" ] ) then { _distance = 100; };

                //--- Units distance from source is less than the max distance
                if ( _unit distance _source < _distance ) then {

                    //--- If object is appearing
                    if ( !( isNull objectParent player ) ) then {

                        //--- If in an open vehicle in _ejectFromVehicleArray
                        if ( typeOf ( vehicle player ) in _ejectFromVehicleArray ) then {

                            //--- Eject from Vehicle
                            player action [ "Eject", vehicle player ];

                            //--- Spawn the tase function
                            [ _unit, _source ] spawn life_fnc_tazed;
                        };
                    } else {

                        //--- Spawn the tase function
                        [ _unit, _source ] spawn life_fnc_tazed;
                    };

                };

            };

        };

    };

};

//--- Vehicle Hit
if ( vehicle _unit isEqualTo _unit ) then {

    if ( !( _source isKindOf "Air" || { _source isKindOf "Car" } || { _source isKindOf "Boat" } ) ) then {

        private _isVehicle = vehicle _source;

        //--- Air, Car, or Boat
        if ( _isVehicle isKindOf "Air" || { _isVehicle isKindOf "Car" } || { _isVehicle isKindOf "Boat" } ) then    {

            //--- Set damage to the current damage of player
            if ( _source isEqualTo driver _isVehicle ) then {

                //--- Set the previous damage of the player
                _damage = _currentDamage;

            };

        };

    };

};


[] spawn life_fnc_hudUpdate;
_damage;