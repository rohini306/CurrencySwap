pragma solidity ^0.5.0;
import "./Token.sol";
contract EthSwap{

string public name="EthSwap Instant Exchange";
Token public token;
uint public rate=100;

event TokenSold(
address account,
address token,
uint amount,
uint rate
);

event TokenPurchased(
address account,
address token,
uint amount,
uint rate
);

constructor(Token _token) public {
token=_token;
}

function buyTokens()public payable{
//redemption rate=number of tokens received for one ether

//amount of ethereum*redemption rate
uint tokenAmount=msg.value*rate;

require(token.balanceOf(address(this))>=tokenAmount);

token.transfer(msg.sender, tokenAmount);
//emit an event  that token was purchased
emit TokenPurchased(msg.sender,address(token),tokenAmount,rate);
}

function sellTokens(uint _amount) public
{

//user cant sell more tokens than they have
require(token.balanceOf(msg.sender)>=_amount);



   //calculate the amount of ether to redeem
   uint etherAmount=_amount / rate;

   require(address(this).balance>=etherAmount);

   token.transferFrom(msg.sender,address(this),_amount);

   //perform sale
   msg.sender.transfer(etherAmount);

   //emit an development
   emit TokenSold(msg.sender,address(token),_amount,rate);


}





}
