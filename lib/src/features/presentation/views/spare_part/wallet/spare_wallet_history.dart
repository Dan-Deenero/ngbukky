import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/wallet_tile.dart';

class Payments extends HookWidget {
  Payments({Key? key}) : super(key: key ?? UniqueKey());
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('credit').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  if (transactionHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.nopaymenticon),
                          heightSpace(1),
                          SizedBox(
                            width: 130,
                            child: customText(
                              text: 'No payments were made to you',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                  ...transactionHistory.value.map(
                    (e) {
                      var dateString = e.createdAt;
                      var dateTime = DateTime.parse(dateString!);
                      var formattedDate =
                          DateFormat('dd MMM yyyy').format(dateTime);

                      var formattedTime =
                          DateFormat('hh:mm a').format(dateTime);
                      return WalletTile(
                        id: e.id,
                        isWithdrawal: false,
                        isMechanic: false,
                        date: formattedDate,
                        amount: e.amount,
                        status: e.status,
                        time: formattedTime,
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }
}

class Withdrawal extends HookWidget {
  Withdrawal({Key? key}) : super(key: key ?? UniqueKey());
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('withdrawal').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  if (transactionHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.nopaymenticon),
                          heightSpace(1),
                          SizedBox(
                            width: 130,
                            child: customText(
                              text: 'No payments were made to you',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                  ...transactionHistory.value.map(
                    (e) {
                      var dateString = e.createdAt;
                      var dateTime = DateTime.parse(dateString!);
                      var formattedDate =
                          DateFormat('dd MMM yyyy').format(dateTime);

                      var formattedTime =
                          DateFormat('hh:mm a').format(dateTime);
                      return WalletTile(
                        id: e.id,
                        isWithdrawal: true,
                        isMechanic: false,
                        date: formattedDate,
                        amount: e.amount,
                        status: e.status,
                        time: formattedTime,
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }
}

class SpareWalletHistory extends HookWidget {
  const SpareWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: "History",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              // heightSpace(1),
              bodyText("Review your financial analytics")
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(AppImages.cancelModal),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                            margin: const EdgeInsets.all(1),
                            width: 400,
                            height: 40,
                            decoration: BoxDecoration(
                                color: tabIndex.value == 0
                                    ? AppColors.white.withOpacity(0.7)
                                    : AppColors.borderGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Tab(
                              text: "Payments",
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(1),
                            width: 400,
                            height: 40,
                            decoration: BoxDecoration(
                                color: tabIndex.value == 1
                                    ? AppColors.white.withOpacity(0.7)
                                    : AppColors.borderGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Tab(
                              text: "Withdrawal",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightSpace(1)
                ],
              ),
            ),
            heightSpace(3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.containerGrey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(AppImages.sort),
                        customText(
                            text: "New to old",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.containerGrey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(AppImages.filter),
                        customText(
                            text: "All",
                            fontSize: 12,
                            textColor: AppColors.black)
                      ],
                    ),
                  )
                ],
              ),
            ),
            heightSpace(2),
            Expanded(
              child: TabBarView(
                children: [Payments(), Withdrawal()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
