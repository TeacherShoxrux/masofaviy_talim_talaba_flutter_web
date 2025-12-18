import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/students_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment/assignment_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_details.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_result_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/video_player_page.dart';
import 'app/services/storage_service.dart';
import 'app/modules/grades/grades_page.dart';
import 'app/modules/home/home_page.dart';
import 'app/modules/login/login_page.dart';
import 'app/modules/main/main_layout.dart';
import 'app/modules/profile/profile_page.dart';
import 'app/modules/subjects/subjects_page.dart';
import 'app/modules/subjects/test_add/test_add_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await StorageService.loadRole();

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
          if(StorageService.role=='admin')StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/students',
                builder: (context, state) => StudentsPage()
              ),
            ],
          ),
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
                      if(StorageService.role=='admin')GoRoute(
                        path: '/test_add/:test_id',
                        builder: (context, state) =>
                            TestAddPage(id: state.pathParameters['test_id']),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/grades',
                builder: (context, state) => GradesPage(),
              ),
            ],
          ),
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