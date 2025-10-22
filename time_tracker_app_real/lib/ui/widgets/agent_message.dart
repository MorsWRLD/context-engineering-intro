import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../agents/companion/companion_agent.dart';

class AgentMessage extends StatelessWidget {
  const AgentMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agent = context.watch<CompanionAgent>();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.message,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${agent.personality.toUpperCase()}: Ready to help!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
