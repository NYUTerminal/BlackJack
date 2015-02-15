// Playground - noun: a place where people can play


import UIKit

var myString = "Here,is,my,string"
let myArray = split(myString, {$0 == ","})
myArray

var Suit = ["Spades","Hearts","Diamonds" , "Clubs"]
var Card = ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]
var deck : [String] = []

for card in Card
{
    for suit in Suit {
        deck.append("\(card):\(suit)")
    }
}

if contains(Suit, "Spades"){
    println("spades dude")
}

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

let mixedUp = deck.shuffled()

println(mixedUp)


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
        return ( 1 , 11)
    default :
        return (0 , 0 )
    }
    
}

println(getCardValue(mixedUp[1]))


func blackJack() {
    var dealerCards: [String]
    var playerCards: [String]
    
    
    
    
    
    
    
}


