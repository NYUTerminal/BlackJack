//
//  ViewController.swift
//  BlackJack
//
//  Created by praveen on 2/14/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//


/*
global varaiable to store bets ..
every time needs to click on start to play .
After start analyze the cards to check blackJack or any combination
one global variable to store deck
options to insurance
option to double
option to

*/


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
    
    @IBOutlet weak var playerCardsOnView: UITextField!
    
    @IBOutlet weak var playerTotalOnView: UITextField!
    
    @IBOutlet weak var dealerCardsOnView: UITextField!
    
    @IBOutlet weak var dealerTotalOnView: UITextField!
    
    @IBOutlet weak var betOnView: UITextField!
    
    @IBOutlet weak var balanceOnView: UITextField!
    
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
    
    var numberOfGamesPlayed = 0
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
        var currentCardValue :Int = getCardValue("\(shuffledDeck[0])").0
        shuffledDeck.removeAtIndex(0)
        return currentCardValue
    }


    @IBAction func start() {
        
        if betOnView.text == nil {
            println("Bet is empty . Please input some bet to proceed ")
            return
        }
        
        if isGreater( betOnView.text.toInt()!) == false
        {
            println("You cant play")
            return
        }
        initializeDeck()
        dealerCards.append(getCardFromDeckAndRemove())
        dealerCards.append(getCardFromDeckAndRemove())
        playerCards.append(getCardFromDeckAndRemove())
        playerCards.append(getCardFromDeckAndRemove())
        println(playerCards)
        println(dealerCards)
        displayPlayerCardsOnView()
        displayDealerCardsOnViewWithFlip()
        displayBalance()
        numberOfGamesPlayed++
        if isBlackJack(playerCards) == true
        {
            
            println("Player Won")
            return
        }
        if isBusted(playerCards) == true
        {
            println("Player lost")
            return
        }

    }
    
    @IBAction func splitCards() {
    }
    
    @IBAction func double() {
    }
    
    func displayPlayerCardsOnView() {
        playerCardsOnView.text = ""
        var tempTotal = 0
        for pc in playerCards {
            tempTotal += pc
            playerCardsOnView.text = playerCardsOnView.text! + "\(pc)" + " , "
        }
        playerTotalOnView.text = playerTotalOnView.text! + "\(tempTotal)"
    }
    
    func displayDealerCardsOnViewWithFlip() {
        dealerCardsOnView.text = ""
        var firstCard = true
        for dc in dealerCards {
            if firstCard {
                dealerCardsOnView.text = dealerCardsOnView.text! + "FLIP" + " , "
                firstCard = false
            }else{
                dealerCardsOnView.text = dealerCardsOnView.text! + "\(dc)" + " , "
            }
        }
    }
    
    func displayBalance() {
        balanceOnView.text = balanceOnView.text! + "\(balance)"
    }
  
  
    @IBAction func hit() {
        
        if standFlag == false {
            
        playerCards.append(getCardFromDeckAndRemove())
            displayPlayerCardsOnView()
            displayDealerCardsOnViewWithFlip()
            if isBlackJack(playerCards) == true
            {
                makeBillingChanges(true)
                displayBalance()
                println("Player Won")
                return
            }
        
            if isBusted(playerCards) == true
            {
                makeBillingChanges(false)
                displayBalance()
                println("Player lost")
                return
            }
        }else{
            println("Cant hit , STAND is on")
            return
        }
        
    }

    @IBAction func stand() {
        standFlag = true
        //dealer cards we have to populate .
        
        
        
        
        
        
    }
    
    func resetCardsTotalAndBetOnView(){
        playerCardsOnView.text = ""
        dealerCardsOnView.text = ""
        betOnView.text = ""
        
    }
    
    func makeBillingChanges(isPlayerWon : Bool ) {
        if isPlayerWon {
            balance = balance + bet
        }else{
            balance = balance - bet
        }
    }
    
}

