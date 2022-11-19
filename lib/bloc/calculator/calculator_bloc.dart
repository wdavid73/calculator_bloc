import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<CalculatorEvent>((event, emit) {
      // Delete All
      if (event is ResetAC) {
        emit.call(_resetAC());
      }

      // Add number to Screen
      if (event is AddNumber) {
        emit.call(state.copyWith(
          mathResult: (state.mathResult == '0')
              ? event.number
              : state.mathResult + event.number,
        ));
      }

      // Change signe of Number ( + / -)
      if (event is ChangeNegativePositive) {
        emit.call(state.copyWith(
            mathResult: state.mathResult.contains('-')
                ? state.mathResult.replaceFirst('-', '')
                : '-' + state.mathResult));
      }

      // Delete last digit
      if (event is DeleteLastEntry) {
        emit.call(state.copyWith(
            mathResult: state.mathResult.length > 1
                ? state.mathResult.substring(0, state.mathResult.length - 1)
                : '0'));
      }

      // add operation
      if (event is OperationEntry) {
        emit.call(state.copyWith(
          firstNumber: state.mathResult,
          mathResult: '0',
          operation: event.operation,
          secondNumber: '0',
        ));
      }

      // Calculate Result of operation
      if (event is CalculateResult) {
        emit.call(_calculateResult());
      }

      if (event is SaveHistory) {
        emit.call(_saveHistory());
      }
    });
  }
  CalculatorState _resetAC() {
    return state.copyWith(
      firstNumber: '0',
      mathResult: '0',
      secondNumber: '0',
      operation: '+',
    );
  }

  CalculatorState _calculateResult() {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.mathResult);

    switch (state.operation) {
      case '+':
        return state.copyWith(
          secondNumber: state.mathResult,
          mathResult: "${num1 + num2}",
        );
      case '-':
        return state.copyWith(
          secondNumber: state.mathResult,
          mathResult: "${num1 - num2}",
        );
      case '/':
        return state.copyWith(
            secondNumber: state.mathResult,
            mathResult: "${num2 != 0 ? num1 / num2 : 'Math Error'}");
      case 'X':
        return state.copyWith(
            secondNumber: state.mathResult, mathResult: "${num1 * num2}");
      default:
        return state;
    }
  }

  CalculatorState _saveHistory() {
    final String num1 = state.firstNumber;
    final String num2 = state.secondNumber;
    final String result = state.mathResult;
    final String operation = state.operation;
    final String history = "$num1 $operation $num2 = $result";

    final list = state.history.toList();
    list.add(history);
    return state.copyWith(history: list);
  }
}
