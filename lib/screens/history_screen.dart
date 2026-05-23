import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/Member4_history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final historyAsync =
    ref.watch(historyProvider);

    return Scaffold(

      backgroundColor:
      Colors.yellow[100],

      appBar: AppBar(

        backgroundColor:
        Colors.deepOrange,

        title: const Text(
          "Cooking History",
        ),
      ),

      body: historyAsync.when(

        data: (historyList) {

          if (historyList.isEmpty) {

            return const Center(

              child: Text(

                "No history yet 🍜",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            );
          }

          return ListView.builder(

            itemCount:
            historyList.length,

            itemBuilder:
                (context, index) {

              final history =
              historyList[index];

              return Card(

                margin:
                const EdgeInsets.all(12),

                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),

                child: ListTile(

                  leading: const Text(
                    "🍜",

                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),

                  title: Text(

                    history.noodleType,

                    style: const TextStyle(

                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(

                    "${history.durationInSeconds ~/ 60} min • ${history.preference}",
                  ),
                ),
              );
            },
          );
        },

        loading: () =>
        const Center(

          child:
          CircularProgressIndicator(),
        ),

        error: (error, stack) =>
            Center(

              child: Text(
                error.toString(),
              ),
            ),
      ),
    );
  }
}
