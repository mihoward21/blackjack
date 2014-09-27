class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    rank = @model.get("rankName")
    suit = @model.get("suitName")
    url = 'url(img/cards/' + rank + '-' + suit + '.png)'
    @$el.children().detach().end().html
    @$el.css 'backgroundImage', url
    @$el.addClass 'covered' unless @model.get 'revealed'
