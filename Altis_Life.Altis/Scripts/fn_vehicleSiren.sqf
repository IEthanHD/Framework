
//--- Get Parameters
params [

    [ "_vehicle", objNull, [ objNull ] ]

];

//--- Check
if ( isNull _vehicle ) exitWith {};
if ( isNil { _vehicle getVariable "siren" } ) exitWith {};

if (Trinity_Is_Civ) exitwith {};

//--- Loop
for "_i" from 0 to 1 step 0 do {

    if ( !( _vehicle getVariable "siren" ) ) exitWith {};

    //--- Make sure there is someone inside the vehicle
    if ( count crew _vehicle isEqualTo 0 ) then {

        _vehicle setVariable [ "siren", false, true ]

    };

    //--- Check
    if !( alive _vehicle ) exitWith {};
    if ( isNull _vehicle ) exitWith {};

    //--- Play Siren
    _vehicle say3D "sirenLong";

    //--- Length of siren
    sleep 5;

    if ( !( _vehicle getVariable "siren" ) ) exitWith {};

};
