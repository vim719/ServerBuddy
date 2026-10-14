import 'package:flutter/material.dart';
import 'package:serverbuddy_client/serverbuddy_client.dart';

import '../client.dart';
import 'greetings_screen.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  /// Memories loaded from the database, most recent first.
  List<Memory> _memories = [];

  /// The memory currently shown, or null if there's none yet.
  Memory? _selected;

  /// The last error message, or null if there's no error.
  String? _errorMessage;

  final _textEditingController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    client.memory.getMemories().then((memories) {
      setState(() => _memories = memories);
    }).catchError((Object e) {
      setState(() => _errorMessage = '$e');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _callRemember() async {
    try {
      setState(() {
        _errorMessage = null;
        _loading = true;
      });

      final result = await client.memory.remember(
        'You',
        _textEditingController.text,
      );

      _textEditingController.clear();
      setState(() {
        _selected = result;
        _memories = [result, ..._memories];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
        _loading = false;
      });
    }
  }

  void _callForget(Memory memory) async {
    await client.memory.forget(memory.id!);
    setState(() {
      _memories = _memories.where((m) => m.id != memory.id).toList();
      if (_selected?.id == memory.id) _selected = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final editor = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tell Anna something to remember',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'e.g. I prefer morning market briefings',
            ),
            onSubmitted: (_) => _loading ? null : _callRemember(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loading ? null : _callRemember,
            child: _loading ? const Text('Saving...') : const Text('Remember'),
          ),
          const SizedBox(height: 16),
          ResultDisplay(
            resultMessage: _selected != null
                ? '${_selected!.author} on ${_selected!.date}:\n${_selected!.text}'
                : null,
            errorMessage: _errorMessage,
          ),
        ],
      ),
    );

    final history = ListView.builder(
      itemCount: _memories.length,
      itemBuilder: (context, index) {
        final memory = _memories[index];
        return ListTile(
          title: Text(memory.text),
          subtitle: Text('${memory.author} - ${memory.date}'),
          onTap: () => setState(() => _selected = memory),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Forget',
            onPressed: () => _callForget(memory),
          ),
        );
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            children: [
              editor,
              const Divider(height: 1),
              Expanded(child: history),
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: history),
            Expanded(flex: 2, child: SingleChildScrollView(child: editor)),
          ],
        );
      },
    );
  }
}
