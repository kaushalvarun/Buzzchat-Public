import 'package:buzz_chat/components/general_components/search_box.dart';
import 'package:flutter/material.dart';

class MySearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSearch;
  const MySearchWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = (Theme.of(context).brightness == Brightness.dark);

    // search box
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MySearchBox(controller: controller),
          ),
          ElevatedButton(
            onPressed: onSearch,
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.grey[400] : Colors.black26,
              elevation: 0,
              shape: const BeveledRectangleBorder(),
              foregroundColor: Colors.black,
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 18, bottom: 18),
              child: Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
