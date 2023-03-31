import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/api/api_service.dart';
import 'package:story_app/models/stories.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;

  StoriesProvider({required this.apiService}) {
    fetchAllStories();
  }
  List<ListStory> _storyList = [];

  List<ListStory> get result => _storyList;

  String? imagePath;
  XFile? imageFile;

  bool isUploading = false;
  String message = "";
  LatLng? pickedLocation;
  UploadResponse? uploadResponse;

  Story? detailstory;

  int? pageItems = 1;
  int sizeItems = 4;

  void setPickedLocation(LatLng latLng) {
    pickedLocation = latLng;
    notifyListeners();
  }

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
      print(' yeay $pageItems');

      final stories = await apiService.getAllStories(pageItems!, sizeItems);
      pageItems = pageItems!+ 1;
      _storyList = stories.listStory;
      if (stories.listStory.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addStory(
    List<int> bytes,
    String fileName,
    String description,
    dynamic latitude,
    dynamic longitude,
  ) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();

      uploadResponse = await apiService.addStory(
          bytes, description, fileName, latitude, longitude);
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
