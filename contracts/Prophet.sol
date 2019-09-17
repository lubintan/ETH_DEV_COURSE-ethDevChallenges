// Nostradamus Challenge

pragma solidity 0.5.10;



contract Nostradamus {
    function prophecise(bytes32 exact, bytes32 braggingRights) public 
    {}

    function prophets() public pure
    {}


}

contract Prophet{
    
    Nostradamus nos;
    
    address nosAddr = address(0x8A879BCCd75B9cb17cc9DC9a69820A794cae0b1E);
    address owner;

	event LogSplit(address indexed sender, address indexed accountA, address indexed accountB, uint256 value);
	event LogWithdrawal(address indexed account, uint256 indexed value);
	event LogView(address indexed account, uint256 indexed value);



	constructor() 
		public 
	{
        nos = Nostradamus(nosAddr);
        owner = msg.sender;
    }

    function prophecise()
        public
    {
        require(msg.sender == owner);
        uint blockNumber = block.number;
        bytes32 blockHash = blockhash(blockNumber);
        bytes32 exact = keccak256(abi.encodePacked(this, blockNumber, blockHash, block.timestamp, nosAddr));
        bytes32 comments = bytes32("Hello! Lubin here :)");

        nos.prophecise(exact, comments);
    }

    function () 
        external
        {
        revert();
        }
}
