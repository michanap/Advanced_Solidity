pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PupperCoinSale is Crowdsale, CappedCrowdsale, MintedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        // @TODO: Fill in the constructor parameters!
        uint256 rate, 
        address payable wallet, 
        uint256 openingTime,
        uint256 closingTime,
        uint256 goal
        PupperCoin token,
            )
    
    
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale(rate, wallet, token)
        MintedCrowdsale()
        PostDeliveryCrowdsale()
        RefundableCrowdsale(goal)
        CappedCrowdsale(goal)
        TimedCrowdsale(openingTime, closingTime)
        public
    {
        // constructor can stay empty
    }
}


contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;



    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet, 
        uint goal   
    )
       
       
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);


        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        uint opening_time = now;
        uint closing_time = now + 24 weeks; 
        PupperCoinSale pupper_sale = new PupperCoinSale(1, wallet, token, goal, openingTime, closingTime);  
        token_sale_address = address(pupper_sale);
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
   
    }

    
}