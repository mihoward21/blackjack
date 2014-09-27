#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'history', history = new History()
    @set 'gameCounter', 0
    @initHands()

  initHands: ->
    @set 'gameCounter', @get('gameCounter')+1
    if @get('playerHand') and @get('gameCounter') > 1
      round = new Round({roundHand: @get 'playerHand'})
      @get('history').add round
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'gameStatus', undefined
    @get 'playerHand'
    .on 'lose', ->
      @set 'gameStatus','lose'
    ,@
    @get 'playerHand'
    .on 'win', ->
     @set 'gameStatus','win'
    ,@
    @get 'dealerHand'
    .on 'win', ->
     @set 'gameStatus','win'
    ,@
    @get 'dealerHand'
    .on 'check', ->
      playerArray = @get 'playerHand'
      .scores()
      if playerArray[1] < 22
        playerScore = playerArray[1]
      else
        playerScore = playerArray[0]
      dealerArray = @get 'dealerHand'
      .scores()
      if dealerArray[1] < 22
        dealerScore = dealerArray[1]
      else
        dealerScore = dealerArray[0]
      if playerScore > dealerScore
        @set 'gameStatus','win'
      else if playerScore == dealerScore
        @set 'gameStatus','tie'
      else
        @set 'gameStatus','lose'
    ,@

  defaults:
    'gameCounter': 0







