/* MAIN LIBRARY OBJECT */

var SFLibrary = {

  currentSort: "",

  init: function(){

    //--- Editable
    $('.asset-name-edit').ready(function(){
      $('.asset-name-edit').editable({
        clear: false,
        ajaxOptions: {
          type: 'put',
          dataType: 'json'
        },
        showbuttons: false,
        mode: "inline",
        inputclass: "asset-edit-name",
        url: '/update_title',
        success: function(response, newValue) {
          if(!response.success) return response.msg;
        }
      });
    });

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

    //--- Setup item edit name hover (these are here because of remote loading)
    $('.asset-name').hover(function() {
        $(this).find('.asset-name-edit-icon').show();
      }, function() {
        $(this).find('.asset-name-edit-icon').hide();
      }
    );

    //--- Setup any newly created lightboxes
    $(".html5lightbox").html5lightbox();

  },
  confirm_delete: function(asset_id){
    $('.show-preview-link.' + asset_id).hide();
    $('#delete-asset-link-' + asset_id).hide();
    $('#delete-container-' + asset_id).removeClass('hidden');
  },
  confirm_cancel: function(asset_id){
    $('.show-preview-link.' + asset_id).show();
    $('#delete-asset-link-' + asset_id).show();
    $('#delete-container-' + asset_id).addClass('hidden');
  },

  // Alter the direction of sorting
  toggleSortDirection: function(elem) {
    var option    = elem.data('sort'),
        direction = elem.data('dir');

    if (direction == 'asc') {
      elem.data('sort', option+"Desc");
      elem.data('dir', 'desc');
    } else {
      elem.data('sort', option.replace('Desc', ''));
      elem.data('dir', 'asc');
    }
  }
}

$('.media_assets.index').ready(function(){

  SFLibrary.init();

  //--- FILTER/SEARCH/SORT
  var qsRegex;
  var selectFilter;
  var $container = $('#asset-container');

  $container.isotope({
    itemSelector: '.item',
    layoutMode: 'cellsByRow',
    cellsByRow: {
      columnWidth: 240,
      rowHeight: 182
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
      size: '.asset-size',
      sizeDesc: '.asset-size',
      duration: '[data-duration]',
      durationDesc: '[data-duration]',
      uploaded: '[data-uploaded]',
      uploadedDesc: '[data-uploaded]'
    }
  });

  $('.filter-options').on('click', function () {
    selectFilter = $(this).data('filter');
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
    // $("img").unveil();
  });

  $('#searchclear').on('click', function(){
    qsRegex = new RegExp( $quicksearch.val(''), 'gi' );
    $container.isotope();
  });

  //--- UPLOADS
  $('.btn-upload-assets, .close-small-uploader').on('click', function(){
    $('.asset-upload-area').slideToggle();
  });

  //--- Dropzone
  Dropzone.options.libraryDropzone = {
    acceptedFiles: "image/jpeg, image/jpg, image/gif, image/png, video/mp4, video/ogg, video/webm, video/x-matroska",
    paramName: "asset_file",
    maxFilesize: 500, //MB
    accept: function(file, done) {
      if (file.name == "justinbieber.jpg") {
        done("Naha, you don't.");
      } else {
        done();
      }
    },
    init: function() {
      this.on("addedfile", function(file) {});
      this.on("success", function(file) {
        var $newItems = $(file.xhr.responseText);
        $('#asset-container').prepend( $newItems).isotope( 'reloadItems' ).isotope({ sortBy: 'original-order' });
        this.removeFile(file);
        // Call init to run methods on new items
        SFLibrary.init();
      });
      this.on("queuecomplete", function (file) {
        if($('.dz-error').length === 0 ){
          $('.asset-upload-area').slideToggle();
          this.removeAllFiles();
        }
      });
    }
  };

  //--- Confirm delete asset, disable button
  $('.confirm-delete').on('click', function(){
    $(this).attr('disabled', 'disabled');
  });

  //--- Click edit name icon
  $('.asset-name-edit-icon').on('click', function(e) {
    e.stopPropagation();
    $(this).prev('h2').find('.asset-name-edit').editable('toggle');
    // $('.asset-name-edit').editable('toggle');
  });


  ///////////////////////////////////////////////////////////////////////
  // Original Javascripts
  ///////////////////////////////////////////////////////////////////////

  var active_types = {
    'image': 0,
    'video': 0
  };

  var $asset_divs = $('.assets-wrapper>div');

  var mimeToRegular = function(mime_string){
      return mime_string.substr(0, mime_string.indexOf('/'))
  }

  var allInactive = function(){
    return Object.keys(active_types).every(function(key){
      if(active_types[key] == 1)
        return false;
      else
        return true;
    });
  }

  var showActiveTypes = function(caller_this, media_type){
    var active = $(caller_this).toggleClass('active').hasClass('active');
    active_types[media_type] = active ? 1 : 0;
    var areAllInactiveActive = allInactive();

    $.each($asset_divs, function(index, value){
      var $v = $(value);
      if(areAllInactiveActive)
        $v.show();
      else{
        if(active_types[mimeToRegular($v.data('media-type'))] == 1){
          $v.show();
        }else{
          $v.hide();
        }
      }
    });
  };

  $('#filter-images').click(function(){
    showActiveTypes(this, 'image');
  });

  $('#filter-videos').click(function(){
    showActiveTypes(this, 'video');
  })

  $('.assets-wrapper').selectable({
    cancel: "a"
  });

  $('[data-ajax-handle="delete-assets"]').bind('ajax:beforeSend', function(e, xhr, settings) {
    $("#ajax-results").empty();
    var media_assets = [];
    $('.asset-wrapper.ui-selected').each(function(index) {
      media_assets.push($(this).data('media-id'));
    });
    settings.data += "&" + $.param({"media_assets":media_assets});
  });
});

