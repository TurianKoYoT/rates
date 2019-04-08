//= require jquery
//= require jquery_ujs
//= require jquery3
//= require action_cable
//= require popper
//= require bootstrap
//= require_tree .

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
}).call(this);
