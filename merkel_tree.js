const keccak256 = require("keccak256");
const { default: MerkleTree } = require("merkletreejs");

const address = [
  "0x328809bc894f92807417d2dad6b7c998c1afdac6",
  "0x1d96f2f6bef1202e4ce1ff6dad0c2cb002861d3e",
  "0xea475d60c118d7058bef4bdd9c32ba51139a74e0",
  "1",
];

const buf2Hex = (x) => "0x" + x.toString("hex");

//  Hashing All Leaf Individual
const leaves = address.map((leaf) => keccak256(leaf));
console.log(buf2Hex(leaves[0]));
console.log(buf2Hex(leaves[1]));
console.log(buf2Hex(leaves[2]));
// Constructing Merkle Tree
const tree = new MerkleTree(leaves, keccak256);

//  Utility Function to Convert From Buffer to Hex

// Get Root of Merkle Tree
console.log(`Here is Root Hash: ${buf2Hex(tree.getRoot())}`);

let data = [];

// Pushing all the proof and leaf in data array
address.forEach((address) => {
  const leaf = keccak256(address);

  const proof = tree.getProof(leaf);

  let tempData = [];

  proof.map((x) => tempData.push(buf2Hex(x.data)));

  data.push({
    address: address,
    leaf: buf2Hex(leaf),
    proof: tempData,
  });
});

// Create WhiteList Object to write JSON file

let whiteList = {
  whiteList: data,
};

const fs = require("fs");

//  Stringify whiteList object and formating
const metadata = JSON.stringify(whiteList, null, 2);

// Write whiteList.json file in root dir
fs.writeFile(`whiteList.json`, metadata, (err) => {
  if (err) {
    throw err;
  }
});
