var SFCampaigns = {

  init: function(){

  }

}

$('.campaigns.index').ready(function(){

  SFCampaigns.init();

  //-- Add New Campaign
  $('.add-new-campaign').on('click', function(e){
    e.preventDefault();
    SFMain.remoteDialog($(this).data('title'), $(this).attr('href'));
  });

});