import 'package:flutter/material.dart';
import 'edit_dosen_page.dart';
import 'tambah_dosen_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DosenListPage extends StatefulWidget {
  @override
  _DosenListPageState createState() => _DosenListPageState();
}

class _DosenListPageState extends State<DosenListPage> {
  List dosenList = [];

  @override
  void initState() {
    super.initState();
    fetchDosens();
  }

  Future<void> fetchDosens() async {
    final response = await http.get(Uri.parse('http://192.168.100.213:8000/api/dosen'));
    if (response.statusCode == 200) {
      setState(() {
        dosenList = json.decode(response.body);
      });
    }
  }

  Future<void> deleteDosen(int no) async {
    await http.delete(Uri.parse('http://192.168.100.213:8000/api/dosen/$no'));
    fetchDosens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Dosen'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: dosenList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          var dosen = dosenList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(dosen['nama_lengkap'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NIP: ${dosen['nip']}"),
                  Text("Telp: ${dosen['no_telepon']}"),
                  Text("Email: ${dosen['email']}"),
                  Text("Alamat: ${dosen['alamat']}"),
                ],
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditDosenPage(dosen: dosen),
                      ),
                    ).then((_) => fetchDosens()),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteDosen(dosen['no']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TambahDosenPage()),
        ).then((_) => fetchDosens()),
        child: Icon(Icons.add),
      ),
    );
  }
}
