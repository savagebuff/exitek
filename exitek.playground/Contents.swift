// Exitek iOS Developer Tech Task
//
// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

// MARK: - Model

struct Mobile: Hashable {
    let imei: String
    let model: String
}

// MARK: - MobileStorageProtocol

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

// MARK: - MobileStorageEmpl

final class MobileStorageEmpl: MobileStorage {

    // MARK: - Private Properties

    private enum MemoryError: Error {
        case badSaving
        case badDelete
    }

    private var mobiles: Dictionary<String, Mobile> = [:]

    // MARK: - Methods

    func getAll() -> Set<Mobile> {
        return Set<Mobile>(mobiles.values)
    }

    func findByImei(_ imei: String) -> Mobile? {
        return mobiles[imei]
    }

    func save(_ mobile: Mobile) throws -> Mobile {
        guard !exists(mobile) else { throw MemoryError.badSaving }
        mobiles[mobile.imei] = mobile

        return mobile
    }

    func delete(_ product: Mobile) throws {
        guard exists(product) else { throw MemoryError.badDelete }
        mobiles[product.imei] = nil
    }

    func exists(_ product: Mobile) -> Bool {
        return mobiles[product.imei] != nil
    }
}
