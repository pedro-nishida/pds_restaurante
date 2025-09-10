import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/app_theme.dart';
import '../widgets/base_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _DashboardBody();
  }

}

class _DashboardBody extends StatefulWidget {
  @override
  State<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<_DashboardBody> {
  int _selectedChart = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Dashboard',
      showCartIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _selectedChart = 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedChart == 0 ? AppColors.primary : AppColors.secondary,
                  ),
                  child: Text('Status'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedChart = 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedChart == 1 ? AppColors.primary : AppColors.secondary,
                  ),
                  child: Text('Dia'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedChart = 2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedChart == 2 ? AppColors.primary : AppColors.secondary,
                  ),
                  child: Text('Categoria'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: _selectedChart == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pedidos por Status', style: Theme.of(context).textTheme.displaySmall),
                        SizedBox(height: 16),
                        Expanded(child: _buildBarChart()),
                      ],
                    )
                  : _selectedChart == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pedidos por Dia', style: Theme.of(context).textTheme.displaySmall),
                            SizedBox(height: 16),
                            Expanded(child: _buildLineChart()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pedidos por Categoria', style: Theme.of(context).textTheme.displaySmall),
                            SizedBox(height: 16),
                            Expanded(child: _buildPieChart()),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 35,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Finalizado', style: style);
                    break;
                  case 1:
                    text = const Text('Em andamento', style: style);
                    break;
                  case 2:
                    text = const Text('Cancelado', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  meta: meta,
                  space: 16,
                  child: text,
                );
              },
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 30,
                color: Colors.blue,
                width: 22,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 12,
                color: Colors.orange,
                width: 22,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 5,
                color: Colors.red,
                width: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Seg', style: style);
                    break;
                  case 1:
                    text = const Text('Ter', style: style);
                    break;
                  case 2:
                    text = const Text('Qua', style: style);
                    break;
                  case 3:
                    text = const Text('Qui', style: style);
                    break;
                  case 4:
                    text = const Text('Sex', style: style);
                    break;
                  case 5:
                    text = const Text('Sab', style: style);
                    break;
                  case 6:
                    text = const Text('Dom', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  meta: meta,
                  space: 8,
                  child: text,
                );
              },
              reservedSize: 32,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 10),
              const FlSpot(1, 15),
              const FlSpot(2, 8),
              const FlSpot(3, 20),
              const FlSpot(4, 18),
              const FlSpot(5, 12),
              const FlSpot(6, 5),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: 'Comidas\n40',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 20,
            title: 'Bebidas\n20',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 10,
            title: 'Sobremesas\n10',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
