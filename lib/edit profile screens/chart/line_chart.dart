import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Simulate fetching data from the backend
Future<Map<String, int>> fetchBackendData() async {
  await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

  // Mock values that represent new contacts, visitors, and likes
  return {
    'contacts': 6,
    'visitors': 13,
    'likes': 13,
  };
}

class LineChartWithLegend extends StatefulWidget {
  const LineChartWithLegend({super.key});

  @override
  State<LineChartWithLegend> createState() => _LineChartWithLegendState();
}

class _LineChartWithLegendState extends State<LineChartWithLegend> {
  double activityLevel = 0.2; // Activity level ranges from 0 to 1

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return DateFormat('MMM d').format(now); // Example: "Dec 23"
  }

  // Function to simulate activity change
  void _simulateActivityChange() {
    setState(() {
      // Toggle between low and high activity
      activityLevel = activityLevel == 0.2
          ? 0.8
          : 0.2; // Switch between low and high activity
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Your activity',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Center(
                  child: Text(
                    activityLevel >= 0.5
                        ? // If activity level is above 0.5, show High, else Low
                        'High'
                        : 'Low',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: activityLevel >= 0.5
                          ? Colors.green
                          : const Color(
                              0xFFF44336), // Green for High, Red for Low
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final startDate = DateTime(
                            DateTime.now().year, DateTime.now().month, 17);
                        final currentDate = DateTime.now();
                        final dateDifference =
                            currentDate.difference(startDate).inDays;

                        final days = List.generate(dateDifference + 1, (index) {
                          final day = startDate.add(Duration(days: index));
                          return "${day.day}"; // Format as month/day
                        });

                        if (value < 0 || value >= days.length) {
                          return Container();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => const FlLine(
                    color: Color(0xFFEAEAEA),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.black, width: 1),
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 20),
                      const FlSpot(1, 50),
                      const FlSpot(2, 10),
                      const FlSpot(3, 70),
                      const FlSpot(4, 80),
                      const FlSpot(5, 40),
                      const FlSpot(6, 100),
                    ],
                    isCurved: true,
                    color: activityLevel == 0.8
                        ? Colors.green
                        : Colors.red, // Change color based on activity level
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'X: ${spot.x}\nY: ${spot.y}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          // Display mock data from the backend using FutureBuilder
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 10.0),
            child: FutureBuilder<Map<String, int>>(
              future: fetchBackendData(), // Simulate fetching data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator while waiting
                } else if (snapshot.hasError) {
                  return const Text("Error loading data");
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color(0xFF958CFA),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              getCurrentDate(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['contacts']} new contacts',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${data['visitors']} new visitors',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${data['likes']} new likes',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          // Add a button to simulate activity change
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
              ),
              onPressed: _simulateActivityChange,
              child: const Text('Refresh Activity'),
            ),
          ),
        ],
      ),
    );
  }
}
