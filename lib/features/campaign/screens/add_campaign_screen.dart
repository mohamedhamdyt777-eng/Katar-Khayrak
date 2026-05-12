import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bloc/campaigns_cubit.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});
  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  int _selectedCategoryIndex = 0;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  XFile? _coverImage;
  final List<XFile> _galleryImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365 * 2)));
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) setState(() => _selectedTime = time);
  }

  Future<void> _pickCoverImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _coverImage = image);
  }

  Future<void> _pickGalleryImages() async {
    final images = await _picker.pickMultiImage();
    if (images.isNotEmpty) setState(() => _galleryImages.addAll(images));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = [
      {'label': l10n.categoryAll, 'icon': Icons.grid_view},
      {'label': l10n.categories_most_needed, 'icon': Icons.priority_high},
      {'label': l10n.categories_most_donated, 'icon': Icons.monetization_on},
      {'label': l10n.categories_health, 'icon': Icons.medical_services_outlined},
      {'label': l10n.categories_education, 'icon': Icons.school_outlined},
      {'label': l10n.categories_orphans, 'icon': Icons.child_care},
      {'label': l10n.categories_disaster, 'icon': Icons.warning_amber_rounded},
    ];

    String formattedDateTime = l10n.timeNotSet;
    if (_selectedDate != null) {
      formattedDateTime = DateFormat('dd MMM yyyy').format(_selectedDate!);
      if (_selectedTime != null) formattedDateTime += ' - ${_selectedTime!.format(context)}';
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(l10n.addCampaign, style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.onSurface, size: 20), onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle(l10n.campaignTitle, isDark),
              const SizedBox(height: 8),
              _buildTextField(controller: _titleController, hintText: l10n.enterCampaignTitle, context: context),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.campaignDescription, isDark),
              const SizedBox(height: 8),
              _buildTextField(controller: _descriptionController, hintText: l10n.enterCampaignDescription, context: context, maxLines: 4),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.campaignDate, isDark),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(child: _buildDateTile(context, _selectedDate == null ? l10n.campaignDate : DateFormat('dd MMM yyyy').format(_selectedDate!), Icons.calendar_today, _pickDate, _selectedDate != null)),
                const SizedBox(width: 16),
                Expanded(child: _buildDateTile(context, _selectedTime == null ? l10n.timeNotSet : _selectedTime!.format(context), Icons.access_time, _pickTime, _selectedTime != null)),
              ]),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.targetAmount, isDark),
              const SizedBox(height: 8),
              _buildTextField(controller: _amountController, hintText: l10n.enterTargetAmount, context: context, keyboardType: const TextInputType.numberWithOptions(decimal: true), prefixIcon: const Icon(Icons.attach_money, color: Colors.grey)),
              const SizedBox(height: 24),
              _buildSectionTitle('Category', isDark),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Row(mainAxisSize: MainAxisSize.min, children: [Icon(category['icon'] as IconData, size: 18, color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface), const SizedBox(width: 8), Text(category['label'] as String)]),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedCategoryIndex = index),
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).cardColor,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? Colors.transparent : Theme.of(context).dividerColor)),
                        elevation: 0,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(l10n.coverImage, isDark),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickCoverImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300), image: _coverImage != null ? DecorationImage(image: FileImage(File(_coverImage!.path)), fit: BoxFit.cover) : null),
                  child: _coverImage == null
                      ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate_outlined, size: 48, color: AppColors.primary.withValues(alpha: 0.5)), const SizedBox(height: 8), Text(l10n.selectCoverImage, style: TextStyle(color: Colors.grey.shade600))])
                      : Container(alignment: Alignment.topRight, padding: const EdgeInsets.all(8), child: IconButton(icon: const Icon(Icons.close, color: Colors.white), style: IconButton.styleFrom(backgroundColor: Colors.black54), onPressed: () => setState(() => _coverImage = null))),
                ),
              ),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildSectionTitle(l10n.galleryImages, isDark),
                TextButton.icon(onPressed: _pickGalleryImages, icon: const Icon(Icons.add_a_photo, size: 16), label: Text(l10n.selectGalleryImages)),
              ]),
              const SizedBox(height: 8),
              if (_galleryImages.isNotEmpty)
                SizedBox(height: 100, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: _galleryImages.length, separatorBuilder: (_, i) => const SizedBox(width: 12), itemBuilder: (context, index) => Stack(children: [ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(_galleryImages[index].path), width: 100, height: 100, fit: BoxFit.cover)), Positioned(top: 4, right: 4, child: InkWell(onTap: () => setState(() => _galleryImages.removeAt(index)), child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, size: 14, color: Colors.white))))])))
              else
                Container(height: 100, alignment: Alignment.center, decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)), child: Text('No additional photos added', style: TextStyle(color: Colors.grey.shade500))),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty && formattedDateTime != l10n.timeNotSet) {
                    context.read<CampaignsCubit>().addCampaign(_titleController.text, formattedDateTime, AppColors.primary.withValues(alpha: 0.2), description: _descriptionController.text, targetAmount: double.tryParse(_amountController.text), coverImagePath: _coverImage?.path, galleryImagePaths: _galleryImages.map((e) => e.path).toList(), categoryIndex: _selectedCategoryIndex);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Campaign added successfully!')));
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill out the title and date')));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                child: Text(l10n.createCampaignBtn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile(BuildContext context, String label, IconData icon, VoidCallback onTap, bool hasValue) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
        child: Row(children: [Icon(icon, color: AppColors.primary, size: 20), const SizedBox(width: 12), Expanded(child: Text(label, style: TextStyle(color: hasValue ? Theme.of(context).colorScheme.onSurface : Colors.grey)))]),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) => Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white70 : Colors.black87));

  Widget _buildTextField({required TextEditingController controller, required String hintText, required BuildContext context, int maxLines = 1, TextInputType? keyboardType, Widget? prefixIcon}) {
    return TextField(
      controller: controller, maxLines: maxLines, keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintText, prefixIcon: prefixIcon, filled: true, fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary))),
    );
  }
}
