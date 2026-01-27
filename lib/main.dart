import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/Services/api_client_service.dart';
import 'package:masofaviy_talim_talaba/app/app_routes.dart';
import 'package:masofaviy_talim_talaba/app/modules/home/home_controller.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/students_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment/assignment_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/assignment_student_list/assignment_student_list_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/details/subject_details_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test/test_result_page.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/video_player_page.dart';
import 'package:provider/provider.dart';
import 'app/modules/loading/loading_controller.dart';
import 'app/modules/login/auth_controller.dart';
import 'app/modules/notification/notification_controller.dart';
import 'app/modules/students/student_controller.dart';
import 'app/modules/subjects/components/subject_controller.dart';
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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoadingController()),
      ChangeNotifierProvider(create: (_) => NotificationController()),
      Provider(create: (_) => ApiService()),
      ChangeNotifierProvider(
        create: (context) => AuthController(
          loading: context.read<LoadingController>(),
          notify: context.read<NotificationController>(),
          apiService: context.read<ApiService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeController(
          loading: context.read<LoadingController>(),
          notify: context.read<NotificationController>(),
          apiService: context.read<ApiService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => StudentController(
          loading: context.read<LoadingController>(),
          notify: context.read<NotificationController>(),
          apiService: context.read<ApiService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SubjectController(
          loading: context.read<LoadingController>(),
          notify: context.read<NotificationController>(),
          apiService: context.read<ApiService>(),
        ),
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
                builder: (context, state) => HomePage(),
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
                    path: ':subject_id',
                    builder: (context, state) =>
                        SubjectDetailsPage(subjectId: state.pathParameters['subject_id']!),
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
                      // if(StorageService.role=='Teacher')
                        GoRoute(
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
                builder: (context, state) => ProfilePage(),
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