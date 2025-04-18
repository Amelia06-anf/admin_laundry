import 'package:flutter/material.dart';

class ServiceManagement extends StatefulWidget {
  const ServiceManagement({super.key});

  @override
  State<ServiceManagement> createState() => _ServiceManagementState();
}

class _ServiceManagementState extends State<ServiceManagement> {
  final List<Service> services = [
    Service("Cuci Kering", "Rp 7.000/kg", "2 Hari", true),
    Service("Cuci Setrika", "Rp 10.000/kg", "3 Hari", true),
    Service("Express (6 Jam)", "Rp 15.000/kg", "6 Jam", true),
    Service("Selimut/Bed Cover", "Rp 25.000/pcs", "4 Hari", false),
  ];

  void _editService(Service service) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Edit layanan: ${service.name}')));
  }

  void _deleteService(Service service) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Hapus layanan: ${service.name}')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Manajemen Layanan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("Tambah Layanan"),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16, // Sama seperti tabel pesanan
            columns: const [
              DataColumn(label: Text("Nama Layanan")),
              DataColumn(label: Text("Harga")),
              DataColumn(label: Text("Durasi")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("Aksi")),
            ],
            rows:
                services.map((service) {
                  return DataRow(
                    cells: [
                      DataCell(Text(service.name)),
                      DataCell(Text(service.price)),
                      DataCell(Text(service.duration)),
                      DataCell(
                        Switch(
                          value: service.active,
                          onChanged: (newValue) {
                            setState(() {
                              service.active = newValue;
                            });
                          },
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 16),
                              tooltip: 'Edit',
                              onPressed: () => _editService(service),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 16),
                              tooltip: 'Hapus',
                              onPressed: () => _deleteService(service),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class Service {
  final String name;
  final String price;
  final String duration;
  bool active;

  Service(this.name, this.price, this.duration, this.active);
}
