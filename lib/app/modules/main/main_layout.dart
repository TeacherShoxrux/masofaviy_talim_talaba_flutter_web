import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/app_routes.dart';
import '../../global/app_colors.dart';
import '../../services/storage_service.dart';
class MainLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({required this.navigationShell, super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  // Collapse state
  bool collapsed = false;

  // Hovered menu index for hover effect
  int? hoveredIndex;

  // Menu definition
  final List<_MenuItemData> menuItems = [
    _MenuItemData(
      label: 'Home',
      icon: Icons.home,
      routeIndex: 0,
      path: AppRoutes.home,
    ),
    if (StorageService.role == 'Teacher')
      _MenuItemData(
        label: 'Student',
        icon: Icons.people,
        routeIndex: 1,
        path: AppRoutes.students,
      ),
    _MenuItemData(
      label: 'Fanlar',
      icon: Icons.settings,
      routeIndex: 2,
      path:AppRoutes.subjects,
    ),
    _MenuItemData(
      label: 'Baholar',
      icon: Icons.bar_chart,
      routeIndex: 3,
      path:AppRoutes.grades,
    ),
    _MenuItemData(
      label: 'Profile',
      icon: Icons.person,
      routeIndex: 4,
      path: AppRoutes.profile,
    ),
  ];

  // widths
  static const double expandedWidth = 220;
  static const double collapsedWidth = 72;

  @override
  Widget build(BuildContext context) {
    final nav = widget.navigationShell;
    final current = nav.currentIndex;

    return Scaffold(
      appBar: AppBar(
        leading: FlutterLogo(),
        animateColor: true,
        centerTitle: false,
        backgroundColor: Colors.grey.shade50,
        title: Text("Masofaviy ta'lim"),
        shadowColor: AppColors.primaryColor,
        elevation: 0.5,
      ),
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: collapsed ? collapsedWidth : expandedWidth,
            curve: Curves.easeInOut,
            child: Material(
              elevation: 4,
              color: AppColors.primaryColor,
              child: SafeArea(
                child: Column(
                  children: [
                    // Top header with collapse button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          if (!collapsed)
                            Text(
                              StorageService.role == 'admin '
                                  ? 'Admin Paneli'
                                  : "Talaba Paneli",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          Spacer(),
                          Tooltip(
                            message: collapsed ? 'Expand' : 'Collapse',
                            child: IconButton(
                              icon: AnimatedRotation(
                                turns: collapsed ? 0.5 : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  collapsed = !collapsed;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Menu items
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, idx) {
                          final item = menuItems[idx];
                          final bool isActive = current == item.routeIndex;
                          final bool isHovered = hoveredIndex == idx;

                          Color bgColor;
                          if (isActive) {
                            bgColor = Colors.white;
                          } else if (isHovered) {
                            bgColor = Colors.blue.shade700;
                          } else {
                            bgColor = Colors.transparent;
                          }
                          return MouseRegion(
                            onEnter: (_) => setState(() => hoveredIndex = idx),
                            onExit: (_) => setState(() => hoveredIndex = null),
                            child: GestureDetector(
                              onTap: () {
                                widget.navigationShell.goBranch(
                                  item.routeIndex,
                                );
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      width: 4,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),

                                    SizedBox(width: 10),

                                    // Icon (centered in collapsed mode)
                                    Icon(
                                      item.icon,
                                      color: Colors.black,
                                      size: 22,
                                    ),

                                    SizedBox(width: collapsed ? 0 : 12),

                                    // Label
                                    if (!collapsed)
                                      Expanded(
                                        child: Text(
                                          item.label,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: isActive
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    if (collapsed) Spacer(),

                                    // optional: chevron for active
                                    if (!collapsed)
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 200),
                                        opacity: isActive ? 1 : 0,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Bottom area (Logout)
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          StorageService.clear();
                          GoRouter.of(context).go(AppRoutes.login);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.white),
                            if (!collapsed) ...[
                              SizedBox(width: 12),
                              Text(
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content area
          Expanded(child: widget.navigationShell),
        ],
      ),
    );
  }
}

class _MenuItemData {
  final String label;
  final IconData icon;
  final int routeIndex;
  final String path;
  _MenuItemData({
    required this.label,
    required this.icon,
    required this.routeIndex,
    required this.path,
  });
}
