

// class Notification extends HookWidget {
//   const Notification({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundGrey,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(14.h),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               customText(
//                   text: "Notification",
//                   fontSize: 25,
//                   textColor: AppColors.black,
//                   fontWeight: FontWeight.bold),
//               heightSpace(1),
//               customText(
//                   text: "You will see all your day to day activities",
//                   fontSize: 12,
//                   textColor: AppColors.textGrey),
//               heightSpace(1),
//             ],
//           ),
//         ),
//       ),
//       body: NewNotification(),
//     );
//   }
// }
