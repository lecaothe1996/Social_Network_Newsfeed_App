import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/like_bloc/like_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/toggle.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';

class LikeCommentView extends StatefulWidget {
  final Post post;

  const LikeCommentView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<LikeCommentView> createState() => _LikeCommentViewState();
}

class _LikeCommentViewState extends State<LikeCommentView> {
  Post get post => widget.post;
  int likeCount = 0;
  bool isLiked = false;

  @override
  void initState() {
    likeCount = post.likeCounts ?? 0;
    isLiked = post.liked ?? false;
    print('initState');
    // _likeBloc.isActivated(post.liked ?? false);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeCommentView oldWidget) {
    print('didUpdateWidget');
    // likeCount = widget.post.likeCounts ?? 0;
    // isLiked = widget.post.liked ?? false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // padding: const EdgeInsets.all(15),
      // height: 28,
      // color: Colors.blueGrey,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Toggle(
            isActivated: isLiked,
            onTrigger: (isLiked) {
              // print('Call API like');
              isLiked ?
              BlocProvider.of<LikeBloc>(context).add(Like(id: 'id'))
                  : BlocProvider.of<LikeBloc>(context).add(UnLike(id: 'id'));
            },
            onTap: (isOn) {
              setState(() {
                likeCount = isOn ? likeCount + 1 : likeCount - 1;
                isLiked = isOn;
              });
            },
            activatedChild: Image.asset(
              AppAssetIcons.like,
              color: AppColors.redMedium,
            ),
            deActivatedChild: Image.asset(
              AppAssetIcons.like,
            ),
          ),
          Expanded(
            child: Text(
              likeCount.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h6,
            ),
          ),
          BlocBuilder<LikeBloc, LikeState>(
            builder: (context, state) {
              print('State Like === ${state}');
              if (state is LikeSuccess) {
                return Image.asset(AppAssetIcons.comment, color: Colors.red,);
              }
              return Image.asset(AppAssetIcons.comment);
            },
          ),
          Text(
            widget.post.commentCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 15),
          Image.asset(AppAssetIcons.share),
          Text(
            widget.post.viewCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
