import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/Services/api_client_service.dart';
import 'package:masofaviy_talim_talaba/app/app_routes.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/students_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment/assignment_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment_student_list/assignment_student_list_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_details.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_result_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/video_player_page.dart';
import 'package:provider/provider.dart';
import 'app/modules/loading/loading_controller.dart';
import 'app/modules/login/auth_controller.dart';
import 'app/modules/notification/notification_controller.dart';
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
  await StorageService.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoadingController()),
      ChangeNotifierProvider(create: (_) => NotificationController()),
      ChangeNotifierProxyProvider2<
          LoadingController,
          NotificationController,
          AuthController>(
        create: (_) => AuthController(
          loading: LoadingController(),
          notify: NotificationController(),
          apiService: ApiService(),
        ),
        update: (_, loading, notify, __) =>
            AuthController(loading: loading, notify: notify, apiService: ApiService()),
      ),
    ],
    child: MyApp(),
  ),);
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => LoginPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => HomePage(
                  subjectsCount: 12,
                  videosCount: 23,
                  tasksCount: 56,
                  studentsCount: 45,
                ),
              ),
            ],
          ),
          if(StorageService.role=='Teacher')StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.students,
                builder: (context, state) => StudentsPage()
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.subjects,
                builder: (context, state) => SubjectsPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        SubjectDetails(subjectId: state.pathParameters['id']),
                    routes: [
                      GoRoute(
                        path: '${AppRoutes.video}/:video_id',
                        builder: (context, state) => VideoPlayerPage(
                          id: state.pathParameters['video_id'],
                        ),
                      ),
                      GoRoute(
                        path: '${AppRoutes.test}/:test_id',
                        builder: (context, state) =>
                            TestPage(id: state.pathParameters['test_id']),
                      ),
                      if(StorageService.role=='Teacher')GoRoute(
                        path: '${AppRoutes.testAdd}/:test_id',
                        builder: (context, state) =>
                            TestAddPage(id: state.pathParameters['test_id']),
                      ),
                      if(StorageService.role=='Teacher')GoRoute(
                        path: '${AppRoutes.assignmentSubmission}/:id',
                        builder: (context, state) =>
                            AssignmentSubmissionsPage(id: state.pathParameters['id']),
                      ),
                      GoRoute(
                        path: '${AppRoutes.testResult}/:id',
                        builder: (context, state) =>
                            TestResultPage(id: state.pathParameters['id']),
                      ),
                      GoRoute(
                        path: '${AppRoutes.assignment}/:id',
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
                path: AppRoutes.grades,
                builder: (context, state) => GradesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
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
    navigatorKey: navigatorKey,
    redirect: (c,g){
      if(StorageService.accessToken==null||StorageService.accessToken!.isEmpty)
      {
        StorageService.clear();
        return AppRoutes.login;
      }
    },

    errorBuilder: (context, state) => Scaffold(body: Center(child: Text('Page not found: ${state.uri.toString()}')),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Masofaviy ta\'lim platformasi',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(useMaterial3: true),
      builder: (context, child) {
      return Stack(
        children: [
          child!,

          //  GLOBAL LOADING
          Consumer<LoadingController>(
            builder: (_, loading, _) {
              if (!loading.isLoading) return const SizedBox();
              return Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),

          //  GLOBAL NOTIFICATION
          Consumer<NotificationController>(
            builder: (_, notify, _) {
              if (notify.message == null) return const SizedBox();

              Color bgColor;
              IconData icon;

              switch (notify.type) {
                case NotifyType.success:
                  bgColor = Colors.green;
                  icon = Icons.check_circle;
                  break;
                case NotifyType.error:
                  bgColor = Colors.red;
                  icon = Icons.error;
                  break;
                case NotifyType.warning:
                  bgColor = Colors.orange;
                  icon = Icons.warning;
                  break;
                default:
                  bgColor = Colors.blue;
                  icon = Icons.info;
              }

              return Positioned(
                top: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          notify.message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    },

    );

    // return MaterialApp.router(
    //   title: 'Masofaviy ta\'lim platformasi',
    //   debugShowCheckedModeBanner: false,
    //   routerConfig: _router,
    //   theme: ThemeData(useMaterial3: true),
    // );
  }
}