#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
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
      playerScore = @get 'playerHand'
      .scores()[0]
      dealerScore = @get 'dealerHand'
      .scores()[0]
      if playerScore > dealerScore
        @set 'gameStatus','win'
      else if playerScore == dealerScore
        @set 'gameStatus','tie'
      else
        @set 'gameStatus','lose'
    ,@

  defaults:
    gameStatus: undefined





