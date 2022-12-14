import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/like_bloc/like_cubit.dart';
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
  final _likeCubit = LikeCubit();

  int _likeCount = 0;
  bool _isLiked = false;

  @override
  void initState() {
    _likeCount = widget.post.likeCounts ?? 0;
    _isLiked = widget.post.liked ?? false;
    // print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeCommentView oldWidget) {
    // print('didUpdateWidget');
    _likeCount = widget.post.likeCounts ?? 0;
    _isLiked = widget.post.liked ?? false;
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
              isLiked
                  ? context.read<PostBloc>().add(LikeAndUnLike(post: widget.post, eventLike: EventLike.likePost))
                  : context.read<PostBloc>().add(LikeAndUnLike(post: widget.post, eventLike: EventLike.unLikePost));
              // print('Call API like');
              _likeCubit.likeAndUnLike(widget.post.id ?? '', isLiked ? EventLike.likePost : EventLike.unLikePost);
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
          GestureDetector(
            onTap: () => _showModalBottomSheet(context),
            child: Image.asset(AppAssetIcons.comment),
          ),
          Text(
            widget.post.commentCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 25),
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

  Future _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.dark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            children: [
              Container(
                height: 50,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    height: 300,
                    color: Colors.grey,
                  );
                },),
              ),
              Container(
                height: 50,
                color: Colors.blueGrey,
              ),
            ],
          ),
        );
      },
    );
  }
}
