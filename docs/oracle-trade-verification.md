# Whisper Oracle Trade Verification Requirements

Every finalized trade MUST record:
- Unique trade ID and verified buyer/seller EVM address.
- Polygon chain ID and exact TILT ERC-20 contract address.
- TILT payment amount as an integer in TILT Dust.
- Confirmed payment transaction hash, event log index, block height, and block hash.
- Resource type, unique ApeLevel Whisper Oracle resource identifier, and mapping version valid at trade execution.
- Authenticated in-game production evidence and inventory reservation reference.
- Oracle verification status, settlement status, and signed proof reference.

Polygon mainnet TILT contract: 0x3eB7e262a9246B877aF7aed3f0F6a80Bebb3AcE0.
Never conflate the TILT payment token address with a resource identifier or resource-specific Oracle contract address.
Resources remain off-chain; a Polygon transfer alone does not establish resource authenticity.
Reject missing, mismatched, duplicated, replayed, or unconfirmed payment and resource proofs.
Preserve historical identifier mappings so later changes cannot rewrite the meaning of completed trades.
Public logs must contain only sanitized verification evidence, never credentials or sensitive player-session data.
