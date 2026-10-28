# TILT Denominations

Whisper uses UNINSTALL (TILT) on Polygon for blockchain payments.

- TILT: Human-readable token amount.
- TILT Dust: Smallest indivisible token unit.
- 1 TILT = 1,000,000,000,000,000,000 TILT Dust (18 decimals).
- Smart contracts and blockchain APIs use integer TILT Dust amounts.
- Interfaces display human-readable TILT amounts with explicit units.
- Oracle proofs must identify amounts as TILT Dust, never ambiguous raw numbers.
- Water, Wood, and other game resources are off-chain inventory units, not TILT Dust.

Example: 100 TILT = 100000000000000000000 TILT Dust.
