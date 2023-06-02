import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_pickers/image_pickers.dart';

import 'main.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  // image picker
  List<Media> _listImagePaths = [];
  bool _isDataSaved = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Mengambil data dari shared preferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('first_name') ?? '';
    String lastName = prefs.getString('last_name') ?? '';
    String email = prefs.getString('email') ?? '';
    String city = prefs.getString('city') ?? '';

    setState(() {
      _firstNameController.text = firstName ?? '';
      _lastNameController.text = lastName ?? '';
      _emailController.text = email ?? '';
      _cityController.text = city ?? '';
    });
  }

  // Menyimpan data ke shared preferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('first_name', _firstNameController.text);
    prefs.setString('last_name', _lastNameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('city', _cityController.text);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<String?> _getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');

    if (imagePath != null && imagePath.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gambar berhasil disimpan di lokal'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }

    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF1B1B1B)),
        title: Text('Edit Profil',
            style: TextStyle(
              color: Color(0xFF1B1B1B),
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            )),
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        toolbarHeight: 68,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfilePicture(
                name: (_firstNameController.text.isNotEmpty ||
                        _lastNameController.text.isNotEmpty)
                    ? _firstNameController.text + ' ' + _lastNameController.text
                    : 'Blank',
                radius: 50,
                fontsize: 30,
              ),
              SizedBox(height: 10.0),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(100, 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(color: Color(0xFF515151)),
                ),
                onPressed: () async {
                  _listImagePaths = await ImagePickers.pickerPaths(
                    galleryMode: GalleryMode.image,
                    selectCount: 1,
                    showGif: false,
                    showCamera: true,
                    compressSize: 500,
                    uiConfig: UIConfig(uiThemeColor: Color(0xFF1B1B1B)),
                  );

                  if (_listImagePaths.isNotEmpty) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(
                        'profile_image', _listImagePaths[0].path.toString());
                    setState(() {
                      _isDataSaved = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gambar berhasil disimpan'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? savedImagePath = prefs.getString('profile_image');
                    if (savedImagePath != null) {
                      print('Gambar tersimpan: $savedImagePath');
                    } else {
                      print('Tidak ada gambar tersimpan');
                    }
                  }
                },
                child: Text(
                  "Pilih Foto",
                  style: TextStyle(
                    color: Color(0xFF515151),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Nama Depan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Nama Belakang',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Kota',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // size of button width full screen
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  primary: Color(0xFF1B1B1B),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  // Mengambil nilai dari input
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String email = _emailController.text;
                  String city = _cityController.text;

                  // /saveData
                  _saveData();
                  // Simpan nilai input ke SharedPreferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('firstName', firstName);
                  prefs.setString('lastName', lastName);
                  prefs.setString('email', email);
                  prefs.setString('city', city);

                  setState(() {
                    _isDataSaved = true;
                  });

                  // tampilkan snackbar kemudia reload halaman
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data berhasil disimpan'),
                      backgroundColor: Color(0xFF1B1B1B),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text('Submit', style: TextStyle(fontSize: 16)),
              ),
              // button untuk clear data di shared preferences kemudian tampilkan snackbar jika berhasil dan mengubah field input menjadi kosong
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  // size of button width full screen
                  fixedSize: Size(MediaQuery.of(context).size.width, 32),
                  primary: Color(0xFF1B1B1B),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi'),
                        content: Text('Apakah Anda yakin ingin menghapus?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              setState(() {
                                _firstNameController.text = '';
                                _lastNameController.text = '';
                                _emailController.text = '';
                                _cityController.text = '';
                              });
                              Navigator.pop(context); // Tutup dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Data berhasil dihapus'),
                                  backgroundColor: Color(0xFF1B1B1B),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Text('Ya',
                                style: TextStyle(color: Color(0xFF1B1B1B))),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                            },
                            child: Text('Tidak',
                                style: TextStyle(color: Colors.red[900])),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Clear', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
