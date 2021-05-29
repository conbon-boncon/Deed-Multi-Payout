const DeedMultiPayout = artifacts.require('DeedMultiPayout');

contract('DeedMultiPayout', (accounts)=>{
    let deedMultiPayout = null;

    before(async () => {
        deedMultiPayout = await DeedMultiPayout.deployed();
      });

    it('Should not withdraw if caller is not beneficiary', async()=>{
        console.log("HI");
        const deedMultiPayout = await DeedMultiPayout.new(accounts[0], accounts[1], 3, {value:100});
        try{
            await deedMultiPayout.withdrawMoney({from: accounts[0]});
        }catch(e){
            assert(e.message.includes("Only beneficiary can withdraw money"));
            return;
        }
        assert(false);
    });
});