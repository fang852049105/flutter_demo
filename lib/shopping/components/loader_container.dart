import 'package:flutter/material.dart';
import 'package:flutter_demo/shopping/config/loader_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loading_dialog.dart';

class LoaderContainer extends StatelessWidget {
  final LoaderState loaderState;
  final Widget loadingView;
  final Widget errorView;
  final Widget emptyView;
  final Widget contentView;
  final Function onReload;

  LoaderContainer({
    Key key,
    @required this.contentView,
    this.loadingView,
    this.errorView,
    this.emptyView,
    @required this.loaderState,
    this.onReload,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (loaderState) {
      case LoaderState.loading:
        currentWidget = loadingView ?? _ClassicalLoadingView();
        break;
      case LoaderState.fail:
        currentWidget = errorView ??
            _ClassicalErrorView(
              onReload: () => onReload(),
            );
        break;
      case LoaderState.empty:
        currentWidget = emptyView ?? _ClassicalEmptyView();
        break;
      case LoaderState.success:
      case LoaderState.noAction:
        currentWidget = contentView;
        break;
      default:
        currentWidget = emptyView ?? _ClassicalEmptyView();
        break;
    }
    return currentWidget;
  }
}

class _ClassicalLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingDialog(
        text: "加载中...",
      ),
    );
  }
}

class _ClassicalErrorView extends StatelessWidget {
  _ClassicalErrorView({@required this.onReload}) : super();

  final Function onReload;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setHeight(1000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('加载失败，请稍后点击重试'),
          RaisedButton(
            color: Colors.white70,
            child: Text('点击重试',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 14
              ),
            ),
            onPressed: onReload
          )
        ],
      ),
    );
  }
}

class _ClassicalEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('暂无相关数据 '),
    );
  }
}
