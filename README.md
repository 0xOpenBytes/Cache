# Cache

Cache is a simple in-memory key-value store that provides thread-safe access to its contents. It is used for storing frequently used data that takes time or resources to compute. When a value is added to the cache, it is stored in memory and can be retrieved quickly on subsequent accesses.

## Usage

To use the Cache, first create an instance with the desired key and value types. You can then use the set(_:forKey:) method to add items to the cache, and the get(_:) method to retrieve items from the cache.

```swift
let cache = Cache<String, Int>()
cache.set(42, forKey: "answer")
let answer = cache.get("answer") // answer == 42
```

The Cache also supports removal of items from the cache using the remove(_:) method. To remove all items from the cache, use the clear() method.

```swift
let cache = Cache<String, Int>()
cache.set(42, forKey: "answer")
cache.remove("answer")
let answer = cache.get("answer") // answer == nil
```

### Thread Safety

The Cache is designed to be thread-safe, allowing multiple threads to access and modify the cache without the risk of data races.
