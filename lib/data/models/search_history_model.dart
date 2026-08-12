class SearchHistory {
  final int id;
  final String query;
  final DateTime searchDate;
  final int resultCount;

  SearchHistory({
    required this.id,
    required this.query,
    required this.searchDate,
    required this.resultCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
      'searchDate': searchDate.toIso8601String(),
      'resultCount': resultCount,
    };
  }

  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['id'] as int,
      query: map['query'] as String,
      searchDate: DateTime.parse(map['searchDate'] as String),
      resultCount: map['resultCount'] as int,
    );
  }
}
