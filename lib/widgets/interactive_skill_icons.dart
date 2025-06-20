import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
import '../utils/constants.dart';
import '../widgets/animated_background.dart';

class InteractiveSkillIcons extends StatefulWidget {
  const InteractiveSkillIcons({Key? key}) : super(key: key);

  @override
  InteractiveSkillIconsState createState() => InteractiveSkillIconsState();
}

class InteractiveSkillIconsState extends State<InteractiveSkillIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: _buildInteractiveIcons(),
      ),
    );
  }

  List<Widget> _buildInteractiveIcons() {
    final iconList = [
      {
        'name': 'flutter',
        'logo': Logo(Logos.flutter),
        'color': const Color(0xFF02569B)
      },
      {
        'name': 'dart',
        'logo': Logo(Logos.android),
        'color': const Color(0xFF0175C2)
      },
      {
        'name': 'hadoop',
        'logo': Logo(Logos.apache),
        'color': const Color(0xFFFFDE57)
      },
      {
        'name': 'django',
        'logo': Logo(Logos.django),
        'color': const Color(0xFF092E20)
      },
      {
        'name': 'python',
        'logo': Logo(Logos.python),
        'color': const Color(0xFF3776AB)
      },
      {
        'name': 'firebase',
        'logo': Logo(Logos.firebase),
        'color': const Color(0xFFFFCA28)
      },
      {
        'name': 'sql',
        'logo': Logo(Logos.mysql),
        'color': const Color(0xFF4479A1)
      },
      {
        'name': 'mongodb',
        'logo': Logo(Logos.mongodb),
        'color': const Color(0xFF4DB33D)
      },
      {
        'name': 'figma',
        'logo': Logo(Logos.figma),
        'color': const Color(0xFFF24E1E)
      },
    ];

    return iconList.map((icon) {
      final color = icon['color'] as Color;

      return Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DesignElements.mediumRadius),
              color: Colors.white10,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Center(
              child: InteractiveParticle(
                size: 40,
                color: color,
                icon: icon['name'] as String,
              ),
            ),
          )
              .animate()
              .fadeIn(
                  duration: 800.ms, delay: (100 * iconList.indexOf(icon)).ms)
              .slideY(begin: 0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            icon['name'] as String,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }).toList();
  }
} 
// flutter  dart hadoop django python firebase sql mongodb figma

     //   case 'django':
    //     return Logo(Logos.django);
    //   case 'python':
    //     return Logo(Logos.python);
    //   case 'firebase':
    //     return Logo(Logos.firebase);
    //   case 'sql':
    //     return Logo(Logos.mysql);
    //   case 'mongodb':
    //     return Logo(Logos.mongodb);
    //   case 'figma':
    //     return Logo(Logos.figma);
    //   default:
    //     return Logo(Logos.flutter);
    // }