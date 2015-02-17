//
//  ViewController.swift
//  BlackJack
//
//  Created by praveen on 2/14/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import UIKit

//Referenced from google . How to shuffle an array
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


class ViewController: UIViewController {
    
    
    @IBOutlet weak var dealerFirstCard: UITextField!
    
    @IBOutlet weak var dealerSecondCard: UITextField!
    
    @IBOutlet weak var playerFirstCard: UITextField!
    
    @IBOutlet weak var playerSecondCard: UITextField!
    
    var dealerCards = Array<Int>()
    
    var playerCards = Array<Int>()
    
    let maxPlayerCash = 100
    
    var playerCashRemaining = 100
    
    var playerCardsTotalSum = 0
    
    var dealterCardTotalSum = 0
    
    var mixedUp: [String] = []
    //Function to initialize the deck
    func initializeDeck() {
        var myString = "Here,is,my,string"
        let myArray = split(myString, {$0 == ","})
        var Suit = ["Spades","Hearts","Diamonds" , "Clubs"]
        var Card = ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]
        var deck : [String] = []
        for suit in Suit
        {
            for card in Card {
                deck.append("\(card):\(suit)")
            }
        }
        if contains(Suit, "Spades"){
            println("spades dude")
        }
        mixedUp = deck.shuffled()
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
    
    
    /*
        global varaiable to store bets .. 
        every time needs to click on start to play .
        After start analyze the cards to check blackJack or any combination
        one global variable to store deck 
        options to insurance 
        option to double 
        option to



*/
    

    @IBAction func startGame() {
        
        dealerCards.append(getCardValue("\(mixedUp[0])").0)
        dealerCards.append(getCardValue("\(mixedUp[1])").0)
        playerCards.append(getCardValue("\(mixedUp[2])").0)
        playerCards.append(getCardValue("\(mixedUp[3])").0)
        
        
        //dealerCards.append("\(mixedUp[0])")
         //dealerCards.append("\(mixedUp[1ˆ])")
        //var playerCards: [String] = [mixedUp[2] , mixedUp[3]]
        //mixedUp.removeRange(Range(start: 0, end: 3))
        //playerFirstCard.text = playerCards[0]
        //playerSecondCard.text = playerCards[1]
        
        var gameState = "testing"
        switch gameState {
        case "blackjack" :
            
        default:
        }
        
        
        
        
        var firstcard = dealerCards[1]
        //println()
        println("testing bro Pleaserun")
    }
    
    func isBlackJack(cardsInHand :Array<Int>) -> Bool {
        let blackJacTotal = 21
        var tempCount = 0
        for eachCard in cardsInHand {
            tempCount += eachCard
        }
        if(tempCount == 21 ){
            return true;
        }
        return false
    }
    
    func isBusted(cardsInHand :Array<Int>) -> Bool {
        
        
        
    }
  

}

