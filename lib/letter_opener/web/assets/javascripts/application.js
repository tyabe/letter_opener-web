jQuery(function($) {
  $('.message_list').on('click', '.message', function(e) {
    var self = $(this);
    var link = self.find('a').attr('href');
    $('iframe').attr('src', link);
    self.parent().find('.active').removeClass('active');
    self.addClass('active');
  });
  $('#toggle_selection').on('click', function(e) {
    var self = $(this);
    var messages = $('input:checkbox', '.message_list');
    if(self.prop('checked')) {
      messages.prop({'checked':'checked'});
    } else {
      messages.prop({'checked':false});
    }
  });
  $('#delete').on('submit', function(e) {
    var ids = $('.message input[type="checkbox"]:checked').map(function(){ return $(this).val(); }).toArray().join(',');
    if (ids.length <= 0) { return false; }
    var self = $(this), message = self.data('confirm');
    if (message && !confirm(message)) { return false; }
    self.find('button[type=submit]').attr("disabled", "disabled");
    self.find(':hidden[name=message_ids]').val(ids);
  });
  $('#refresh').on('click', function(e) {
    var self = $(this);
    var icon = self.find( ".glyphicon" );
    icon.addClass( "glyphicon-animate" );
  });
});
