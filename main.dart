import 'package:flutter/material.dart';

void main() {
  runApp(const FlashShareApp());
}

// Custom Design System Colors
class FlashColors {
  static const Color darkBg = Color(0xFF292A26);
  static const Color lightBg = Color(0xFFF5F3EC);
  static const Color accentMint = Color(0xFF9AD7CB);
  static const Color accentBlue = Color(0xFFD3E7F9);
  static const Color cardLight = Color(0xFFFAF8F2);
  static const Color textDark = Color(0xFF1E1F1C);
  static const Color textLight = Color(0xFFF5F3EC);
  static const Color buttonCream = Color(0xFFF2EFE6);
}

class FlashShareApp extends StatelessWidget {
  const FlashShareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlashShare',
      theme: ThemeData(
        scaffoldBackgroundColor: FlashColors.lightBg,
        fontFamily: 'Roboto', // Replace with custom font if preferred
      ),
      home: const ResponsiveLayoutController(),
    );
  }
}

/// Dynamic switcher between Mobile and Tablet Layouts
class ResponsiveLayoutController extends StatelessWidget {
  const ResponsiveLayoutController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return const TabletDashboard();
        } else {
          return const MobileHomeScreen();
        }
      },
    );
  }
}

// ==========================================
// 1. MOBILE VIEW (ANDROID)
// ==========================================
class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlashColors.darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on, color: FlashColors.accentMint, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'FlashShare',
                        style: TextStyle(
                          color: FlashColors.textLight,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: FlashColors.lightBg.withOpacity(0.2),
                        child: const Icon(Icons.person_outline, color: Colors.white),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: FlashColors.accentMint,
                          child: const Text('1', style: TextStyle(fontSize: 10, color: Colors.black)),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              // Speed Gauge / Dashboard graphic
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 12,
                        color: FlashColors.accentMint,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.flash_on, size: 48, color: FlashColors.accentMint),
                        const SizedBox(height: 8),
                        const Text(
                          '350 Mbps',
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Total transferred data',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              // Action Buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlashColors.buttonCream,
                  foregroundColor: FlashColors.textDark,
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => _showPairingModal(context),
                child: const Text('SEND FILES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlashColors.accentMint,
                  foregroundColor: FlashColors.textDark,
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {},
                child: const Text('RECEIVE FILES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: FlashColors.buttonCream,
        selectedItemColor: FlashColors.textDark,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: 'Files'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // Code entry/QR slide sheet pairing view
  void _showPairingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: FlashColors.lightBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BorderRadius.circular(2).toBoxDecoration(Colors.grey)),
            const SizedBox(height: 24),
            const Text('SCAN TO CONNECT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            // Mock QR Code block
            Container(
              width: 140,
              height: 140,
              color: Colors.white,
              child: const Icon(Icons.qr_code_2, size: 120, color: FlashColors.textDark),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: const Text('QR CODE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                const SizedBox(width: 20),
                TextButton(onPressed: () {}, child: const Text('SIMPLE CODE', style: TextStyle(color: Colors.grey))),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '739 104',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 4),
            )
          ],
        ),
      ),
    );
  }
}

// Extension util helper
extension CustomBox on BorderRadius {
  BoxDecoration toBoxDecoration(Color color) => BoxDecoration(color: color, borderRadius: this);
}

// ==========================================
// 2. TABLET VIEW (IPAD DASHBOARD)
// ==========================================
class TabletDashboard extends StatelessWidget {
  const TabletDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlashColors.lightBg,
      body: Row(
        children: [
          // Left Sidebar Nav Navigation Layout
          Container(
            width: 240,
            color: const Color(0xFFECE9E0),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flash_on, color: FlashColors.textDark, size: 28),
                    const SizedBox(width: 8),
                    const Text('FlashShare', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: FlashColors.textDark)),
                  ],
                ),
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.dashboard, 'Dashboard', isActive: true),
                _buildSidebarItem(Icons.folder_open, 'Files'),
                _buildSidebarItem(Icons.send_outlined, 'Send'),
                _buildSidebarItem(Icons.download_outlined, 'Receive'),
                _buildSidebarItem(Icons.history, 'Recent Activity'),
                const Spacer(),
                _buildSidebarItem(Icons.settings_outlined, 'Settings'),
              ],
            ),
          ),

          // Central Workspace Panel Dashboard
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: FlashColors.textDark)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, size: 28)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Transfer Activity Summary Bar Panel
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatColumn('Active transfers', '1h', 'Total + transfers', '3h'),
                        _buildStatColumn('350 Mbps', 'Total transferred data', 'Summary', '350 Mbps'),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: FlashColors.accentMint, foregroundColor: FlashColors.textDark, shape: StadiumBorder()),
                              onPressed: () {},
                              child: const Text('Send Files'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: FlashColors.lightBg, foregroundColor: FlashColors.textDark, shape: StadiumBorder()),
                              onPressed: () {},
                              child: const Text('Receive Files'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text('Recent files', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: FlashColors.textDark)),
                  const SizedBox(height: 16),
                  // Grid array files structural list view
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: const [
                        FileGridCard(title: 'Drone_Footage.mp4', subtitle: '1.2 GB • Video', isVideo: true),
                        FileGridCard(title: 'IMG_0452.jpg', subtitle: '12.1 MB • Photo', isImage: true),
                        FileGridCard(title: 'IMG_0453.jpg', subtitle: '12.1 MB • Photo', isImage: true),
                        FileGridCard(title: 'IMG_0454.jpg', subtitle: '12.1 MB • Photo', isImage: true),
                        FileGridCard(title: 'Report.pdf', subtitle: '4.5 MB • PDF', isDoc: true),
                        FileGridCard(title: 'Folder', subtitle: '4.5 MB • Assets Folder', isFolder: true),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // Right Connection Setup Rail View Panel Panel
          Container(
            width: 280,
            color: FlashColors.accentBlue,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('SCAN TO CONNECT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.5, color: FlashColors.textDark)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: const Icon(Icons.qr_code_2, size: 160, color: FlashColors.textDark),
                ),
                const SizedBox(height: 40),
                const Text('SIMPLE PAIRING CODE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: const Text(
                    '109 238',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2, color: FlashColors.textDark),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? FlashColors.buttonCream : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: FlashColors.textDark),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: FlashColors.textDark)),
        dense: true,
      ),
    );
  }

  Widget _buildStatColumn(String t1, String v1, String t2, String v2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$t1: $v1', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)),
        const SizedBox(height: 4),
        Text('$t2: $v2', style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

// Grid Card Component Model Component
class FileGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isVideo;
  final bool isImage;
  final bool isDoc;
  final bool isFolder;

  const FileGridCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isVideo = false,
    this.isImage = false,
    this.isDoc = false,
    this.isFolder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlashColors.lightBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  isVideo
                      ? Icons.play_circle_fill
                      : isImage
                          ? Icons.image
                          : isDoc
                              ? Icons.description
                              : Icons.folder,
                  size: 40,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, overflow: TextOverflow.ellipsis)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}

