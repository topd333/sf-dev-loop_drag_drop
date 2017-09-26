var SFCampaignsEdit = {
	init: function(){
		$('.selectpicker').selectpicker();
	},
	removeException: function(elem) {
		$(elem).closest('div.js-hook').remove();
	},
	remoteDialogCallback:function(){
		SFMain.initCallback(); // Set up form inputs

		//-- Always was checked
		$("input.always-toggle").on('ifToggled', function(event){
			if($(this).is(":checked")){
				$('#startDate').removeAttr('required');
				$('#endDate').removeAttr('required');
				$('.date-range').slideUp();
			} else {
				$('.date-range').slideDown();
				$('#startDate').attr('required', true);
				$('#endDate').attr('required', true);
			}
    });
	}
};

$('.campaigns.edit').ready(function(){

	SFCampaignsEdit.init();

	//-- Add exception
	$('#add-ex-button').on('click', function(){
		SFMain.remoteDialog("Add Exception", $(this).data('url'));
	});

	// $('#add-ex-button').click(function() {
	// 	var newex = {};
	// 	newex.id = null;
	// 	var newrow = $(new_row_html(newex));
	// 	$("#exceptions-container").append(newrow);
	// 	newrow.find(".js-daterange").datepicker({
	// 		autoclose: true,
	// 		todayHighlight: true
	// 	});
	// 	newrow.find(".js-starttimefield, .js-endtimefield").timepicker({
	// 		template: false,
	// 		showInputs: false,
	// 		showMeridian: false
	// 	});
	// });

	//--- Original Javascript ---//
	// console.log(hooks);
	// $('#campaign-main-loop').append($(list_loop_options(null)))


// 	var excontainer = $("#exceptions-container");
// 	for (var i=0, len = hooks.length; i < len; i++) {
// 		if (hooks[i].play_info === 'main') {
// 			$('#campaign-main-loop option[value="' + hooks[i].loop_asset_id + '"]').attr('selected', 'selected');
// 			$('#campaign-main-loop').data("ex-id", hooks[i].id);
// 		} else {
// 			var newrow = $(new_row_html(hooks[i]));
// 			excontainer.append(newrow);
// 			newrow.find(".js-daterange").datepicker({
// 				autoclose: true,
// 				todayHighlight: true
// 			});
// 			newrow.find(".js-starttimefield, .js-endtimefield").timepicker({
// 				template: false,
// 				showInputs: false,
// 				showMeridian: false
// 			});
// 		}
// 	}

// 	function new_row_html(hook) {
// 		var rowhtml = '' +
// 			'<div class="row panel panel-default js-hook" data-ex-id="' + hook.id + '">' +
// 				'<div class="col-sm-2">' +
// 					'<div class="form-group">' +
// 						'<label>Loop</label>' +
// 						'<select class="form-control js-loop-select">' +
// 							list_loop_options(hook.loop_asset_id) +
// 						'</select>' +
// 					'</div>' +
// 				'</div>' +
// 				'<div class="col-sm-4">' +
// 					'<div class="form-group">' +
// 						'<label>Time (24h)</label>' +
// 						'<div class="input-append bootstrap-timepicker input-group">' +
// 							'<input type="text" class="js-starttimefield form-control" value="' + hook.start_hour + ':' + hook.start_minute + '">' +
// 							'<span class="input-group-addon">to</span>' +
// 							'<input type="text" class="js-endtimefield form-control" value="' + hook.end_hour + ':' + hook.end_minute + '">' +
// 						'</div>' +
// 					'</div>' +
// 				'</div>' +
// 				'<div class="col-sm-4">' +
// 					'<div class="form-group">' +
// 						'<label>Dates</label>' +
// 						'<div class="js-daterange input-daterange input-group">' +
// 							'<input type="text" class="form-control" name="startdate" value="' + hook.start_month + '/' + hook.start_day + '/' + hook.start_year + '" />' +
// 							'<span class="input-group-addon">to</span>' +
// 							'<input type="text" class="form-control" name="enddate" value="' + hook.end_month + '/' + hook.end_day + '/' + hook.end_year + '" />' +
// 						'</div>' +
// 					'</div>' +
// 				'</div>' +
// 				'<div class="col-sm-2">' +
// 					'<table>' +
// 						'<tr>' +
// 							'<td>' +
// 								'<table><tr>' +
// 									'<td>Su</td>' +
// 									'<td>Mo</td>' +
// 									'<td>Tu</td>' +
// 									'<td>We</td>' +
// 									'<td>Th</td>' +
// 									'<td>Fr</td>' +
// 									'<td>Sa</td>' +
// 								'</tr>' +
// 								'<tr class="js-repeat-row">' +
// 									'<td><input ' + (hook.repeat_info & 64 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 32 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 16 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 8 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 4 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 2 ? 'checked' : '') + ' type="checkbox"></td>' +
// 									'<td><input ' + (hook.repeat_info & 1 ? 'checked' : '') + ' type="checkbox"></td>' +
// 								'</tr></table>' +
// 							'</td>' +
// 							'<td>' +
// 								'<a href="javascript:void(0)" class="btn btn-link" onclick="SFCampaignsEdit.removeException($(this));"><span class="glyphicon glyphicon-remove"></span></a>' +
// 							'</td>' +
// 						'</tr>' +
// 					'</table>' +
// 				'</div>' +
// 			'</div>';
// 		return rowhtml;
// 	}

// 	function list_loop_options(loop_asset_id) {
// 		var options = '';
// 		if(loop_asset_id == null) {
// 			options += '<option disabled selected> -- Select A Loop -- </option>';
// 		}
// 		for (var i=0, len = loops_available.length; i < len; i++) {
// 			if (loop_asset_id == loops_available[i].id) {
// 				options += '<option selected value="' + loops_available[i].id + '">' + loops_available[i].displayname + '</option>';
// 			} else {
// 				options += '<option value="' + loops_available[i].id + '">' + loops_available[i].displayname + '</option>';
// 			}
// 		}
// 		return options;
// 	}

// 	// When the campaign name is clicked, it changes to an editable text box
// 	$('#campaign-name').click(function() {
// 		var name = $(this).text();
// 		$(this).replaceWith($('<input type="text" id="campaign-name">').val(name));
// 	});



// 	// when the save button is pressed, generate the required json string
	$('[data-ajax-handle="save-campaign"]').bind('ajax:beforeSend', function(e, xhr, settings) {
		// Get the new name (element may be a span OR input)
		var newname = $('.campaign-name').text();
		if (newname == "") newname = $('.campaign-name').val();
		settings.data += "&campaign[displayname]=" + $.trim(newname);

		// Get the new hooks json
		var new_hooks = generate_hooks_object();

		settings.data += "&campaign[hooks_json_string]=" + JSON.stringify(new_hooks);

		// console.log(new_hooks);
	});

	function generate_hooks_object() {
		var hooks = [];
		hooks[0] = {
			id: $('#campaign-main-loop').data("ex-id"),
			loop_asset_id: parseInt($('#campaign-main-loop').find(":selected").val()),
			play_info: "main"
		};

		$(".js-hook").each(function(i) {
			var startdate = $(this).find('span.startDate').val().split("/");
			var enddate = $(this).find('span.endDate').val().split("/");
			var starttime = $(this).find('span.startTime').val().split(":");
			var endtime = $(this).find('span.endTime').val().split(":");
			var repeatinfo = getRepeatInfo($(this).find('.js-repeat-row'));

			hooks[hooks.length] = {
				id: $(this).data("ex-id"),
				play_info: "weekly",
				loop_asset_id: parseInt($(this).find('.js-loop-select :selected').val()),
				start_year: parseInt(startdate[2]),
				start_month: parseInt(startdate[0]),
				start_day: parseInt(startdate[1]),
				end_year: parseInt(enddate[2]),
				end_month: parseInt(enddate[0]),
				end_day: parseInt(enddate[1]),
				start_hour: parseInt(starttime[0]),
				start_minute: parseInt(starttime[1]),
				start_second: 0,
				end_hour: parseInt(endtime[0]),
				end_minute: parseInt(endtime[1]),
				end_second: 0,
				repeat_info: repeatinfo
			};
		});

		return hooks;
	}

	function getRepeatInfo(row) {
		var repeatinfostring = '';
		row.find('td input').each(function() {
			if ($(this).is(':checked')) {
				repeatinfostring += '1';
			} else {
				repeatinfostring += '0';
			}
		});
		return parseInt(repeatinfostring, 2);
	}

});



