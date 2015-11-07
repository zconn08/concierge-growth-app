ConciergeGrowthApp.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "submitted/:id/:boolean": "submittedRating",
  },

  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },

  index: function(){
    var view = new ConciergeGrowthApp.Views.ReviewForm();
    this.swapView(view);
  },

  submittedRating: function(id, boolean){
    var view = new ConciergeGrowthApp.Views.SubmittedForm({
      referralLink: id,
      showLink: boolean
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
