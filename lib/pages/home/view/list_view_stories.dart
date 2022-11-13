import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';

class ListViewStories extends StatefulWidget {
  const ListViewStories({Key? key}) : super(key: key);

  @override
  State<ListViewStories> createState() => _ListViewStoriesState();
}

class _ListViewStoriesState extends State<ListViewStories> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppColors.dark,
        child: Container(
          // color: Colors.blueGrey,
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 179,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 15),
                width: 135,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1517960413843-0aee8e2b3285?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: AppColors.redMedium,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(3),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('https://s.ws.pho.to/76eeee/img/index/ai/source.jpg'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Ninh Dương Lan Ngọc',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.h7.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
