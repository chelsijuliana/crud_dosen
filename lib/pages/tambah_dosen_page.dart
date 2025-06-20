import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahDosenPage extends StatefulWidget {
  @override
  _TambahDosenPageState createState() => _TambahDosenPageState();
}

class _TambahDosenPageState extends State<TambahDosenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nipCtrl = TextEditingController();
  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController teleponCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController alamatCtrl = TextEditingController();

  Future<void> simpanData() async {
    final response = await http.post(
      Uri.parse('http://192.168.100.213:8000/api/dosen'),
      body: {
        'nip': nipCtrl.text,
        'nama_lengkap': namaCtrl.text,
        'no_telepon': teleponCtrl.text,
        'email': emailCtrl.text,
        'alamat': alamatCtrl.text,
      },
    );
    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      final error = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Dosen'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
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
                  if (_formKey.currentState!.validate()) simpanData();
                },
                child: Text(
                  'Simpan',
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
