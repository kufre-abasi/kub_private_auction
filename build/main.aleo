program kub_private_auction.aleo;

record Bid:
    owner as address.private;
    bidder as address.private;
    amount as u64.private;
    is_winner as u8.private;

function place_bid:
    input r0 as address.private;
    input r1 as u64.private;
    assert.eq self.caller r0;
    gt r1 0u64 into r2;
    assert.eq r2 true;
    cast aleo1etcfylxvf5waf3crajnjn440gqm0pyder84sfqxgqtqyy4pcc58s0y8anf r0 r1 0u8 into r3 as Bid.record;
    output r3 as Bid.record;

function resolve:
    input r0 as Bid.record;
    input r1 as Bid.record;
    assert.eq self.caller aleo1etcfylxvf5waf3crajnjn440gqm0pyder84sfqxgqtqyy4pcc58s0y8anf;
    gte r0.amount r1.amount into r2;
    cast r0.owner r0.bidder r0.amount 0u8 into r3 as Bid.record;
    not r2 into r4;
    cast r1.owner r1.bidder r1.amount 0u8 into r5 as Bid.record;
    ternary r2 r3.owner r5.owner into r6;
    ternary r2 r3.bidder r5.bidder into r7;
    ternary r2 r3.amount r5.amount into r8;
    ternary r2 r3.is_winner r5.is_winner into r9;
    cast r6 r7 r8 r9 into r10 as Bid.record;
    output r10 as Bid.record;

function finish:
    input r0 as Bid.record;
    assert.eq self.caller aleo1etcfylxvf5waf3crajnjn440gqm0pyder84sfqxgqtqyy4pcc58s0y8anf;
    cast r0.bidder r0.bidder r0.amount 0u8 into r1 as Bid.record;
    output r1 as Bid.record;
