import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// ===================== MaterialApp + Routing =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Indonesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BerandaPage(),
        '/pantai': (context) => const PantaiPage(),
        '/gunung': (context) => const GunungPage(),
        '/budaya': (context) => const BudayaPage(),
        '/kuliner': (context) => const KulinerPage(),
        '/detail': (context) => const DetailWisataPage(),
      },
    );
  }
}

/// ===================== Halaman Beranda =====================
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            MenuCard(
              judul: 'Pantai',
              ikon: Icons.beach_access,
              warna: Colors.blue,
              rute: '/pantai',
            ),
            MenuCard(
              judul: 'Gunung',
              ikon: Icons.terrain,
              warna: Colors.green,
              rute: '/gunung',
            ),
            MenuCard(
              judul: 'Budaya',
              ikon: Icons.theater_comedy,
              warna: Colors.deepOrange,
              rute: '/budaya',
            ),
            MenuCard(
              judul: 'Kuliner',
              ikon: Icons.restaurant,
              warna: Colors.red,
              rute: '/kuliner',
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String judul;
  final IconData ikon;
  final Color warna;
  final String rute;

  const MenuCard({
    super.key,
    required this.judul,
    required this.ikon,
    required this.warna,
    required this.rute,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(context, rute);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, size: 64, color: warna),
            const SizedBox(height: 12),
            Text(
              judul,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== Halaman Kategori (reusable) =====================
class KategoriPage extends StatelessWidget {
  final String judulAppBar;
  final IconData ikon;
  final Color warna;
  final String nama;
  final String deskripsi;
  final bool tampilkanTombolDetail;

  const KategoriPage({
    super.key,
    required this.judulAppBar,
    required this.ikon,
    required this.warna,
    required this.nama,
    required this.deskripsi,
    this.tampilkanTombolDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judulAppBar),
        backgroundColor: warna,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: warna.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(ikon, size: 80, color: warna),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: warna,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      deskripsi,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (tampilkanTombolDetail)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Kirim data nama tempat wisata ke halaman Detail Wisata
                    Navigator.pushNamed(context, '/detail', arguments: nama);
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Lihat Detail'),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== Empat Halaman Menu =====================
class PantaiPage extends StatelessWidget {
  const PantaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KategoriPage(
      judulAppBar: 'Pantai',
      ikon: Icons.beach_access,
      warna: Colors.blue,
      nama: 'Pantai Kuta, Bali',
      deskripsi:
          'Pantai Kuta terkenal dengan pasir putih yang luas, ombak yang cocok '
          'untuk berselancar, dan pemandangan matahari terbenam yang indah. '
          'Pantai ini menjadi salah satu tujuan wisata favorit di Pulau Bali.',
      tampilkanTombolDetail: true, // tombol "Lihat Detail" (Tugas Pengembangan)
    );
  }
}

class GunungPage extends StatelessWidget {
  const GunungPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KategoriPage(
      judulAppBar: 'Gunung',
      ikon: Icons.terrain,
      warna: Colors.green,
      nama: 'Gunung Bromo, Jawa Timur',
      deskripsi:
          'Gunung Bromo adalah gunung berapi aktif di kawasan Taman Nasional '
          'Bromo Tengger Semeru. Wisatawan datang untuk menikmati matahari '
          'terbit dan lautan pasir yang menakjubkan.',
    );
  }
}

class BudayaPage extends StatelessWidget {
  const BudayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KategoriPage(
      judulAppBar: 'Budaya',
      ikon: Icons.theater_comedy,
      warna: Colors.deepOrange,
      nama: 'Tari Kecak, Bali',
      deskripsi:
          'Tari Kecak adalah tarian tradisional Bali yang dibawakan oleh '
          'puluhan penari laki-laki dengan seruan "cak" secara bersahutan, '
          'menceritakan kisah Ramayana tanpa iringan alat musik.',
    );
  }
}

class KulinerPage extends StatelessWidget {
  const KulinerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const KategoriPage(
      judulAppBar: 'Kuliner',
      ikon: Icons.restaurant,
      warna: Colors.red,
      nama: 'Rendang, Sumatera Barat',
      deskripsi:
          'Rendang adalah masakan daging berbumbu rempah dan santan yang '
          'dimasak lama hingga kering. Hidangan khas Minangkabau ini dikenal '
          'sebagai salah satu makanan terlezat di dunia.',
    );
  }
}

/// ===================== Halaman Detail Wisata =====================
class DetailWisataPage extends StatelessWidget {
  const DetailWisataPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data yang dikirim lewat Navigator.pushNamed(arguments: ...)
    final String namaWisata =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Wisata'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.place, size: 90, color: Colors.blue),
              const SizedBox(height: 16),
              const Text(
                'Tempat Wisata yang Dipilih:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                namaWisata,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}