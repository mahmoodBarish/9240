An expert Flutter software architect and senior developer, I have meticulously analyzed the provided Figma design JSON. I will now generate the complete, production-ready Flutter project according to the specified architectural blueprint and coding standards.

### /pubspec.yaml
```yaml
name: figma_messenger_project
description: A new Flutter project generated from a Figma design.
version: 1.0.0+1
publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

### /architecture.md
```md
This project follows a clean, layered architecture designed for scalability and maintainability.

- **Models (`lib/models/`):** Define the core data structures of the application (e.g., `Chat`, `Story`). This ensures a single source of truth for our data shapes.
- **Services (`lib/services/`):** Handle data fetching and business logic. They abstract the data source (e.g., a REST API or a local database) from the UI. Currently, they provide mock data.
- **Widgets (`lib/widgets/`):** Contain small, reusable UI components (atomic design). This promotes code reuse and a consistent UI, making it easier to build and update screens.
- **Screens (`lib/screens/`):** Represent full pages in the app. They are composed of smaller widgets and are responsible for the overall layout and state management of the page.
- **State Management:** We use Riverpod for dependency injection and state management. This provides a robust and scalable way to manage app state, separating UI from business logic.
- **Theme (`lib/theme.dart`):** Centralizes all UI styling constants like colors and text styles, ensuring a consistent look and feel across the entire application.
```

### /analysis_options.yaml
```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_const_literals_to_create_immutables
    - avoid_print
    - require_trailing_commas
    - unnecessary_new
```

### /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_messenger_project/screens/messanger_chats_screen.dart';
import 'package:figma_messenger_project/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger Chats',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MessangerChatsScreen(),
        // Add other routes here as the app grows
        // '/chat_details': (context) => const ChatDetailsScreen(),
      },
    );
  }
}
```

### /lib/theme.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF000000);
  static const Color secondaryText = Color(0x80000000); // Black with 50% opacity
  static const Color searchBarBg = Color(0x0D000000); // Black with 5% opacity
  static const Color searchBarHint = Color(0xFF8E8E93);
  static const Color iconButtonBg = Color(0x0A000000); // Black with 4% opacity
  static const Color onlineIndicator = Color(0xFF5AD439);
  static const Color blueAction = Color(0xFF0084FD);
  static const Color inactiveIcon = Color(0xFFa4aab2);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primaryText,
    textTheme: GoogleFonts.sfProTextTextTheme(
      TextTheme(
        displayLarge: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
          letterSpacing: 0.4,
        ),
        titleLarge: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
          letterSpacing: -0.4,
        ),
        bodyLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
          letterSpacing: -0.15,
        ),
        bodyMedium: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0x59000000), // Black with 35% opacity
          letterSpacing: -0.08,
        ),
        labelLarge: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: AppColors.searchBarHint,
          letterSpacing: -0.41,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0x99FFFFFF), // White with 60% opacity
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryText),
      actionsIconTheme: IconThemeData(color: AppColors.primaryText),
    ),
  );
}
```

### /lib/models/chat_model.dart
```dart
enum MessageStatus { sent, delivered, read }

class Chat {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final bool isMuted;
  final MessageStatus status;
  final int unreadCount;

  const Chat({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isMuted = false,
    this.status = MessageStatus.sent,
    this.unreadCount = 0,
  });
}
```

### /lib/models/story_model.dart
```dart
class Story {
  final String imageUrl;
  final String name;
  final bool isOnline;
  final bool isUserStory;

  const Story({
    required this.imageUrl,
    required this.name,
    this.isOnline = false,
    this.isUserStory = false,
  });
}
```

### /lib/services/chat_service.dart
```dart
import 'package:figma_messenger_project/models/chat_model.dart';
import 'package:figma_messenger_project/models/story_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatService {
  Future<List<Story>> getStories() async {
    // Mock network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      const Story(imageUrl: '', name: 'Your story', isUserStory: true),
      const Story(imageUrl: 'assets/images/287_62.png', name: 'Joshua', isOnline: true),
      const Story(imageUrl: 'assets/images/287_67.png', name: 'Martin', isOnline: true),
      const Story(imageUrl: 'assets/images/287_72.png', name: 'Karen', isOnline: true),
      const Story(imageUrl: 'assets/images/287_77.png', name: 'Martha', isOnline: true),
    ];
  }

  Future<List<Chat>> getChats() async {
    // Mock network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const Chat(
        imageUrl: 'assets/images/287_10.png',
        name: 'Martin Randolph',
        lastMessage: 'You: What’s man! · 9:40 AM',
        time: '',
        status: MessageStatus.read,
      ),
      const Chat(
        imageUrl: 'assets/images/287_19.png',
        name: 'Andrew Parker',
        lastMessage: 'You: Ok, thanks! · 9:25 AM',
        time: '',
        status: MessageStatus.read,
      ),
      const Chat(
        imageUrl: 'assets/images/287_29.png',
        name: 'Karen Castillo',
        lastMessage: 'You: Ok, See you in To… · Fri',
        time: '',
        status: MessageStatus.read,
      ),
      const Chat(
        imageUrl: 'assets/images/287_44.png',
        name: 'Maisy Humphrey',
        lastMessage: 'Have a good day, Maisy! · Fri',
        time: '',
        status: MessageStatus.read,
      ),
      const Chat(
        imageUrl: 'assets/images/287_39.png',
        name: 'Joshua Lawrence',
        lastMessage: 'The business plan loo…  · Thu',
        time: '',
      ),
      const Chat(
        imageUrl: 'assets/images/287_5.png',
        name: 'Maximillian Jacobson',
        lastMessage: 'Messenger UI · Thu',
        time: '',
      ),
    ];
  }
}

// Provider for the service
final chatServiceProvider = Provider<ChatService>((ref) => ChatService());

// Provider for the stories future
final storiesProvider = FutureProvider<List<Story>>((ref) async {
  return ref.read(chatServiceProvider).getStories();
});

// Provider for the chats future
final chatsProvider = FutureProvider<List<Chat>>((ref) async {
  return ref.read(chatServiceProvider).getChats();
});
```

### /lib/widgets/ad_list_item.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_messenger_project/theme.dart';

class AdListItem extends StatelessWidget {
  const AdListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        // Handle ad tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/287_108.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pixsellz',
                        style: textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryText.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Ad',
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Make design process easier…',
                    style: textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'View More',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.blueAction,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/287_115.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### /lib/widgets/chat_list_item.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_messenger_project/models/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        // Navigate to chat detail screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(chat.imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: textTheme.titleLarge?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    chat.lastMessage,
                    style: textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (chat.status == MessageStatus.read)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### /lib/widgets/custom_bottom_nav_bar.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_messenger_project/theme.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.background.withOpacity(0.8),
      elevation: 0,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(Icons.chat_bubble, 0),
            _buildNavItemWithBadge(Icons.people_alt_outlined, 1, '2'),
            _buildNavItem(Icons.explore_outlined, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index
            ? AppColors.primaryText
            : AppColors.inactiveIcon,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }

  Widget _buildNavItemWithBadge(IconData icon, int index, String badgeText) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: _selectedIndex == index
                  ? AppColors.primaryText
                  : AppColors.inactiveIcon,
            ),
          ),
          Positioned(
            right: 0,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: AppColors.onlineIndicator.withOpacity(0.16),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: AppColors.onlineIndicator,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### /lib/widgets/search_bar.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_messenger_project/theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.labelLarge,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.searchBarHint,
          ),
          filled: true,
          fillColor: AppColors.searchBarBg,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
```

### /lib/widgets/story_avatar.dart
```dart
import 'package:flutter/material.dart';
import 'package:figma_messenger_project/models/story_model.dart';
import 'package:figma_messenger_project/theme.dart';

class StoryAvatar extends StatelessWidget {
  final Story story;

  const StoryAvatar({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.iconButtonBg,
                  child: story.isUserStory
                      ? const Icon(Icons.add, color: AppColors.primaryText, size: 28)
                      : CircleAvatar(
                          radius: 26,
                          backgroundImage: AssetImage(story.imageUrl),
                        ),
                ),
                if (story.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.onlineIndicator,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              story.name,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

### /lib/widgets/story_list.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_messenger_project/services/chat_service.dart';
import 'package:figma_messenger_project/widgets/story_avatar.dart';

class StoryList extends ConsumerWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(storiesProvider);

    return storiesAsync.when(
      data: (stories) {
        return SizedBox(
          height: 106,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return StoryAvatar(story: stories[index]);
            },
          ),
        );
      },
      loading: () => const SizedBox(
        height: 106,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SizedBox(
        height: 106,
        child: Center(child: Text('Error: $err')),
      ),
    );
  }
}
```

### /lib/screens/messanger_chats_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_messenger_project/services/chat_service.dart';
import 'package:figma_messenger_project/theme.dart';
import 'package:figma_messenger_project/widgets/ad_list_item.dart';
import 'package:figma_messenger_project/widgets/chat_list_item.dart';
import 'package:figma_messenger_project/widgets/custom_bottom_nav_bar.dart';
import 'package:figma_messenger_project/widgets/search_bar.dart';
import 'package:figma_messenger_project/widgets/story_list.dart';

class MessangerChatsScreen extends ConsumerWidget {
  const MessangerChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(chatsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 100.0,
            backgroundColor: AppColors.background.withOpacity(0.8),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              title: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/287_84.png'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Chats',
                    style: textTheme.displayLarge?.copyWith(fontSize: 28),
                  ),
                  const Spacer(),
                  _buildActionIcon(Icons.camera_alt_outlined),
                  const SizedBox(width: 16),
                  _buildActionIcon(Icons.edit_outlined),
                ],
              ),
              centerTitle: false,
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: CustomSearchBar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: StoryList(),
          ),
          chatsAsync.when(
            data: (chats) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Injecting the Ad at a specific position for demonstration
                    if (index == 5) {
                      return const AdListItem();
                    }
                    final chatIndex = index > 5 ? index - 1 : index;
                    if (chatIndex >= chats.length) return null;
                    return ChatListItem(chat: chats[chatIndex]);
                  },
                  childCount: chats.length + 1, // +1 for the ad
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.iconButtonBg,
      child: Icon(
        icon,
        color: AppColors.primaryText,
        size: 20,
      ),
    );
  }
}
```

### /assets/
This folder should be created in the root directory. Inside it, create another folder named `images`. You will need to download all the images from the provided URLs and place them in the `/assets/images/` folder, renaming them according to the Figma node ID rule (e.g., the image for `287:5` becomes `287_5.png`).

**Example:**
- `/assets/images/287_5.png`
- `/assets/images/287_10.png`
- `/assets/images/287_19.png`
- ...and so on for all images.