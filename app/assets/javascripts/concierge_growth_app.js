window.ConciergeGrowthApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Backbone.history.start();

    var view = new ConciergeGrowthApp.Views.ReviewForm();
    $("#main-content").html(view.render().$el);
  }
};

$(document).ready(function(){
  ConciergeGrowthApp.initialize();
});
