import 'package:flutter/material.dart';

class SwiperCardWidget extends StatelessWidget {
  const SwiperCardWidget({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://mma.prnewswire.com/media/2159579/The_Dawn_Project_Tesla.mp4?p=medium",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(112, 0, 36, 69),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: const Text(
              "Lilly Joins Biogen as Alzheimer’s Drugs Finally Emerge",
              maxLines: 3,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
