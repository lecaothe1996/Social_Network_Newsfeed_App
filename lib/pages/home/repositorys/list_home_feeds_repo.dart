import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/services/my_client.dart';
import 'package:social_app/utils/my_exception.dart';

class ListHomeFeedsRepo {
  final _myClient = MyClient();

  Future<List<HomeFeed>> getHomeFeeds() async {
    final res = await _myClient.get(
      '/homefeeds',
      queryParameters: {'page': '19'},
    );
    // print('res====${res.data}');
    if (res.statusCode != 200) {
      throw MyException('Server Error!!!');
    }
    final data = res.data['data'];
    // print('data====${data}');
    if (data == null) {
      throw MyException('End Home Feed!!!');
    }
    final homeFeeds = List<HomeFeed>.from(data.map((x) => HomeFeed.fromJson(x)));
    // print('homeFeeds==$homeFeeds');
    return homeFeeds;
  }
}