class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    if not @isDealer then @isDealer = false
    if not @isDealer and @scores.call(array)[1] == 21
      result = @
      setTimeout ->
        result.trigger 'win',result
      ,1

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
    # hiddenAce = false
    numAces = @reduce (num, card) ->
      num + if card.get('value') == 1 then 1 else 0
    , 0
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    hiddenAce = @reduce (memo, card) ->
      helper = not card.get('revealed') and card.get('value') == 1
      memo or helper
    , false
    if numAces > 1
     [score, score+10]
    else if numAces == 1 and not hiddenAce
     [score, score+10]
    else
     [score]
