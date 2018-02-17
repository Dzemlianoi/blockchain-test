class ManagementController < ApplicationController
  def sync
    SyncService.call
  end

  def add_link
    node = Node.new(node_params)
    node.save ? success_response : failure_response({ entity: node })
  end

  def add_transaction
    transaction = Transaction.new(transaction_params)
    transaction.save ? success_response : failure_response({ entity: transaction })
  end

  def status
    render json: StatusService.call
  end

  private

  def transaction_params
    params.permit(:from, :to, :amount)
  end

  def node_params
    params.permit(:id, :url)
  end
end
