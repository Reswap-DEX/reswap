// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/UniERC20.sol";
import "./Reswap.sol";


contract ReswapFactory is Ownable {
    using UniERC20 for IERC20;

    event Deployed(
        address indexed mooniswap,
        address indexed token1,
        address indexed token2
    );

    uint256 public constant MAX_FEE = 0.003e18; // 0.3%

    uint256 public fee;
    Reswap[] public allPools;
    mapping(Reswap => bool) public isPool;
    mapping(IERC20 => mapping(IERC20 => Reswap)) public pools;

    function getAllPools() external view returns(Reswap[] memory) {
        return allPools;
    }

    function setFee(uint256 newFee) external onlyOwner {
        require(newFee <= MAX_FEE, "Factory: fee should be <= 0.3%");
        fee = newFee;
    }

    function deploy(IERC20 tokenA, IERC20 tokenB) public returns(Reswap pool) {
        require(tokenA != tokenB, "Factory: not support same tokens");
        require(pools[tokenA][tokenB] == Reswap(0), "Factory: pool already exists");

        (IERC20 token1, IERC20 token2) = sortTokens(tokenA, tokenB);
        IERC20[] memory tokens = new IERC20[](2);
        tokens[0] = token1;
        tokens[1] = token2;

        string memory symbol1 = token1.uniSymbol();
        string memory symbol2 = token2.uniSymbol();

        pool = new Reswap(
            tokens,
            string(abi.encodePacked("Reswap V1 (", symbol1, "-", symbol2, ")")),
            string(abi.encodePacked("RSWAP-V1-", symbol1, "-", symbol2))
        );

        pool.transferOwnership(owner());
        pools[token1][token2] = pool;
        pools[token2][token1] = pool;
        allPools.push(pool);
        isPool[pool] = true;

        emit Deployed(
            address(pool),
            address(token1),
            address(token2)
        );
    }

    function sortTokens(IERC20 tokenA, IERC20 tokenB) public pure returns(IERC20, IERC20) {
        if (tokenA < tokenB) {
            return (tokenA, tokenB);
        }
        return (tokenB, tokenA);
    }
}
