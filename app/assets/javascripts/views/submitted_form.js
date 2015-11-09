ConciergeGrowthApp.Views.SubmittedForm = Backbone.View.extend({
  template: JST['submitted_form'],

  initialize: function(options){
    this.linkAddress = "https://concierge-growth-app.herokuapp.com/referrals/" + options.referralLink;
    this.rating = options.rating;
    mixpanel.track("Submitted Rating");
  },

  render: function(){
    this.$el.html(this.template({linkAddress: this.linkAddress}));
    this.onRender();
    return this;
  },

  onRender: function() {
    $('#myModal').modal('show');
    if(parseInt(this.rating) > 3){
      $(".modal-body").css("display", "inline");
      mixpanel.track("Invite Link Displayed", {"numStars": this.rating});
    }
  },

});
