class DifficultyRangeInputFormValidate {
  static const int minRange = 1;
  static const int maxRange = 5;

  String? validator(String? value) {
    if (_isNotValidDifficultyRange(value)) {
      return 'Insira uma Dificuldade entre $minRange e $maxRange';
    }
    return null;
  }

  /// Validar se o range informado para dificuldade está inválido
  bool _isNotValidDifficultyRange(String? value) {
    if (value != null && value.isNotEmpty) {
      var difficulty = int.parse(value);
      return difficulty > maxRange || difficulty < minRange;
    }
    return true;
  }
}
