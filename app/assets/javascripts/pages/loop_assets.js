/* MAIN LOOPS OBJECT */

var SFLoops = {

  init: function(){

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

    //--- Setup any newly created lightboxes
    $(".html5lightbox").html5lightbox();

  },
  confirm_delete: function(asset_id, event){
    alert('test');
    $('.show-preview-link.' + asset_id).hide();
    $('#delete-asset-link-' + asset_id).hide();
    $('#delete-container-' + asset_id).removeClass('hidden');
    return false;
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

//--- Loops Index Page Ready
$('.loop_assets.index').ready(function(){

  SFLoops.init();

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

  var $quicksearch = $('#quicksearch').keyup( debounce( function() {
    qsRegex = new RegExp( $quicksearch.val(), 'gi' );
    $container.isotope();
  }));

  // Main sort options
  $('.loops-sort-options').on('click', function () {
    var option = $(this).data('sort');

    SFLoops.toggleSortDirection($(this));

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
  $container.isotope( 'on', 'layoutComplete', function(){});

  $('#searchclear').on('click', function(){
    qsRegex = new RegExp( $quicksearch.val(''), 'gi' );
    $container.isotope();
  });

  //--- Dropzone
  Dropzone.options.libraryDropzone = {
    acceptedFiles: "image/*,video/mp4",
    paramName: "asset_file",
    maxFilesize: 500,
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
        SFLoops.init();
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

  $('.btn-create-loop').on('click', function(e){
    e.preventDefault();
    var button = {
      icon: 'glyphicon glyphicon-send',
      label: ' Create Loop',
      cssClass: 'btn-primary',
      autospin: true,
      action: function(dialogRef){
        dialogRef.enableButtons(false);
        dialogRef.setClosable(false);
        setTimeout(function(){
            dialogRef.close();
        }, 2000);
      }
    }
    SFMain.remoteDialog($(this).data('title'), $(this).attr('href'), button);
  });

  //-- Edit Loop by clicking item.
  $('.loop-asset-item').on('click', function(event){
    var target = $( event.target );
    // console.log(target);
    if( !target.hasClass('flaticon-delete84')
        && !target.hasClass('glyphicon-cog')
        && !target.hasClass('confirm-cancel')
        && !target.hasClass('confirm-delete')
      ) {
      window.location.href = $(this).data('url');
    }
  });

});



///////////////////////////////////////////////////////////////////////
// Original Javascripts
///////////////////////////////////////////////////////////////////////

// $('.loop_assets.index').ready(function(){
//   $('#basicModal').on('show.bs.modal', function(){});
//   $('#new-loop-button-link').click(function(){$("#basicModal").modal();});

//   $('.assets-wrapper').selectable({
//   	cancel: 'a'
//   });

//   $('[data-ajax-handle="delete-assets"]').bind('ajax:beforeSend', function(e, xhr, settings) {
// 	    $("#ajax-results").empty();
// 	    var loop_assets = [];
// 	    $('.asset-wrapper.ui-selected').each(function(index) {
// 	      loop_assets.push($(this).data('loop-id'));
// 	    });
// 	    settings.data += "&" + $.param({"loop_assets":loop_assets});
// 	});
// });

// $('.loop_assets.edit').ready(function(){
// 	window.enableSave = function() {
// 		$('[data-ajax-handle="save-loop"]').show();
// 	}
// 	window.disableSave = function() {
// 		$('[data-ajax-handle="save-loop"]').hide();
// 	}
// 	disableSave(); // Hide the save button until needed

// 	// Configure the loop edit list as sortable
// 	$('#loop-edit-list').sortable({
// 		items: "> div:not(.sortable-locked)",	// Dont include placeholder
// 		revert: true,
// 		axis: "y",
// 		placeholder: "slide-wrapper",
// 		over: function (event, ui) {
// 			$(this).find('.slide-wrapper.drag-new-clip-wrapper').appendTo(this);
// 		},
// 		receive: function (event, ui) {
// 			var original = $(this).find('.asset-wrapper');
// 			var newSlide = $('<div/>', {
// 				class: 'slide-wrapper row',
// 				'data-slide-id': 'new'
// 			});
// 			newSlide.append($('<div/>', {class: 'thumb col-sm-3'}).append(original.find(".thumb > img")));
// 			newSlide.append($('<div/>', {class: 'slide-title col-sm-5'}).text(original.find(".asset-thumbnail").text()));
// 			newSlide.append(
// 				$('<div/>', {class: 'slide-duration col-sm-3'}).append(
// 					$('<input>', {
// 						type: 'text',
// 						name: 'duration',
// 						maxlength: '5',
// 						value: original.data("media-duration") / 1000.00
// 					}).attr('size', 5), // Can't set size like the rest for some reason...
// 					"seconds"
// 				)
// 			);
// 			newSlide.append('<div class="col-sm-1"><a class="js-remove-slide" href="javascript:void(0);">x</a></div>');
// 			newSlide.data('hooks_json_string', JSON.stringify({"__SRC1__":original.data('media-id')}));
// 			if (original.data('media-type').lastIndexOf('image',0) === 0) {
// 				newSlide.data('slide_template_id', 1);
// 			} else if (original.data('media-type').lastIndexOf('video',0) === 0) {
// 				newSlide.data('slide_template_id', 2);
// 			} else {
// 				newSlide.data('slide_template_id', null);
// 			}
// 			original.replaceWith(newSlide);
// 		},
// 		stop: function(event, ui) {enableSave();}
// 	});

// 	$('#assets-wrapper').children().draggable({
// 		connectToSortable: "#loop-edit-list",
// 		helper: "clone",
// 		revert: "invalid"
// 	});

// 	$('#loop-edit-list').find("input[name='duration']").on('input', enableSave);

// 	// When the loop name is clicked, it changes to an editable text box
// 	$('#loop-name').click(function() {
// 		var name = $(this).text();
// 		$(this).replaceWith($('<input type="text" id="loop-name">').val(name));
// 		enableSave();
// 	});

// 	// When the save button is pressed, generate the required json string.
// 	$('[data-ajax-handle="save-loop"]').bind('ajax:beforeSend', function(e, xhr, settings) {
// 		// Get the new name (element may be a span OR input)
// 		var newname = $('#loop-name').text();
// 		if (newname == "") newname = $('#loop-name').val();
// 		settings.data += "&loop_asset[displayname]=" + $.trim(newname);

// 		// Loop thru the edit list and create the json string
// 		var loop_data = [];
// 		$('#loop-edit-list').children().not(".sortable-locked").each(function(index) {
// 			var duration = $(this).find('input[name="duration"]').val();
// 			var displayname = $.trim($(this).find('.slide-title').text());
// 			loop_data[index] = {id: $(this).data("slide-id"), duration: duration, displayname: displayname}
// 			if ($(this).data("slide-id") == 'new') {
// 				loop_data[index].slide_template_id = $(this).data("slide_template_id");
// 				loop_data[index].hooks_json_string = $(this).data("hooks_json_string");
// 			}
// 		});
// 		settings.data += "&loop_asset[loop_json_string]=" + JSON.stringify(loop_data);
// 	});

// 	// When the remove button is clicked on an slide, remove it
// 	$('.js-remove-slide').click(function() {
// 		$(this).parent().parent().remove();
// 		enableSave();
// 	})
// });