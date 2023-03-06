import SwiftUI
import XCTest
@testable import Cache

final class CacheTests: XCTestCase {
    func testCacheString() throws {
        enum CacheKey {
            case text
        }

        let cache: Cache<CacheKey, String> = Cache(
            initialValues: [
                .text: "Hello, World!"
            ]
        )

        let cachedValue: String = try XCTUnwrap(cache.get(.text))

        XCTAssertEqual(cachedValue, "Hello, World!")
    }

    func testCacheImage() throws {
        let cache: Cache<URL, Image> = Cache()

        let imageURL = try XCTUnwrap(URL(string: "test-image"))

        XCTAssertNil(cache.get(imageURL))

        cache.set(value: Image(systemName: "circle"), forKey: imageURL)

        XCTAssertNotNil(cache.get(imageURL))

        cache.remove(imageURL)

        XCTAssertNil(cache.get(imageURL))
    }

    func testCacheObjectInheritance() throws {
        class ParentObject {
            let value: String

            init(value: String) {
                self.value = value
            }
        }

        class SubclassObject: ParentObject { }

        let expectedValue = "subclass"
        let key = UUID()

        let cache: Cache<AnyHashable, ParentObject> = Cache()

        cache.set(value: SubclassObject(value: expectedValue), forKey: key)

        let subclassObject: SubclassObject = try XCTUnwrap(cache.get(key))

        XCTAssertEqual(subclassObject.value, expectedValue)
    }

    func testJSON() throws {
        enum MockJSONKey: String, Hashable {
            case name, number, bool, invalid_key
        }

        struct MockJSON: Codable {
            var name: String
            var number: Int
            var bool: Bool
        }

        let jsonData: Data = try! JSONEncoder().encode(MockJSON(name: "OpenBytes", number: 5, bool: false))

        var json: JSON<MockJSONKey> = JSON(data: jsonData)

        XCTAssertEqual(try json.resolve(.name), "OpenBytes")
        XCTAssertEqual(try json.resolve(.number), 5)
        XCTAssertEqual(try json.resolve(.bool), false)

        XCTAssertEqual(json.valuesInCache(ofType: String.self).count, 1)
        XCTAssertEqual(json.valuesInCache(ofType: Int.self).count, 2)
        XCTAssertEqual(json.valuesInCache(ofType: Bool.self).count, 1)

        let invalid_key: Bool? = json.get(.invalid_key)

        XCTAssertNil(json.get(.invalid_key))
        XCTAssertNil(invalid_key)

        json.set(value: "Leif", forKey: .name)

        XCTAssertEqual(try json.resolve(.name), "Leif")
    }
}
