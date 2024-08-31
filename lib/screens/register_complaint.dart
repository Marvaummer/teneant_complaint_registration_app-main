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
              ),
            ),
          ],
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
          hint: Text(hint),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
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
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 5,
        maxLength: 500,
        decoration: const InputDecoration(
          hintText: 'Request Details',
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: [
        if (_imageFile != null)
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: FileImage(_imageFile!),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          )
        else
          Container(
            width: 320,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.image,
              size: 80,
              color: Colors.white70,
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take a Photo'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Handle form submission logic here
            }
          },
          child: const Text('Submit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
      ],
    );
  }
}
