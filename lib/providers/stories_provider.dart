import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/api/api_service.dart';
import 'package:story_app/models/stories.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;

  StoriesProvider({required this.apiService}){
    fetchAllStories();
  }
  List<ListStory> _storyList = [];

  List<ListStory> get result => _storyList;

  String? imagePath;
  XFile? imageFile;

  bool isUploading = false;
  String message = "";
  UploadResponse? uploadResponse;

  Story? detailstory;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> fetchAllStories() async {
    try {
      print(' yeay ');
      final stories = await apiService.getAllStories();
      _storyList = stories.listStory;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addStory(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();

      uploadResponse = await apiService.addStory(bytes, description, fileName);
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();

      print(message);
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<void> getDetail(String id) async {
    try {
      final response = await apiService.detailStory(id);
      detailstory = response.story;
      notifyListeners();
    } catch (e) {
      print("error data tidak ditemukan");
    }
  }
}
