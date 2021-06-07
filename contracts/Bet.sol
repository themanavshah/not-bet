// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Bet {
    string public nameContract;
    address public owner;
    Game[] games;
    mapping(address => uint256) public balances;
    uint256 counter = 0;

    constructor(string memory name) public {
        nameContract = name;
    }

    struct Game {
        uint256 id;
        address creator;
        string home;
        string away;
        uint16 category;
        uint64 locktime;
        GameStatus status;
        Book book;
        GameResult result;
    }

    struct GameResult {
        int256 home;
        int256 away;
        uint256 timestamp;
    }

    struct Book {
        Bid[] overBids;
        Bid[] underBids;
        Bid[] bets;
    }

    struct Bid {
        address bidder;
        uint256 amount;
        bool over;
        int32 line;
    }

    struct BetStruct {
        address over;
        address under;
        int32 line;
        BetStatus status;
    }

    enum GameStatus {Open, Locked, Scored, Verified}
    enum BetStatus {Open, Paid}

    event GameCreated(
        uint256 indexed id,
        address indexed creator,
        string home,
        string away,
        uint16 indexed category,
        uint64 locktime
    );
    event BidPlaced(
        uint256 indexed game_id,
        address bidder,
        uint256 amount,
        bool over,
        int32 line
    );
    event BetPlaced(
        uint256 indexed game_id,
        address indexed user,
        bool over,
        uint256 amount,
        int32 line
    );
    event GameScored(
        uint256 indexed game_id,
        int256 homeScore,
        int256 awayScore,
        uint256 timestamp
    );
    event Withdrawal(address indexed user, uint256 amount, uint256 timestamp);

    function createGame(
        string memory home,
        string memory away,
        uint16 category,
        uint64 locktime
    ) public returns (int256) {
        uint256 id = counter;
        counter++;
        uint256 gamesLength = games.length;

        gamesLength += 1;
        Game memory game = games[gamesLength - 1];

        game.id = id;
        game.creator = msg.sender;
        game.home = home;
        game.away = away;
        game.category = category;

        game.locktime = locktime;
        game.status = GameStatus.Open;

        emit GameCreated(id, game.creator, home, away, category, locktime);
        return -1;
    }

    function bet() public {
        owner = msg.sender;
    }

    // function kill() public {
    //     require(msg.sender == owner, "Only owner can kill the contract");
    //     selfdestruct(owner);
    // }
}
