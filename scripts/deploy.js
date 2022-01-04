const main = async () => {
    signer = await hre.ethers.getSigner()
    const ownerAddress = signer.address
    const pokerGameFactory = await hre.ethers.getContractFactory('PokerGame');
    const pokerGameContract = await pokerGameFactory.deploy();
    await pokerGameContract.deployed();
    console.log('Contract deployed to:', pokerGameContract.address);





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