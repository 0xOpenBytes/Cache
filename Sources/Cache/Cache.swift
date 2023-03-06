import c

/**
 A convenience subclass of `c.Cache`.

 To use the cache, create an instance of `Cache` with the desired key and value types. You can then use the `set(_:forKey:)` method to add items to the cache, and the `get(_:)` or `resolve(_:)` method to retrieve items from the cache.

 ```swift
 let cache = Cache<String, Int>()
 cache.set(42, forKey: "answer")
 let answer = cache.get("answer") // answer == 42
 ```
*/
open class Cache<Key: Hashable, Value>: c.Cache<Key, Value> { }
