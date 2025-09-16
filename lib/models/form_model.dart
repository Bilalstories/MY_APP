// lib/models/form_model.dart

class FormModel {
  final String formId;
  final List<FormFieldModel> fields;

  const FormModel({required this.formId, required this.fields});
}

class FormFieldModel {
  final String name;
  final String label;
  final String inputType; // 'text', 'phone', 'number', 'file'

  const FormFieldModel({
    required this.name,
    required this.label,
    required this.inputType,
  });
}