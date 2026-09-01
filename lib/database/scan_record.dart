enum RecordSource {
  scan,
  generate;

  static RecordSource fromName(String? name) {
    return name == generate.name ? generate : scan;
  }
}

class ScanRecord {
  final int? id;
  final int timestamp;
  final String rawValue;
  final String format;
  final String contentType;
  final RecordSource source;

  const ScanRecord({
    this.id,
    required this.timestamp,
    required this.rawValue,
    required this.format,
    required this.contentType,
    this.source = RecordSource.scan,
  });

  bool get isGenerated => source == RecordSource.generate;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'raw_value': rawValue,
      'format': format,
      'content_type': contentType,
      'source': source.name,
    };
  }

  factory ScanRecord.fromMap(Map<String, dynamic> map) {
    return ScanRecord(
      id: map['id'] as int?,
      timestamp: map['timestamp'] as int,
      rawValue: map['raw_value'] as String,
      format: map['format'] as String? ?? 'unknown',
      contentType: map['content_type'] as String? ?? 'text',
      source: RecordSource.fromName(map['source'] as String?),
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);

  ScanRecord copyWith({int? id, RecordSource? source}) {
    return ScanRecord(
      id: id ?? this.id,
      timestamp: timestamp,
      rawValue: rawValue,
      format: format,
      contentType: contentType,
      source: source ?? this.source,
    );
  }
}
