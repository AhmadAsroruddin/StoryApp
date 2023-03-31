import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/register.dart';
import '../models/login.dart';
import '../models/stories.dart';

class ApiService {
  String? token;
  Future<Register> registerUser(
      String email, String name, String password) async {
    Map data = {'name': name, 'email': email, 'password': password};
    final response = await http.post(
      Uri.parse('https://story-api.dicoding.dev/v1/register'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      final data = registerFromJson(response.body);
      throw registerFromJson(data.message);
    }
  }

  Future<Login> login(String email, String password) async {
    Map data = {'email': email, 'password': password};

    final response = await http.post(
      Uri.parse("https://story-api.dicoding.dev/v1/login"),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode(data),
    
    );

    if (response.statusCode == 200) {
      print("work");
      print(response.body);
      return Login.fromJson(jsonDecode(response.body));
    } else {
      print("error");
      print(response.statusCode);
      final data = json.encode(response.body);
      throw "Data Tidak ditemukan";
    }
  }

  Future<Stories> getAllStories(int page, int size) async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");


    final response = await http.get(
      Uri.parse("https://story-api.dicoding.dev/v1/stories?size=$size&page=$page",),
      headers: {"Authorization": "Bearer $token"},
    
    );

    if (response.statusCode == 200) {
      print(token);
      return storiesFromJson(response.body);
    } else {
      print(response.statusCode);
      throw "data kosong";
    }
  }

  Future<Detailstory> detailStory(String id) async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");

    final response = await http.get(
        Uri.parse("https://story-api.dicoding.dev/v1/stories/$id"),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return detailstoryFromJson(response.body);
    } else {
      throw "DATA TIDAK DITEMUKAN";
    }
  }

  Future<UploadResponse> addStory(List<int> bytes, String desc, String image,
      dynamic lat, dynamic lon) async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString("token");

    const String url = "https://story-api.dicoding.dev/v1/stories";

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile =
        http.MultipartFile.fromBytes("photo", bytes, filename: image);

    final Map<String, String> fields = {
      "description": desc,
      "lat": lat.toString(),
      "lon": lon.toString()
    };

    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      print("object");
      final UploadResponse uploadResponse = UploadResponse.fromJson(
        responseData,
      );
      return uploadResponse;
    } else {
      print(responseData);
      throw Exception("Upload file error");
    }
  }
}
