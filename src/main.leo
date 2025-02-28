program kub_private_auction.aleo {
// A bid in an auction.
    // - owner     : The address of the account that owns the record associated with this bid.
    // - bidder    : The address of the account that placed the bid.
    // - amount    : The amount of the bid.
    // - is_winner : Whether the bid is the winning bid.
    record Bid {
        owner: address,
        bidder: address,
        amount: u64,
    is_winner: u8,  // Use u8 instead of bool
    }

    // Auction runner's address (hardcoded as required)
    const AUCTION_RUNNER: address = aleo1etcfylxvf5waf3crajnjn440gqm0pyder84sfqxgqtqyy4pcc58s0y8anf;

    // Places a bid in the auction.
    // - bidder : The address of the account that placed the bid.
    // - amount : The amount of the bid.
    // Ensures that only the bidder can place their own bid.
    transition place_bid(bidder: address, amount: u64) -> Bid {
        // Ensure the caller is the auction bidder.
        assert_eq(self.caller, bidder);

        // Ensure the bid amount is greater than zero.
     assert(amount > 0u64);
        
        // Return a new 'Bid' record for the auction.
        return Bid {
            owner: AUCTION_RUNNER,  // Auction runner owns the bid during the auction.
            bidder: bidder,
            amount: amount,
        is_winner: 0u8,  // Explicitly use 0u8 instead of 0
        };
    }

    // Resolves the winning bid between two bids.
    // - first  : The first bid.
    // - second : The second bid.
    // Ensures that only the auction runner can call this function.
    // In the event of a tie, the first bid is selected.
    transition resolve(first: Bid, second: Bid) -> Bid {
    // Ensure the caller is the auctioneer.
    assert_eq(self.caller, AUCTION_RUNNER);

    // Determine the highest bid and return it.
    if first.amount >= second.amount {
        return Bid {
            owner: first.owner,
            bidder: first.bidder,
            amount: first.amount,
            is_winner: 0u8,  // Ensure 0u8 is used
        };
    } else {
        return Bid {
            owner: second.owner,
            bidder: second.bidder,
            amount: second.amount,
            is_winner: 0u8,  // Ensure 0u8 is used
        };
    }
}

    // Transfers ownership of the winning bid to the winning bidder.
    // - bid : The winning bid.
    // Ensures that only the auction runner can call this function.
    transition finish(bid: Bid) -> Bid {
        // Ensure the caller is the auctioneer.
        assert_eq(self.caller, AUCTION_RUNNER);

        // Update and return the bid with ownership transferred to the bidder.
        return Bid {
            owner: bid.bidder,  // Winner now owns the bid.
            bidder: bid.bidder,
            amount: bid.amount,
        is_winner: 0u8,  // Use 0u8 instead of false
        };
    }
}

// program auction.aleo {
//     // A bid in an auction.
//     // - `owner`     : The address of the account that owns the record associated with this bid.
//     //                 This is separate from the address of the account that placed the bid.
//     // - `bidder`    : The address of the account that placed the bid.
//     // - `amount`    : The amount of the bid.
//     // - `is_winner` : Whether the bid is the winning bid.
//     record Bid {
//         owner: address,
//         bidder: address,
//         amount: u64,
//         is_winner: bool,
//     }

//     // Returns a new bid.
//     // - `bidder` : The address of the account that placed the bid.
//     // - `amount` : The amount of the bid.
//     // Requires that `bidder` matches the function caller.
//     // The owner of the record is set to the entity responsible for running the auction (auction runner).
//     // The address of the auction runner is aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg.
//     transition place_bid(bidder: address, amount: u64) -> Bid {
//         // Ensure the caller is the auction bidder.
//         assert_eq(self.caller, bidder);
//         // Return a new 'Bid' record for the auction bidder.
//         return Bid {
//             owner: aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg,
//             bidder: bidder,
//             amount: amount,
//             is_winner: false,
//         };
//     }

//     // Returns the winning bid.
//     // - `first`  : The first bid.
//     // - `second` : The second bid.
//     // Requires that the function caller is the auction runner.
//     // Assumes that the function is invoked only after the bidding period has ended.
//     // In the event of a tie, the first bid is selected.
//     transition resolve(first: Bid, second: Bid) -> Bid {
//         // Ensure the caller is the auctioneer.
//         assert_eq(self.caller, aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg);
//         // Resolve the winner of the auction.
//         if (first.amount >= second.amount) {
//             return first;
//         } else {
//             return second;
//         }
//     }

//     // Returns ownership of the bid to bidder.
//     // - `bid` : The winning bid.
//     // Requires that the function caller is the auction runner.
//     // Assumes that the function is invoked only after all bids have been resolved.
//     transition finish(bid: Bid) -> Bid {
//         // Ensure the caller is the auctioneer.
//         assert_eq(self.caller, aleo1ashyu96tjwe63u0gtnnv8z5lhapdu4l5pjsl2kha7fv7hvz2eqxs5dz0rg);
//         // Return 'is_winner' as 'true' in the winning 'Bid'.
//         return Bid {
//             owner: bid.bidder,
//             bidder: bid.bidder,
//             amount: bid.amount,
//             is_winner: true,
//         };
//     }
// }

