// link to example
// https://github.com/KPull/eth-guess-the-number-game/blob/master/GuessTheNumberGame.sol
pragma solidity ^0.5.1;

contract Gambling {

	// event AnswerSubmitted(uint answer);
	// event BetSubmitted(address player, uint bet, uint guessedNum);
	// event DisplayResults(string winner);

	address payable public owner;
	address payable public player;
	uint casinoPot;
	// State public state;
	//the minimum bet a user has to make in order to participate
	//maybe do some calculates about how the minimum bet has to be greater than the transaction cost
	uint public minimumBet = 100 finney;
	uint public totalBet = 0;
	uint public selected;
	uint public transactionCost = totalBet * 1/20;
	uint public answer;
	uint public winOrLose;
	//uint private currBet;
	//the total num of bets made so far
	//uint private numberOfBets = 0;
	//the max number of bets that each user can make
	// uint private constant maxAmountOfBets = 10;
	//constant var for the max amount of bets that cannot exceed this val
	// uint private constant LIMIT_AMOUNT_BETS = 100;
	//the number that the user presses
	//uint private betNum;
	//constant number of users - only 10 are allowed (maybe we need to use a hashmap or array)
	// uint private constant NUM_USERS = 10;
	// uint private userID;

	//METHODS

	//constructor??
	constructor(uint _minimumBet) public {
		owner = msg.sender;
		minimumBet = _minimumBet;
	}
	function _generateRandomNum (string memory _str) private pure returns (uint x) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % 10 + 1;
    }
	
	//grab inputs from what button they press
	function userBetNum (uint _buttonPress) public payable {
		player = msg.sender;
		totalBet = msg.value;
		selected = _buttonPress;
		results();
	}
	function toString(address x) private pure returns (string memory playerString) {
	    bytes memory b = new bytes(20);
	    for (uint i = 0; i < 20; i++)
	        b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
	    return string(b);
	}
	//display whether the player won or lost, how much the player won
	function results () public payable {
		answer = _generateRandomNum(toString(player));
		if (answer == selected) {
			// winner = "You are the winner.";
			player.transfer((totalBet - transactionCost) * 2);
			// casinoPot = casinoPot - totalBet - transactionCost;
			resetGame();
			winOrLose = 1;
		} else {
			// winner = "You are the loser.";
			owner.transfer(totalBet);
			resetGame();
			winOrLose = 0;
		}
	}

	//reset the game (reset all the variables) after someone wins the game
	function resetGame () private {
		totalBet = 0;
		player = address(0);
	}
}
