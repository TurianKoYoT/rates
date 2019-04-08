$(function(){
  if ($('body.rates-index').length === 0) {
    return;
  }

  App.cable.subscriptions.create('RatesChannel', {
    connected: function() {
      this.perform('follow');
    },

    received: function(data) {
      console.log('received');
      var card = $(".rate-card-" + data.id);
      if (card) {
        return card.replaceWith(data.html);
      }
    }
  })
});
