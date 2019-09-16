import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_flutter_chart/chart/mp/chart/chart.dart';
import 'package:mp_flutter_chart/chart/mp/chart/line_chart.dart';
import 'package:mp_flutter_chart/chart/mp/core/animator.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/chart_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/line_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_interfaces/i_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/description.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_form.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/limite_label_postion.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/mode.dart';
import 'package:mp_flutter_chart/chart/mp/core/limit_line.dart';
import 'package:mp_flutter_chart/chart/mp/core/utils/color_utils.dart';
import 'package:mp_flutter_chart/chart/mp/core/utils/utils.dart';
import 'package:mp_flutter_chart/chart/mp/painter/line_chart_painter.dart';
import 'package:mp_flutter_chart/chart/mp/painter/painter.dart';
import 'package:mp_flutter_chart/demo/action_state.dart';

class LineChartBasic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LineChartBasicState();
  }
}

class LineChartBasicState extends ActionState<LineChartBasic> {
  LineChart _lineChart;
  LineData _lineData;

  var random = Random(1);

  int _count = 45;
  double _range = 180.0;

  @override
  void initState() {
    _initLineData(_count, _range);
    super.initState();
  }

  @override
  void chartInit() {
    _initLineChart();
  }

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 100,
          child: _lineChart,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _count.toDouble(),
                            min: 0,
                            max: 500,
                            onChanged: (value) {
                              _count = value.toInt();
                              _initLineData(_count, _range);
                              setState(() {});
                            })),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "$_count",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorUtils.BLACK,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _range,
                            min: 0,
                            max: 180,
                            onChanged: (value) {
                              _range = value;
                              _initLineData(_count, _range);
                              setState(() {});
                            })),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "${_range.toInt()}",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorUtils.BLACK,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void itemClick(String action) {
    var state = _lineChart?.getState();
    var painter = state?.painter as LineChartPainter;
    if (state == null || painter == null) {
      return;
    }

    switch (action) {
      case 'A':
        break;
      case 'B':
        List<ILineDataSet> sets = painter.getData().getDataSets();
        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          set.setDrawValues(!set.isDrawValuesEnabled());
        }
        state.setState(() {});
        break;
      case 'C':
        // todo icons
        break;
      case 'D':
        List<ILineDataSet> sets = painter.getData().getDataSets();

        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          if (set.isDrawFilledEnabled())
            set.setDrawFilled(false);
          else
            set.setDrawFilled(true);
        }
        state.setState(() {});
        break;
      case 'E':
        List<ILineDataSet> sets = painter.getData().getDataSets();

        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          if (set.isDrawCirclesEnabled())
            set.setDrawCircles(false);
          else
            set.setDrawCircles(true);
        }
        state.setState(() {});
        break;
      case 'F':
        List<ILineDataSet> sets = painter.getData().getDataSets();

        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          set.setMode(set.getMode() == Mode.CUBIC_BEZIER
              ? Mode.LINEAR
              : Mode.CUBIC_BEZIER);
        }
        state.setState(() {});
        break;
      case 'G':
        List<ILineDataSet> sets = painter.getData().getDataSets();

        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          set.setMode(
              set.getMode() == Mode.STEPPED ? Mode.LINEAR : Mode.STEPPED);
        }
        state.setState(() {});
        break;
      case 'H':
        List<ILineDataSet> sets = painter.getData().getDataSets();

        for (ILineDataSet iSet in sets) {
          LineDataSet set = iSet as LineDataSet;
          set.setMode(set.getMode() == Mode.HORIZONTAL_BEZIER
              ? Mode.LINEAR
              : Mode.HORIZONTAL_BEZIER);
        }
        state.setState(() {});
        break;
      case 'I':
        painter.mPinchZoomEnabled = !painter.mPinchZoomEnabled;
        state.setState(() {});
        break;
      case 'J':
        painter.mAutoScaleMinMaxEnabled = !painter.mAutoScaleMinMaxEnabled;
        state.setState(() {});
        break;
      case 'K':
        if (painter.getData() != null) {
          painter
              .getData()
              .setHighlightEnabled(!painter.getData().isHighlightEnabled());
          state.setState(() {});
        }
        break;
      case 'L':
        painter.mAnimator
          ..reset()
          ..animateX1(2000);
        break;
      case 'M':
        painter.mAnimator
          ..reset()
          ..animateY2(2000, Easing.EaseInCubic);
        break;
      case 'N':
        painter.mAnimator
          ..reset()
          ..animateXY1(2000, 2000);
        break;
      case 'O':
        // todo save
        break;
    }
  }

  @override
  String getTitle() {
    return "Line Chart Basic";
  }

  void _initLineData(int count, double range) {
    List<Entry> values = List();

    for (int i = 0; i < count; i++) {
      double val = (random.nextDouble() * range) - 30;
      values.add(Entry(x: i.toDouble(), y: val));
    }

    LineDataSet set1;

    // create a dataset and give it a type
    set1 = LineDataSet(values, "DataSet 1");

    set1.setDrawIcons(false);

    // draw dashed line
//      set1.enableDashedLine(10, 5, 0);

    // black lines and points
    set1.setColor1(ColorUtils.FADE_RED_END);
    set1.setCircleColor(ColorUtils.FADE_RED_END);
    set1.setHighLightColor(ColorUtils.PURPLE);

    // line thickness and point size
    set1.setLineWidth(1);
    set1.setCircleRadius(3);

    // draw points as solid circles
    set1.setDrawCircleHole(false);

    // customize legend entry
    set1.setFormLineWidth(1);
//      set1.setFormLineDashEffect(new DashPathEffect(new double[]{10f, 5f}, 0f));
    set1.setFormSize(15);

    // text size of values
    set1.setValueTextSize(9);

    // draw selection line as dashed
//      set1.enableDashedHighlightLine(10, 5, 0);

    // set the filled area
    set1.setDrawFilled(true);
//    set1.setFillFormatter(A(_lineChart.painter));

    // set color of filled area
    set1.setFillColor(ColorUtils.FADE_RED_END);

    set1.setDrawIcons(true);
    List<ILineDataSet> dataSets = List();
    dataSets.add(set1); // add the data sets

    // create a data object with the data sets
    _lineData = LineData.fromList(dataSets);
//    _lineData.setValueTypeface(TextStyle(fontSize: Utils.convertDpToPixel(9)));
  }

  void _initLineChart() {
    var desc = Description();
    desc.setEnabled(false);
    _lineChart = LineChart(_lineData, (painter) {
      painter.mXAxis.enableGridDashedLine(10, 10, 0);

      painter.mAxisRight.setEnabled(false);
//    _lineChart.painter.mAxisRight.enableGridDashedLine(10, 10, 0);
//    _lineChart.painter.mAxisRight.setAxisMaximum(200);
//    _lineChart.painter.mAxisRight.setAxisMinimum(-50);

      painter.mAxisLeft.enableGridDashedLine(10, 10, 0);
      painter.mAxisLeft.setAxisMaximum(200);
      painter.mAxisLeft.setAxisMinimum(-50);

      LimitLine llXAxis = new LimitLine(9, "Index 10");
      llXAxis.setLineWidth(4);
      llXAxis.enableDashedLine(10, 10, 0);
      llXAxis.setLabelPosition(LimitLabelPosition.RIGHT_BOTTOM);
      llXAxis.setTextSize(10);

      LimitLine ll1 = new LimitLine(150, "Upper Limit");
      ll1.setLineWidth(4);
      ll1.enableDashedLine(10, 10, 0);
      ll1.setLabelPosition(LimitLabelPosition.RIGHT_TOP);
      ll1.setTextSize(10);

      LimitLine ll2 = new LimitLine(-30, "Lower Limit");
      ll2.setLineWidth(4);
      ll2.enableDashedLine(10, 10, 0);
      ll2.setLabelPosition(LimitLabelPosition.RIGHT_BOTTOM);
      ll2.setTextSize(10);

      // draw limit lines behind data instead of on top
      painter.mAxisLeft.setDrawLimitLinesBehindData(true);
      painter.mXAxis.setDrawLimitLinesBehindData(true);

      // add limit lines
      painter.mAxisLeft.addLimitLine(ll1);
      painter.mAxisLeft.addLimitLine(ll2);
      painter.mLegend.setForm(LegendForm.LINE);

      painter.mAnimator.animateX1(1500);
    },
        touchEnabled: true,
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: true,
        desc: desc);
  }
}
