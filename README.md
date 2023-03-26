# Swift Record Generator

A record is a collection of named data elements. In Swift 4, records can be implemented using

- tuples
- dictionaries (`[String : AnyObject]`)
- structs (possibly with Copy-on-Write)
- classes

`generator` randomly builds a record schema and implements the same schema using each data structure. The code is saved in the `generated` project, which can run the following performance tests:

- "initializing" a new record instance from a given list of random values
- retrieving values of elements
- mutating values of elements
- passing records as function arguments
- serializing records to JSON
- deserializing records from JSON
- sorting a random array of records

## Limitations

- The schema randomization is controlled by hard-coded constants in the `main.swift` files of each project.

- Tuples are only really meant for lightweight records of up to 6 elements, so they are not included in these tests.

- A "mutation" test on a constant is done by copying it to a variable first, then modifying the variable. (The only exception is for class instances, whose elements are mutable even if the instance is constant.)

- For each test, only the mean time taken per run is reported.

## Quick Start

1.  clone this repository
2.  change the working directory to the root folder of this repository
3.  build and run the `generator` project
4.  choose your desired build settings for the **Generated** project at `generated/Generated.xcodeproj`.
5.  Run the **Generated** project.

If you choose to have verbose output, below is a result of a sample run of the _Swift Record Generator_. `SANITY_CHECKS_ENABLED: true` indicates that there will be a fatal crash if a record's data is observed to be inconsistent with the program's expectations at any point.

> `(let)` refers to a record instance stored in a constant.
>
> `(var)` refers to a record instance stored in a variable.

```
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
```
