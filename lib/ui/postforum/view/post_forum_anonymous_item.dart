import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ui/postforum/viewmodel/post_forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';

/// 发帖匿名item
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumAnonymousItem extends StatelessWidget {
  const PostForumAnonymousItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SelectorView<PostForumViewModel, bool>(
        selector: (ctx, viewModel) => viewModel.model.isAnonymous,
        builder: (ctx, isAnonymous, _) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                child: Icon(
                  isAnonymous ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              const Text(
                StringAssets.anonymousPost,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Spacer(),
              Switch(
                value: isAnonymous,
                onChanged: (value) {
                  context.read<PostForumViewModel>().setIsAnonymous(value);
                },
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
