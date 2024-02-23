extension DuplicatesRemover on List {
  List<dynamic> get removeDuplicates {
    return this.toSet().toList();
  }
}