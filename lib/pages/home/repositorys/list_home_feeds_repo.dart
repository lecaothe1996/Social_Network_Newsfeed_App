import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/services/my_client.dart';
import 'package:social_app/utils/my_exception.dart';

class ListHomeFeedsRepo {
  final _myClient = MyClient();

  Future<List<HomeFeed>> getHomeFeeds() async {
    final res = await _myClient.get('/homefeeds');
    // print('res====${res.data}');
    if (res.statusCode != 200) {
      throw MyException('Server Error!!!');
    }
    List data = res.data['data'];
    // print('data====${data}');
    final homeFeeds = List<HomeFeed>.from(data.map((x) => HomeFeed.fromJson(x)));
    // print('homeFeeds==$homeFeeds');
    return homeFeeds;
  }
}
