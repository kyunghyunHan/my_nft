use aptos_sdk::crypto::ed25519::Ed25519PrivateKey;
use aptos_sdk::types::account_address::AccountAddress;
use aptos_sdk::types::chain_id::ChainId;
use aptos_sdk::types::{LocalAccount, account_address::create_resource_address};
use aptos_sdk::{bcs, rest_client};
use aptos_sdk::{transaction_builder::TransactionBuilder};
use framework::{BuildOptions, BuiltPackage};
use cached_packages::aptos_stdlib;
use std::borrow::BorrowMut;
use std::path::PathBuf;
use url::Url;
use anyhow::{Context, Result};
use std::time::{SystemTime, UNIX_EPOCH};
use std::env;

#[tokio::main]
fn main() {
    println!("Hello, world!");
}
