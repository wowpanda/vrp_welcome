Citizen.CreateThread(function ()
local ped = GetPlayerPed(-1)
local coords = GetEntityCoords(ped)
    while true do
        Citizen.Wait(5000)
		camera_tutorial(-537.54364013672,-258.42102050781,46.180515289307)
        TriggerServerEvent('faby:server_welcome')
        Citizen.Wait(15000)
        camera_stop()
        help_text_notify("Ummm, ce frumos este orasul asta!")
        SetEntityCoords(ped,coords.x,coords.y,coords.z,false,false,false,true)
        break
    end
end)

RegisterNetEvent('faby:welcome')
AddEventHandler('faby:welcome', function(id,name)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
            function Initialize(scaleform)
                local scaleform = RequestScaleformMovie(scaleform)
                while not HasScaleformMovieLoaded(scaleform) do
                    Citizen.Wait(0)
                end
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieFunctionParameterString("~w~[~g~ "..id.." ~w~] ~g~"..name.." <FONT COLOR='#757575'>| ~b~Bine ai venit!")
                PushScaleformMovieFunctionParameterString("~w~Speram sa te distrezi de minune alaturi de noi!")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
                Citizen.SetTimeout(15500, function()
                    PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
                    PushScaleformMovieFunctionParameterInt(1)
                    PushScaleformMovieFunctionParameterFloat(0.33)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
                end)
                return scaleform
            end

            scaleform = Initialize("mp_big_message_freemode")

            while true do
                Citizen.Wait(0)
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
    end)
end)

function camera_tutorial(x, y,z)
    local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetCamCoord(cam, x, y, z) --- Set the camera there
    RenderScriptCams(1, 0, 0, 1, 1) --- Render Cams
end

function camera_stop()
    local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    SetEntityCoordsNoOffset(playerPed,-544.34588623047,-207.53785705566,37.664409637451, false, false, false, true) --- Teleport Player Back to start
    FreezeEntityPosition(playerPed, false) --- Freeze The Player There
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
end

function help_text_notify(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end