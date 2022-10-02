// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract History {

    struct Document{
        string _hash;
        string message;
        uint datetime;
    }

    mapping (address => Document[]) public entries;
    mapping (string  => Document) public documents;


    function addDocument( string memory _hash, string memory message ) public {
        
        Document memory doc = Document({
            _hash: _hash,
            message: message,
            datetime: block.timestamp
        });

        documents[_hash] = doc;
        entries[msg.sender].push(doc);
    }

    function getDocumentOf(address anAddress) public view returns( Document [] memory){
        return entries[anAddress];
    }


}