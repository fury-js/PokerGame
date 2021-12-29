//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import "hardhat/console.sol";

contract PokerGame {
    using SafeMath for uint;

    uint256 public betAmount = uint256(1 ether).div(10); //0.1
    IERC20 public betToken;

    event Claimed(address sender, address receipient, uint256 amount);

    // struct Player {

    // }

    mapping(address => uint256) playerCurrentAmount;
    mapping(address => string[5]) playerCurrentHand;
    mapping(address => string[5])  dealerHand;
    mapping(address => string) ipfsHashOfPlayerDetails;
    mapping(address => string) ipfsHashOfPlayerCurrentHand;


    // mapping(address => Player) public playerDetails;

    // struct Player {
    //     address payable playerAddress;
    //     string[3] playerCards;
    // }

    string[] cards = [
        "Ace_Clubs", "Two_Clubs", "Three_Clubs", "Four_Clubs", "Five_Clubs", "Six_Clubs", "Seven_Clubs", "Eight_Clubs", "Nine_Clubs", "Ten_Clubs", "Jack_Clubs", "Queen_Clubs", "King_Clubs",
		"Ace_Diamonds", "Two_Diamonds", "Three_Diamonds", "Four_Diamonds", "Five_Diamonds", "Six_Diamonds", "Seven_Diamonds", "Eight_Diamonds", "Nine_Diamonds", "Ten_Diamonds", "Jack_Diamonds", "Queen_Diamonds", "King_Diamonds",
		"Ace_Hearts", "Two_Hearts", "Three_Hearts", "Four_Hearts", "Five_Hearts", "Six_Hearts", "Seven_Hearts", "Eight_Hearts", "Nine_Hearts", "Ten_Hearts", "Jack_Hearts", "Queen_Hearts", "King_Hearts",
		"Ace_Spades", "Two_Spades", "Three_Spades", "Four_Spades", "Five_Spades", "Six_Spades", "Seven_Spades", "Eight_Spades", "Nine_Spades", "Ten_Spades", "Jack_Spades", "Queen_Spades", "King_Spades"
    ];

    constructor(address _betCurrency) {
        // console.log("Deploying a Greeter with greeting:", _greeting);
        betToken = IERC20(_betCurrency);
    }

    // function dealCard() public {
    //     Player memory player = Player({
    //         playerAddress: payable(msg.sender),
    //         playerCards: ["Ace_Clubs", "Two_Clubs", "Three_Clubs"]
    //     });

    //     // dealtCards[msg.sender] = player;

    // }

    function getUserDetails() public view returns(uint256, string[5] memory, string memory) {
        return (playerCurrentAmount[msg.sender], playerCurrentHand[msg.sender], ipfsHashOfPlayerDetails[msg.sender]);

    }

    function generateHand() public returns(string[5] memory) {
        // generate hand for the player and the dealer

    }

    function placeBet(uint256 _amount) public {
        require(_amount >= betAmount, "Bet Amount is lower than the required ante");
        playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(_amount);
        _determineWinner(playerCurrentHand[msg.sender], dealerHand[address(this)]);

    }

    function _determineWinner(string[5] memory _playerHand, string[5] memory _dealerHand) internal returns(bool) {
        // needs a function to evaluate both hands to determine who won.
        // if(_playerHand !== uint) {
        playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(betAmount);

        return true;
        // };
    }

    function claimWinnings() public {
        uint256 amountToTransfer = playerCurrentAmount[msg.sender];
        playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].sub(amountToTransfer);
        require(betToken.transfer(msg.sender, amountToTransfer));

        emit Claimed(address(this), msg.sender, amountToTransfer);
    }


}
