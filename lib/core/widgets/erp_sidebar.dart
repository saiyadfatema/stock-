import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_text_styles.dart';
import '../../shared/providers/app_state_providers.dart';

class ErpSidebar extends ConsumerStatefulWidget {
  const ErpSidebar({super.key});

  @override
  ConsumerState<ErpSidebar> createState() => _ErpSidebarState();
}

class _ErpSidebarState extends ConsumerState<ErpSidebar> {
  final Map<String, bool> _expandedGroups = {
    'Inventory': true,
    'Purchase': false,
    'Production': false,
    'Sales': false,
    'Payments': false,
    'Masters': false,
    'Reports': false,
  };

  void _toggleGroup(String group) {
    setState(() {
      _expandedGroups[group] = !(_expandedGroups[group] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSection = ref.watch(currentNavSectionProvider);
    final db = ref.watch(databaseServiceProvider);

    return Container(
      width: 250,
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          // Logo Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'd',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'de luxex',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Navigation List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                // 1. Dashboard
                _buildNavItem(
                  icon: Icons.home_outlined,
                  title: 'Dashboard',
                  isSelected: currentSection == ErpNavSection.dashboard,
                  onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.dashboard,
                ),

                // 2. Inventory (Group)
                _buildNavGroup(
                  groupTitle: 'Inventory',
                  icon: Icons.inventory_2_outlined,
                  isExpanded: _expandedGroups['Inventory'] ?? false,
                  onGroupTap: () => _toggleGroup('Inventory'),
                  children: [
                    _buildSubNavItem(
                      title: 'Raw Material Stock',
                      isSelected: currentSection == ErpNavSection.rawMaterialStock,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.rawMaterialStock,
                    ),
                    _buildSubNavItem(
                      title: 'Finished Product Stock',
                      isSelected: currentSection == ErpNavSection.finishedProductStock,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.finishedProductStock,
                    ),
                    _buildSubNavItem(
                      title: 'Stock Movement (Ledger)',
                      isSelected: currentSection == ErpNavSection.stockMovement,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.stockMovement,
                    ),
                    _buildSubNavItem(
                      title: 'Stock Adjustments',
                      isSelected: currentSection == ErpNavSection.stockAdjustments,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.stockAdjustments,
                    ),
                  ],
                ),

                // 3. Purchase (Group)
                _buildNavGroup(
                  groupTitle: 'Purchase',
                  icon: Icons.shopping_bag_outlined,
                  isExpanded: _expandedGroups['Purchase'] ?? false,
                  onGroupTap: () => _toggleGroup('Purchase'),
                  children: [
                    _buildSubNavItem(
                      title: 'Purchase List',
                      isSelected: currentSection == ErpNavSection.purchaseList,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.purchaseList,
                    ),
                    _buildSubNavItem(
                      title: 'Create Purchase',
                      isSelected: currentSection == ErpNavSection.createPurchase,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.createPurchase,
                    ),
                    _buildSubNavItem(
                      title: 'Purchase History',
                      isSelected: currentSection == ErpNavSection.purchaseHistory,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.purchaseHistory,
                    ),
                    _buildSubNavItem(
                      title: 'Vendor Payments',
                      isSelected: currentSection == ErpNavSection.vendorPayments,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.vendorPayments,
                    ),
                  ],
                ),

                // 4. Production (Group)
                _buildNavGroup(
                  groupTitle: 'Production',
                  icon: Icons.precision_manufacturing_outlined,
                  isExpanded: _expandedGroups['Production'] ?? false,
                  onGroupTap: () => _toggleGroup('Production'),
                  children: [
                    _buildSubNavItem(
                      title: 'Production Orders',
                      isSelected: currentSection == ErpNavSection.productionOrders,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.productionOrders,
                    ),
                    _buildSubNavItem(
                      title: 'Create Production',
                      isSelected: currentSection == ErpNavSection.createProduction,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.createProduction,
                    ),
                    _buildSubNavItem(
                      title: 'Production History',
                      isSelected: currentSection == ErpNavSection.productionHistory,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.productionHistory,
                    ),
                    _buildSubNavItem(
                      title: 'Production Costing',
                      isSelected: currentSection == ErpNavSection.productionCosting,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.productionCosting,
                    ),
                  ],
                ),

                // 5. Sales (Group)
                _buildNavGroup(
                  groupTitle: 'Sales',
                  icon: Icons.point_of_sale_outlined,
                  isExpanded: _expandedGroups['Sales'] ?? false,
                  onGroupTap: () => _toggleGroup('Sales'),
                  children: [
                    _buildSubNavItem(
                      title: 'Sales Invoices',
                      isSelected: currentSection == ErpNavSection.salesInvoiceList,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.salesInvoiceList,
                    ),
                    _buildSubNavItem(
                      title: 'Create Sale',
                      isSelected: currentSection == ErpNavSection.createSale,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.createSale,
                    ),
                    _buildSubNavItem(
                      title: 'Quotations',
                      isSelected: currentSection == ErpNavSection.quotations,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.quotations,
                    ),
                    _buildSubNavItem(
                      title: 'Sales Orders',
                      isSelected: currentSection == ErpNavSection.salesOrders,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.salesOrders,
                    ),
                    _buildSubNavItem(
                      title: 'Sales Returns',
                      isSelected: currentSection == ErpNavSection.salesReturns,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.salesReturns,
                    ),
                  ],
                ),

                // 6. Payments (Group)
                _buildNavGroup(
                  groupTitle: 'Payments',
                  icon: Icons.payments_outlined,
                  isExpanded: _expandedGroups['Payments'] ?? false,
                  onGroupTap: () => _toggleGroup('Payments'),
                  children: [
                    _buildSubNavItem(
                      title: 'Customer Payments',
                      isSelected: currentSection == ErpNavSection.customerPayments,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.customerPayments,
                    ),
                    _buildSubNavItem(
                      title: 'Dealer Payments',
                      isSelected: currentSection == ErpNavSection.dealerPayments,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.dealerPayments,
                    ),
                    _buildSubNavItem(
                      title: 'Vendor Payments',
                      isSelected: currentSection == ErpNavSection.vendorPaymentsSection,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.vendorPaymentsSection,
                    ),
                    _buildSubNavItem(
                      title: 'Commission Payouts',
                      isSelected: currentSection == ErpNavSection.commissionPayments,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.commissionPayments,
                    ),
                  ],
                ),

                // 8. Masters (Group)
                _buildNavGroup(
                  groupTitle: 'Masters',
                  icon: Icons.dataset_outlined,
                  isExpanded: _expandedGroups['Masters'] ?? false,
                  onGroupTap: () => _toggleGroup('Masters'),
                  children: [
                    _buildSubNavItem(
                      title: 'Categories & Units',
                      isSelected: currentSection == ErpNavSection.categoriesUnits,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.categoriesUnits,
                    ),
                    _buildSubNavItem(
                      title: 'Vendors',
                      isSelected: currentSection == ErpNavSection.vendors,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.vendors,
                    ),
                    _buildSubNavItem(
                      title: 'Customers',
                      isSelected: currentSection == ErpNavSection.customers,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.customers,
                    ),
                    _buildSubNavItem(
                      title: 'Dealers',
                      isSelected: currentSection == ErpNavSection.dealers,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.dealers,
                    ),
                    _buildSubNavItem(
                      title: 'Architects & Commission',
                      isSelected: currentSection == ErpNavSection.architects,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.architects,
                    ),
                    _buildSubNavItem(
                      title: 'Raw Materials',
                      isSelected: currentSection == ErpNavSection.rawMaterials,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.rawMaterials,
                    ),
                    _buildSubNavItem(
                      title: 'Finished Products',
                      isSelected: currentSection == ErpNavSection.finishedProducts,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.finishedProducts,
                    ),
                  ],
                ),

                // 9. Reports (Group)
                _buildNavGroup(
                  groupTitle: 'Reports',
                  icon: Icons.bar_chart_rounded,
                  isExpanded: _expandedGroups['Reports'] ?? false,
                  onGroupTap: () => _toggleGroup('Reports'),
                  children: [
                    _buildSubNavItem(
                      title: 'Inventory Reports',
                      isSelected: currentSection == ErpNavSection.inventoryReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.inventoryReports,
                    ),
                    _buildSubNavItem(
                      title: 'Purchase Reports',
                      isSelected: currentSection == ErpNavSection.purchaseReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.purchaseReports,
                    ),
                    _buildSubNavItem(
                      title: 'Production Reports',
                      isSelected: currentSection == ErpNavSection.productionReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.productionReports,
                    ),
                    _buildSubNavItem(
                      title: 'Sales Reports',
                      isSelected: currentSection == ErpNavSection.salesReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.salesReports,
                    ),
                    _buildSubNavItem(
                      title: 'Commission Reports',
                      isSelected: currentSection == ErpNavSection.commissionReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.commissionReports,
                    ),
                    _buildSubNavItem(
                      title: 'Financial Reports',
                      isSelected: currentSection == ErpNavSection.financialReports,
                      onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.financialReports,
                    ),
                  ],
                ),

                // 10. Settings
                _buildNavItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  isSelected: currentSection == ErpNavSection.settings,
                  onTap: () => ref.read(currentNavSectionProvider.notifier).state = ErpNavSection.settings,
                ),
              ],
            ),
          ),

          // User Profile Card Footer (Alex Sterling - Service Manager)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.sidebarBackground,
              border: Border(
                top: BorderSide(color: AppColors.sidebarBorder, width: 1),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryLight,
                  child: const Text(
                    'AS',
                    style: TextStyle(
                      color: AppColors.sidebarBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        db.currentUser.name,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        db.currentUser.role,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.sidebarTextMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.sidebarActiveBackground : Colors.transparent,
        borderRadius: isSelected
            ? const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            : AppRadius.smBorderRadius,
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        leading: Icon(
          icon,
          size: 20,
          color: isSelected ? AppColors.sidebarActiveText : AppColors.sidebarTextMuted,
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.sidebarActiveText : AppColors.sidebarTextMuted,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildNavGroup({
    required String groupTitle,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onGroupTap,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onGroupTap,
          borderRadius: AppRadius.smBorderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isExpanded ? Colors.white : AppColors.sidebarTextMuted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    groupTitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isExpanded ? Colors.white : AppColors.sidebarTextMuted,
                      fontWeight: isExpanded ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                  size: 18,
                  color: AppColors.sidebarTextMuted,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 6),
            child: Column(
              children: children,
            ),
          ),
      ],
    );
  }

  Widget _buildSubNavItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.sidebarActiveBackground : Colors.transparent,
        borderRadius: isSelected
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )
            : AppRadius.smBorderRadius,
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        title: Text(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? AppColors.sidebarActiveText : AppColors.sidebarTextMuted,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12.5,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
