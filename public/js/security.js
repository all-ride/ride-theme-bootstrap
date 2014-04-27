$(".role a").click(function() {
    $(this).next().toggle();

    return false;
});
$(".role textarea").hide();
