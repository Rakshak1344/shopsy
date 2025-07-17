import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginatedGridView<T> extends StatefulWidget {
  final List<T> items;
  final AsyncCallback onRefresh;
  final AsyncValueSetter<int?> updatePageNumber;
  final Widget Function(T) buildItem;
  final String noMoreItemsText;
  final bool hasMore;

  /// Defines the layout of the grid, such as the number of columns.
  /// This is a required parameter for a grid.
  final SliverGridDelegate gridDelegate;

  /// Optional padding around the grid.
  final EdgeInsetsGeometry? padding;

  const PaginatedGridView({
    super.key,
    required this.items,
    required this.onRefresh,
    required this.updatePageNumber,
    required this.noMoreItemsText,
    required this.buildItem,
    required this.hasMore,
    required this.gridDelegate, // Added parameter
    this.padding = const EdgeInsets.all(8.0), // Default padding
  });

  @override
  State<PaginatedGridView<T>> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listenOnScrollController);
    // The initial fetch is commented out to prevent duplicate calls,
    // assuming the parent widget triggers the first fetch.
    // Uncomment if you want this widget to trigger the initial load.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.updatePageNumber(1);
    // });
  }

  /// Listens to the scroll position to fetch more data when the user
  /// reaches the end of the grid.
  Future<void> listenOnScrollController() async {
    // Fetches more items when the user scrolls to the bottom.
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await widget.updatePageNumber(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      // The ListView.builder is replaced with GridView.builder.
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        padding: widget.padding,
        // The new gridDelegate parameter is used here.
        gridDelegate: widget.gridDelegate,
        itemCount: widget.items.length + 1,
        itemBuilder: (context, i) {
          if (i < widget.items.length) {
            // Builds each grid item.
            return widget.buildItem(widget.items[i]);
          } else {
            // Builds the indicator at the end of the grid.
            return buildLoadingOrNoMoreItem();
          }
        },
      ),
    );
  }

  /// Builds the widget at the bottom of the grid, showing a loading
  /// indicator if more items are available, or the "no more items" text otherwise.
  /// Note: This will occupy a single grid cell.
  Widget buildLoadingOrNoMoreItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Visibility(
          visible: widget.hasMore,
          replacement: Text(widget.noMoreItemsText),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(listenOnScrollController);
    scrollController.dispose();
  }
}