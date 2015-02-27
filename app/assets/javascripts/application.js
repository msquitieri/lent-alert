// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(document).ready(function() {
  $('.time-selector').timepicker();

  $('#user_alert_type').on('change', function() {
    var val = $(this).val();
    var $contact = $('#contact');
    var $prompt = $('#prompt');
    var promptText = 'Send me a';

    if (val == 'Email') {
      promptText += 'n';
      $contact.attr({ placeholder: 'Email Address' });
    } else {
      $contact.attr({ placeholder: 'Phone Number' });
    }

    $prompt.html(promptText);
  });

  function getContactType(value) {
    return value == 'Email' ? 'email' : 'text message';
  }

  $('.sign-up-button').on('click', function() {
    var timeZone = $('#time-zone-picker').val();
    var contact = $('#contact').val();
    var selectedTime = $('#selected-time').val();
    var contactType = getContactType($('#user_alert_type').val());

    $.ajax({
      url: '/api/v1/users/',
      type: 'POST',
      data: {
        contact_info: contact,
        time_zone: timeZone,
        selected_time: selectedTime,
        contact_type: contactType
      }
    }).then(function(data) {
      sweetAlert("Success!", "You will now receive an alert at " + contact + " every Friday at " + selectedTime + " during Lent.", "success");
    }, function(xhr) {
      if (xhr.status == 500) {
        sweetAlert("Uh oh.", "Please check you've input everything and try again.", "error");
      } else if (xhr.status == 422) {
        sweetAlert("Uh oh.", 'It seems like your ' + xhr.responseJSON.error.message, "error");
      }
    });
  });

  $('.stop-alerts-button').on('click', function() {
    var contactType = getContactType($('#user_alert_type').val());
    var contactInfo = $('#contact').val();

    sweetAlert({
      title: 'Are you sure?',
      text: 'We will miss you!',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, stop the alerts.",
      closeOnConfirm: false
    }, function() {
      $.ajax({
        url: '/api/v1/users/delete',
        type: 'DELETE',
        data: {
          contact_info: contactInfo,
          contact_type: contactType
        }
      }).then(function() {
        swal("Success!", "You will no longer receive alerts from lentalert.com.", "success");
      }, function(xhr) {
        if (xhr.status == 404) {
          swal("Oops", "It looks like that user doesn't exist.");
        }
      });
    });
  });
});