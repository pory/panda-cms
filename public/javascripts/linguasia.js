$(function() {

  $('#main-menu .item').mouseenter(function(){
    $(this).find('.image-wrapper').css("overflow", "hidden")
                                  .css("height", "150px");
    $(this).find('.submenu').css("display", "block");
  }).mouseleave(function(){
    $(this).find('.image-wrapper').css("overflow", "visible")
                                  .css("height", "auto");
    $(this).find('.submenu').css("display", "none");
  });

});