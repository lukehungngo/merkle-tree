// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {VerifyMerkle, Leaf} from "../src/VerifyMerkle.sol";

contract TestVerifyMerkle is Test {
    VerifyMerkle public verifyMerkle;
    address alice = makeAddr("alice"); // 0x328809Bc894f92807417D2dAD6b7C998c1aFdac6
    address bob = makeAddr("bob"); // 0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e
    address charlie = makeAddr("charlie"); // 0xea475d60c118d7058beF4bDd9c32bA51139a74e0
    address david = makeAddr("david"); // 0x671d2ba5bF3C160A568Aae17dE26B51390d6BD5b
    address eve = makeAddr("eve"); // 0xa959355654849CbEAbBf65235f8235833b9e031D

    function setUp() public {}

    function test_VerifyMerkle_2() public {
        verifyMerkle = new VerifyMerkle(0x6cfe3ce5882fc05fb02e83cd80730e89f91c5227afb96d51bfd1bfc23650740b);
        bytes32[] memory proof = new bytes32[](1);
        proof[0] = 0x51c4b9a3cc313d7d7325f2d5d9e782a5a484e56a38947ab7eea7297ec86ff138;
        Leaf memory leaf = Leaf({player: bob, index: 2});

        bool result = verifyMerkle.verify(leaf, proof);
        assertEq(result, true);
    }

    function test_VerifyMerkle_3() public {
        verifyMerkle = new VerifyMerkle(0x8f51f338740520ec4d8551873768dc91bc573636d2c897642f7e68992b3271a5);
        bytes32[] memory proof = new bytes32[](1);
        proof[0] = 0x6cfe3ce5882fc05fb02e83cd80730e89f91c5227afb96d51bfd1bfc23650740b;
        Leaf memory leaf = Leaf({player: charlie, index: 3});

        bool result = verifyMerkle.verify(leaf, proof);
        assertEq(result, true);
    }

    function test_VerifyMerkle_4() public {
        verifyMerkle = new VerifyMerkle(0x53c81b7742045a962221578a98df80f2fee48e530170ab75481b6c79da8aa7e8);
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0xbfc59f2ee12ed1a64983b8a44397df3583a76c950551568959ac1978e3c5b191;
        proof[1] = 0xbf44222b2d62771316636306bf359285c72e3dbbccec607d6c780ea6c295f882;
        Leaf memory leaf = Leaf({player: charlie, index: 3});

        bool result = verifyMerkle.verify(leaf, proof);
        assertEq(result, true);
    }

    function test_VerifyMerkle_5_4() public {
        verifyMerkle = new VerifyMerkle(0xde2d967c2485ded2fe13751236768cacd3977ffea76aac1ab57a1e141ac331f6);
        bytes32[] memory proof = new bytes32[](3);
        proof[0] = 0x51c4b9a3cc313d7d7325f2d5d9e782a5a484e56a38947ab7eea7297ec86ff138;
        proof[1] = 0xcfcdb3bc45b7d7ab8a137019d4893361c0036d85df68e648706f4a887c26bba2;
        proof[2] = 0x25004dff47a4adc10116a128d8e0c0f0748f6e4c257fd89d888ed9a7147c322f;
        Leaf memory leaf = Leaf({player: david, index: 4});

        bool result = verifyMerkle.verify(leaf, proof);
        assertEq(result, true);
    }

    function test_VerifyMerkle_5_5() public {
        verifyMerkle = new VerifyMerkle(0xde2d967c2485ded2fe13751236768cacd3977ffea76aac1ab57a1e141ac331f6);
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0xbfc59f2ee12ed1a64983b8a44397df3583a76c950551568959ac1978e3c5b191;
        proof[1] = 0x2e43b676a8dc00f05f4e826ba8642bb6827c0699b7611310b74de01fe8d211a3;
        Leaf memory leaf = Leaf({player: eve, index: 5});

        bool result = verifyMerkle.verify(leaf, proof);
        assertEq(result, true);
    }
}
