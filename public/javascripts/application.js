var update_status_for = function(element) {
  element.find("a").hide();
  if (element.data("accepted") == 1) {
    element.find(".cancel").show();
  } else {
    element.find(".accept").show();
  }
}

$(document).ready(function() {
  
  $('.dimmer').hide();
  $('.user_status').each(function() {
    update_status_for($(this));
  });
  $('.user_status a').click(function() {
    var timestamp = new Date() * 1;
    var status = $(this).parents('.user_status');
    if (status.data("accepted") == 1) {
      status.data("accepted", 0);
    } else {
      status.data("accepted", 1);
    }
    $.get($(this).attr("href") + "&timestamp=" + timestamp, function() {
      update_status_for(status);
    });
    return false;
  });

});