/**
Croseus Challenge*/

pragma solidity >=0.4.25 <0.6.0;

contract AddrFinder{
        address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    address c = address(0x18C1eacb4Ee22DaD44276770ed0a887920c9cb08);

    function finder(uint8 nonce)
        public
        view
        onlyOwner
        returns (address)
    {
        uint8 a = 0xd6;
        uint8 b = 0x94;
        
        address computed = address(uint160(uint256(keccak256(abi.encodePacked(a, b, c, nonce)))));
        
        return computed;
    }

    function setAddr(address _c)
        public
        onlyOwner
        returns (address)
    {
        c = _c;
        
        return c;
    }
    
    function execute()
        public
        onlyOwner
    {
        CroesusFactory cf = CroesusFactory(c);
        
        cf.tryToWin("Hello!! It's Lubin :)");
    }
    
    function regularSend(address payable recipient)
        public
        payable
        onlyOwner
    {
        recipient.transfer(msg.value);
    }

    function () external {}
}


contract Croesus {
    constructor() public {
        require(address(this).balance > 0);
    }
}

contract CroesusFactory {
    mapping (address => bool) public winners;
    
    event LogWon(address indexed sender, address indexed croesus, bytes32 braggingRights);

    function tryToWin(bytes32 braggingRights) public {
        winners[msg.sender] = true;
        emit LogWon(msg.sender, address(new Croesus()), braggingRights);
    }
    
    function compute() public pure
        returns (address, address, address, address)
    {
        
        uint8 a = 0xd6;
        uint8 b = 0x94;
        
        address nonce0 = address(uint160(uint256(keccak256(abi.encodePacked(a, b, address(0x6AC7EA33F8831EA9dcC53393aAA88B25A785DBF0), uint8(0x80))))));
        address nonce1 = address(uint160(uint256(keccak256(abi.encodePacked(a, b, address(0x6AC7EA33F8831EA9dcC53393aAA88B25A785DBF0), uint8(0x01))))));
        address nonce2 = address(uint160(uint256(keccak256(abi.encodePacked(a, b, address(0x6AC7EA33F8831EA9dcC53393aAA88B25A785DBF0), uint8(0x02))))));
        address nonce3 = address(uint160(uint256(keccak256(abi.encodePacked(a, b, address(0x6AC7EA33F8831EA9dcC53393aAA88B25A785DBF0), uint8(0x03))))));
        
        return (nonce0, nonce1, nonce2, nonce3);
    }
}

