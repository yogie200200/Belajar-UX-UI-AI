import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(icon: Icon(Icons.menu, size: 24), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(Icons.doorbell_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.person, size: 24), onPressed: () {}),
        ],
        centerTitle: true,
        title: Text(
          'Slip Calculator',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/009/362/398/original/blue-dynamic-shape-abstract-background-suitable-for-web-and-mobile-app-backgrounds-eps-10-vector.jpg',
            ),
            fit: BoxFit.cover
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selamat Datang, User ! 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ayo Buat Formulasi Keramik Baru',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildMenuCard(
                context,
                icon: Icons.article_outlined,
                title: 'Buat Formulasi Baru',
                subtitle:
                    'Buat resep keramik dengan komposisi bahan yang tepat',
                onTap: () => Navigator.pushNamed(context, '/formulasi_Baru'),
              ),
              SizedBox(height: 24),
              _buildMenuCard(
                context,
                icon: Icons.calculate_outlined,
                title: 'Hitung Data Formulasi',
                subtitle: 'kalkulasi berdasarkan formulasi yang sudah dibuat',
                onTap: () => Navigator.pushNamed(context, '/hitung_formulasi'),
              ),
              SizedBox(height: 24),
              _buildMenuCard(
                context,
                icon: Icons.history,
                title: 'Cek Riwayat Trial',
                subtitle:
                    'Lihat hasil trial dan duplikasiformulasi sebelumnya ',
                onTap: () => Navigator.pushNamed(context, '/riwayat_formulasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.cyanAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 36, color: Colors.brown),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
