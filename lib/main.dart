import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment/assignment_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_details.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_result_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/video_player_page.dart';
import 'app/modules/grades/grades_page.dart';
import 'app/modules/home/home_page.dart';
import 'app/modules/login/login_page.dart';
import 'app/modules/main/main_layout.dart';
import 'app/modules/profile/profile_page.dart';
import 'app/modules/subjects/subjects_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.blueAccent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0 -> Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => HomePage(
                  subjectsCount: 12,
                  videosCount: 23,
                  tasksCount: 56,
                  studentsCount: 45,
                ),
              ),
            ],
          ),
          // Branch 1 -> Reports
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/subjects',
                builder: (context, state) => SubjectsPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        SubjectDetails(subjectId: state.pathParameters['id']),
                    routes: [
                      GoRoute(
                        path: '/video/:video_id',
                        builder: (context, state) => VideoPlayerPage(
                          id: state.pathParameters['video_id'],
                        ),
                      ),
                      GoRoute(
                        path: '/test/:test_id',
                        builder: (context, state) =>
                            TestPage(id: state.pathParameters['test_id']),
                      ),
                      GoRoute(
                        path: '/test_result/:id',
                        builder: (context, state) =>
                            TestResultPage(id: state.pathParameters['id']),
                      ),
                      GoRoute(
                        path: '/assignment/:id',
                        builder: (context, state) =>
                            AssignmentPage(id: state.pathParameters['id']),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Branch 2 -> Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/grades',
                builder: (context, state) => GradesPage(),
              ),
            ],
          ),
          // Branch 3 -> Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfilePage(
                  firstName: 'Shoxrux',
                  lastName: 'Yarashov',
                  phoneNumber: '+99895 888 22 66',
                  imageUrl: 'https://fastly.picsum.photos/id/826/200/200.jpg?hmac=WlCuCjxEhXh_s4IkOpulPoB-LOoGjfZwP4GjNnkzTLA',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    // optional: handle unknown or root
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.toString()}')),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Masofaviy ta\'lim platformasi',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _PageScaffold(title: 'Home', child: Center(child: Text('Welcome to Home', style: TextStyle(fontSize: 22))));
//   }
// }
//
// class ReportsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _PageScaffold(
//       title: 'Reports',
//       child: Center(child: Text('Reports and charts go here', style: TextStyle(fontSize: 22))),
//     );
//   }
// }
//
// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _PageScaffold(
//       title: 'Settings',
//       child: Center(child: Text('Settings page', style: TextStyle(fontSize: 22))),
//     );
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _PageScaffold(
//       title: 'Profile',
//       child: Center(child: Text('Profile page', style: TextStyle(fontSize: 22))),
//     );
//   }
// }
//
// /// Reusable page scaffold with AppBar
// class _PageScaffold extends StatelessWidget {
//   final String title;
//   final Widget child;
//   const _PageScaffold({required this.title, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.blueGrey.shade900,
//         elevation: 2,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(18),
//         child: child,
//       ),
//     );
//   }
// }
