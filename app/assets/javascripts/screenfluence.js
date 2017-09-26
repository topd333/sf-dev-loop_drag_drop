var SFMain = {
  closeBtn: { label: 'Close', action: function(dialogRef){ dialogRef.close(); } },
  remoteDialog: function(title, url, size){
    BootstrapDialog.show({
      title: title,
      type: BootstrapDialog.TYPE_DEFAULT,
      message: $('<div></div>').load(url)
    });
  },

  notify: function(message, type){
    $.notify(
      {
        message: message
      },
      {
        type: type,
        placement: {
          from: "bottom",
          align: "right"
        },
        offset: 20,
        spacing: 5,
        z_index: 1031,
        delay: 3500,
        timer: 1000,
        animate: {
          enter: 'animated fadeInDown',
          exit: 'animated fadeOutUp'
        }
      }
    );
  },

  //-- Called whenever some new objects need to load
  initCallback:function(){
    $(function(){

      $(".sf-datepicker").datepicker({
        autoclose: true,
        todayHighlight: true
      });

      $('.sf-timepicker').timepicker({
        minuteStep: 1,
        template: 'modal',
        appendWidgetTo: 'body',
        disableFocus: true,
        showSeconds: true,
        showMeridian: false,
      });

      //-- Checkbox function setup in applicaton.js
      icheck();

    });

  }

}
