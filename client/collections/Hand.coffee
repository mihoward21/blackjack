class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @trigger 'win',@ if not@isDealer and @scores()[1] == 21

  hit: ->
    out = @add(@deck.pop()).last()
    @trigger 'lose',@ if @scores()[0] > 21
    @trigger 'win',@ if @scores()[0] == 21 or @scores()[1] == 21
    out

  stand: ->
    @at(0).flip()
    @playDealer()

  playDealer: ->
    if @scores()[0] > 21
      @trigger 'win',@
    else if @scores()[0] > 16 or 16 < @scores()[1] < 22
      @trigger 'check',@
    else
      @add(@deck.pop()).last()
      @playDealer()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
