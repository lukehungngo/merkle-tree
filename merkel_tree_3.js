import {
  SimpleMerkleTree,
  StandardMerkleTree,
} from "@openzeppelin/merkle-tree";
import { keccak256 } from "@ethersproject/keccak256";
import fs from "fs";

let players = [];
try {
  let data = fs.readFileSync("./array.json", "utf8");
  data = JSON.parse(data);
  console.log(data);
  players = data.map((item) => [
    item.Player,
    item.TokenID,
    item.TxHash,
    item.Kill,
  ]);
} catch (err) {
  console.error(err);
}

console.log(players);
const tree = StandardMerkleTree.of(players, [
  "address",
  "uint256",
  "bytes",
  "uint256",
]);

console.log(tree.root);

fs.writeFileSync(`array.tree.json`, JSON.stringify(tree.dump()));

const proofs = [];
for (const [i, v] of tree.entries()) {
  const proof = tree.getProof(i);
  proofs.push({
    i: i,
    value: v,
    proof: proof,
  });
}

fs.writeFileSync(`array.proof.json`, JSON.stringify(proofs));
