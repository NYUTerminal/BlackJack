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
    
    @IBOutlet weak var noOfTimesOnView: UITextField!
    
    
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
    
    var dealerCardsSum = 0
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
    
    func getSumOfCards(cardsInHand : Array<Int>) -> Int{
        var tempCount = 0
        for card in cardsInHand {
            tempCount += card
        }
        return tempCount
    }
    
    
    func isGreater(bet: Int) -> Bool {
        if bet > 1 && bet < balance{
            return true
        }
            return false
    }
    
    func getCardFromDeckAndRemove()-> Int
    {
        if(shuffledDeck.count>0){
            var currentCardValue :Int = getCardValue("\(shuffledDeck[0])").0
            shuffledDeck.removeAtIndex(0)
            return currentCardValue
        }
        return 0
    }


    @IBAction func start() {
        
        if betOnView == nil {
            println("Bet is empty . Please input some bet to proceed ")
            return
        }
        
        if isGreater( betOnView.text.toInt()! ) == false
        {
            println("You cant play")
            return
        }
        
        
        
        /*
            After Every 5 times need to shuffle the deck . 
            Number of times played should be multiple of 5.
        */
        initializeDeck()
        if numberOfGamesPlayed%5 == 0 {
            shuffledDeck = shuffledDeck.shuffled()
        }
        
        //This block wont execute .
        if  shuffledDeck.count == 0 {
            println("No more cards left in the deck to play . Please reset the game . Launch the app again for now . ")
            return
        }
        dealerCards.append(getCardFromDeckAndRemove())
        dealerCards.append(getCardFromDeckAndRemove())
        playerCards.append(getCardFromDeckAndRemove())
        playerCards.append(getCardFromDeckAndRemove())
        println("playerCards - \(playerCards)")
        println("dealerCards - \(dealerCards)")
        displayPlayerCardsOnView()
        displayDealerCardsOnViewWithFlip()
        displayNoOfTimesPlayed()
        displayBalance()
        bet = betOnView.text.toInt()!
        numberOfGamesPlayed++
        
        if isBlackJack(playerCards) == true
        {
            makeBillingChanges(true)
            displayBalance()
            resetCardsTotalAndBetOnView()
            println("Player Won")
            return
        }
        if isBusted(playerCards) == true
        {
            makeBillingChanges(false)
            displayBalance()
            resetCardsTotalAndBetOnView()
            println("Player lost")
            return
        }

    }
    
    @IBAction func splitCards() {
    }
    
    
    //Player will loose money two times .
    
    @IBAction func double() {
        playerCards.append(getCardFromDeckAndRemove())
        displayPlayerCardsOnView()
        println("playerCards - \(playerCards)")
        println("dealerCards - \(dealerCards)")
        if isBlackJack(playerCards) == true
        {
            makeBillingChanges(true)
            makeBillingChanges(true)
            displayBalance()
            resetCardsTotalAndBetOnView()
            println("Player Won")
            return
        }
        
        if isBusted(playerCards) == true
        {
            makeBillingChanges(false)
            makeBillingChanges(false)
            displayBalance()
            resetCardsTotalAndBetOnView()
            println("Player lost")
            return
        }
        stand()
        
        
    }
  
    @IBAction func hit() {
        
        if standFlag == false {
            
        playerCards.append(getCardFromDeckAndRemove())
            println("playerCards - \(playerCards)")
            println("dealerCards - \(dealerCards)")
            displayPlayerCardsOnView()
            displayDealerCardsOnViewWithFlip()
            if isBlackJack(playerCards) == true
            {
                playerWon()
                return
            }
        
            if isBusted(playerCards) == true
            {
                playerLost()
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
        dealerCardsSum = getSumOfCards(dealerCards)
        while(dealerCardsSum<16){
            var currentCardForDealer = getCardFromDeckAndRemove()
            dealerCards.append(currentCardForDealer)
            dealerCardsSum += currentCardForDealer
        }
        println("dealer Card sum after stand \(dealerCardsSum)")
        println("dealer Cards \(dealerCards)")
        if(dealerCardsSum>21){
            println("player won !! while dealter is trying to get above 16")
            playerWon()
            return
        }
        
        if(dealerCardsSum > playerCardsTotalSum){
            println("dealer sum \(dealerCardsSum) > player sum \(playerCardsTotalSum)")
            playerLost()
        }else if dealerCardsSum < playerCardsTotalSum{
            println("dealer sum \(dealerCardsSum) < player sum \(playerCardsTotalSum)")
            playerWon()
        }else{
            println("dealer sum \(dealerCardsSum) == player sum \(playerCardsTotalSum)")
            resetCardsTotalAndBetOnView()
        }
        
    }

    func playerWon(){
        makeBillingChanges(true)
        displayBalance()
        resetCardsTotalAndBetOnView()
        println("Player Won")
    }
    
    func playerLost(){
        makeBillingChanges(false)
        displayBalance()
        resetCardsTotalAndBetOnView()
        println("Player lost")

    }
    
    func resetCardsTotalAndBetOnView(){
        playerCardsOnView.text = ""
        dealerCardsOnView.text = ""
        playerTotalOnView.text = ""
        dealerTotalOnView.text = ""
        betOnView.text = ""
        dealerCardsSum = 0
        playerCardsTotalSum = 0
        playerCards = []
        dealerCards = []
        standFlag = false
    }
    
    func makeBillingChanges(isPlayerWon : Bool ) {
        if isPlayerWon {
            balance = balance + bet
            println("new balance of player(won) - \(balance)")
            println("bet - \(bet)")
        }else{
            println("new balance of player(lost) - \(balance)")
            println("bet - \(bet)")
            balance = balance - bet
        }
    }
    
    
    func displayPlayerCardsOnView() {
        playerCardsOnView.text = ""
        playerTotalOnView.text = ""
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
        balanceOnView.text = ""
        balanceOnView.text = balanceOnView.text! + "\(balance)"
    }
    
    func displayNoOfTimesPlayed() {
        noOfTimesOnView.text = ""
        noOfTimesOnView.text = noOfTimesOnView.text! + "\(numberOfGamesPlayed)"
    }
    
}

