import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDark = false;
  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FB),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar
          Container(
            width: 220,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFF6C4DD4),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'FreshTrack',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.home, "Home", true),
                _buildSidebarItem(Icons.shopping_bag, "Products", false),
                _buildSidebarItem(Icons.category, "Categories", false),
                _buildSidebarItem(Icons.store, "Stores", false),
                _buildSidebarItem(Icons.attach_money, "Finances", false),
                _buildSidebarItem(Icons.settings, "Settings", false),
                const Spacer(),
                _buildSidebarItem(Icons.add_circle_outline, "Add product", false),
                _buildSidebarItem(Icons.logout, "Log out", false),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SearchAnchor(
                          searchController: _searchController,
                          builder: (context, controller) {
                            return SearchBar(
                              controller: controller,
                              padding: const WidgetStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              onTap: () => controller.openView(),
                              onChanged: (_) => controller.openView(),
                              leading: const Icon(Icons.search),
                              trailing: <Widget>[
                                Tooltip(
                                  message: 'Change brightness mode',
                                  child: IconButton(
                                    isSelected: isDark,
                                    onPressed: () {
                                      setState(() {
                                        isDark = !isDark;
                                      });
                                    },
                                    icon: const Icon(Icons.wb_sunny_outlined),
                                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                                  ),
                                ),
                              ],
                            );
                          },
                          suggestionsBuilder: (context, controller) {
                            return List<ListTile>.generate(5, (int index) {
                              final String item = 'Item $index';
                              return ListTile(
                                title: Text(item),
                                onTap: () => setState(() => controller.closeView(item)),
                              );
                            });
                          },
                        ),
                      ),
                      if (!isSmallScreen) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.notifications_none, size: 30),
                      ]
                    ],
                  ),
                  if (isSmallScreen)
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.notifications_none, size: 30),
                      ),
                    ),

                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(5, (index) {
                      return _infoCard("Qty", ["NEW ITEMS", "NEW ORDERS", "REFUNDS", "MESSAGE", "GROUPS"][index], [741, 123, 12, 1, 4][index]);
                    }),
                  ),

                  const SizedBox(height: 30),

                      // Row 1 - Stats
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: List.generate(5, (index) {
                          return _infoCard("Qty", ["NEW ITEMS", "NEW ORDERS", "REFUNDS", "MESSAGE", "GROUPS"][index], [741, 123, 12, 1, 4][index]);
                        }),
                      ),

                      const SizedBox(height: 30),

                      // Row 2 - Graph and categories
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return constraints.maxWidth > 600
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Center(child: Text("[Bar Chart Placeholder]")),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        height: 200,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: GridView.count(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: const [
                                            Icon(Icons.local_florist),
                                            Icon(Icons.set_meal),
                                            Icon(Icons.apple),
                                            Icon(Icons.spa),
                                            Icon(Icons.emoji_food_beverage),
                                            Icon(Icons.rice_bowl),
                                            Icon(Icons.local_dining),
                                            Icon(Icons.icecream),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Center(child: Text("[Bar Chart Placeholder]")),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: GridView.count(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: const [
                                          Icon(Icons.local_florist),
                                          Icon(Icons.set_meal),
                                          Icon(Icons.apple),
                                          Icon(Icons.spa),
                                          Icon(Icons.emoji_food_beverage),
                                          Icon(Icons.rice_bowl),
                                          Icon(Icons.local_dining),
                                          Icon(Icons.icecream),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),

                      const SizedBox(height: 30),

                      // Row 3 - Recommended section
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text("Recommended: Restock alert / Top-selling item / Activity log"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      )
    );
  }

  Widget _infoCard(String title, String label, int value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$value", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF6C4DD4))),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {},
      ),
    );
  }
}
