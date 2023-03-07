import c

/**
 `JSON` is a generic struct that provides a convenient way to parse and manipulate JSON data. It uses the `c` library to parse and serialize JSON data.

 To create a `JSON` object, pass a `Data` object that contains JSON data to the `init(data:)` method. You can then use the `get(_:)` or `resolve(_:)` method to extract individual values from the JSON data.

```swift
let jsonData = "{\"name\": \"John Doe\", \"age\": 42}".data(using: .utf8)!
let json = JSON<MockJSONKey>(data: jsonData)

let name: String = try json.resolve(.name)
let age: Int = try json.resolve(.age)
```

 You can also use the `set(value:forKey:)` method to update the values in the JSON object, and the `get(_:)` or `resolve(_:)` method to retrieve the values from the object.

```swift
json.set(value: "Jane Doe", forKey: .name)
let newName: String = try json.resolve(.name)
```
*/
public typealias JSON = c.JSON
