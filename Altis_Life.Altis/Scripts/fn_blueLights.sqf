private ["_vehicle","_lightRed","_lightBlue","_lightleft","_lightright","_leftRed"];
_vehicle = _this select 0;

if(isNil "_vehicle" OR isNull _vehicle OR !(_vehicle getVariable "lights")) exitWith {};
_lightRed = [20, 0.1, 0.1];
_lightBlue = [0.1, 0.1, 20];

_lightleft = "#lightpoint" createVehicleLocal (getpos _vehicle);

sleep 0.2;
_lightleft setLightColor _lightBlue;
_lightleft setLightBrightness 0.2;
_lightleft setLightAmbient [0.1,0.1,20];
_lightright = "#lightpoint" createVehicleLocal (getpos _vehicle);
sleep 0.2;
_lightright setLightColor _lightBlue;
_lightright setLightBrightness 0.2;
_lightright setLightAmbient [0.1,0.1,20];


switch (typeOf _vehicle) do {
  case "B_G_Offroad_01_F";
  case "B_G_Offroad_01_armed_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.25, 2.45, -0.45]];
	_lightRight lightAttachObject [_vehicle, [0.25, 2.45, -0.45]];
  };

  case "C_Offroad_01_repair_F";
  case "C_Offroad_01_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];
	_lightRight lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];
  };

  case "C_Van_01_fuel_F";
  case "C_Van_01_box_F";
  case "C_Van_01_transport_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.6, 0, 0.77]];
	_lightRight lightAttachObject [_vehicle, [0.6, 0, 0.77]];
  };

  case "I_Truck_02_box_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.6, 1.3, 0.55]];
	_lightRight lightAttachObject [_vehicle, [0.6, 1.3, 0.55]];
  };

  case "B_MRAP_01_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.50, 1.5, -0.68]];
	_lightRight lightAttachObject [_vehicle, [0.50, 1.5, -0.68]];
  };

  case "C_SUV_01_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.37,-1.2,0.42]];
	_lightRight lightAttachObject [_vehicle, [0.37,-1.2,0.42]];
  };

  case "C_Hatchback_01_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.6, 2.0, -0.95]];
	_lightRight lightAttachObject [_vehicle, [0.6, 2.0, -0.95]];
  };

  case "C_Hatchback_01_sport_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.6, 2.0, -0.95]];
	_lightRight lightAttachObject [_vehicle, [0.6, 2, -0.95]];
  };

  case "I_MRAP_03_F": {
	_lightLeft lightAttachObject [_vehicle, [-0.9, 2.1, -0.8]];
	_lightRight lightAttachObject [_vehicle, [0.9, 2.1, -0.8]];
  };
};

_lightleft  setLightAttenuation [0.1, 0, 1000, 130];
_lightleft  setLightIntensity 8;
_lightleft  setLightFlareSize 0.38;
_lightleft  setLightFlareMaxDistance 120;
_lightleft  setLightUseFlare true;
_lightright setLightAttenuation [0.1, 0, 1000, 130];
_lightright setLightIntensity 8;
_lightright setLightFlareSize 0.38;
_lightright setLightFlareMaxDistance 120;
_lightright setLightUseFlare true;

//--- Set the lights for day
_lightleft setLightDayLight true;
_lightright setLightDayLight true;

_leftRed = true;
while{ (alive _vehicle)} do
{
	if(!(_vehicle getVariable "lights")) exitWith {};
	if(_leftRed) then
	{
		_leftRed = false;
		_lightright setLightBrightness 0.0;
		sleep 0.05;
		_lightleft setLightBrightness 6;
	}
		else
	{
		_leftRed = true;
		_lightleft setLightBrightness 0.0;
		sleep 0.05;
		_lightright setLightBrightness 6;
	};
	sleep (_this select 1);
};
deleteVehicle _lightleft;
deleteVehicle _lightright;
