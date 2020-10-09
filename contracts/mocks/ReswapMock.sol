// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../Reswap.sol";


contract FactoryMock is IFactory {
    uint256 private _fee;

    function fee() external view override returns(uint256) {
        return _fee;
    }

    function setFee(uint256 newFee) external {
        _fee = newFee;
    }
}


contract ReswapMock is Reswap {
    constructor(IERC20[] memory assets, string memory name, string memory symbol)
        public Reswap(assets, name, symbol)
    {
        factory = new FactoryMock();
    }
}
