import 'package:flutter/material.dart';
import 'package:partners_app/providers/partners_provider.dart';
import 'package:provider/provider.dart';

class TopFive extends StatefulWidget {
  const TopFive({super.key});

  @override
  State<TopFive> createState() => _TopFiveState();
}

class _TopFiveState extends State<TopFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Five Partners'),
        ),
        body: Consumer<PartnersProivders>(
            builder: (context, partnersProivders, child) {
          partnersProivders.getTopFive();
          return ListView.builder(
            itemCount: partnersProivders.topFive.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(partnersProivders.topFive[index].businessName)
                  ],
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.email,
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 10),
                    Text(partnersProivders.topFive[index].email),
                  ],
                ),
                trailing: Text(
                    'Reach: ${partnersProivders.topFive[index].reach.toString()}'),
              );
            },
          );
        }));
  }
}
