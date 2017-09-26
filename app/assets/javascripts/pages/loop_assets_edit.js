
//--- Loops Edit Object
var SFLoopsEdit = {

  init: function(){

    var $runningTimeElem = $('#running-time');

    //--- Setup Item Overlay (these are here because of remote loading)
    $('.overlay').hide();
    $('.item').hover(function() {
        $(this).find('.overlay').fadeIn();
      }, function() {
        if (!$(this).find('.asset-checked').is(":checked")) {
          $(this).find('.overlay').fadeOut();
        }
      }
    );

    //-- Set current running time
    SFLoopsEdit.updateRunningTime();

    //--- Setup any newly created lightboxes
    $(".html5lightbox").html5lightbox();

    //-- Setup initial sortable etc.
    SFLoopsEdit.droppedCallback();
  },

  updateRunningTime: function(){
    $('#running-time').html(SFLoopsEdit.getRunningTimeTotal());
  },

  getRunningTimeTotal: function(){
    var sum = 0,
        ret = '';
    $('.asset-duration').each(function() {
      sum += Number($(this).val());
    });
    ret = sum.toHHMMSS();
    return ret;
  },

  //--- Set Scroll height for asset library
  setLibraryScrollHeight: function() {
    var elementOffset = $('#loop-asset-container').offset().top,
    windowHeight  = $(window).height(),
    setHeight = windowHeight - (elementOffset-2) - 120;

    $('#loop-asset-container').slimScroll({
      height: setHeight
    });
  },
  updateLibraryScrollHeight: function() {
    var elementOffset = $('#loop-asset-container').offset().top,
    windowHeight  = $(window).height(),
    setHeight = windowHeight - (elementOffset-2) - 120;

    // check if container has slimScroll, if yes remove it
    if( $('#loop-asset-container').parent('.slimScrollDiv').size() > 0) {
       $('#loop-asset-container').parent().replaceWith( $('#loop-asset-container') );
      // now (re)assign slimScroll
      $('#loop-asset-container').slimScroll({
        height: setHeight
      });
    }
  },

  //--- Process Dropped Item
  processDroppedItem: function(event, ui){
    var ma_id = $(ui.draggable[0]).data('id'),
    $assetList = $('#loop-asset-list');
    $assetList.children(".loop-asset-draggable")
    $assetList.spin();
    $.getJSON( "/library/"+ma_id+".json", function( data ) {


      // Template setup in edit file
      var template = $.templates("#loop-asset-item-template");
      var htmlOutput = template.render(data);
//      console.log(htmlOutput)
      if (event.target == $('#loop-asset-drop-area')[0]){
        $assetList.append(htmlOutput).hide().fadeIn(400);
      } else {
        $assetList.children(".loop-asset-draggable").after(htmlOutput);
      }

      SFLoopsEdit.droppedCallback();
      $assetList.children(".loop-asset-draggable").remove()
    });
    // $(ui).remove();
    // $container.isotope('remove', $('.item-'+ma_id)).isotope('layout');

  },

  //--- Main callback after dropped
  droppedCallback: function() {
    var $assetList = $('#loop-asset-list'),
        $runningTimeElem = $('#running-time');

    //-- Set sortable on elements
    $assetList.sortable({
      placeholder: "ui-sortable-placeholder",
      items: "div.loop-asset-item",
      axis: 'y',
      receive: SFLoopsEdit.sortableDrop
    });
    $assetList.disableSelection();

    //-- Prepare icon hover
    $assetList.find('span.sort-icon').hide();
    $('.loop-asset-item').hover(function() {
        $(this).find('span.sort-icon').show();
      }, function() {
        $(this).find('span.sort-icon').hide();
      }
    );

    //-- Stop spinner
    $assetList.spin(false);

    //-- Remove Item
    $('a.remove-item').on('click', function(){
      $(this).closest('.loop-asset-item').fadeOut(200, function() {
        $(this).remove();
        SFLoopsEdit.updateRunningTime();
      });
    });

    //-- Update running timw after drop
    SFLoopsEdit.updateRunningTime();

    //-- Update running time when duration changes
    $('.asset-duration').keyup(function(){
      var value = $(this).val();
      $(this).val(value.replace(/\D/g,''));
      SFLoopsEdit.updateRunningTime();
    });
    $('.asset-duration').change(function(){
      SFLoopsEdit.updateRunningTime();
    });
  },

  //-- Sortable drop
  //-- TODO not working yet.
  sortableDrop: function(event, ui) {
    $(ui).remove();
    var ma_id = $(ui.item[0]).data('id'),
        $assetList = $('#loop-asset-list');

    $assetList.spin();
    $.getJSON( "/library/"+ma_id+".json", function( data ) {

      // Template setup in edit file
      var template = $.templates("#loop-asset-item-template");
      var htmlOutput = template.render(data);

      // $assetList.append(htmlOutput).hide().fadeIn(400);

      SFLoopsEdit.droppedCallback();

    });
  },

  //-- Validate Save Loop form fields
  validateFields: function(){
    var response = {};
    response.message = "valid";
    response.valid = true;

    if(!$('.asset-duration').length){
      response.message = 'You must add at least one asset to the loop';
      response.valid = false;
    } else if ($('.asset-duration').length){
      $('.asset-duration').each(function(index, input){
        if($(input).val() == ''){
          response.message = 'Please enter a duration for all assets';
          response.valid = false;
          return false;
        } else if ($(input).val() < .1){
          response.message = 'Duration must be greater than zero';
          response.valid = false;
          return false;
        }
      });

    }
    return response;
  },

  //-- Collect Loop data
  gatherLoopData: function(){

    var loop_data = [],
        sendData = '';

    $('.loop-asset-item').not(".sortable-locked").each(function(index) {
      var duration = $(this).find('input[name="duration"]').val();
      var displayname = $.trim($(this).find('.loop-asset-name').text());
      loop_data[index] = {id: $(this).data("slide-id"), duration: duration, displayname: displayname}
      if ($(this).data("slide-id") == 'new') {

        // newSlide.data('hooks_json_string', JSON.stringify({"__SRC1__":original.data('media-id')}));
        // if (original.data('media-type').lastIndexOf('image',0) === 0) {
        //   newSlide.data('slide_template_id', 1);
        // } else if (original.data('media-type').lastIndexOf('video',0) === 0) {
        //   newSlide.data('slide_template_id', 2);
        // } else {
        //   newSlide.data('slide_template_id', null);
        // }
        if ($(this).data('media-type').lastIndexOf('image',0) === 0) {
          loop_data[index].slide_template_id = 1;
        } else if ($(this).data('media-type').lastIndexOf('video',0) === 0) {
          loop_data[index].slide_template_id = 2;
        } else {
          loop_data[index].slide_template_id = null;
        }
        loop_data[index].hooks_json_string = JSON.stringify({"__SRC1__": $(this).data('media-id')});
      }
    });
    sendData += JSON.stringify(loop_data);
    return sendData;

  }

}


/**
 * Loop Edit Page Ready
 */
$('.loop_assets.edit').ready(function(){

  SFLoopsEdit.init();

  //--- FILTER/SEARCH/SORT
  var qsRegex;
  var selectFilter;
  var $container = $('#loop-asset-container'),
      $runningTimeElem = $('#running-time'),
      $runningTime = '00:00';

  $container.isotope({
    itemSelector: '.item',
    layoutMode: 'cellsByRow',
    cellsByRow: {
      columnWidth: 150,
      rowHeight: 114
    },
    filter: function() {
      var $this = $(this);
      var searchResult = qsRegex ? $this.text().match( qsRegex ) : true;
      var selectResult = selectFilter ? $this.is( selectFilter ) : true;
      return searchResult && selectResult;
    },
    getSortData: {
      name: '.asset-name',
      nameDesc: '.asset-name',
      size: '.asset-size parseFloat',
      sizeDesc: '.asset-size parseFloat',
      duration: '[data-duration] parseInt',
      durationDesc: '[data-duration] parseInt',
      uploaded: '[data-uploaded] parseInt',
      uploadedDesc: '[data-uploaded] parseInt'
    }
  });

  $('.filter-options').on('click', function () {
    selectFilter = $(this).data('filter');
    $container.isotope();
  });

  $('#searchclear').on('click', function(){
    qsRegex = new RegExp( $quicksearch.val(''), 'gi' );
    $container.isotope();
  });

  var $quicksearch = $('#quicksearch').keyup( debounce( function() {
    qsRegex = new RegExp( $quicksearch.val(), 'gi' );
    $container.isotope();
  }));

  // Main sort options
  $('.sort-options').on('click', function () {
    var option = $(this).data('sort');

    SFLibrary.toggleSortDirection($(this));

    $container.isotope({
      sortBy : option,
      sortAscending: {
        nameDesc: false,
        sizeDesc: false,
        durationDesc: false,
        uploaded: false // Reverse uploaded for timestamp
      }
    });
  });

  // Main Callback when everything is complete
  $container.isotope( 'on', 'layoutComplete', function(){
    SFLoopsEdit.updateLibraryScrollHeight();
  });
  SFLoopsEdit.setLibraryScrollHeight();
  $(window).bind("load page:load resize", function() {
    SFLoopsEdit.updateLibraryScrollHeight();
  });

  //--- Setup Draggle elements
  $( ".loop-asset-draggable" ).draggable({
    connectToSortable: "#loop-asset-list",
    appendTo: "body",
    revert: 'invalid',
    helper: 'clone',
    start: function(){ //hide original when showing clone
        $(this).hide();
    },
    stop: function(){ //show original when hiding clone
        $(this).show();
    }
  });

  //--- Droppable
  $("#loop-asset-drop-area").droppable({
    accept: ".loop-asset-draggable",
    drop: SFLoopsEdit.processDroppedItem
  });

  $("#loop-asset-list").droppable({
    accept: ".loop-asset-draggable",
    drop: SFLoopsEdit.processDroppedItem
  });

  //-- Save Loop Form
  $('#loop-save-btn').on('click', function(e){
    e.preventDefault();
    var response = SFLoopsEdit.validateFields();

    if(!response.valid){
      SFMain.notify(response.message, 'danger');
      return false;
    }

    var loopData = SFLoopsEdit.gatherLoopData();
    $('#loop_asset_loop_json_string').val(loopData);
    $('form#loop-update').submit();

  });

  //-- Update running time when duration changes
  $('.asset-duration').keyup(function(){
    var value = $(this).val();
    //$(this).val(value.replace(/\D/g,''));
    SFLoopsEdit.updateRunningTime();
  });
  $('.asset-duration').change(function(){
    SFLoopsEdit.updateRunningTime();
  });

});
