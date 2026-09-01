import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:qr_scanner/database/database_helper.dart';
import 'package:qr_scanner/database/scan_record.dart';
import 'package:qr_scanner/l10n/generated/app_localizations.dart';
import 'package:qr_scanner/scan/result_sheet.dart';
import 'package:qr_scanner/theme/caju_icons.dart';
import 'package:qr_scanner/theme/caju_style.dart';

Future<void> openHistoryPage(
  BuildContext context, {
  RecordSource source = RecordSource.scan,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => HistoryPage(source: source),
    ),
  );
}

class HistoryEntryButton extends StatelessWidget {
  const HistoryEntryButton({super.key, this.source = RecordSource.scan});

  final RecordSource source;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () => openHistoryPage(context, source: source),
      icon: const CajuAnimeIcon(kind: CajuIconKind.history, size: 26),
      tooltip: l10n.historyTab,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.source});

  final RecordSource source;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final ScrollController _scrollController = ScrollController();
  final List<ScanRecord> _records = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;
  static const _pageSize = 20;
  intl.DateFormat? _dateFormat;
  final ValueNotifier<bool> _loadingMore = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dateFormat ??= intl.DateFormat('yyyy-MM-dd HH:mm:ss');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _loadingMore.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMore || _isLoading || _loadingMore.value) return;
    if (_scrollController.position.extentAfter < 480) {
      _loadMoreRecords();
    }
  }

  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
      _currentPage = 0;
    });
    try {
      final records = await _dbHelper.getRecords(
        source: widget.source,
        limit: _pageSize,
        offset: 0,
      );
      final totalCount = await _dbHelper.getRecordCount(source: widget.source);
      if (!mounted) return;
      setState(() {
        _records
          ..clear()
          ..addAll(records);
        _hasMore = records.length < totalCount;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMoreRecords() async {
    if (_isLoading || _loadingMore.value || !_hasMore) return;
    _loadingMore.value = true;
    try {
      final nextPage = _currentPage + 1;
      final records = await _dbHelper.getRecords(
        source: widget.source,
        limit: _pageSize,
        offset: nextPage * _pageSize,
      );
      final totalCount = await _dbHelper.getRecordCount(source: widget.source);
      if (!mounted) return;
      setState(() {
        _records.addAll(records);
        _hasMore = _records.length < totalCount;
        _currentPage = nextPage;
      });
    } finally {
      _loadingMore.value = false;
    }
  }

  Future<void> _deleteRecord(ScanRecord record) async {
    if (record.id == null) return;
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteRecord),
        content: Text(l10n.deleteRecordConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _dbHelper.deleteRecord(record.id!);
    if (!mounted) return;
    setState(() => _records.removeWhere((item) => item.id == record.id));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.recordDeleted)));
  }

  Future<void> _deleteAllRecords() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAllRecords),
        content: Text(l10n.deleteAllRecordsConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _dbHelper.deleteAllRecords(source: widget.source);
    if (!mounted) return;
    setState(() {
      _records.clear();
      _hasMore = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.allRecordsDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = _dateFormat ?? intl.DateFormat('yyyy-MM-dd HH:mm:ss');
    final colorScheme = Theme.of(context).colorScheme;
    final scanning = widget.source == RecordSource.scan;
    final title = scanning ? l10n.scanHistoryTitle : l10n.generateHistoryTitle;

    return ColoredBox(
      color: colorScheme.surface,
      child: CajuWash(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const CajuAnimeIcon(kind: CajuIconKind.back, size: 26),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                  color: colorScheme.primary,
                ),
              ),
            ),
            actions: [
              if (_records.isNotEmpty)
                IconButton(
                  icon: const CajuAnimeIcon(kind: CajuIconKind.delete, size: 26),
                  onPressed: _deleteAllRecords,
                  tooltip: l10n.deleteAllRecords,
                ),
            ],
          ),
        body: _isLoading && _records.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : _records.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CajuAnimeIcon(
                      kind: scanning
                          ? CajuIconKind.scan
                          : CajuIconKind.generate,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noHistory,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
              onRefresh: _loadRecords,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: _records.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _records.length) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: _loadingMore,
                          builder: (context, loading, _) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const SizedBox(height: 28),
                            );
                          },
                        );
                      }
                      final record = _records[index];
                      return _HistoryTile(
                        record: record,
                        dateText: dateFormat.format(record.dateTime),
                        onOpen: () => showScanResultSheet(context, record),
                        onDelete: () => _deleteRecord(record),
                      );
                    },
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.record,
    required this.dateText,
    required this.onOpen,
    required this.onDelete,
  });

  final ScanRecord record;
  final String dateText;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Material(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onOpen,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: record.isGenerated
                      ? colorScheme.tertiary
                      : colorScheme.primary,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
              child: Row(
                children: [
                  CajuAnimeIcon(
                    kind: cajuIconForContent(record.contentType),
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.rawValue,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$dateText · ${record.format}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const CajuAnimeIcon(
                      kind: CajuIconKind.delete,
                      size: 26,
                    ),
                    tooltip: l10n.delete,
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
