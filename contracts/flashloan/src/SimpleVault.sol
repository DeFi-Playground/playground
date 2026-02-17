// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0 || ^0.8.0;

import {IERC3156FlashLender} from "./interfaces/IERC3156FlashLender.sol";
import {IERC3156FlashBorrower} from "./interfaces/IERC3156FlashBorrower.sol";
import {IERC20} from "./interfaces/IERC20.sol";

error TransferFailed();
error AmountInvalid();
error NoBalance();
error NotTrustedAddress();
error OnFlashLoanFailed();

contract SimpleVault is IERC3156FlashLender {

  bytes32 public constant CALLBACK_SUCCESS = keccak256("ERC3156FlashBorrower.onFlashLoan");
  address public trustedReceiver;

  constructor(
    address _trustedReceiver
  ) {
    trustedReceiver = _trustedReceiver;
  }

  /*
   * @dev Alternative approach to send ERC20 balance to this contract
   * @param token The token address
   * @param amount The amount of token
   * @return The amount pulled from `msg.sender`
   */
  function deposit(
    address token,
    uint256 amount
  ) external returns (uint256) {
    bool success = IERC20(token).transferFrom(msg.sender, address(this), amount);
    if (!success) revert TransferFailed();
  }

  function maxFlashLoan(
    address token
  ) external view override returns (uint256) {
    return IERC20(token).balanceOf(address(this));
  }

  function flashFee(
    address token,
    uint256 amount
  ) external view override returns (uint256) {
    // 1% from the amount
    if (amount == 0) return 0;
    if (amount < 100) return 0;

    return _flashFee(amount);
  }

  function _flashFee(
    uint256 amount
  ) internal view returns (uint256) {
    return amount / 100;
  }

  function flashLoan(
    IERC3156FlashBorrower receiver,
    address token,
    uint256 amount,
    bytes calldata data   
  ) external override returns (bool) {
    if (
      IERC20(token).balanceOf(address(this)) == 0
    ) revert NoBalance();
    if (amount == 0) revert AmountInvalid();
    if (
      msg.sender != trustedReceiver
    ) revert NotTrustedAddress();

    uint256 fee = _flashFee(amount);
    
    // transfer token
    bool sendSuccess = IERC20(token).transfer(
      msg.sender,
      amount
    );
    if (!sendSuccess) revert OnFlashLoanFailed();

    bytes32 onFlashLoanResult = receiver.onFlashLoan(
      msg.sender,
      token,
      amount,
      fee,
      data
    );
    if (onFlashLoanResult != CALLBACK_SUCCESS) revert OnFlashLoanFailed();

    // pull token
    bool pullSuccess = IERC20(token).transferFrom(msg.sender, address(this), amount + fee);
    if (!pullSuccess) revert TransferFailed();

    return true;
  }

}
