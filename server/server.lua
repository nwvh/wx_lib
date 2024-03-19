function TCE(event,playerid,...)
    TriggerClientEvent(event,playerid,...)
end

exports('triggerClientEvent',function (event,playerid,...)
    TCE(event,playerid,...)
end)