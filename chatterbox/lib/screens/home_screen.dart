import 'package:chatterbox/pages/calls_page.dart';
import 'package:chatterbox/pages/contacts_page.dart';
import 'package:chatterbox/pages/messages_page.dart';
import 'package:chatterbox/pages/notifications_page.dart';
import 'package:chatterbox/widgets/avatar.dart';
import 'package:chatterbox/widgets/icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatterbox/theme.dart';
import '../helpers.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];
  final pagesTitle = [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(index) {
    title.value = pagesTitle[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Center(
              child: Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: AppColors.textHighlight),
              ),
            );
          },
        ),
        leadingWidth: 54.0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print('To do Search');
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onitemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onitemSelected,
  }) : super(key: key);

  final ValueChanged<int> onitemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onitemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                index: 0,
                label: "Messaging",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 0),
              ),
              NavigationBarItem(
                index: 1,
                label: "Notifications",
                icon: CupertinoIcons.bell_solid,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1),
              ),
              NavigationBarItem(
                index: 2,
                label: "Calls",
                icon: CupertinoIcons.phone_fill,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2),
              ),
              NavigationBarItem(
                index: 3,
                label: "Contacts",
                icon: CupertinoIcons.person_2_fill,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    Key? key,
    required this.onTap,
    required this.index,
    required this.label,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  final ValueChanged<int> onTap;
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11.0,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(
                      fontSize: 11.0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
