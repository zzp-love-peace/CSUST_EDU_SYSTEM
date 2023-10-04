import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ui/school/jsonbean/school_notice_bean.dart';
import 'package:csust_edu_system/ui/school/model/school_model.dart';
import 'package:csust_edu_system/ui/school/view/school_function_bar_view.dart';
import 'package:csust_edu_system/ui/school/view/school_img_swiper_view.dart';
import 'package:csust_edu_system/ui/school/view/school_notice_item_view.dart';
import 'package:csust_edu_system/ui/school/viewmodel/school_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/lottie/none_lottie.dart';

/// 校园页
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SchoolViewModel(model: SchoolModel()))
      ],
      child: const SchoolHome(),
    );
  }
}

/// 校园页Home
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolHome extends StatelessWidget {
  const SchoolHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectorView<SchoolViewModel, List<SchoolNoticeBean>>(
      onInit: (viewModel) {
        viewModel.initNoticeAndBannerData(StuInfo.cookie);
      },
      selector: (ctx, viewModel) => viewModel.model.noticeList,
      builder: (ctx, noticeList, child) {
        return Scaffold(
          appBar: CommonAppBar.create(
            StringAssets.school,
            actions: [
              if (noticeList.isEmpty)
                IconButton(
                  onPressed: () {
                    ctx.read<SchoolViewModel>().getNoticeList(StuInfo.cookie);
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                )
            ],
          ),
          body: ListView(
            children: [
              const SchoolImgSwiperView(),
              const SchoolFunctionBarView(),
              const Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 0, 15),
                child: Text(
                  StringAssets.schoolAnnouncement,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              noticeList.isNotEmpty
                  ? Column(
                      children: _mapToNoticeItemList(noticeList),
                    )
                  : const Column(
                      children: [
                        NoneLottie(hint: StringAssets.schoolError),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }

  /// 将noticeList转化为NoticeItemViewList
  ///
  /// [noticeList] 教务通知list
  List<Widget> _mapToNoticeItemList(List<SchoolNoticeBean> noticeList) =>
      noticeList
          .map((notice) => SchoolNoticeItemView(schoolNoticeBean: notice))
          .toList();
}
