import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (screenWidth < 600) {
      crossAxisCount = 2; // <-- ubah ini
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
    }

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        SummaryCard(
          title: "Pesanan Hari Ini",
          value: "24",
          percentage: "+12%",
          subtitle: "dari kemarin",
          icon: Icons.event_note,
          color: Colors.indigo,
        ),
        SummaryCard(
          title: "Dalam Proses",
          value: "18",
          percentage: "-3%",
          subtitle: "dari kemarin",
          icon: Icons.sync,
          color: Colors.yellow,
        ),
        SummaryCard(
          title: "Pendapatan Hari Ini",
          value: "Rp 1.250.000",
          percentage: "+8%",
          subtitle: "dari kemarin",
          icon: Icons.attach_money,
          color: Colors.green,
        ),
        SummaryCard(
          title: "Total Pelanggan",
          value: "156",
          percentage: "+5%",
          subtitle: "bulan ini",
          icon: Icons.person,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title, value, percentage, subtitle;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "$percentage $subtitle",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
