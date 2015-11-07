ConciergeGrowthApp.Views.ReviewForm = Backbone.View.extend({
  template: JST['review_form'],

  events: {
    "submit form" : "submitRating"
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
    debugger;
    // this.model.save(formData, {
    //   success: function() {
    //     Backbone.history.navigate("#users/" + this.model.id, {trigger: true});
    //   }.bind(this)
    // });
  }

});
