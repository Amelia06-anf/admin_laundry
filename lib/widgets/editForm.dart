import 'package:flutter/material.dart';

class EditOrderForm extends StatefulWidget {
  final Map<String, String> order;
  final void Function(Map<String, String>) onSave;

  const EditOrderForm({super.key, required this.order, required this.onSave});

  @override
  State<EditOrderForm> createState() => _EditOrderFormState();
}

class _EditOrderFormState extends State<EditOrderForm> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String> editedOrder;

  @override
  void initState() {
    super.initState();
    editedOrder = Map.from(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Pesanan"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField("pelanggan", "Nama Pelanggan"),
                buildTextFormField("layanan", "Layanan"),
                buildTextFormField("berat", "Berat"),
                buildTextFormField("status", "Status"),
                buildTextFormField("tanggal", "Tanggal Masuk"),
                buildTextFormField("total", "Total"),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(editedOrder);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Data berhasil disimpan")),
              );
            }
          },
          child: const Text("Simpan"),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(String field, String label) {
    return TextFormField(
      initialValue: editedOrder[field],
      decoration: InputDecoration(labelText: label),
      onChanged: (value) => editedOrder[field] = value,
      validator:
          (value) => value == null || value.isEmpty ? "Wajib diisi" : null,
    );
  }
}
