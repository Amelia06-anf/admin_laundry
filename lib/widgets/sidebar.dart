import 'package:flutter/material.dart';
import 'nav_item.dart';

class SideBar extends StatelessWidget {
  final String selectedMenu;
  final void Function(String) onMenuTap;

  const SideBar({
    super.key,
    required this.selectedMenu,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          const FlutterLogo(size: 40),
          const SizedBox(height: 20),
          const Text(
            "Laundry App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 40),
          NavItem(
            title: 'Dashboard',
            selected: selectedMenu == 'Dashboard',
            onTap: () => onMenuTap('Dashboard'),
          ),
          NavItem(
            title: 'Pesanan',
            selected: selectedMenu == 'Pesanan',
            onTap: () => onMenuTap('Pesanan'),
          ),
          NavItem(
            title: 'Pelanggan',
            selected: selectedMenu == 'Pelanggan',
            onTap: () => onMenuTap('Pelanggan'),
          ),
          NavItem(
            title: 'Layanan',
            selected: selectedMenu == 'Layanan',
            onTap: () => onMenuTap('Layanan'),
          ),
          NavItem(
            title: 'Laporan',
            selected: selectedMenu == 'Laporan',
            onTap: () => onMenuTap('Laporan'),
          ),
          NavItem(
            title: 'Pengaturan',
            selected: selectedMenu == 'Pengaturan',
            onTap: () => onMenuTap('Pengaturan'),
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              "Budi Santoso",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: Text("Admin", style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
