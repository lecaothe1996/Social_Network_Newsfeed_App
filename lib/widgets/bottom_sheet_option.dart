import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/themes/app_color.dart';

class BottomSheetOption {
  static Future showBottomSheet(String id, BuildContext context) {
    return showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: AppColors.slate,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: ListTile(
              leading: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white,)),
              title: Container(
                padding: EdgeInsets.only(left: 0),
                color: Colors.blue,
                  child: Text('Xóa')),
              contentPadding: EdgeInsets.only(left: 0),
              onTap: () {

              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Chỉnh sửa'),
          ),
          ListTile(
            leading: Icon(Icons.copy),
            title: Text('Sao chép'),

          ),
        ],
      ),
    );
  }
}
