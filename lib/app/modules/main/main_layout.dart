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

class _MainLayoutState extends State<MainLayout> {
  bool isCollapsed = false;

  // Menu elementlarini rolga qarab getter orqali olish
  List<_MenuItemData> get menuItems => [
    _MenuItemData('Home', Icons.home_rounded, 0),
    if (StorageService.role == 'Teacher')
      _MenuItemData('Student', Icons.people_alt_rounded, 1),
    _MenuItemData('Fanlar', Icons.menu_book_rounded, 2),
    _MenuItemData('Baholar', Icons.analytics_rounded, 3),
    _MenuItemData('Profile', Icons.person_rounded, 4),
  ];

  static const double expandedWidth = 240;
  static const double collapsedWidth = 78;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: widget.navigationShell),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(),
      ),
      centerTitle: false,
      backgroundColor: Colors.grey.shade50,
      title: const Text(
        "Masofaviy ta'lim",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      surfaceTintColor: Colors.white,
    );
  }

  Widget _buildSidebar() {
    final bool isTeacher = StorageService.role == 'Teacher';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? collapsedWidth : expandedWidth,
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          )
        ],
      ),
      child: Column(
        children: [
          // Sidebar Header
          _SidebarHeader(
            isCollapsed: isCollapsed,
            title: isTeacher ? 'Admin Paneli' : 'Talaba Paneli',
            onToggle: () => setState(() => isCollapsed = !isCollapsed),
          ),

          // Menu List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: menuItems.map((item) {
                  return _SidebarItem(
                    data: item,
                    isActive: widget.navigationShell.currentIndex == item.index,
                    isCollapsed: isCollapsed,
                    onTap: () => widget.navigationShell.goBranch(item.index),
                  );
                }).toList(),
              ),
            ),
          ),

          // Logout Button
          _LogoutButton(isCollapsed: isCollapsed),
        ],
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  final String title;
  final VoidCallback onToggle;

  const _SidebarHeader({
    required this.isCollapsed,
    required this.title,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 8, 20),
      child: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
        children: [
          if (!isCollapsed)
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          IconButton(
            onPressed: onToggle,
            icon: AnimatedRotation(
              turns: isCollapsed ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.chevron_left, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final _MenuItemData data;
  final bool isActive;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.data,
    required this.isActive,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.white;
    final inactiveColor = Colors.white.withOpacity(0.7);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 50,
          decoration: BoxDecoration(
            color: widget.isActive
                ? Colors.white.withOpacity(0.2)
                : (isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: widget.isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              Icon(
                widget.data.icon,
                color: widget.isActive ? activeColor : inactiveColor,
                size: 24,
              ),
              if (!widget.isCollapsed) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.data.label,
                    style: TextStyle(
                      color: widget.isActive ? activeColor : inactiveColor,
                      fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (widget.isActive)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.circle, size: 6, color: Colors.white),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final bool isCollapsed;
  const _LogoutButton({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          StorageService.clear();
          context.go(AppRoutes.login);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                const Text(
                  'Chiqish',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItemData {
  final String label;
  final IconData icon;
  final int index;
  _MenuItemData(this.label, this.icon, this.index);
}