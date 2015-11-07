ConciergeGrowthApp.Views.ReviewForm = Backbone.View.extend({
  template: JST['review_form'],

  events: {
    "click #submit-rating" : "submitRating"
  },

  initialize: function(){
  },

  render: function(){
    this.$el.html(this.template());
    this.onRender();
    return this;
  },

  onRender: function() {
    this.$('#star-rate').raty('destroy');
    this.$('#star-rate').raty({
      path: '/assets/',
      half: false,
      score: 3,
      scoreName: 'rating[rating]'
    });
  },

  submitRating: function(e){
    e.preventDefault();
    var formData = this.$("form").serializeJSON();
    if(parseInt(formData.rating.rating) > 3){
      $(".modal-body").css("display", "inline");
    }

    // Save Rating
    var newRating = new ConciergeGrowthApp.Models.Rating();
    newRating.save(formData, {
      success: function(rating,b,c){

        // Save Referral
        var newReferralLink = new ConciergeGrowthApp.Models.Referral();
        newReferralLink.save(
          {referral: {"rating_id": rating.get("id")}}, {
          success: function(referral){
            var linkAddress = "http://localhost:3000/referrals/" + referral.attributes.referral_link
            $("#referral-link").html(
              '<a href="' + linkAddress + '">' + linkAddress + "</a>"
            );
          }.bind(this)
        });
      }.bind(this)
    });
  }

});
