import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

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
                  rows: [
                    OrderRow(
                      id: "#ORD-2504",
                      pelanggan: "Anita Wijaya",
                      layanan: "Cuci Setrika",
                      berat: "3.5 kg",
                      status: "Diproses",
                      tanggal: "11 Apr 2025",
                      total: "Rp 35.000",
                    ),
                    OrderRow(
                      id: "#ORD-2503",
                      pelanggan: "Bambang Kurniawan",
                      layanan: "Express (6 Jam)",
                      berat: "2 kg",
                      status: "Selesai",
                      tanggal: "11 Apr 2025",
                      total: "Rp 30.000",
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrderRow extends DataRow {
  OrderRow({
    required String id,
    required String pelanggan,
    required String layanan,
    required String berat,
    required String status,
    required String tanggal,
    required String total,
  }) : super(
         cells: [
           DataCell(Text(id)),
           DataCell(Text(pelanggan)),
           DataCell(Text(layanan)),
           DataCell(Text(berat)),
           DataCell(Text(status)),
           DataCell(Text(tanggal)),
           DataCell(Text(total)),
           DataCell(ActionButtons()),
         ],
       );
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60, // cukup untuk 2 icon
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.edit, size: 18),
            tooltip: 'Edit',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Edit diklik')));
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.delete, size: 18),
            tooltip: 'Hapus',
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Hapus diklik')));
            },
          ),
        ],
      ),
    );
  }
}
