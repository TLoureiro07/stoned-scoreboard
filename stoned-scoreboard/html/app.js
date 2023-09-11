QBScoreboard = {}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                QBScoreboard.Open(event.data);
                break;
            case "close":
                QBScoreboard.Close();
                break;
        }
    })
});

QBScoreboard.Open = function(data) {
    $(".scoreboard-block").fadeIn(150);
    $("#total-players").html("<p>"+data.players+"/"+data.maxPlayers+"</p>");

    if (event.data.currentParamedics == 0) {
        $("#INEM").html('<i class="fas fa-times"></i>');
    } else if (event.data.currentParamedics >= 1) {
        $("#INEM").html('<i class="fas fa-check"></i>');
        $("#INEM .paramedics-count").text(event.data.currentParamedics);
    }

    $.each(data.requiredCops, function(i, category){
        var beam = $(".scoreboard-info").find('[id="'+i+'"]');
        var status = $(beam).find(".info-beam-status");
        if (event.data.estado == "on") {
            if (category.busy) {

                $(status).html('<i class="fas fa-clock"></i>');
            } else if (data.currentCops >= category.minimum) {

                $(status).html('<i class="fas fa-check"></i>');
            } else {

                $(status).html('<i class="fas fa-times"></i>');
            };
        } else if (event.data.estado == "off") {
            $(status).html('<i class="fas fa-clock"></i>');
        }
    });

    $.each(data.requiredParamedics, function(i, category) {
        var beam = $(".scoreboard-info").find('[id="' + i + '"]');
        var status = $(beam).find(".info-beam-status");

        if (event.data.estado == "on") {
            var paramedicsOnline = 0;

            for (var player in data.players) {
                var xPlayer = ESX.GetPlayerData(data.players[player]);

                if (xPlayer.job.name == category.job) {
                    paramedicsOnline = paramedicsOnline + 1;
                }
            }

            if (category.busy) {
                $(status).html('<i class="fas fa-clock"></i>');
            } else if (paramedicsOnline >= category.minimum) {
                $(status).html('<i class="fas fa-check"></i>');
                $(beam).find(".paramedics-count").text(paramedicsOnline);
            } else {
                $(status).html('<i class="fas fa-times"></i>');
            }
        } else if (event.data.estado == "off") {
            $(status).html('<i class="fas fa-clock"></i>');
        }
    });
    


}

QBScoreboard.Close = function() {
    $(".scoreboard-block").fadeOut(150);
}