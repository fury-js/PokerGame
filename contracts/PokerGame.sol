//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';


import "hardhat/console.sol";

contract PokerGame {
    using SafeMath for uint;


    uint256 public betAmount = uint256(1 ether).div(10); //0.1
    IERC20 public betToken;
    string[13] denominations = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"];
    string[4] suits = ["H", "C", "S", "D"];
    string[] cards;
    
    


    event Claimed(address sender, address receipient, uint256 amount);
    event CardHand(string hand);
    event AllHands(string playerHand, string dealerHand);

    struct Hand {
        string cards;

    }


    mapping(address => uint256) public bidAmount;
    mapping(address => uint256) public playerCurrentAmount;
    mapping(address => uint256) public dealerCurrentAmount;
    mapping(address => Hand)  playerCurrentHand;
    mapping(address => Hand)   dealerHand;
    mapping(address => string) public ipfsHashOfPlayerDetails;



    constructor() {
        
    }




    function getHand() public  {
        emit AllHands(playerCurrentHand[msg.sender].cards, dealerHand[msg.sender].cards);
    }

    

    function setAmount(uint256 _amount) public payable {
        playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(_amount);
        dealerCurrentAmount[msg.sender] = dealerCurrentAmount[msg.sender].add(_amount);
    }



    function getApprovedAmount() public view returns(uint256, uint256) {
        return (playerCurrentAmount[msg.sender], dealerCurrentAmount[msg.sender]);
    }





    function placeBet(uint256 _amount) public {
        require(_amount > 0, "Bet Amount cannot be 0");
        playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].sub(_amount);
        dealerCurrentAmount[msg.sender] = dealerCurrentAmount[msg.sender].sub(_amount);
        bidAmount[msg.sender] = _amount;
    }




    function rewardWinner(string memory _winner) public {
        require(bidAmount[msg.sender] > 0, "Bid amount Cannot be 0, Caller must play a game");
        if((keccak256(abi.encodePacked(_winner)) == keccak256(abi.encodePacked("player"))))
        {
            playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(bidAmount[msg.sender].mul(2));
        }
        if((keccak256(abi.encodePacked(_winner)) == keccak256(abi.encodePacked("dealer")))) {
            dealerCurrentAmount[msg.sender] = dealerCurrentAmount[msg.sender].add(bidAmount[msg.sender].mul(2));
        }
        if((keccak256(abi.encodePacked(_winner)) == keccak256(abi.encodePacked("tie")))) {
            dealerCurrentAmount[msg.sender] = dealerCurrentAmount[msg.sender].add(bidAmount[msg.sender]);
            playerCurrentAmount[msg.sender] = playerCurrentAmount[msg.sender].add(bidAmount[msg.sender]);
        }

        bidAmount[msg.sender] = bidAmount[msg.sender].sub(bidAmount[msg.sender]);
    }



    function updatePlayerDetails(string memory _historyHash) public {
        ipfsHashOfPlayerDetails[msg.sender] = _historyHash;
    }



    function getGameDetails() public view returns(uint, uint, string memory, string memory, string memory) {
        return (
            playerCurrentAmount[msg.sender],
            dealerCurrentAmount[msg.sender],
            playerCurrentHand[msg.sender].cards,
            dealerHand[msg.sender].cards,
            ipfsHashOfPlayerDetails[msg.sender]
        );
    }

    function setHand(string memory _playerHand, string memory _dealerHand) public {
        playerCurrentHand[msg.sender].cards = _playerHand;
        dealerHand[msg.sender].cards = _dealerHand;
    }

}
