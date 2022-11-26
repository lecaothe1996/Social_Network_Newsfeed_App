import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_utils.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class DetailPostScreen extends StatelessWidget {
  final List<Post> photos;

  const DetailPostScreen({
    Key? key,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlAvatar = ImageUtils.genImgIx(photos[0].user?.avatar?.url, 40, 40);
    return SafeArea(
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
                                            '${photos[0].user?.firstName ?? ''} ${photos[0].user?.lastName ?? 'User'}',
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
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      ConvertToTimeAgo().timeAgo(photos[0].createdAt ?? DateTime.now()),
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
                        photos[0].tags == null || photos[0].tags!.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(
                                  photos[0].tags!.join(', #'),
                                  style: const TextStyle(color: AppColors.redMedium),
                                ),
                              ),
                        photos[0].description!.isEmpty || photos[0].description == null
                            ? const SizedBox()
                            : ReadMoreText(
                                photos[0].description ?? '',
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    // padding: const EdgeInsets.all(15),
                    height: 28,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AppAssetIcons.like),
                        Expanded(
                          child: Text(
                            photos[0].likeCounts.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.h6,
                          ),
                        ),
                        Image.asset(AppAssetIcons.comment),
                        Text(
                          photos[0].commentCounts.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(AppAssetIcons.share),
                        Text(
                          photos[0].viewCounts.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: photos.length,
                (context, index) {
                  final deviceWidth = MediaQuery.of(context).size.width;
                  final heightImage = ImageUtils.getHeightView(deviceWidth, photos[index].image?.orgWidth ?? 1, photos[index].image?.orgHeight ?? 1);
                  final urlImage = ImageUtils.genImgIx(photos[index].image?.url, deviceWidth.toInt(), heightImage.toInt());
                  if (heightImage >= deviceWidth * 2.5) {
                    return SizedBox(
                      height: deviceWidth * 2.5,
                      width: deviceWidth,
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Container(
                        height: heightImage,
                        width: deviceWidth,
                        color: AppColors.slate,
                        child: CachedNetworkImage(
                          imageUrl: urlImage,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        // padding: const EdgeInsets.all(15),
                        height: 28,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(AppAssetIcons.like),
                            Expanded(
                              child: Text(
                                photos[index].likeCounts.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.h6,
                              ),
                            ),
                            Image.asset(AppAssetIcons.comment),
                            Text(
                              photos[index].commentCounts.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 15),
                            Image.asset(AppAssetIcons.share),
                            Text(
                              photos[index].viewCounts.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: AppColors.slate,)
                    ],
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
