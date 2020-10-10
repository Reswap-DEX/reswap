pragma solidity ^0.6.0;
interface IReswapFactory {
  function MAX_FEE (  ) external view returns ( uint256 );
  function allPools ( uint256 ) external view returns ( address );
  function fee (  ) external view returns ( uint256 );
  function isPool ( address ) external view returns ( bool );
  function pools ( address, address ) external view returns ( address );
}
