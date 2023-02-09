module my_nft::minting{
  use std::string::{Self, String};
  use std::vector;

  use aptos_token::token::{Self, TokenDataId};
  use aptos_framework::resource_account;
  use aptos_framework::account;



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

    let resourse_signer_cap= resource_account::retrieve_resource_account_cap(resource_account,@deployer);
    let resourse_signer= account::create_signer_with_capability(&resourse_signer_cap);

    token::create_collection(&resourse_signer,collection_name,description,collection_uri,maxium_supply,mutate_setting);

    move_to(resource_account,MyNft{
      signer_cap:resourse_signer_cap,
      collection: collection_name,
    });

  }
}