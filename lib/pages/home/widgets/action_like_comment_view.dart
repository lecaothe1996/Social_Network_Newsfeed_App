import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/like_bloc/like_cubit.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/bottom_sheets/bottom_sheet_comment.dart';
import 'package:social_app/pages/home/widgets/toggle.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';

class ActionLikeCommentView extends StatefulWidget {
  final Post post;

  const ActionLikeCommentView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<ActionLikeCommentView> createState() => _ActionLikeCommentViewState();
}

class _ActionLikeCommentViewState extends State<ActionLikeCommentView> {
  final _likeCubit = LikeCubit();

  int _likeCount = 0;
  bool _isLiked = false;
  int _commentCounts = 0;

  @override
  void initState() {
    _likeCount = widget.post.likeCounts ?? 0;
    _isLiked = widget.post.liked ?? false;
    _commentCounts = widget.post.commentCounts ?? 0;
    // print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ActionLikeCommentView oldWidget) {
    // print('didUpdateWidget');
    _likeCount = widget.post.likeCounts ?? 0;
    _isLiked = widget.post.liked ?? false;

    _commentCounts = widget.post.commentCounts ?? 0;
    // print('_commentCounts==$_commentCounts');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // print('===== Build ActionLikeCommentView =====');
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Toggle(
            isActivated: _isLiked,
            onTrigger: (isLiked) => _handleLikePost(isLiked),
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
          Text(
            _likeCount.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 25),
          GestureDetector(
            onTap: () => _tapComment(context),
            child: Image.asset(AppAssetIcons.comment),
          ),
          Expanded(
            child: Text(
              _commentCounts.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Image.asset(AppAssetIcons.view),
          const SizedBox(width: 2),
          Text(
            widget.post.viewCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _handleLikePost(bool isLiked) {
    isLiked
        ? context.read<PostBloc>().add(LikeAndUnLike(post: widget.post, eventAction: EventAction.likePost))
        : context.read<PostBloc>().add(LikeAndUnLike(post: widget.post, eventAction: EventAction.unLikePost));
    // Call API
    _likeCubit.likeAndUnLike(widget.post.id ?? '', isLiked ? EventAction.likePost : EventAction.unLikePost);
  }

  Future _tapComment(BuildContext context) {
    return BottomSheetComment.show(widget.post, context);
  }
}
