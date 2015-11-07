window.ConciergeGrowthApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new ConciergeGrowthApp.Routers.Router({
      $rootEl: $("#main-content")
    });
    
    Backbone.history.start();

  }
};

$(document).ready(function(){
  ConciergeGrowthApp.initialize();
});
