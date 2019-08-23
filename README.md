# Swift-Record-Generator
Version 1.2

Twin Xcode projects that generate and run performance tests on different record data structure implementations in Swift.

Feel free to dig through the source code and modify this project to extend its capabilities in any way your curiosity sees fit.

## Background

"Record" is a name familiar with databases. Here, it refers very broadly to Robert Sebesta's definition: "an aggregate of data elements in which the individual elements are identified by names." Swift tuples, dictionaries (`String` to `AnyObject`), structures, and classes all satisfy this definition. It would be useful to know which performs best, and how much better they perform.

*Swift Record Generator* aims to produce random raw speed tests on the basic functions that developers expect their records to have. **Generator** houses the code that randomly generates a list of elements and sets up a record implementation using those elements for each of the data structures it tests. The code is saved in the **Generated** project, where following tests can be run on the main thread:

 - "Initializing" a new record instance from a given list of random values
 - Retrieving values of elements
 - Mutating values of elements
 - Passing records as function arguments
 - Serializing records to JSON
 - Deserializing records from JSON
 - (BONUS) Sorting a random array of records

The tests are highly configurable, including options for:

- The number of elements defined in the record
- The number of times each test is run before averaging the result
- The size of the array that gets sorted
- Element name lengths
- Element types (and the distribution of those types)
	- Currently supported: `Int`, `UInt`, `Double`, `Bool`, `String`, `Date`
	- Each type can be optional or non-optional, the element type of an array, or  the value type of a `String`-keyed dictionary
- Element mutability
  
### *Caveats

 - Tuples are only really meant for lightweight records of up to 6 elements, so they are not included in these tests.

 - Structures may be further augmented with Copy-On-Write (COW), which is evaluated separately in these tests.

- *Swift Record Generator*'s sorting tests sort by the first element of the record. Sorting when the first element is of type Bool is not yet implemented. In such a case, it's usually easiest to run the **Generator** again.

- Since you can make your tests as heavy as you want (and doing so is an active choice), the *Swift Record Generator* will not be held responsible for melted CPUs.

- When the program runs a mutation test on a constant, it does so by copying the constant to a variable first, with the exception of a class. Mutable elements of constant class instances are still mutable, so copying is not necessary.

- Although times are measured to the nanosecond, the *Swift Record Generator* does not yet have a way to indicate how much the times vary. Only the first two significant digits should be considered. It is also suspected that all time measurements are overestimates, since starting and stopping the measurement also takes time.

## How to Use

 1. Place the entire folder in the user directory. You can also place it in any other directory as long as you adjust the **Generator**'s `GENERATOR_PATH` setting to point directly to the `Generated/Generated/Generated` folder.
 2. Run the **Generator** project at `Generator/Generator.xcodeproj`.
 3. Choose your desired build settings on the **Generated** project at `Generated/Generated.xcodeproj`.
 4. Run the **Generated** project.

If you choose to have verbose output, below is a result of a sample run of the *Swift Record Generator*. `SANITY_CHECKS_ENABLED: true`  indicates that there will be a fatal crash if a record's data is observed to be inconsistent with the program's expectations at any point.

`(let)` refers to a record instance stored in a constant.
`(var)` refers to a record instance stored in a variable.

            ELEMENT_COUNT: 16
    MUTABLE_ELEMENT_COUNT: 3
               TEST_COUNT: 256
               ARRAY_SIZE: 256
         ARRAY_TEST_COUNT: 16
    
        MAX_STRING_LENGTH: 64
          MIN_NAME_LENGTH: 4
          MAX_NAME_LENGTH: 24
      MAX_COLLECTION_SIZE: 16
        
    SANITY_CHECKS_ENABLED: true
        
    ELEMENTS:
    let rk3kkwfz46cguu1: [Date]
    var b0yjdl3stwqzi0rvcfwpt: [String : Double]?
    let m0rp91: String
    let ed8de04k2fx5nqdv0hf_sw: Int
    let urtedt0kcjfl5ml7wh: [String : Int]
    let ghjxupry5fzo38d42v2bz: [Bool]
    let jqluo1fzkwxnc0t1kvs: [String]
    let byrrquq5e: [Int]
    let _8uybhb6b1i18aahc1: [String : String]
    let jkaav8ts69oe: Int
    let r5he1u4sepvqehupah0a57js: [String : Int]
    let npzv53sg46gh04mew: String
    let ug0ca43e7w2: Double
    var m3sjahsez: Int
    let qb526mnbzr7_: Double
    var k0jz8190pgda31q_xty: [String : Int]
        
    MEAN TIME TO HASH A DICTIONARY KEY
    153.33740234375 ns
        
    MEAN TIME TO INITIALIZE, PER ELEMENT
       dictionary (let): 6472.580322265625 ns
       dictionary (var): 7429.5634765625 ns
        structure (let): 15.75927734375 ns
        structure (var): 22.759765625 ns
    COW structure (let): 74.70068359375 ns
    COW structure (var): 89.839599609375 ns
            class (let): 52.75927734375 ns
            class (var): 54.389892578125 ns
        
    MEAN TIME TO RETRIEVE AN ELEMENT
       dictionary (let): 19630.7578125 ns
       dictionary (var): 21008.837646484375 ns
        structure (let): 15.383544921875 ns
        structure (var): 14.359619140625 ns
    COW structure (let): 276.404541015625 ns
    COW structure (var): 278.75341796875 ns
            class (let): 22.0751953125 ns
            class (var): 23.7880859375 ns
        
    MEAN TIME TO MUTATE AN ELEMENT
       dictionary (let): 1859.8229166666667 ns
       dictionary (var): 1822.2135416666667 ns
        structure (let): 104.95182291666667 ns
        structure (var): 35.83203125 ns
    COW structure (let): 791.94140625 ns
    COW structure (var): 758.60546875 ns
            class (let): 599.4791666666666 ns
            class (var): 659.69140625 ns
        
    MEAN TIME TO PASS AS FUNCTION ARGUMENT
       dictionary (let): 45.6640625 ns
       dictionary (var): 78.92578125 ns
        structure (let): 41.9453125 ns
        structure (var): 159.90234375 ns
    COW structure (let): 45.4609375 ns
    COW structure (var): 62.578125 ns
            class (let): 159.3359375 ns
            class (var): 61.80078125 ns
    
    MEAN TIME TO SERIALIZE TO JSON, PER ELEMENT
       dictionary (let): 7595.759765625 ns
       dictionary (var): 7470.516357421875 ns
        structure (let): 23144.01416015625 ns
        structure (var): 23278.771484375 ns
    COW structure (let): 23699.650146484375 ns
    COW structure (var): 23269.886474609375 ns
            class (let): 23194.10888671875 ns
            class (var): 23470.774169921875 ns
        
    MEAN TIME TO DESERIALIZE FROM JSON, PER ELEMENT
       dictionary (let): 7563.54541015625 ns
       dictionary (var): 7710.93359375 ns
        structure (let): 29372.016845703125 ns
        structure (var): 29071.224609375 ns
    COW structure (let): 29380.45947265625 ns
    COW structure (var): 29096.40283203125 ns
            class (let): 28830.109130859375 ns
            class (var): 30130.084716796875 ns
        
    MEAN TIME TO SORT ARRAY OF 256 RECORDS
       dictionary (let): 31345303.125 ns
       dictionary (var): 30099811.5625 ns
        structure (let): 1881485.0625 ns
        structure (var): 1787431.0 ns
    COW structure (let): 2681041.8125 ns
    COW structure (var): 2612785.625 ns
            class (let): 521543.75 ns
            class (var): 505356.3125 ns
    
    GLOBAL COUNTER: 165888
    Program ended with exit code: 0

## Acknowledgements

Thank you to the iOS team at Osellus Inc. for inspiring and supporting this project. I hope you will find the results useful.

## References

Sebesta, R. W. (2016). _Concepts of Programming Languages_ (11th ed.). Harlow: Pearson
