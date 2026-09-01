enum ContentKind {
  url,
  wifi,
  phone,
  email,
  sms,
  geo,
  product,
  contact,
  isbn,
  text,
}

class ParsedContent {
  const ParsedContent({
    required this.kind,
    required this.rawValue,
    this.title,
    this.extras = const {},
  });

  final ContentKind kind;
  final String rawValue;
  final String? title;
  final Map<String, String> extras;

  String get contentType => kind.name;
}

ParsedContent parseContent(String raw, {String? hintedType}) {
  final value = raw.trim();
  final lower = value.toLowerCase();
  final hinted = hintedType?.toLowerCase();

  if (hinted == 'url' ||
      lower.startsWith('http://') ||
      lower.startsWith('https://')) {
    return ParsedContent(kind: ContentKind.url, rawValue: value);
  }
  if (hinted == 'wifi' || lower.startsWith('wifi:')) {
    return ParsedContent(
      kind: ContentKind.wifi,
      rawValue: value,
      extras: _parseWifi(value),
    );
  }
  if (hinted == 'phone' || lower.startsWith('tel:')) {
    return ParsedContent(
      kind: ContentKind.phone,
      rawValue: value,
      extras: {
        'number': value.replaceFirst(
          RegExp(r'^tel:', caseSensitive: false),
          '',
        ),
      },
    );
  }
  if (hinted == 'email' ||
      lower.startsWith('mailto:') ||
      lower.startsWith('matmsg:')) {
    return ParsedContent(kind: ContentKind.email, rawValue: value);
  }
  if (hinted == 'sms' ||
      lower.startsWith('smsto:') ||
      lower.startsWith('sms:')) {
    return ParsedContent(kind: ContentKind.sms, rawValue: value);
  }
  if (hinted == 'geo' || lower.startsWith('geo:')) {
    return ParsedContent(kind: ContentKind.geo, rawValue: value);
  }
  if (hinted == 'contactinfo' ||
      lower.startsWith('begin:vcard') ||
      lower.startsWith('mecard:')) {
    return ParsedContent(kind: ContentKind.contact, rawValue: value);
  }
  if (hinted == 'isbn') {
    return ParsedContent(kind: ContentKind.isbn, rawValue: value);
  }
  if (hinted == 'product' || RegExp(r'^\d{8,14}$').hasMatch(value)) {
    return ParsedContent(kind: ContentKind.product, rawValue: value);
  }
  return ParsedContent(kind: ContentKind.text, rawValue: value);
}

Map<String, String> _parseWifi(String raw) {
  final extras = <String, String>{};
  final body = raw.replaceFirst(RegExp(r'^WIFI:', caseSensitive: false), '');
  for (final part in body.split(';')) {
    if (part.isEmpty) continue;
    final index = part.indexOf(':');
    if (index <= 0) continue;
    final key = part.substring(0, index).toUpperCase();
    final value = part.substring(index + 1);
    if (key == 'S') extras['ssid'] = value;
    if (key == 'P') extras['password'] = value;
    if (key == 'T') extras['encryption'] = value;
  }
  return extras;
}

String wifiPayload({
  required String ssid,
  required String password,
  required String encryption,
}) {
  final type = encryption == 'nopass' ? 'nopass' : encryption;
  final pass = type == 'nopass' ? '' : password;
  return 'WIFI:T:$type;S:$ssid;P:$pass;;';
}
