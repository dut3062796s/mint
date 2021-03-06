/* Functions for the Set data structure which represents a set of unique values. */
module Set {
  /* Returns an empty set. */
  fun empty : Set(a) {
    `[]`
  }

  /*
  Converts the Set to an Array.

    (Set.empty()
    |> Set.add("value")
    |> Set.toArray()) == ["value"]
  */
  fun toArray (set : Set(a)) : Array(a) {
    `Array.from(#{set})`
  }

  /*
  Converts an Array to a Set.

    (Set.empty()
    |> Set.add("value")) == Set.fromArray(["value"])
  */
  fun fromArray (array : Array(a)) : Set(a) {
    try {
      unique =
        Array.uniq(array)

      `Array.from(#{unique})`
    }
  }

  /*
  Returns whether or not the given set has the given value.

    (Set.empty()
    |> Set.add(Maybe.just("value"))
    |> Set.has(Maybe.just("value"))) == true
  */
  fun has (value : a, set : Set(a)) : Bool {
    `
    (() => {
      for (let item of #{set}) {
        if (_compare(item, #{value})) {
          return true
        }
      }

      return false
    })()
    `
  }

  /*
  Adds the given value to the set.

    (Set.empty()
    |> Set.add("value")) == Set.fromArray(["value"])
  */
  fun add (value : a, set : Set(a)) : Set(a) {
    `
    (() => {
      if (#{has(value, set)}) { return #{set} }

      const newSet = Array.from(#{set})
      newSet.push(#{value})

      return newSet
    })()
    `
  }

  /*
  Deletes the given value from the set.

    (Set.empty()
    |> Set.add("value")
    |> Set.delete("value")) == Set.empty()
  */
  fun delete (value : a, set : Set(a)) : Set(a) {
    `
    (() => {
      const newSet = []

      #{set}.forEach((item) => {
        if (_compare(item, #{value})) { return }
        newSet.push(item)
      })

      return newSet
    })()
    `
  }

  /*
  Maps over the items of the set to return a new set.

    (Set.fromArray([0])
    |> Set.map(Number.toString)) == Set.fromArray(["0"])
  */
  fun map (method : Function(a, b), set : Set(a)) : Set(b) {
    `
    (() => {
      const newSet = []

      #{set}.forEach((item) => {
        newSet.push(#{method}(item))
      })

      return newSet
    })()
    `
  }

  /*
  Returns the size of a set

    Set.size(Set.fromArray([0,1,2])) == 3
  */
  fun size (set : Set(a)) : Number {
    `#{set}.length`
  }
}
