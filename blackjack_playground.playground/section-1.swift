  
  import UIKit
  
  extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
  }
  
  var dealerCards = Array<Int>()
  
  var playerCards = Array<Int>()
  
  let maxPlayerCash = 100
  
  var bet = 0
  
  var balance = 100
  
  var playerCardsTotalSum = 0
  
  var dealterCardTotalSum = 0
  
  var shuffledDeck = Array<String>()
  
  var standFlag  = false
  
  var isPlayerWon = false
  //Function to initialize the deck
  
  func initializeDeck() {
    var Suit = ["Spades","Hearts","Diamonds" , "Clubs"]
    var Card = ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]
    var deck : [String] = []
    for suit in Suit
    {
        for card in Card {
            deck.append("\(card):\(suit)")
        }
    }
    shuffledDeck = deck.shuffled()
  }
  
  func getCardValue(card : String) -> ( Int , Int ) {
    var card_types = split( card, {$0 == ":"})
    println(card_types[0])
    switch card_types[0]
    {
    case "2":
        return ( 2 , 0)
    case "3":
        return ( 3 , 0)
    case "4":
        return ( 4 , 0)
    case "5":
        return ( 5 , 0)
    case "6":
        return ( 6 , 0)
    case "7":
        return ( 7 , 0)
    case "8":
        return ( 8 ,  0)
    case "9":
        return ( 9 , 0)
    case "10":
        return ( 10 , 0)
    case "Jack":
        return ( 10 , 0)
    case "Queen":
        return ( 10 , 0)
    case "King":
        return ( 10 , 0)
    case "Ace":
        return ( 11 , 11)
    default :
        return (0 , 0 )
    }
    
  }
  
  
  func isBlackJack(cardsInHand : Array<Int>) -> Bool {
    var tempCount = 0
    for eachCard in cardsInHand {
        tempCount += eachCard
    }
    if tempCount == 21 {
        return true
    }
    playerCardsTotalSum = tempCount
    return false
  }
  
  func isBusted(cardsInHand :Array<Int>) -> Bool {
    var tempCount = 0
    for eachCard in cardsInHand {
        tempCount += eachCard
    }
    if tempCount > 21 {
        return true
    }
    return false
    
  }
  
  
  func isGreater(bet: Int) -> Bool {
    if bet > 1 && bet < balance{
        return true
    }
    return false
  }
  
  func getCardFromDeckAndRemove()-> Int
  {
    initializeDeck()
    println("checking")
    println(shuffledDeck.last)
    println(getCardValue("\(shuffledDeck[0])"))

    var currentCardValue :Int = getCardValue("\(shuffledDeck[0])").0
    shuffledDeck.removeAtIndex(0)
    return currentCardValue
  }
  
  getCardFromDeckAndRemove()
  
  
  
