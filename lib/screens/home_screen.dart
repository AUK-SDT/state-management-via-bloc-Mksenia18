import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cat_bloc.dart';
import '../bloc/cat_event.dart';
import '../bloc/cat_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  void fetchCat(BuildContext context) {
    final code = int.tryParse(controller.text);

    if (code == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid number")));
      return;
    }

    context.read<CatBloc>().add(FetchCatEvent(code));
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

            ElevatedButton(
              onPressed: () => fetchCat(context),
              child: const Text("Get Cat"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<CatBloc, CatState>(
                builder: (context, state) {
                  if (state is CatInitial) {
                    return const Center(child: Text("Enter a code"));
                  }

                  if (state is CatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CatError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is CatLoaded) {
                    return Column(
                      children: [
                        Text(
                          "Status: ${controller.text}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Image.network(
                            state.cat.imageUrl,
                            errorBuilder: (_, __, ___) {
                              return const Center(
                                child: Text(
                                  "No image 😢",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
