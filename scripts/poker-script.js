const main = async () => {
    signer = await hre.ethers.getSigner()
    const ownerAddress = signer.address
    const pokerGameFactory = await hre.ethers.getContractFactory('PokerGame');
    const pokerGameContract = await pokerGameFactory.deploy();
    await pokerGameContract.deployed();
    console.log('Contract deployed to:', pokerGameContract.address);

    //  call function
    let amount = 100000;
  
    let result;

    // let txn0 = await pokerGameContract.generatePlayerHand()
    // let txn1 = await pokerGameContract.generateDealerHand()

    // let hand1 = await pokerGameContract.getHand()
    // let receipt1 = await hand1.wait()
    // console.log(receipt1.events[0].args)
    // // let receipt = await txn.wait()
    // // console.log(receipt.events[0].args)
    // let txn2 = await pokerGameContract.generatePlayerHand()
    // let txn3 = await pokerGameContract.generateDealerHand()
    // let hand2 = await pokerGameContract.getHand()
    // let receipt2 = await hand2.wait()
    // await pokerGameContract.setAmount(amount)

    // result = await pokerGameContract.getPlayerApprovedAmount()
    // console.log(result.toString())

  

    result = await pokerGameContract.getGameDetails()
    // result = await pokerGameContract.getPlayerApprovedAmount()
    console.log(result.toString())

    // await pokerGameContract.rewardWinner("player")
    // result = await pokerGameContract.getPlayerApprovedAmount()
    // console.log(result.toString())

    


    // let receipt1 = await txn1.wait()
    // console.log(receipt1.events[0].args)


};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();