# Whisper Treasury Architecture

TILT is the on-chain ERC-20 payment token. All token quantities in contracts are denominated in integer TILT Dust (18 decimals).
Water, Wood, and other resources remain off-chain in the authoritative RAGE REALMZ game inventory.
The treasury must never mint, store, or transfer ERC-1155 game resources.
The treasury must validate the expected Polygon chain and configured TILT contract.
Each settlement requires a unique trade ID and authorized Oracle settlement instruction.
The Oracle must verify resource production, wallet ownership, inventory reservations, payment evidence, and the correct historical resource identifier.
No final trade authorization is permitted before the signed public audit proof has been published and its repository, commit, and contents verified.
Settlement instructions must prevent replay, double payment, and unauthorized withdrawals.
Enforce spending budgets, treasury reserve floors, transaction limits, and emergency pause controls.
Start with Polygon Amoy and test TILT. Do not authorize mainnet transfers until explicitly approved.
