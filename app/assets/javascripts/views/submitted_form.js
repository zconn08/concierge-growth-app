ConciergeGrowthApp.Views.SubmittedForm = Backbone.View.extend({
  template: JST['submitted_form'],

  initialize: function(options){
    this.linkAddress = "http://localhost:3000/referrals/" + options.referralLink;
    this.showLink = options.showLink === "true";
  },

  render: function(){
    this.$el.html(this.template({linkAddress: this.linkAddress}));
    $('#myModal').modal('show');
    if(this.showLink){
      $(".modal-body").css("display", "inline");
    }
    return this;
  },

});
