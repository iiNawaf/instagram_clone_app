import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/home/post_viewmodel.dart';
import 'package:instagram_clone_app/widgets/home/post_caption.dart';
import 'package:instagram_clone_app/widgets/home/post_like_btn.dart';
import 'package:instagram_clone_app/widgets/home/post_likes_number.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_img.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_username.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';

final postViewModelProvider = ChangeNotifierProvider((ref) {
  return PostViewModel(ref);
});

class PostView extends HookConsumerWidget {
  final String id;
  final String userId;
  const PostView({super.key, required this.id, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(postViewModelProvider);
    viewModel.postOwnerData = useState({});
    viewModel.isLoading = useState(false);
    viewModel.isInit = useState(true);
    if (viewModel.isInit!.value) {
      useEffect(() {
        viewModel.isLoading!.value = true;
        if (viewModel.isInit!.value) {
          Future.microtask(() async {
            await viewModel.fetchPostOwnerData(userId);
            viewModel.isLoading!.value = false;
          });
          viewModel.isInit!.value = false;
        }
        return () {
          print("disp");
        };
      });
    }
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(),
      ),
      body: viewModel.isLoading!.value
          ? Container()
          : Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.marginValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingMedium,
                        left: AppDimensions.paddingMedium),
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: PostOwnerImg(
                          imgUrl: viewModel.postOwnerData!.value['profileImageUrl'],
                        ),
                        title: PostOwnerUsername(
                          username: viewModel.postOwnerData!.value['username'],
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: AppDimensions.marginValue),
                    height: 300,
                    color: AppColors.containerBgColor,
                    child: Image.network(
                      viewModel.post(id).imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          right: AppDimensions.paddingMedium,
                          left: AppDimensions.paddingMedium),
                      margin: const EdgeInsets.only(
                          bottom: AppDimensions.marginValue),
                      child: PostLikeBtn(
                        btnAction: () {},
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                          right: AppDimensions.paddingMedium,
                          left: AppDimensions.paddingMedium),
                      child: PostLikesNumber(
                        number: 100,
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingMedium,
                        left: AppDimensions.paddingMedium),
                    child: PostCaption(
                      username: "Username",
                      caption: viewModel.post(id).caption,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
