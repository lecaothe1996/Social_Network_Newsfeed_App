import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/action_like_comment_view.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final urlAvatar = ImageUtils.genImgIx(widget.post.user?.avatar?.url, 40, 40);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.dark,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.slate,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: urlAvatar,
                                  errorWidget: (_, __, ___) => Image.asset(
                                    AppAssetIcons.avatar,
                                    color: AppColors.blueGrey,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${widget.post.user?.firstName ?? ''} ${widget.post.user?.lastName ?? 'Người dùng'}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        MyIconButton(
                                          nameImage: AppAssetIcons.close,
                                          colorImage: AppColors.blueGrey,
                                          width: 20,
                                          height: 20,
                                          onTap: () {
                                            print('Click Close');
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      ConvertToTimeAgo.timeAgo(widget.post.createdAt ?? DateTime.now()),
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.h6.copyWith(color: AppColors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        widget.post.description!.isEmpty || widget.post.description == null
                            ? const SizedBox()
                            : ReadMoreText(
                                widget.post.description ?? '',
                                trimLines: 8,
                                colorClickableText: AppColors.blueGrey,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: '',
                                style: AppTextStyles.body,
                              ),
                      ],
                    ),
                  ),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      return ActionLikeCommentView(post: widget.post);
                    },
                  ),
                  const Divider(color: AppColors.slate),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.post.photos?.length,
                (context, index) {
                  final deviceWidth = MediaQuery.of(context).size.width;
                  final heightImage = ImageUtils.getHeightView(deviceWidth, widget.post.photos?[index].image?.orgWidth ?? 1,
                      widget.post.photos?[index].image?.orgHeight ?? 1);
                  final urlImage =
                      ImageUtils.genImgIx(widget.post.photos?[index].image?.url, deviceWidth.toInt(), heightImage.toInt());
                  if (heightImage >= deviceWidth * 3) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: deviceWidth * 3,
                      width: deviceWidth,
                      color: AppColors.slate,
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    height: heightImage,
                    width: deviceWidth,
                    color: AppColors.slate,
                    child: CachedNetworkImage(
                      imageUrl: urlImage,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
