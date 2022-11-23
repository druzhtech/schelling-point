// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract SchellingToken {
    uint256 block_number;

    // отправка хеша значения
    function hash_submit() public {
        if (block.number % 100 < 50) {}
    }

    // отправка прообраза хеша-значения
    function value_submit() public {}

    function balance_request() public {}

    // запрос собранных значений
    function value_request() public {}
}
