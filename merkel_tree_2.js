import {
  SimpleMerkleTree,
  StandardMerkleTree,
} from "@openzeppelin/merkle-tree";
import { keccak256 } from "@ethersproject/keccak256";
import fs from "fs";

const players = [
  ["0x328809Bc894f92807417D2dAD6b7C998c1aFdac6", 1],
  ["0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e", 2],
  ["0xea475d60c118d7058beF4bDd9c32bA51139a74e0", 3],
  ["0x671d2ba5bF3C160A568Aae17dE26B51390d6BD5b", 4],
  ["0xa959355654849CbEAbBf65235f8235833b9e031D", 5],
];

for (let i = 2; i <= 5; i++) {
  const tree = StandardMerkleTree.of(players.slice(0, i), [
    "address",
    "uint256",
  ]);
  console.log(tree.root);
  fs.writeFileSync(`tree_${i}.json`, JSON.stringify(tree.dump()));

  const tree2 = StandardMerkleTree.load(
    JSON.parse(fs.readFileSync(`tree_${i}.json`, "utf8"))
  );

  const proofs = [];
  for (const [i, v] of tree2.entries()) {
    const proof = tree2.getProof(i);
    proofs.push({
      i: i,
      value: v,
      proof: proof,
    });
  }

  fs.writeFileSync(`proof_${i}.json`, JSON.stringify(proofs));
}
