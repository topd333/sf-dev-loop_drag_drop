
//-- Main Exception object
var SFExceptions = {

  data: {},

  init: function(){
    SFExceptions.eventListeners();
  },

  //-- Setup listeners
  eventListeners: function(e){
    $('#exception-form').on('submit', function(e){
      e.preventDefault();
      return SFExceptions.validateForm();
    });

    // Remove exception item
    $('.remove-item').on('click', function(){
      $(this).closest('li').remove();
      if($('ul.exception-list li:visible').length < 1) {
        $('.no-exceptions').show();
      }
    });

  },

  //-- Validate exception modal form
  validateForm: function() {
    // var startDate = moment($('input[name=startDate]').val()).unix();
    // var endDate   = moment($('input[name=endDate]').val()).unix();

    //-- Ensure at least one day is selected
    if ($('.days-of-week').children('.btn-dow.active').length < 1){
      $('.error-messages').html('<p class="text-danger"> Select at least one day of the week.</p>');
      return false;
    } else if (false) {
      // TODO Add Start/End Date validations
    } else if (false) {
      // TODO Add Start/End Time validations
    }
    SFExceptions.processNewException();
  },

  //-- Main New Exception processing
  processNewException: function(){
    $('.exception-form-wrapper').spin();
    SFExceptions.setExceptionData();

    var template   = $.templates("#campaign-exception-template");
    var htmlOutput = template.render(SFExceptions.data);

    // console.log(SFExceptions.data); return false;

    $('.modal').modal('hide');
    if($('.no-exceptions').is(":visible")){
      $('.no-exceptions').hide();
    }
    $('.exception-list').append(htmlOutput).hide().fadeIn(400);
    SFExceptions.eventListeners();
  },

  //-- Generate necessary Exception data
  setExceptionData: function(){
    SFExceptions.data = {
      "exLoopId": $('#campaign-ex-loop').val(),
      "exLoopName": $('#campaign-ex-loop option:selected').text(),
      "exAlways": $('#exception-always').is(':checked'),
      "daysArray": SFExceptions.setDaysArray(),
      "daysString": SFExceptions.setDaysString(),
      "startDate": $('#startDate').val(),
      "endDate": $('#endDate').val(),
      "startTime": $('#startTime').val(),
      "endTime": $('#endTime').val()
    }
  },

  //-- Gather data about the selected days
  setDaysArray: function(){
    var activeBtns = $('.days-of-week').children('.btn-dow.active');
    var daysArray = activeBtns.map(function() {
      return $(this).data('day');
    }).get();
    return daysArray;
  },

  //-- Set selected days as string
  setDaysString: function() {
    var activeBtns = $('.days-of-week').children('.btn-dow.active');
    var daysString = activeBtns.map(function() {
      return $(this).data('day').toUpperCase();
    }).get().join(" ");
    return daysString;
  }

};
