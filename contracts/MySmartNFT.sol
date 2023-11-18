// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract MySmartNFT is  ERC721URIStorage {
    uint256 private _tokenIdTracker;

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
        _tokenIdTracker = 0; 
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIdTracker;
        _safeMint(msg.sender, newItemId);
        tokenURI(newItemId);
        _tokenIdTracker += 1; 
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        address owner = ownerOf(_tokenId);
        require(owner != address(0), "Token ID does not exist");
        console.log("An NFT w/ ID %s has been minted to %s", _tokenId, owner);
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                "PHN2ZyB3aWR0aD0iMzE3MyIgaGVpZ2h0PSIzMTE0IiB2aWV3Qm94PSIwIDAgMzE3MyAzMTE0IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8ZyBmaWx0ZXI9InVybCgjZmlsdGVyMF9kZl8xMTRfMjcpIj4KPHBhdGggZD0iTTIxMi45NzEgNjg5LjQ3NEwzMTU5LjMzIDE5NTYuMTlMMjk1Ny4wMyAyNDE5LjE1TDEwLjY2OTkgMTE1Mi40NEwyMTIuOTcxIDY4OS40NzRaIiBmaWxsPSJ1cmwoI3BhaW50MF9saW5lYXJfMTE0XzI3KSIvPgo8cGF0aCBkPSJNMzE2Mi4zOSAxOTU3LjE5QzMwOTEuMzMgMjI1Mi43IDI5MjkuNTEgMjUxOC4xIDI2OTcuMzkgMjcxOS44MUMyNDY1LjI4IDI5MjEuNTMgMjE3My4zIDMwNTAuNTEgMTg1OC4zNyAzMDkwLjQ0QzE1NDMuNDQgMzEzMC4zOCAxMjE5LjcyIDMwNzkuNDcgOTI4LjEyNyAyOTQ0LjE2QzYzNi41MzggMjgwOC44NCAzOTAuMTgyIDI1OTUuMjEgMjIwLjIxMyAyMzMwLjI2TDYzMC40NyAyMDk4LjIzQzc0OS40NDggMjI4My43IDkyMS44OTcgMjQzMy4yNCAxMTI2LjAxIDI1MjcuOTZDMTMzMC4xMiAyNjIyLjY4IDE1NTYuNzMgMjY1OC4zMSAxNzc3LjE4IDI2MzAuMzZDMTk5Ny42MyAyNjAyLjQxIDIyMDIuMDEgMjUxMi4xMiAyMzY0LjQ5IDIzNzAuOTJDMjUyNi45NyAyMjI5LjcyIDI2NDAuMjUgMjA0My45NCAyNjg5Ljk5IDE4MzcuMDhMMzE2Mi4zOSAxOTU3LjE5WiIgZmlsbD0idXJsKCNwYWludDFfbGluZWFyXzExNF8yNykiLz4KPHBhdGggZD0iTTI5NTUuMjYgNzgzLjQyQzI3ODUuMjkgNTE4LjQ3MiAyNTM4LjkzIDMwNC44MzQgMjI0Ny4zNCAxNjkuNTIyQzE5NTUuNzUgMzQuMjEwNCAxNjMyLjAzIC0xNi42OTggMTMxNy4xIDIzLjIzNDZDMTAwMi4xOCA2My4xNjcyIDcxMC4xOTQgMTkyLjE0NyA0NzguMDggMzkzLjg2NUMyNDUuOTY2IDU5NS41ODIgODQuMTQ0MiA4NjAuOTc3IDEzLjA3OSAxMTU2LjQ5TDQ4NS40NzYgMTI3Ni41OUM1MzUuMjIyIDEwNjkuNzQgNjQ4LjQ5NiA4ODMuOTU5IDgxMC45NzYgNzQyLjc1N0M5NzMuNDU2IDYwMS41NTUgMTE3Ny44NCA1MTEuMjY5IDEzOTguMjkgNDgzLjMxNkMxNjE4Ljc0IDQ1NS4zNjMgMTg0NS4zNSA0OTAuOTk5IDIwNDkuNDYgNTg1LjcxN0MyMjUzLjU3IDY4MC40MzYgMjQyNi4wMiA4MjkuOTgyIDI1NDUgMTAxNS40NUwyOTU1LjI2IDc4My40MloiIGZpbGw9InVybCgjcGFpbnQyX2xpbmVhcl8xMTRfMjcpIi8+CjwvZz4KPGRlZnM+CjxmaWx0ZXIgaWQ9ImZpbHRlcjBfZGZfMTE0XzI3IiB4PSIwLjY2Nzk2OSIgeT0iMCIgd2lkdGg9IjMxNzEuNzIiIGhlaWdodD0iMzExMy42OCIgZmlsdGVyVW5pdHM9InVzZXJTcGFjZU9uVXNlIiBjb2xvci1pbnRlcnBvbGF0aW9uLWZpbHRlcnM9InNSR0IiPgo8ZmVGbG9vZCBmbG9vZC1vcGFjaXR5PSIwIiByZXN1bHQ9IkJhY2tncm91bmRJbWFnZUZpeCIvPgo8ZmVDb2xvck1hdHJpeCBpbj0iU291cmNlQWxwaGEiIHR5cGU9Im1hdHJpeCIgdmFsdWVzPSIwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAxMjcgMCIgcmVzdWx0PSJoYXJkQWxwaGEiLz4KPGZlT2Zmc2V0Lz4KPGZlR2F1c3NpYW5CbHVyIHN0ZERldmlhdGlvbj0iMC41Ii8+CjxmZUNvbXBvc2l0ZSBpbjI9ImhhcmRBbHBoYSIgb3BlcmF0b3I9Im91dCIvPgo8ZmVDb2xvck1hdHJpeCB0eXBlPSJtYXRyaXgiIHZhbHVlcz0iMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMSAwIi8+CjxmZUJsZW5kIG1vZGU9Im5vcm1hbCIgaW4yPSJCYWNrZ3JvdW5kSW1hZ2VGaXgiIHJlc3VsdD0iZWZmZWN0MV9kcm9wU2hhZG93XzExNF8yNyIvPgo8ZmVCbGVuZCBtb2RlPSJub3JtYWwiIGluPSJTb3VyY2VHcmFwaGljIiBpbjI9ImVmZmVjdDFfZHJvcFNoYWRvd18xMTRfMjciIHJlc3VsdD0ic2hhcGUiLz4KPGZlR2F1c3NpYW5CbHVyIHN0ZERldmlhdGlvbj0iNSIgcmVzdWx0PSJlZmZlY3QyX2ZvcmVncm91bmRCbHVyXzExNF8yNyIvPgo8L2ZpbHRlcj4KPGxpbmVhckdyYWRpZW50IGlkPSJwYWludDBfbGluZWFyXzExNF8yNyIgeDE9IjE1MjYuMTMiIHkxPSIxMCIgeDI9IjE1MjYuMTMiIHkyPSIzMTAzLjY4IiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CjxzdG9wIHN0b3AtY29sb3I9IiMwMEYyNjAiLz4KPHN0b3Agb2Zmc2V0PSIwLjg1OTM3NSIgc3RvcC1jb2xvcj0iIzA1NzVFNiIvPgo8L2xpbmVhckdyYWRpZW50Pgo8bGluZWFyR3JhZGllbnQgaWQ9InBhaW50MV9saW5lYXJfMTE0XzI3IiB4MT0iMTUyNi4xMyIgeTE9IjEwIiB4Mj0iMTUyNi4xMyIgeTI9IjMxMDMuNjgiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj4KPHN0b3Agc3RvcC1jb2xvcj0iIzAwRjI2MCIvPgo8c3RvcCBvZmZzZXQ9IjAuODU5Mzc1IiBzdG9wLWNvbG9yPSIjMDU3NUU2Ii8+CjwvbGluZWFyR3JhZGllbnQ+CjxsaW5lYXJHcmFkaWVudCBpZD0icGFpbnQyX2xpbmVhcl8xMTRfMjciIHgxPSIxNTI2LjEzIiB5MT0iMTAiIHgyPSIxNTI2LjEzIiB5Mj0iMzEwMy42OCIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPgo8c3RvcCBzdG9wLWNvbG9yPSIjMDBGMjYwIi8+CjxzdG9wIG9mZnNldD0iMC44NTkzNzUiIHN0b3AtY29sb3I9IiMwNTc1RTYiLz4KPC9saW5lYXJHcmFkaWVudD4KPC9kZWZzPgo8L3N2Zz4K"
            )
        )
    }

}
