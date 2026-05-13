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
import '../models/campaign.dart';

class EditCampaignScreen extends StatefulWidget {
  final Campaign campaign;

  const EditCampaignScreen({super.key, required this.campaign});

  @override
  State<EditCampaignScreen> createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  int _selectedCategoryIndex = 0;
  bool _isSubmitting = false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _existingDateTimeString = '';

  XFile? _newCoverImage;
  String? _existingCoverImagePath;

  final List<XFile> _newGalleryImages = [];
  List<String> _existingGalleryImages = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.campaign.title;
    _descriptionController.text = widget.campaign.description;
    if (widget.campaign.targetAmount != null) {
      _amountController.text = widget.campaign.targetAmount.toString();
    }
    
    _existingDateTimeString = widget.campaign.date;
    _existingCoverImagePath = widget.campaign.coverImagePath;
    _existingGalleryImages = List.from(widget.campaign.galleryImagePaths);
    _selectedCategoryIndex = widget.campaign.categoryIndex;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)), // allow past for edits
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Future<void> _pickCoverImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _newCoverImage = image;
      });
    }
  }

  Future<void> _pickGalleryImages() async {
    final images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _newGalleryImages.addAll(images);
      });
    }
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else if (path.startsWith('assets/')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
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

    String formattedDateTime = _existingDateTimeString;
    if (_selectedDate != null) {
      formattedDateTime = DateFormat('dd MMM yyyy').format(_selectedDate!);
      if (_selectedTime != null) {
        formattedDateTime += ' - ${_selectedTime!.format(context)}';
      }
    }

    // Determine current cover image provider
    ImageProvider? currentCoverImageProvider;
    if (_newCoverImage != null) {
      currentCoverImageProvider = FileImage(File(_newCoverImage!.path));
    } else if (_existingCoverImagePath != null) {
      currentCoverImageProvider = _getImageProvider(_existingCoverImagePath!);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.editCampaign,
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.onSurface, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Input
              _buildSectionTitle(l10n.campaignTitle, isDark),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _titleController,
                hintText: l10n.enterCampaignTitle,
                context: context,
              ),
              const SizedBox(height: 24),

              // Description Input
              _buildSectionTitle(l10n.campaignDescription, isDark),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _descriptionController,
                hintText: l10n.enterCampaignDescription,
                context: context,
                maxLines: 4,
              ),
              const SizedBox(height: 24),

              // Date & Time Picker
              _buildSectionTitle(l10n.campaignDate, isDark),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _selectedDate == null 
                                    ? formattedDateTime.split(' - ').first // rudimentary extraction
                                    : DateFormat('dd MMM yyyy').format(_selectedDate!),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _pickTime,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _selectedTime == null 
                                    ? (formattedDateTime.contains(' - ') ? formattedDateTime.split(' - ').last : l10n.timeNotSet)
                                    : _selectedTime!.format(context),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Target Amount Input
              _buildSectionTitle(l10n.targetAmount, isDark),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _amountController,
                hintText: l10n.enterTargetAmount,
                context: context,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.attach_money, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Category Selection
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
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category['icon'] as IconData,
                              size: 18,
                              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(width: 8),
                            Text(category['label'] as String),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).cardColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? Colors.transparent : Theme.of(context).dividerColor,
                          ),
                        ),
                        elevation: 0,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Media - Cover Image
              _buildSectionTitle(l10n.coverImage, isDark),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickCoverImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                    image: currentCoverImageProvider != null
                        ? DecorationImage(
                            image: currentCoverImageProvider,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: currentCoverImageProvider == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined, size: 48, color: AppColors.primary.withValues(alpha: 0.5)),
                            const SizedBox(height: 8),
                            Text(
                              l10n.selectCoverImage,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        )
                      : Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            style: IconButton.styleFrom(backgroundColor: Colors.black54),
                            onPressed: () {
                              setState(() {
                                _newCoverImage = null;
                                _existingCoverImagePath = null;
                              });
                            },
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Media - Gallery Images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(l10n.galleryImages, isDark),
                  TextButton.icon(
                    onPressed: _pickGalleryImages,
                    icon: const Icon(Icons.add_a_photo, size: 16),
                    label: Text(l10n.selectGalleryImages),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_existingGalleryImages.isNotEmpty || _newGalleryImages.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Existing Images
                      ..._existingGalleryImages.asMap().entries.map((entry) {
                        int index = entry.key;
                        String path = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: _getImageProvider(path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _existingGalleryImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      // New Images
                      ..._newGalleryImages.asMap().entries.map((entry) {
                        int index = entry.key;
                        XFile file = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(file.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _newGalleryImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                )
              else
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    'No additional photos added',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),

              const SizedBox(height: 48),

              // Update Button
              ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_titleController.text.isNotEmpty &&
                            formattedDateTime.isNotEmpty) {
                          setState(() => _isSubmitting = true);
                          try {
                            final targetAmt =
                                double.tryParse(_amountController.text);
                            final finalGalleryImages = [
                              ..._existingGalleryImages,
                              ..._newGalleryImages.map((e) => e.path),
                            ];
                            final updatedCampaign = Campaign(
                              id: widget.campaign.id,
                              title: _titleController.text,
                              date: formattedDateTime,
                              imageColor: widget.campaign.imageColor,
                              description: _descriptionController.text,
                              targetAmount: targetAmt,
                              coverImagePath:
                                  _newCoverImage?.path ?? _existingCoverImagePath,
                              galleryImagePaths: finalGalleryImages,
                              categoryIndex: _selectedCategoryIndex,
                              organizationId: widget.campaign.organizationId,
                            );
                            await context
                                .read<CampaignsCubit>()
                                .updateCampaign(updatedCampaign);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Campaign updated successfully!')),
                              );
                              context.pop();
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Error: ${e.toString()}')),
                              );
                            }
                          } finally {
                            if (mounted) setState(() => _isSubmitting = false);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please fill out the title and date')),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.5),
                      )
                    : Text(
                        l10n.updateCampaignBtn,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
    int maxLines = 1,
    TextInputType? keyboardType,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
