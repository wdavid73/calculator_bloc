import 'package:calculador_bloc/bloc/calculator/calculator_bloc.dart';
import 'package:calculador_bloc/widgets/line_separator.dart';
import 'package:calculador_bloc/widgets/main_result.dart';
import 'package:calculador_bloc/widgets/sub_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Column(
          children: [
            SubResult(text: state.firstNumber),
            SubResult(text: state.operation),
            SubResult(text: state.secondNumber),
            const LineSeparator(),
            MainResultText(text: state.mathResult),
          ],
        );
      },
    );
  }
}
