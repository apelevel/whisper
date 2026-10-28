# Whisper Oracle Publication Gate

MANDATORY: No confirmed public audit record means no final trade authorization.

1. Verify the wallet, trade, Polygon payment, and genuine off-chain resource evidence.
2. Reserve required funds and inventory without finalizing settlement.
3. Generate a unique, signed, sanitized Oracle trade proof.
4. Publish the proof to the official ApeLevel Whisper public GitHub repository.
5. Verify the exact published record, commit SHA, repository identity, and proof contents.
6. Only after successful publication may the Oracle authorize final settlement.

GitHub rate limits, outages, and API failures must never bypass this gate.
Pending trades remain AWAITING_PUBLICATION until publication succeeds or a safe cancellation/reconciliation process completes.
Use durable queues, idempotent trade identifiers, rate-limit-aware retries, and batching where appropriate.
Provide safe reservation expiration, refunds, and reconciliation for irreversible Polygon payments.
Maintain narrowly scoped permanent automated publishing permissions.
Publishing a record is not independent proof that an off-chain resource is genuine.
Never publish wallet-session secrets, private keys, or sensitive private-server data.
