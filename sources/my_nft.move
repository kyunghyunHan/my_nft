module my_nft::minting{
  use std::string::{Self, String};
  use std::vector;

  use aptos_token::token::{Self, TokenDataId};
  use aptos_framework::resource_account;
  use aptos_framework::account;
  use std::signer::{address_of};


  struct MyNft has key{
    signer_cap:account::SignerCapability,
    collection:String,
  }

  fun init_module(resource_account:&signer){

    //the collection name
    let collection_name= string::utf8(b"My NFT Collection");
    let description= string::utf8(b"NFT issued");
    let collection_uri= string::utf8(b"http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg");

    let maxium_supply= 1024;
    let mutate_setting= vector<bool>[false,false,false];

    let resource_signer_cap= resource_account::retrieve_resource_account_cap(resource_account,@deployer);
    let resource_signer= account::create_signer_with_capability(&resource_signer_cap);

    token::create_collection(&resource_signer,collection_name,description,collection_uri,maxium_supply,mutate_setting);

    move_to(resource_account,MyNft{
      signer_cap:resource_signer_cap,
      collection: collection_name,
    });

  }





public entry fun mint_nft(receiver:&signer)acquires MyNft{
  let receiver_addr= address_of(receiver);

  let nft_minter= borrow_global_mut<MyNft>(@my_nft);

  let resource_signer= account::create_signer_with_capability(&nft_minter.signer_cap);

  let resource_account_address= address_of(&resource_signer);

  let token_name= string::utf8(b"My NFT");

  let token_description= string::utf8(b"");
  let token_uri= string::utf8(b"http://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg");

    let token_data_id = token::create_tokendata(
      &resource_signer,
      nft_minter.collection,
      token_name,
      token_description,
      1,
      token_uri,
      resource_account_address,
      1,
      0,
      token::create_token_mutability_config(
        &vector<bool>[ false, false, false, false, true ]
      ),
      vector::empty<String>(),
      vector::empty<vector<u8>>(),
      vector::empty<String>(),
    );


    let token_id=  token::mint_token(&resource_signer,token_data_id,1);
    token::direct_transfer(&resource_signer,receiver,token_id,1);
}




}