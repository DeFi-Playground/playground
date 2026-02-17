pragma solidity ^0.8.0;

import { IERC3156FlashBorrower } from "./interfaces/IERC3156FlashBorrower.sol";
import { IERC3156FlashLender } from "./interfaces/IERC3156FlashLender.sol";
import { IERC20 } from "./interfaces/IERC20.sol";

error NotTrustedAddress();

contract FlashBorrower is IERC3156FlashBorrower {

  IERC3156FlashLender lender;
  address owner;

  constructor () {
    owner = msg.sender;
  }

  function setLender(
    address lender_
  ) external returns (address) {
    if (msg.sender != owner) revert NotTrustedAddress();

    lender = IERC3156FlashLender(lender_);
    return address(lender);
  }

  /// @dev ERC-3156 Flash loan callback
  function onFlashLoan(
    address initiator,
    address token,
    uint256 amount,
    uint256 fee,
    bytes calldata data
  ) external override returns(bytes32) {
    if (
      msg.sender != address(lender)
    ) revert NotTrustedAddress();

    // do something, but this time we do nothing

    return keccak256("ERC3156FlashBorrower.onFlashLoan");
  }

  /// @dev Initiate a flash loan
  function flashBorrow(
    address token,
    uint256 amount
  ) public {
    bytes memory data = abi.encode("");
    uint256 _allowance = IERC20(token).allowance(
      address(this),
      address(lender)
    );
    uint256 _fee = lender.flashFee(token, amount);
    uint256 _repayment = amount + _fee;
    IERC20(token).approve(
      address(lender),
      _allowance + _repayment
    );
    lender.flashLoan(this, token, amount, data);
  }

}
