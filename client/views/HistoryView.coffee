class window.HistoryView extends Backbone.View

 template: _.template '<h2>History</h2>'

 initialize: ->
  @collection.on 'add remove change', => @render()
  @render()

 render: ->
  @$el.children().detach()
  @$el.html @template()
  i = 1
  @$el.append @collection.map (roundModel) ->
    $round = new HandView(collection: roundModel.get 'roundHand').$el
    $round.children().first().text(i)
    i++
    $round



