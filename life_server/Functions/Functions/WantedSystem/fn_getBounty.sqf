/*
    Author: GetSomePanda / Panda
    SteamID: 76561198145366418
    File Name: fn_getBounty.sqf
    Information: Get bounty from db then send back the var to the client.
*/

//--- Define Variables
private["_pid","_player","_query","_queryResult"];

//--- Convert Variables
_pid = _this select 0;
_player = _this select 1;

_query = format["SELECT wantedBounty FROM wanted WHERE active='1' AND wantedID='%1'",_pid];
_queryResult = [_query,2] call DB_fnc_asyncCall;

//--- Define A Bool
if(count _queryResult isEqualTo 0) then {
	myBounty = 0;
} else {
	myBounty = _queryResult select 0;
};

//--- Set Variable
(owner _player) publicVariableClient "myBounty";
