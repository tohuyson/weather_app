import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/common/styles.dart';

import '../colors.dart';

class LoadMoreWidget extends StatefulWidget {
  const LoadMoreWidget({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
    this.refreshController,
    this.reverse = false,
    this.itemCount,
  });

  final Widget child;
  final Future Function()? onRefresh;
  final Future Function()? onLoadMore;
  final RefreshController? refreshController;
  final bool reverse;
  final int? itemCount;

  @override
  State<LoadMoreWidget> createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  late final RefreshController refreshController;

  get maxScrollExtent => refreshController.position?.maxScrollExtent ?? 0;

  get canLoadMoreGesture => maxScrollExtent > 0;

  @override
  void initState() {
    super.initState();
    refreshController = widget.refreshController ?? RefreshController();
  }

  @override
  void dispose() {
    if (widget.refreshController == null) {
      refreshController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadMoreWidget oldWidget) {
    if (refreshController.footerStatus == LoadStatus.noMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final triggerResetLoadMore = [
          widget.itemCount != oldWidget.itemCount,
          widget.itemCount == oldWidget.itemCount && canLoadMoreGesture,
        ];
        if (triggerResetLoadMore.any((e) => e == true)) {
          refreshController.resetNoData();
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      reverse: widget.reverse,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      onRefresh: () async {
        if (widget.onRefresh != null) {
          await widget.onRefresh!.call();
          refreshController.refreshCompleted(resetFooterState: true);
        }
      },
      onLoading: () async {
        if (widget.onLoadMore != null) {
          /// [true]: changed data
          /// [false]: not changed data
          final enabledLoadMore = await widget.onLoadMore!.call();
          if (enabledLoadMore is bool && enabledLoadMore) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        }
      },
      header: ClassicHeader(
        refreshStyle: RefreshStyle.UnFollow,
        refreshingText: 'Đang cập nhật',
        releaseIcon: Icon(Icons.arrow_upward, color: UIColors.defaultText),
        releaseText: 'Thả để cập nhật ngay',
        completeIcon: Icon(Icons.done, color: UIColors.defaultText),
        completeText: 'Tải dữ liệu thành công',
        idleIcon: Icon(Icons.arrow_downward, color: UIColors.defaultText),
        idleText: 'Kéo để tải dữ liệu mới nhất',
        failedIcon: Icon(Icons.error, color: UIColors.defaultText),
        failedText: 'Tải dữ liệu thất bại',
        textStyle: UITextStyle.regular,
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          if (mode == LoadStatus.loading) {
            Widget body = const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(UIColors.primaryColor)),
            );
            return SizedBox(height: 32, child: Center(child: body));
          }
          return const SizedBox();
        },
      ),
      child: widget.child,
    );
  }
}
