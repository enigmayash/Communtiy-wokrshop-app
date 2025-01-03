// widgets/create_workshop_dialog.dart
import 'package:flutter/material.dart';

class CreateWorkshopDialog extends StatefulWidget {
  const CreateWorkshopDialog({super.key});

  @override
  State<CreateWorkshopDialog> createState() => _CreateWorkshopDialogState();
}

class _CreateWorkshopDialogState extends State<CreateWorkshopDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedCategory = 'Art';
  String _selectedSkillLevel = 'Beginner';
  final _maxParticipantsController = TextEditingController();
  final _priceController = TextEditingController();

  final List<String> _categories = ['Art', 'Music', 'Technology', 'Cooking'];
  final List<String> _skillLevels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Workshop'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Workshop Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value!);
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedSkillLevel,
                decoration: const InputDecoration(labelText: 'Skill Level'),
                items: _skillLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedSkillLevel = value!);
                },
              ),
              TextFormField(
                controller: _maxParticipantsController,
                decoration: const InputDecoration(labelText: 'Maximum Participants'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter max participants' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a price' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Create'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newWorkshop = Workshop(
        id: DateTime.now().toString(), // In production, use proper ID generation
        name: _nameController.text,
        category: _selectedCategory,
        skillLevel: _selectedSkillLevel,
        maxParticipants: int.parse(_maxParticipantsController.text),
        price: double.parse(_priceController.text),
        hostId: 'current_user_id', // In production, get from auth service
        location: 'To be determined', // In production, get from location service
        dateTime: DateTime.now(),
      );

      // In production, save to backend
      Navigator.pop(context, newWorkshop);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _maxParticipantsController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}