import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditDosenPage extends StatefulWidget {
  final Map dosen;
  EditDosenPage({required this.dosen});

  @override
  _EditDosenPageState createState() => _EditDosenPageState();
}

class _EditDosenPageState extends State<EditDosenPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nipCtrl;
  late TextEditingController namaCtrl;
  late TextEditingController teleponCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController alamatCtrl;

  @override
  void initState() {
    super.initState();
    nipCtrl = TextEditingController(text: widget.dosen['nip']);
    namaCtrl = TextEditingController(text: widget.dosen['nama_lengkap']);
    teleponCtrl = TextEditingController(text: widget.dosen['no_telepon']);
    emailCtrl = TextEditingController(text: widget.dosen['email']);
    alamatCtrl = TextEditingController(text: widget.dosen['alamat']);
  }

  Future<void> updateData() async {
    final response = await http.put(
      Uri.parse('http://192.168.100.213:8000/api/dosen/${widget.dosen['no']}'),
      body: {
        'nip': nipCtrl.text,
        'nama_lengkap': namaCtrl.text,
        'no_telepon': teleponCtrl.text,
        'email': emailCtrl.text,
        'alamat': alamatCtrl.text,
      },
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      final error = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Dosen'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildInputField('NIP', nipCtrl),
              buildInputField('Nama Lengkap', namaCtrl),
              buildInputField('No Telepon', teleponCtrl),
              buildInputField('Email', emailCtrl, inputType: TextInputType.emailAddress),
              buildInputField('Alamat', alamatCtrl, maxLines: 3),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                onPressed: () {
                  if (_formKey.currentState!.validate()) updateData();
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white), // teks putih
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        validator: (value) => value == null || value.isEmpty ? '$label tidak boleh kosong' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
