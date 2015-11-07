window.ConciergeGrowthApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Backbone.history.start();

    var ratings = new ConciergeGrowthApp.Collections.Ratings();
    var view = new ConciergeGrowthApp.Views.ReviewForm({
      collection: ratings
    });

    $("#main-content").html(view.render().$el);
  }
};

$(document).ready(function(){
  ConciergeGrowthApp.initialize();
});
