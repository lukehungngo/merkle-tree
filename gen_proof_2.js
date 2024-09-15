import {
  SimpleMerkleTree,
  StandardMerkleTree,
} from "@openzeppelin/merkle-tree";
import { keccak256 } from "@ethersproject/keccak256";
import fs from "fs";

// (1)
const tree2 = StandardMerkleTree.load(
  JSON.parse(fs.readFileSync("tree.json", "utf8"))
);

// (2)
for (const [i, v] of tree2.entries()) {
  const proof = tree2.getProof(i);
  console.log("Value:", v);
  console.log("Proof:", proof);
}
