// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

struct Leaf {
    address player;
    uint256 index;
}

contract VerifyMerkle {
    bytes32 public root;

    constructor(bytes32 _root) {
        root = _root;
    }

    function verify(Leaf memory leaf, bytes32[] memory proof) public view returns (bool) {
        return MerkleProof.verify(proof, root, keccak256(bytes.concat(keccak256(abi.encode(leaf.player, leaf.index)))));
    }
}
