# frozen_string_literal: true

module Fireblocks
  # Namespace to access Fireblocks api methods
  class API
    class << self
      def get_vault_accounts(params = {})
        path = '/v1/vault/accounts_paged'
        if params.any?
          query_string = URI.encode_www_form(params)
          path = "#{path}?#{query_string}"
        end

        Request.get(path: path)
      end

      def create_vault_account(name:, hidden: false, use_gas_station: false, idempotency_key: nil)
        Request.post(
          body: { name: name, hiddenOnUI: hidden, autoFuel: use_gas_station },
          headers: { 'Idempotency-Key' => idempotency_key },
          path: '/v1/vault/accounts'
        )
      end

      def get_vault_account(id)
        Request.get(path: "/v1/vault/accounts/#{id}")
      end

      def update_vault_account(vault_account_id, name:, idempotency_key:)
        Request.put(
          body: { name: name },
          headers: { 'Idempotency-Key' => idempotency_key },
          path: "/v1/vault/accounts/#{vault_account_id}"
        )
      end

      def get_vault_account_asset(vault_account_id, asset_id)
        Request.get(path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}")
      end

      def create_vault_account_asset(vault_account_id, asset_id, idempotency_key:)
        Request.post(
          body: {},
          headers: { 'Idempotency-Key' => idempotency_key },
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}"
        )
      end

      def create_deposit_address(vault_account_id, asset_id, description: nil, idempotency_key: nil)
        Request.post(
          body: { description: description },
          headers: { 'Idempotency-Key' => idempotency_key },
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}/addresses"
        )
      end

      def get_deposit_addresses(vault_account_id, asset_id)
        Request.get(
          path: "/v1/vault/accounts/#{vault_account_id}/#{asset_id}/addresses"
        )
      end

      def get_internal_wallet(wallet_id)
        Request.get(path: "/v1/internal_wallets/#{wallet_id}")
      end

      def get_internal_wallets
        Request.get(path: '/v1/internal_wallets')
      end

      def create_internal_wallet(name:, idempotency_key: nil)
        Request.post(
          body: { name: name },
          headers: { 'Idempotency-Key' => idempotency_key },
          path: '/v1/internal_wallets'
        )
      end

      def get_supported_assets
        Request.get(path: '/v1/supported_assets')
      end

      def create_transfer(amount:, asset_id:, external_id:, source:, destination:, idempotency_key: nil, note: '')
        Request.post(
          body: { operation: 'TRANSFER', externalTxId: external_id, amount: amount, assetId: asset_id,
                  source: source, destination: destination, note: note },
          headers: { 'Idempotency-Key' => idempotency_key },
          path: "/v1/transactions"
        )
      end
    end
  end
end
