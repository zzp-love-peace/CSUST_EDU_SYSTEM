import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ui/schoolnotice/model/school_notice_model.dart';
import 'package:csust_edu_system/ui/schoolnotice/viewmodel/school_notice_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

///学校通知页
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8

class SchoolNoticePage extends StatelessWidget {
  /// 学校通知id
  final String ggid;

  const SchoolNoticePage(this.ggid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => SchoolNoticeViewModel(model: SchoolNoticeModel()),
      )
    ], child: SchoolNoticeHome(ggid));
  }
}

/// 学校通知页Home
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8

class SchoolNoticeHome extends StatelessWidget {
  /// 学校通知id
  final String ggid;

  const SchoolNoticeHome(this.ggid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.schoolNotice),
      body: SingleChildScrollView(
        child: ConsumerView<SchoolNoticeViewModel>(
          onInit: (viewModel) {
            viewModel.initSchoolNoticePageData(StuInfo.cookie, ggid);
          },
          builder: (context, viewModel, _) {
            return HtmlWidget(viewModel.model.html);
          },
        ),
      ),
    );
  }
}
