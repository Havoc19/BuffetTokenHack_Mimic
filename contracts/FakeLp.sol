pragma solidity ^0.5.16;


// It's a FakeLP Pool, just to mimic the working of pool, not an exact version
import "./BEP20Token.sol";
contract FakeLp is Ownable {

    address public token;
    using SafeMath for uint256;
    BEP20Token public c;
    constructor(address _token) public{
        token = _token;
        c = BEP20Token(token);
    }


    function swapETHForToken(uint _amount) public payable returns(bool){
        
        require((msg.sender).balance >= _amount,"Invalid Amount");
        uint _token0Balance = c.balanceOf(address(this));
        uint _token1Balance = address(this).balance;
        uint _k = _token0Balance.mul(_token1Balance);
        uint _newValue = (_k.div(_token1Balance.add(_amount))).add(100000);
        c.transfer(msg.sender, _token0Balance.sub(_newValue));
        return true;
    }

    function swapTokenForETH(uint _amount) public payable returns(bool){
        require(c.balanceOf(msg.sender) >= _amount,"Invalid Amount");
        uint _token0Balance = c.balanceOf(address(this));
        uint _token1Balance = address(this).balance;
        uint _k = _token0Balance.mul(_token1Balance);
        uint _newValue = _k.div(_token0Balance.add(_amount));
        uint _balance = _token1Balance.sub(_newValue);
        msg.sender.transfer(_balance);
        return true;
    }

    function balance() public view returns (uint){
        return address(this).balance;
    }

    function tokenBalance() public view returns (uint){
        return c.balanceOf(address(this));
    }

function fallback() external payable {
    }

}

// $ truffle run verify FakeLp BEP20Token HackerContract --network ethTest
// Verifying FakeLp
// Pass - Verified: https://rinkeby.etherscan.io/address/0x5c4b6c920D0090F55E98562d8C0a701Bdb1d865b#code
// Verifying BEP20Token
// Pass - Verified: https://rinkeby.etherscan.io/address/0x92Cf23C222F1e020110F1B21ca4d8813645C9dcE#code
// Verifying HackerContract
// Pass - Verified: https://rinkeby.etherscan.io/address/0xdD98eD2AAd98d7b9ca31D3A619527dfA11187264#code
// Successfully verified 3 contract(s).