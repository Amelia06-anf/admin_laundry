import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<String> _statusTabs = [
    'Semua',
    'Diproses',
    'Dicuci',
    'Disetrika',
    'Selesai',
  ];

  final List<Map<String, dynamic>> _orders = [
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
    {
      'id': '#ORD-2501',
      'pelanggan': 'Eko Prasetyo',
      'layanan': 'Cuci Setrika',
      'berat': '5 kg',
      'status': 'Disetrika',
      'tanggal': '10 Apr 2025',
      'total': 'Rp 50.000',
    },
    {
      'id': '#ORD-2500',
      'pelanggan': 'Farida Nurjanah',
      'layanan': 'Express (6 Jam)',
      'berat': '1.5 kg',
      'status': 'Selesai',
      'tanggal': '09 Apr 2025',
      'total': 'Rp 22.500',
    },
    {
      'id': '#ORD-2499',
      'pelanggan': 'Gita Purnama',
      'layanan': 'Cuci Kering',
      'berat': '3 kg',
      'status': 'Selesai',
      'tanggal': '09 Apr 2025',
      'total': 'Rp 21.000',
    },
    {
      'id': '#ORD-2498',
      'pelanggan': 'Hendra Gunawan',
      'layanan': 'Cuci Setrika',
      'berat': '4.5 kg',
      'status': 'Diproses',
      'tanggal': '08 Apr 2025',
      'total': 'Rp 45.000',
    },
    {
      'id': '#ORD-2497',
      'pelanggan': 'Indra Kusuma',
      'layanan': 'Selimut/Bed Cover',
      'berat': '2 pcs',
      'status': 'Dicuci',
      'tanggal': '08 Apr 2025',
      'total': 'Rp 50.000',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusTabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredOrders {
    final selectedStatus = _statusTabs[_tabController.index];
    var filtered = [..._orders];

    if (selectedStatus != 'Semua') {
      filtered = filtered.where((o) => o['status'] == selectedStatus).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered =
          filtered
              .where(
                (o) =>
                    o['id'].toLowerCase().contains(q) ||
                    o['pelanggan'].toLowerCase().contains(q),
              )
              .toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    return {
          'Diproses': Colors.orange,
          'Dicuci': Colors.blue,
          'Disetrika': Colors.purple,
          'Selesai': Colors.green,
        }[status] ??
        Colors.grey;
  }

  Color _getStatusBg(String status) {
    return {
          'Diproses': const Color(0xFFFFF3DC),
          'Dicuci': const Color(0xFFE6F2FF),
          'Disetrika': const Color(0xFFF5E6FF),
          'Selesai': const Color(0xFFE6FFE6),
        }[status] ??
        Colors.grey.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(),
          _buildSearchAndActions(),
          _buildTableHeader(),
          _buildOrderList(),
          _buildPagination(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.black12,

      title: const Text(
        'Daftar Pesanan',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      // actions: [
      //   _buildNotifIcon(),
      //   IconButton(
      //     icon: const Icon(Icons.settings_outlined, color: Colors.black54),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  // Widget _buildNotifIcon() {
  //   return IconButton(
  //     icon: Stack(
  //       children: [
  //         const Icon(Icons.notifications_outlined, color: Colors.black54),
  //         Positioned(
  //           right: 0,
  //           top: 0,
  //           child: Container(
  //             padding: const EdgeInsets.all(1),
  //             decoration: BoxDecoration(
  //               color: Colors.red,
  //               borderRadius: BorderRadius.circular(6),
  //             ),
  //             constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
  //             child: const Text(
  //               '2',
  //               style: TextStyle(color: Colors.white, fontSize: 8),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     onPressed: () {},
  //   );
  // }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.indigo,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.indigo,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      tabs: _statusTabs.map((status) => Tab(text: status)).toList(),
    );
  }

  Widget _buildSearchAndActions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Search box
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: const InputDecoration(
                  hintText: 'Cari pesanan atau pelanggan...',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _actionButton(Icons.filter_list, 'Filter'),
          const SizedBox(width: 12),
          _actionButton(Icons.sort, 'Urutkan'),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            label: const Text(
              'Tambah Pesanan',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.grey),
        label: Text(label, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildTableHeader() {
    final headers = [
      'ID PESANAN',
      'PELANGGAN',
      'LAYANAN',
      'BERAT',
      'STATUS',
      'TANGGAL MASUK',
      'TOTAL',
      'AKSI',
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children:
            headers
                .map(
                  (title) => Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildOrderList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredOrders.length,
        itemBuilder: (context, index) {
          final order = _filteredOrders[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    order['id'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    order['pelanggan'],
                    style: const TextStyle(color: Color(0xFF666666)),
                  ),
                ),
                Expanded(
                  child: Text(
                    order['layanan'],
                    style: const TextStyle(color: Color(0xFF666666)),
                  ),
                ),
                Expanded(
                  child: Text(
                    order['berat'],
                    style: const TextStyle(color: Color(0xFF666666)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusBg(order['status']),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      order['status'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _getStatusColor(order['status']),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    order['tanggal'],
                    style: const TextStyle(color: Color(0xFF666666)),
                  ),
                ),
                Expanded(
                  child: Text(
                    order['total'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Text(
            'Menampilkan 1 sampai 8 dari 42 hasil',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const Spacer(),
          _paginationButton('Sebelumnya', isEnabled: false),
          _paginationButton('1', isCurrent: true),
          _paginationButton('2'),
          _paginationButton('3'),
          _paginationButton('Selanjutnya'),
        ],
      ),
    );
  }

  Widget _paginationButton(
    String label, {
    bool isCurrent = false,
    bool isEnabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: isEnabled ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isCurrent ? const Color(0xFF4F46E5) : Colors.white,
          foregroundColor: isCurrent ? Colors.white : Colors.black87,
          disabledBackgroundColor: Colors.grey.shade200,
          disabledForegroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isCurrent ? const Color(0xFF4F46E5) : Colors.grey.shade300,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: 0,
        ),
        child: Text(label),
      ),
    );
  }
}
