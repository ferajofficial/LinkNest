import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

@RoutePage(deferredLoading: true)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
                // children: [
                //   //WHITE SPACE
                //   SizedBox(
                //     height: 40,
                //   ),
                //   Container(
                //     width: double.maxFinite,
                //     padding: EdgeInsets.all(14),
                //     decoration: BoxDecoration(
                //       color: Colors.black12,
                //       // border: Border.all(
                //       //   width: 1,
                //       //   color: Colors.black45,
                //       // ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CircleAvatar(
                //               radius: MediaQuery.sizeOf(context).height * 0.04,
                //               backgroundColor: Colors.grey,
                //               backgroundImage: AssetImage(
                //                 'assets/logos/appIcon.png',
                //               ),
                //             ),
                //             Spacer(),
                //             Container(
                //               padding: EdgeInsets.all(12),
                //               decoration: BoxDecoration(
                //                 border: Border.all(width: 1, color: Colors.black38),
                //                 borderRadius: BorderRadius.circular(8),
                //                 color: Colors.white,
                //               ),
                //               child: Icon(
                //                 Icons.logout_rounded,
                //                 size: 20,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ],
                //         ),
                //         16.heightBox,
                //         Text(
                //           'Sk Ferajuddin',
                //           style: TextStyle(
                //               color: Colors.black54,
                //               fontWeight: FontWeight.w600,
                //               fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                //         ),
                //         Text(
                //           'Joined On :  ${DateTime.now().day} | ${DateTime.now().month} | ${DateTime.now().year}',
                //           style: TextStyle(
                //               color: Colors.black45,
                //               fontWeight: FontWeight.w400,
                //               fontSize: Theme.of(context).textTheme.labelLarge!.fontSize),
                //         ),
                //       ],
                //     ),
                //   ),
                //   24.heightBox,
                //   //SECOND CONTAINER
                //   Container(
                //     width: double.maxFinite,
                //     padding: EdgeInsets.all(14),
                //     decoration: BoxDecoration(
                //       color: Colors.black12,
                //       border: Border.all(
                //         width: 1,
                //         color: Colors.white,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.bookmark_border_sharp, color: Colors.black),
                //           title: Text(
                //             'Saved',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.archive_outlined, color: Colors.black),
                //           title: Text(
                //             'Archived',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.monitor_heart_outlined, color: Colors.black),
                //           title: Text(
                //             'Your Activity',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.favorite_outline_rounded, color: Colors.black),
                //           title: Text(
                //             'Favourites',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //       ],
                //     ),
                //   ),
                //   24.heightBox,
                //   //THIRD CONTAINER
                //   Container(
                //     width: double.maxFinite,
                //     padding: EdgeInsets.all(14),
                //     decoration: BoxDecoration(
                //       color: Colors.black12,
                //       border: Border.all(
                //         width: 1,
                //         color: Colors.white,
                //       ),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.manage_accounts, color: Colors.black),
                //           title: Text(
                //             'Account Details',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.sell_rounded, color: Colors.black),
                //           title: Text(
                //             'Preferences',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //         ListTile(
                //           minTileHeight: 10,
                //           leading: Icon(Icons.info_outlined, color: Colors.black),
                //           title: Text(
                //             'Activity Log',
                //             style: TextStyle(
                //                 color: Colors.black45,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {},
                //             icon: Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //         12.heightBox,
                //       ],
                //     ),
                //   ),
                //   40.heightBox,
                //   GlobalButton(
                //           elevation: 0,
                //           backgroundColor: Colors.black,
                //           child: Text(
                //             'BACK TO HOME',
                //             style: TextStyle(
                //                 color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.4),
                //           ),
                //           onPressed: () {})
                //       .w(200)
                // ],

                ),
          ),
        ),
      ),
    );
  }
}

class ScoreGauge extends StatelessWidget {
  final String title;
  final double score;
  final double maxScore;
  final double performanceIndex;
  final String performanceLabel;
  final Color performanceColor;

  const ScoreGauge({
    super.key,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.performanceIndex,
    required this.performanceLabel,
    required this.performanceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff1F2630),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: maxScore,
                  showLabels: true,
                  showTicks: true,
                  startAngle: 180,
                  endAngle: 0,
                  ranges: [
                    GaugeRange(startValue: 0, endValue: maxScore * 0.3, color: Colors.red),
                    GaugeRange(
                        startValue: maxScore * 0.3, endValue: maxScore * 0.6, color: Colors.orange),
                    GaugeRange(startValue: maxScore * 0.6, endValue: maxScore, color: Colors.green),
                  ],
                  pointers: [
                    NeedlePointer(
                      value: score,
                      needleStartWidth: 0,
                      needleEndWidth: 4,
                      knobStyle: KnobStyle(color: Colors.white),
                    )
                  ],
                  annotations: [
                    GaugeAnnotation(
                      widget: Text(
                        score.toStringAsFixed(0),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      angle: 90,
                      positionFactor: 0.4,
                    )
                  ],
                )
              ],
            ),
          ),
          Text("Expected NEET Score: ${maxScore.toStringAsFixed(0)}",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text("Performance Index: ${performanceIndex.toStringAsFixed(1)}%",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: performanceColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              performanceLabel,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
