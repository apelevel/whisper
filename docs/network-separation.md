# Whisper Network Separation

Every Oracle trade record MUST explicitly identify TESTNET or MAINNET.

Polygon Amoy TESTNET: chain ID 80002, verified test TILT contract address.
Polygon MAINNET: chain ID 137, TILT contract 0x3eB7e262a9246B877aF7aed3f0F6a80Bebb3AcE0.

Every record MUST include:
- network: TESTNET or MAINNET
- chainId: exact EVM chain ID
- tokenAddress: verified token contract on that chain
- walletAddress: authenticated EVM address
- transactionHash and transactionLogIndex
- blockNumber and blockHash
- amountTiltDust: integer token amount
- resourceOracleId and resourceMappingVersion
- productionProofReference and tradeId
- publicationCommit and settlementStatus

Publish testnet and mainnet proofs in separate ledger paths.
Never accept testnet payments as mainnet payments.
Never reuse a proof or settlement authorization across chain IDs.
Bind signed commitments, trade IDs and replay protection to the chain ID and token contract.
The Oracle MUST verify network identity through blockchain evidence before final settlement.
Mainnet authorization must remain disabled until explicitly approved.
