import Foundation

@Observable
final class TransactionsModel {
    private(set) var transactions: [GameTransaction] = []

    private let maxCount = 100

    func append(_ transaction: GameTransaction) {
        transactions.append(transaction)
        if transactions.count > maxCount {
            transactions.removeFirst(transactions.count - maxCount)
        }
    }
}
