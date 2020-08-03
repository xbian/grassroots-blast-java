$(document).ready(function () {
    var search_form_content = $('#search_form_2');
    $('#search_form').remove();
    $('#searchFormHolder').html(search_form_content);
    $('#search_form_popup').addClass("modal");
    $('#search_form_popup').addClass("fade");
    // $('#search_form_popup').modal({
    //     show: false
    // });

    if ($('#login_link') != null) {
        $('#loginout').html('Login');
        $('#loginout').attr('href', $('#login_link').attr('href'));
        $('#loginout').attr('data-toggle', 'tooltip');git
        $('#loginout').attr('data-placement', 'bottom');
        $('#loginout').attr('title', 'You are viewing ' + $('#user .zone_name').html() + ' zone');
    } else if ($('#login_link') != null) {

        $('#loginout').html('logout');
        $('#loginout').attr('href', $('#login_link').attr('href'));
        $('#loginout').attr('data-toggle', 'tooltip');
        $('#loginout').attr('data-placement', 'bottom');
        $('#loginout').attr('title', 'You are logged in as ' + $('#user .zone_name').html());
    }


});

function licenseCollapse() {
    $("#licenseDetail").collapse('toggle');
}

function searchModal() {
    $('#search_form_popup').modal('show');

    SetUpMetadataKeysAutoCompleteList();
    SetUpMetadataValuesAutoCompleteList();
}


function searchCollapse() {
    if ($('#searchFormHolder').css('display') == 'none') {
        $('#searchFormHolder').show();
        $('#searchFormHolder').css({
            "left": $('#searchLink').offset().left,
            "top": $('#searchLink').offset().top + 40,
            "z-index": "9999"
        });
        $('#mainNav').css({
            "padding-bottom": "60px"
        });
        $('#project-info').css({
            "margin-top": "140px"
        });
    } else {

        $('#searchFormHolder').hide();
        $('#mainNav').css({
            "padding-bottom": "25px"
        });
        $('#project-info').css({
            "margin-top": "120px"
        });
    }
    SetUpMetadataKeysAutoCompleteList();
    SetUpMetadataValuesAutoCompleteList();
}