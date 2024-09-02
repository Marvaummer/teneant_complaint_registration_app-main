import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../commons/colors.dart';

class RegisterComplaint extends StatefulWidget {
  const RegisterComplaint({super.key});

  @override
  State<RegisterComplaint> createState() => _RegisterComplaintState();
}

class _RegisterComplaintState extends State<RegisterComplaint> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubCategory;
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Map<String, List<String>> subCategories = {
    'Facilities': ['Leakage of sewage water(outside the village)', 'Cleaning issue', 'Clean Tank', 'Garbage Issues', 'Landscaping', 'Park Tent Repair', 'Pest control', 'Recreation Area', 'Satellite issue'],
    'Maintenance': ['Clean Tank', 'Garbage Issue', 'Landscaping', 'Park tent Repair', 'Pest Control', 'Recreation Area', 'Satellite issue', 'Security issues', 'Village facilities', 'Carpentry', 'Common Repairs', 'Electric', 'Fire System', 'Furniture', 'Home Appliance', 'Missing item', 'Painting', 'Plumbing'],
  };

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          controller.text = fullDateTime.toString(); // Format the datetime string as needed
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
        title: const Text(
          'Service Request',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi Sam, we would like to hear from you!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Name", Icons.label),
                    _buildTextField("Phone number", Icons.phone),
                    _buildTextField("Location", Icons.location_city),
                    _buildunitNumber('Unit Number', Icons.numbers),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      hint: 'Select a Category',
                      value: _selectedCategory,
                      items: subCategories.keys.toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                          _selectedSubCategory = null; // Reset sub-category
                        });
                      },
                    ),
                    if (_selectedCategory != null)
                      const SizedBox(height: 16),
                    if (_selectedCategory != null)
                      _buildDropdown(
                        hint: 'Select a Sub-Category',
                        value: _selectedSubCategory,
                        items: subCategories[_selectedCategory]!,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSubCategory = newValue;
                          });
                        },
                      ),
                    const SizedBox(height: 16),
                    _buildDateField("Available From", Icons.date_range, _fromDateController, () => _selectDateTime(context, _fromDateController)),
                    const SizedBox(height: 16),
                    _buildDateField("Available To", Icons.date_range, _toDateController, () => _selectDateTime(context, _toDateController)),
                    const SizedBox(height: 16),
                    _buildDescriptionField(),
                    const SizedBox(height: 20),
                    _buildImageSection(),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: Icon(icon, color: Colors.red),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDateField(String hintText, IconData icon, TextEditingController controller, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.red),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                enabled: false,
                validator: (value) {
                  if (controller.text.isEmpty) {
                    return 'Please select $hintText';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildunitNumber(String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: Icon(icon, color: Colors.red),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.black)),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.red),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return 'Please select $hint';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Description',
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Image'),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick from Gallery'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture with Camera'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_imageFile != null)
          Image.file(
            _imageFile!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        if (_imageFile == null)
          const Text('No image selected.', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && _imageFile != null) {
              // Perform form submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form submitted successfully!')),
              );
            } else if (_imageFile == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(' upload an image')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            // Clear form fields
            _formKey.currentState!.reset();
            _descriptionController.clear();
            _fromDateController.clear();
            _toDateController.clear();
            setState(() {
              _selectedCategory = null;
              _selectedSubCategory = null;
              _imageFile = null;
            });
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('Reset'),
          ),
        ),
      ],
    );
  }
}
