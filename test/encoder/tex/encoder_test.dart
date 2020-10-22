import 'package:flutter_math/flutter_math.dart';
import 'package:flutter_math/src/ast/nodes/symbol.dart';
import 'package:flutter_math/src/encoder/encoder.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_math/src/encoder/tex/encoder.dart';

void main() {
  group('EquationRowEncoderResult', () {
    test('empty row', () {
      final result = EquationRowTexEncodeResult(<dynamic>[]);
      expect(result.stringify(TexEncodeConf.mathConf), '{}');
      expect(result.stringify(TexEncodeConf.mathParamConf), '');
    });

    test('normal row', () {
      final result = EquationRowTexEncodeResult(<dynamic>[
        'a',
        StaticEncodeResult('b'),
        SymbolNode(symbol: 'c'),
        EquationRowNode.empty(),
      ]);
      expect(result.stringify(TexEncodeConf.mathConf), '{abc{}}');
      expect(result.stringify(TexEncodeConf.mathParamConf), 'abc{}');
    });
  });
  group('TexCommandEncoderResult', () {
    test('basic spec lookup', () {
      final result =
          TexCommandEncodeResult(command: '\\frac', args: <dynamic>[]);
      expect(result.numArgs, 2);
      expect(result.numOptionalArgs, 0);
      expect(result.argModes, [null, null]);
    });

    test('empty math param', () {
      final result = TexCommandEncodeResult(
          command: '\\frac',
          args: <dynamic>[EquationRowNode.empty(), EquationRowNode.empty()]);
      expect(result.stringify(TexEncodeConf.mathConf), '\\frac{}{}');
    });

    test('single char math param', () {
      final result =
          TexCommandEncodeResult(command: '\\frac', args: <dynamic>['1', '2']);
      expect(result.stringify(TexEncodeConf.mathConf), '\\frac{1}{2}');
    });
  });
}