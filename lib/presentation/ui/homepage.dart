
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/viewmodel/firebase_viewmodel.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///This will delay the call to avoid terminal error message
      final viewModel = Provider.of<FirebaseViewmodel>(context, listen: false);
      viewModel.fetchSearchDataViewModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FirebaseViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: viewModel.isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : viewModel.searchEntity == null || viewModel.searchEntity!.isEmpty
            ? const Center(child: Text('No data Available'))
            :  ListView.builder(
                itemCount: viewModel.searchEntity!.length,
                itemBuilder: (context, index) {
                  final item = viewModel.searchEntity![index];
                  return ListTile(
                    title: Text('${item.title}'),
                  );
                },
          ),
    );
  }
}
