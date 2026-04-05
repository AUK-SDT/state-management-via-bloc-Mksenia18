import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController controller = TextEditingController();

  Future<Cat>? futureCat;

  void fetchCat() {
    final code = int.tryParse(controller.text);

    setState(() {
      if (code == null) {
        futureCat = Future.error("Please enter a valid number");
      } else {
        futureCat = apiService.fetchCat(code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HTTP Cat App 🐱")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter status code (200, 404...)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: fetchCat, child: const Text("Get Cat")),

            const SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<Cat>(
                future: futureCat,
                builder: (context, snapshot) {
                  if (futureCat == null) {
                    return const Center(child: Text("Enter a code"));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final cat = snapshot.data!;
                  return Column(
                    children: [
                      Text(
                        "Status: ${controller.text}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),

                      Expanded(
                        child: Image.network(
                          cat.imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text(
                                "No image for this status code 😢",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
