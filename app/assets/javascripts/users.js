// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    function isDark( color ) {
        var match = /rgb\((\d+).*?(\d+).*?(\d+)\)/.exec(color);
        return ( match[1] & 255 )
            + ( match[2] & 255 )
            + ( match[3] & 255 )
            < 3 * 256 / 2;
    }

    $('.user-header').each(function() {console.log($(this).css("background-color"));
        $(this).css("color", isDark($(this).css("background-color")) ? 'white' : 'black');
    });
});