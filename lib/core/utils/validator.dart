class Validator {
  static String? validate(Rule rule, String value) {
    if (rule.require && value.isEmpty) {
      return 'This field is required';
    }
    if (rule.min != null && double.parse(value) < rule.min!) {
      return 'Value must be at least ${rule.min}';
    }
    if (rule.max != null && double.parse(value) > rule.max!) {
      return 'Value must be at most ${rule.max}';
    }
    if (rule.minLength != null && value.length < rule.minLength!) {
      return 'Value must be at least ${rule.minLength} characters long';
    }
    if (rule.maxLength != null && value.length > rule.maxLength!) {
      return 'Value must be at most ${rule.maxLength} characters long';
    }
    if (rule.email && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Invalid email address';
    }
    if (rule.url) {
      final url = Uri.tryParse(value);
      if (url == null) {
        return 'Invalid URL';
      }
    }
    return null;
  }
}

class Rule {
  final bool require;
  final double? min;
  final double? max;
  final int? minLength;
  final int? maxLength;
  final bool email;
  final bool url;

  Rule({
    this.require = false,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.email = false,
    this.url = false,
  });
}
