import 'package:admin_laudry/widgets/editForm.dart';
import 'package:flutter/material.dart';

class RecentOrders extends StatefulWidget {
  const RecentOrders({super.key});

  @override
  State<RecentOrders> createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  List<Map<String, String>> orders = [
    {
      "id": "#ORD-2504",
      "pelanggan": "Anita Wijaya",
      "layanan": "Cuci Setrika",
      "berat": "3.5 kg",
      "status": "Diproses",
      "tanggal": "11 Apr 2025",
      "total": "Rp 35.000",
    },
    {
      "id": "#ORD-2503",
      "pelanggan": "Bambang Kurniawan",
      "layanan": "Express (6 Jam)",
      "berat": "2 kg",
      "status": "Selesai",
      "tanggal": "11 Apr 2025",
      "total": "Rp 30.000",
    },
  ];

  void editOrder(String id, Map<String, String> updatedOrder) {
    setState(() {
      final index = orders.indexWhere((order) => order['id'] == id);
      if (index != -1) {
        orders[index] = updatedOrder;
      }
    });
  }

  void deleteOrder(String id) {
    setState(() {
      orders.removeWhere((order) => order['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pesanan Terbaru",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text("ID Pesanan")),
                    DataColumn(label: Text("Pelanggan")),
                    DataColumn(label: Text("Layanan")),
                    DataColumn(label: Text("Berat")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Tanggal Masuk")),
                    DataColumn(label: Text("Total")),
                    DataColumn(label: Text("Aksi")),
                  ],
                  rows:
                      orders.map((order) {
                        return DataRow(
                          cells: [
                            DataCell(Text(order['id']!)),
                            DataCell(Text(order['pelanggan']!)),
                            DataCell(Text(order['layanan']!)),
                            DataCell(Text(order['berat']!)),
                            DataCell(Text(order['status']!)),
                            DataCell(Text(order['tanggal']!)),
                            DataCell(Text(order['total']!)),
                            DataCell(
                              ActionButtons(
                                order: order,
                                onEdit: (updatedOrder) {
                                  editOrder(order['id']!, updatedOrder);
                                },
                                onDelete: () {
                                  deleteOrder(order['id']!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Pesanan ${order['id']} berhasil dihapus",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ActionButtons extends StatelessWidget {
  final Map<String, String> order;
  final void Function(Map<String, String>) onEdit;
  final VoidCallback onDelete;

  const ActionButtons({
    super.key,
    required this.order,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.edit, size: 18),
            tooltip: 'Edit',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => EditOrderForm(order: order, onSave: onEdit),
              );
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.delete, size: 18),
            tooltip: 'Hapus',
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text("Konfirmasi"),
                      content: Text(
                        "Yakin ingin menghapus pesanan ${order['id']}?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onDelete();
                          },
                          child: const Text("Hapus"),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
