import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/postforum/viewmodel/post_forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 发帖标签item
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumTabItem extends StatelessWidget {
  const PostForumTabItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      color: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: () {
          context.read<PostForumViewModel>().showTabPicker();
        },
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
              child: Image.asset(
                ImageAssets.imgTab,
                width: 20,
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Text(
              StringAssets.tab,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Spacer(),
            SelectorView<PostForumViewModel, String>(
              selector: (ctx, viewModel) => viewModel.model.tab,
              builder: (ctx, tab, _) => Text(
                tab,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.navigate_next),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
