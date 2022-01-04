//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';


import "hardhat/console.sol";

contract PokerGameTon {
    using SafeMath for uint;


    uint256 public betAmount = uint256(1 ether).div(10); //0.1
    IERC20 public betToken;
    string[13] denominations = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"];
    string[4] suits = ["H", "C", "S", "D"];
    string[] cards;
    


    event Claimed(address sender, address receipient, uint256 amount);
    event CardHand(string[] hand);
    event AllHands(string[] playerHand, string[] dealerHand);

    struct Hand {
        string[] cards;

    }

    mapping(address => uint256) public playerCurrentAmount;
    mapping(address => Hand)  playerCurrentHand;
    mapping(address => Hand)   dealerHand;
    mapping(address => string) public ipfsHashOfPlayerDetails;
    mapping(address => string) public ipfsHashOfPlayerCurrentHand;



    constructor() {
        // console.log("Deploying a Greeter with greeting:", _greeting);
        // betToken = IERC20(_betCurrency);
    }


    // function getUserDetails() public view returns(uint256, string[5] memory, string memory) {
    //     return (playerCurrentAmount[msg.sender], playerCurrentHand[msg.sender], ipfsHashOfPlayerDetails[msg.sender]);

    // }



    
    function generatePlayerHand() public  {
        Hand storage playerHand = playerCurrentHand[msg.sender];
        playerHand.cards = cards;
        uint number = 5;
        for(uint i = 0; i < number; i++) {
            uint randomDenominationIndex = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, i))) % 13;   
            uint randomSuitIndex = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, i))) % 4; 
            string memory card = string(abi.encodePacked(denominations[randomDenominationIndex], suits[randomSuitIndex]));     
            
            
            playerHand.cards.push(card);
        }
        playerCurrentHand[msg.sender].cards = playerHand.cards;
        cards = [''];
        cards.pop();

        emit CardHand(playerHand.cards);
    
    }

    function generateDealerHand() public  {
        Hand storage dealercurrentHand = dealerHand[msg.sender];
        dealercurrentHand.cards = cards;
        uint number = 5;
        for(uint i = 0; i < number; i++) {
            uint randomDenominationIndex = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, i))) % 13;   
            uint randomSuitIndex = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, i))) % 4; 
            string memory card = string(abi.encodePacked(denominations[randomDenominationIndex], suits[randomSuitIndex]));     
     
            
            dealercurrentHand.cards.push(card);
        }
        dealerHand[msg.sender].cards = dealercurrentHand.cards;
        cards = [''];
        cards.pop();

        emit CardHand(dealercurrentHand.cards);

    }

    function getHand() public  {
        emit AllHands(playerCurrentHand[msg.sender].cards, dealerHand[msg.sender].cards);
    }


    // function placeBet(uint256 _amount) public {
    //     require(_amount >= betAmount, "Bet Amount is lower than the required ante");
    //     playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(_amount);
    //     _determineWinner(playerCurrentHand[msg.sender], dealerHand[address(this)]);

    // }

    // function _determineWinner(string[5] memory _playerHand, string[5] memory _dealerHand) internal returns(bool) {
    //     // needs a function to evaluate both hands to determine who won.
    //     // if(_playerHand !== uint) {
    //     playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(betAmount);

    //     return true;
    //     // };
    // }

    // function claimWinnings() public {
    //     uint256 amountToTransfer = playerCurrentAmount[msg.sender];
    //     playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].sub(amountToTransfer);
    //     require(betToken.transfer(msg.sender, amountToTransfer));

    //     emit Claimed(address(this), msg.sender, amountToTransfer);
    // }


}
