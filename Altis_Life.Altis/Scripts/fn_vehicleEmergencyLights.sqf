if (Trinity_Is_Civ) exitwith {};

//--- Get Params
params [

    [ "_vehicle", objNull, [ objNull ] ]

];

//--- Object Null Check
if ( isNull _vehicle ) exitWith {};

//--- Vehicle does not have emergency lights
if ( !( vehicle player isKindOf "Car" ) && { !( vehicle player isKindOf "Tank" ) } ) exitWith {};

//--- Lights are on
if ( _vehicle getVariable [ "lights", false ] ) then {

    //--- Set Lights to false
    _vehicle setVariable [ "lights", false, true ];

} else {

    //--- Set Lights Variable to True
    _vehicle setVariable [ "lights", true, true ];

    //--- For Blufor
    if ( Trinity_Is_Cop ) then {

        //--- Attach Lights to Vehicle
        [ _vehicle, 0.22 ] remoteExec [ "AX_fnc_blueLights", 0 ];

    //--- For Independent
    } else {

		[ _vehicle, 0.22 ] remoteExec [ "AX_fnc_orangeLights", 0 ];

    };
};
