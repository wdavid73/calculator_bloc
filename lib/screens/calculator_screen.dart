import 'package:calculador_bloc/bloc/calculator/calculator_bloc.dart';
import 'package:calculador_bloc/widgets/calc_buttton.dart';
import 'package:calculador_bloc/widgets/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

    void calculateResult() {
      calculatorBloc.add(CalculateResult());
      calculatorBloc.add(SaveHistory());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator BLOC'),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.indigoAccent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: HistoryCalculator(),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(child: Container()),
              const Results(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: 'AC',
                    bgColor: const Color(0xffA5A5A5),
                    onPressed: () => calculatorBloc.add(ResetAC()),
                  ),
                  CalculatorButton(
                    text: '+/-',
                    bgColor: const Color(0xffA5A5A5),
                    onPressed: () =>
                        calculatorBloc.add(ChangeNegativePositive()),
                  ),
                  CalculatorButton(
                    text: 'del',
                    bgColor: const Color(0xffA5A5A5),
                    onPressed: () => calculatorBloc.add(DeleteLastEntry()),
                  ),
                  CalculatorButton(
                    text: '/',
                    bgColor: const Color(0xffF0A23B),
                    onPressed: () => calculatorBloc.add(OperationEntry('/')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '7',
                    onPressed: () => calculatorBloc.add(AddNumber('7')),
                  ),
                  CalculatorButton(
                    text: '8',
                    onPressed: () => calculatorBloc.add(AddNumber('8')),
                  ),
                  CalculatorButton(
                    text: '9',
                    onPressed: () => calculatorBloc.add(AddNumber('9')),
                  ),
                  CalculatorButton(
                    text: 'X',
                    bgColor: const Color(0xffF0A23B),
                    onPressed: () => calculatorBloc.add(OperationEntry('X')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '4',
                    onPressed: () => calculatorBloc.add(AddNumber('4')),
                  ),
                  CalculatorButton(
                    text: '5',
                    onPressed: () => calculatorBloc.add(AddNumber('5')),
                  ),
                  CalculatorButton(
                    text: '6',
                    onPressed: () => calculatorBloc.add(AddNumber('6')),
                  ),
                  CalculatorButton(
                    text: '-',
                    bgColor: const Color(0xffF0A23B),
                    onPressed: () => calculatorBloc.add(OperationEntry('-')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '1',
                    onPressed: () => calculatorBloc.add(AddNumber('1')),
                  ),
                  CalculatorButton(
                    text: '2',
                    onPressed: () => calculatorBloc.add(AddNumber('2')),
                  ),
                  CalculatorButton(
                    text: '3',
                    onPressed: () => calculatorBloc.add(AddNumber('3')),
                  ),
                  CalculatorButton(
                    text: '+',
                    bgColor: const Color(0xffF0A23B),
                    onPressed: () => calculatorBloc.add(OperationEntry('+')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '0',
                    big: true,
                    onPressed: () => calculatorBloc.add(AddNumber('0')),
                  ),
                  CalculatorButton(
                    text: '.',
                    onPressed: () => calculatorBloc.add(AddNumber('.')),
                  ),
                  CalculatorButton(
                    text: '=',
                    bgColor: const Color(0xffF0A23B),
                    onPressed: () => calculateResult(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryCalculator extends StatelessWidget {
  const HistoryCalculator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (content, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 70,
          ),
          const Text(
            'History of Calculator',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            height: 500,
            child: ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "${index + 1}.",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        state.history[index],
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
