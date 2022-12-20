class ConvertToTimeAgo {
  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} năm trước";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} tháng trước";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} tuần trước";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ngày trước";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} giờ trước";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} phút trước";
    }
    return "Vừa xong";
  }
}