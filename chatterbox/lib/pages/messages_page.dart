import 'package:chatterbox/helpers.dart';
import 'package:chatterbox/models/models.dart';
import 'package:chatterbox/theme.dart';
import 'package:flutter/material.dart';

import '../models/story_data.dart';
import '../widgets/avatar.dart';
import 'package:faker/faker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Stories(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _delegate,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _delegate(BuildContext context, int index) {
  final Faker faker = Faker();
  final date = Helpers.randomDate();
  final timePassed = timeago.format(date);
  return _MessageTile(
    messageData: MessageData(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: timePassed,
      profilePicture: Helpers.randomPictureUrl(),
    ),
  );
}


class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Avatar.medium(url: messageData.profilePicture),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  messageData.senderName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    letterSpacing: 0.2,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  messageData.message,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textFaded,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                messageData.dateMessage.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFaded,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textLigth,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}


class _Stories extends StatelessWidget {
  const _Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: SizedBox(
        height: 134.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return SizedBox(
                      width: 60.0,
                      child: _StoryCard(
                          storyData: StoryData(
                              name: faker.person.name(),
                              url: Helpers.randomPictureUrl())),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
