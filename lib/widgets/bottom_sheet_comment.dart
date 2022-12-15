import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/icon_button_widget.dart';
import 'package:social_app/widgets/text_field_widget.dart';

class BottomSheetComment {
  Future showBottomSheet(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      backgroundColor: AppColors.dark,
      expand: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 15, right: 15),
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.deepOrange,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  // height: 300,
                  margin: EdgeInsets.only(bottom: 15),
                  // color: Colors.blueGrey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    // textDirection: TextDirection.rtl,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.slate,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: 'https://meliawedding.com.vn/wp-content/uploads/2022/03/avatar-gai-xinh-5.jpg',
                            errorWidget: (_, __, ___) =>
                                Image.asset(
                                  AppAssetIcons.avatar,
                                  color: AppColors.blueGrey,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          color: AppColors.slate,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lê Minh Thư',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const ReadMoreText(
                                  'Tôi đề nghị không thể tuyệt Tôi đề nghị không thể tuyệt Tôi đề nghị không thể tuyệt /n Tôi đề nghị không thể tuyệt',
                                  trimLines: 5,
                                  colorClickableText: AppColors.blueGrey,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: '',
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              decoration: const BoxDecoration(
                // color: Colors.grey,
                  border: Border(top: BorderSide(color: AppColors.slate, width: 1))),
              child: Row(
                children: [
                  const Expanded(
                    child: MyTextField(
                      hintText: 'Viết bình luận...',
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 11),
                  MyIconButton(
                    onTap: () {},
                    nameImage: AppAssetIcons.plane,
                    colorImage: AppColors.redMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}