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

  fun init_module(){}
}