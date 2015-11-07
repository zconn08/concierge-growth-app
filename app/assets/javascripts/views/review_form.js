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
      half: true,
      score: 3,
      scoreName: 'rating[rating]'
    });
  },

  submitRating: function(e){
    e.preventDefault();
    var formData = this.$("form").serializeJSON();
    var newRating = new ConciergeGrowthApp.Models.Rating();
    newRating.save(formData, {
      success: function(response,b,c){
        if(response.get("rating") > 3){
          $(".modal-body").css("display", "inline");
        }
      },
    });
  }

});
