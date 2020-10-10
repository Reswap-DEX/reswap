// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
import "./libraries/UniERC20.sol";
import "./interfaces/IReswapFactory.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract ReswapHelper{
    using UniERC20 for IERC20;
    using SafeMath for uint256;

    struct PoolData{
        address pool;
        uint256 balanceA;
        uint256 balanceB;
    }


    function getPoolData ( address factory, address tokenA, address tokenB ) public view returns ( address pool,uint256 balanceA,uint256 balanceB ){
        IReswapFactory reswap = IReswapFactory(factory);
        PoolData memory poolData;
        poolData.pool = reswap.pools(tokenA,tokenB);
        poolData.balanceA = simpleGetBalance(tokenA,poolData.pool);
        poolData.balanceB = simpleGetBalance(tokenB,poolData.pool);
        return (poolData.pool,poolData.balanceA,poolData.balanceB);
    }


    function simpleGetBalance(address tokenAddr,address addrToGet) public view returns (uint256){
        IERC20 iToken = IERC20(tokenAddr);
        return iToken.uniBalanceOf(addrToGet);
    }

    function  getPoolDataList(address factory, address[] calldata tokenAList, address[] calldata tokenBList) public view returns (address[] memory pools,uint256[] memory balanceA,uint256[] memory balanceB){
        address[] memory poolsx;
        uint256[] memory balanceAx;
        uint256[] memory balanceBx;
        for(uint256 i=0;i<tokenAList.length;i++){
            (poolsx[i],balanceAx[i],balanceBx[i]) = getPoolData(factory,tokenAList[i],tokenBList[i]);
        }
        return (poolsx,balanceAx,balanceBx);
    }
}
