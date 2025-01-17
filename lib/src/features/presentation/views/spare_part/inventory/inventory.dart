import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/inventory_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/dashboard_widget/inventory_tile.dart';

class Inventory extends HookWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final sw = mediaQueryData.size.width;

    final tabIndex = useState<int>(0);
    final searchQuery = useState<String>('');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.push(AppRoutes.addInventory),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                          customText(
                            text: 'Add new',
                            fontSize: 14,
                            textColor: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: "Inventory",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.black,
                    ),
                    heightSpace(1),
                    SizedBox(
                      width: sw * 0.8,
                      child: customText(
                        text:
                            "Keep track your products; add new items to your store",
                        fontSize: 14,
                        textColor: AppColors.textGrey,
                      ),
                    ),
                    heightSpace(5),
                    TextFormField(
                      onChanged: (value) {
                        searchQuery.value = value; // Update search query
                      },
                      cursorColor: AppColors.black,
                      cursorWidth: 1,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        disabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformGrey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textformGrey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 10),
                        errorStyle: const TextStyle(fontSize: 14),
                        hintText: 'search for your products',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textGrey.withOpacity(0.3)),
                        prefixIcon: const Icon(Icons.search),
                        fillColor: AppColors.backgroundGrey,
                        filled: true,
                        enabledBorder: AppColors.emptyBorder,
                        errorBorder: AppColors.errorBorder,
                        focusedBorder: AppColors.normalBorder,
                        focusedErrorBorder: AppColors.normalBorder,
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(1),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  indicator: const BoxDecoration(),
                  onTap: (value) {
                    tabIndex.value = value;
                  },
                  tabs: [
                    Container(
                      width: 400,
                      height: 40,
                      decoration: BoxDecoration(
                        color: tabIndex.value == 0
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        border: tabIndex.value == 0
                            ? Border.all(
                                width: 1.0,
                                color: AppColors.borderGrey,
                              )
                            : Border.all(
                                width: 0, color: AppColors.backgroundGrey),
                      ),
                      child: const Tab(
                        text: "All",
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      decoration: BoxDecoration(
                        color: tabIndex.value == 1
                            ? AppColors.white
                            : AppColors.borderGrey,
                        border: tabIndex.value == 1
                            ? Border.all(
                                width: 1.0,
                                color: AppColors.borderGrey,
                              )
                            : Border.all(
                                width: 0, color: AppColors.backgroundGrey),
                      ),
                      child: const Tab(
                        text: "Running - out",
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      decoration: BoxDecoration(
                        color: tabIndex.value == 2
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: tabIndex.value == 2
                            ? Border.all(
                                width: 1.0,
                                color: AppColors.borderGrey,
                              )
                            : Border.all(
                                width: 0, color: AppColors.backgroundGrey),
                      ),
                      child: const Tab(
                        text: "Stockout",
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(2),
              Expanded(
                child: TabBarView(
                  children: [
                    All(
                      searchQuery: searchQuery.value,
                    ),
                    RunningOut(
                      searchQuery: searchQuery.value,
                    ),
                    StockOut(
                      searchQuery: searchQuery.value,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class All extends HookWidget {
  final String searchQuery;
  static const bool empty = false;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  All({Key? key, required this.searchQuery}) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final inventoryHistory = useState<List<InventoryModel>>([]);
    final inventorySearch = useState<List<InventoryModel>>([]);
    final isLoading = useState<bool>(true);
    final isSearching = useState<bool>(false);

    if (searchQuery.isEmpty) {
      isSearching.value = false;
    } else {
      isSearching.value = true;
    }

    getInventory() {
      mechanicRepo.getAllInventory('all').then(
        (value) {
          inventoryHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    searchInventory() {
      mechanicRepo.searchAnyInventory(searchQuery).then(
        (value) {
          inventorySearch.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      searchInventory();
      getInventory();
      return null;
    }, [inventoryHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                if (inventoryHistory.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        SvgPicture.asset(AppImages.noInventory),
                        heightSpace(1),
                        SizedBox(
                          width: 400,
                          child: customText(
                            text: 'You haven’t added an item yet to your store',
                            fontSize: 15,
                            textColor: AppColors.textGrey.withOpacity(0.3),
                            textAlignment: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                else
                  ...(isSearching.value
                          ? inventorySearch.value
                          : inventoryHistory.value)
                      .map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InventoryTile(
                              name: e.name,
                              price: e.finalPrice,
                              weight: e.specifications!.weight!.toString(),
                              image: e.imageUrl,
                              inStock: e.quantityInStock,
                              id: e.id,
                            ),
                            heightSpace(2),
                          ],
                        ),
                      );
                    },
                  ),
                if (isSearching.value == true && inventorySearch.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        customText(
                          text: 'No item match',
                          fontSize: 15,
                          textColor: AppColors.textGrey.withOpacity(0.7),
                          textAlignment: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}

class RunningOut extends HookWidget {
  static final MechanicRepo mechanicRepo = MechanicRepo();

  final String searchQuery;
  RunningOut({Key? key, required this.searchQuery})
      : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final inventoryHistory = useState<List<InventoryModel>>([]);
    final inventorySearch = useState<List<InventoryModel>>([]);

    final isLoading = useState<bool>(true);
    final isSearching = useState<bool>(false);

    if (searchQuery.isEmpty) {
      isSearching.value = false;
    } else {
      isSearching.value = true;
    }

    getInventory() {
      mechanicRepo.getAllInventory('running-out').then(
        (value) {
          inventoryHistory.value = value;
          log(inventoryHistory.value.isEmpty.toString());
          isLoading.value = false;
        },
      );
    }

    searchInventory() {
      mechanicRepo.searchAnyInventory(searchQuery).then(
        (value) {
          inventorySearch.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getInventory();
      searchInventory();
      return null;
    }, [inventoryHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),

            child: Column(
              children: [
                if (inventoryHistory.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        SvgPicture.asset(AppImages.noInventory),
                        heightSpace(1),
                        SizedBox(
                          width: 400,
                          child: customText(
                            text: 'You haven’t added an item yet to your store',
                            fontSize: 15,
                            textColor: AppColors.textGrey.withOpacity(0.3),
                            textAlignment: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                else
                  ...(isSearching.value
                          ? inventorySearch.value
                          : inventoryHistory.value)
                      .map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InventoryTile(
                              name: e.name,
                              price: e.finalPrice!,
                              weight: e.specifications!.weight!.toString(),
                              image: e.imageUrl,
                              inStock: e.quantityInStock,
                              id: e.id,
                            ),
                            heightSpace(2),
                          ],
                        ),
                      );
                    },
                  ),
                if (isSearching.value == true && inventorySearch.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        customText(
                          text: 'No item match',
                          fontSize: 15,
                          textColor: AppColors.textGrey.withOpacity(0.7),
                          textAlignment: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}

class StockOut extends HookWidget {
  static const bool empty = false;
  final String searchQuery;
  static final MechanicRepo mechanicRepo = MechanicRepo();

  StockOut({Key? key, required this.searchQuery})
      : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final inventoryHistory = useState<List<InventoryModel>>([]);
    final inventorySearch = useState<List<InventoryModel>>([]);

    final isLoading = useState<bool>(true);
    final isSearching = useState<bool>(false);

    if (searchQuery.isEmpty) {
      isSearching.value = false;
    } else {
      isSearching.value = true;
    }

    getInventory() {
      mechanicRepo.getAllInventory('out-of-stock').then(
        (value) {
          inventoryHistory.value = value;
          log(inventoryHistory.value.isEmpty.toString());
          isLoading.value = false;
        },
      );
    }

    searchInventory() {
      mechanicRepo.searchAnyInventory(searchQuery).then(
        (value) {
          inventorySearch.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getInventory();
      searchInventory();
      return null;
    }, [inventoryHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const ScrollPhysics(),

            child: Column(
              children: [
                if (inventoryHistory.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        SvgPicture.asset(AppImages.noInventory),
                        heightSpace(1),
                        SizedBox(
                          width: 400,
                          child: customText(
                            text: 'You haven’t added an item yet to your store',
                            fontSize: 15,
                            textColor: AppColors.textGrey.withOpacity(0.3),
                            textAlignment: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                else
                  ...(isSearching.value
                          ? inventorySearch.value
                          : inventoryHistory.value)
                      .map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InventoryTile(
                              name: e.name,
                              price: e.finalPrice!,
                              weight: e.specifications!.weight!.toString(),
                              image: e.imageUrl,
                              inStock: e.quantityInStock,
                              id: e.id,
                            ),
                            heightSpace(2),
                          ],
                        ),
                      );
                    },
                  ),
                if (isSearching.value == true && inventorySearch.value.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        heightSpace(5),
                        customText(
                          text: 'No item match',
                          fontSize: 15,
                          textColor: AppColors.textGrey.withOpacity(0.7),
                          textAlignment: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}
