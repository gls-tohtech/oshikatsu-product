function chunk(array, size) {
  return array.reduce(
    (newarr, _, i) =>
    i % size ? newarr : [...newarr, array.slice(i, i + size)],
    []
  )
}

exports.chunk = chunk