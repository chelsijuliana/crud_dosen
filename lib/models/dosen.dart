class Dosen {
  final int? no;
  final String nip;
  final String namaLengkap;
  final String noTelepon;
  final String email;
  final String alamat;

  Dosen({
    this.no,
    required this.nip,
    required this.namaLengkap,
    required this.noTelepon,
    required this.email,
    required this.alamat,
  });

  factory Dosen.fromJson(Map<String, dynamic> json) {
    return Dosen(
      no: json['no'],
      nip: json['nip'],
      namaLengkap: json['nama_lengkap'],
      noTelepon: json['no_telepon'],
      email: json['email'],
      alamat: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'nama_lengkap': namaLengkap,
      'no_telepon': noTelepon,
      'email': email,
      'alamat': alamat,
    };
  }
}
