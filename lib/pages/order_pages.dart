import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, String>> allOrders = [
    {
      'id': '#ORD-2504',
      'pelanggan': 'Anita Wijaya',
      'layanan': 'Cuci Setrika',
      'berat': '3.5 kg',
      'status': 'Diproses',
      'tanggal': '11 Apr 2025',
      'total': 'Rp 35.000',
    },
    {
      'id': '#ORD-2503',
      'pelanggan': 'Bambang Kurniawan',
      'layanan': 'Express (6 Jam)',
      'berat': '2 kg',
      'status': 'Selesai',
      'tanggal': '11 Apr 2025',
      'total': 'Rp 30.000',
    },
    {
      'id': '#ORD-2502',
      'pelanggan': 'Dewi Lestari',
      'layanan': 'Cuci Kering',
      'berat': '4 kg',
      'status': 'Dicuci',
      'tanggal': '10 Apr 2025',
      'total': 'Rp 28.000',
    },
  ];

  final List<String> statusTabs = [
    'Semua',
    'Diproses',
    'Dicuci',
    'Disetrika',
    'Selesai',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: statusTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Diproses':
        return Colors.orange;
      case 'Dicuci':
        return Colors.blue;
      case 'Disetrika':
        return Colors.purple;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, String>> _filteredOrders() {
    final selectedStatus = statusTabs[_tabController.index];
    if (selectedStatus == 'Semua') return allOrders;
    return allOrders
        .where((order) => order['status'] == selectedStatus)
        .toList();
  }

  DataRow _buildOrderRow(Map<String, String> order) {
    return DataRow(
      cells: [
        DataCell(Text(order['id'] ?? '-')),
        DataCell(Text(order['pelanggan'] ?? '-')),
        DataCell(Text(order['layanan'] ?? '-')),
        DataCell(Text(order['berat'] ?? '-')),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _statusColor(order['status'] ?? '').withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              order['status'] ?? '-',
              style: TextStyle(color: _statusColor(order['status'] ?? '')),
            ),
          ),
        ),
        DataCell(Text(order['tanggal'] ?? '-')),
        DataCell(Text(order['total'] ?? '-')),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Daftar Pesanan",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepPurple,
              onTap: (_) => setState(() {}),
              tabs: statusTabs.map((status) => Tab(text: status)).toList(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID PESANAN')),
                        DataColumn(label: Text('PELANGGAN')),
                        DataColumn(label: Text('LAYANAN')),
                        DataColumn(label: Text('BERAT')),
                        DataColumn(label: Text('STATUS')),
                        DataColumn(label: Text('TANGGAL MASUK')),
                        DataColumn(label: Text('TOTAL')),
                        DataColumn(label: Text('AKSI')),
                      ],
                      rows: _filteredOrders().map(_buildOrderRow).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
