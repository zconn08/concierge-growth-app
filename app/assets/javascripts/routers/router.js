ConciergeGrowthApp.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "submitted/:id/:rating": "submittedRating",
  },

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  index: function(){
    var view = new ConciergeGrowthApp.Views.ReviewForm();
    this.swapView(view);
  },

  submittedRating: function(id, rating){
    var view = new ConciergeGrowthApp.Views.SubmittedForm({
      referralLink: id,
      rating: rating
    });
    this.swapView(view);
  },

  swapView: function(view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.$el);
    view.render();
  },
});
