ConciergeGrowthApp.Views.ReviewForm = Backbone.View.extend({
  template: JST['review_form'],

  events: {
    "click #submit-rating" : "submitRating"
  },

  initialize: function(){
    mixpanel.track("Rating Page View");
  },

  render: function(){
    this.$el.html(this.template());
    this.onRender();
    return this;
  },

  onRender: function() {
    this.$('#star-rate').raty('destroy');
    this.$('#star-rate').raty({
      path: 'public/Images/',
      half: false,
      score: 3,
      scoreName: 'rating[rating]'
    });
  },

  submitRating: function(e){
    e.preventDefault();
    var formData = this.$("form").serializeJSON();
    var numStars = formData.rating.rating

    // Save Rating
    var newRating = new ConciergeGrowthApp.Models.Rating();
    newRating.save(formData, {
      success: function(rating){

        // Save Referral
        var newReferralLink = new ConciergeGrowthApp.Models.Referral();
        newReferralLink.save({referral: {"rating_id": rating.get("id")}}, {
          success: function(referral){
            Backbone.history.navigate("/submitted/" + referral.attributes.referral_link + "/" + numStars, {trigger: true});
          }.bind(this)
        });
      }.bind(this)
    });
  }

});
