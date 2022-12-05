import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
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
  int _likeCount = 0;
  bool _isLiked = false;

  @override
  void initState() {
    _likeCount = post.likeCounts ?? 0;
    _isLiked = post.liked ?? false;
    print('initState');
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
            isActivated: _isLiked,
            onTrigger: (isLiked) {
              // print('Call API like');
              isLiked
                  ? context.read<PostBloc>().add(LikeAndUnLike(post: post, eventLike: EventLike.likePost))
                  : context.read<PostBloc>().add(LikeAndUnLike(post: post, eventLike: EventLike.unLikePost));
            },
            onTap: (isOn) {
              setState(() {
                _likeCount = isOn ? _likeCount + 1 : _likeCount - 1;
                _isLiked = isOn;
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
              _likeCount.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h6,
            ),
          ),
          Image.asset(AppAssetIcons.comment),
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
