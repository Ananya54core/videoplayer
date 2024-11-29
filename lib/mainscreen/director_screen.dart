import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:file_picker/file_picker.dart';

class DirectorScreen extends StatefulWidget {
  const DirectorScreen({Key? key}) : super(key: key);

  @override
  _DirectorScreenState createState() => _DirectorScreenState();
}

class _DirectorScreenState extends State<DirectorScreen> {
  // Video Controllers
  late FlickManager flickManager;
  VideoPlayerController? _videoPlayerController;
  YoutubePlayerController? _youtubeController;

  // State Variables
  bool _isYouTubeVideo = false;
  bool _isCustomVideo = false;

  // Comments
  final List<Map<String, dynamic>> comments = [
    {
      "name": "Sarah Johnson",
      "role": "Lead Director",
      "comment": "Great cinematography, especially scene 3.",
      "timestamp": "2h ago",
      "replies": [],
      "avatar": "https://ui-avatars.com/api/?name=Sarah+Johnson"
    },
    {
      "name": "Mike Rodriguez",
      "role": "Cinematographer",
      "comment": "Lighting could be improved in scene 5.",
      "timestamp": "1h ago",
      "replies": [],
      "avatar": "https://ui-avatars.com/api/?name=Mike+Rodriguez"
    }
  ];

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize Flick Manager with default video
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    _videoPlayerController?.dispose();
    _youtubeController?.dispose();
    _commentController.dispose();
    _searchController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    if (_isYouTubeVideo && _youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
      );
    } else if (_isCustomVideo && _videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
      return VideoPlayer(_videoPlayerController!);
    } else {
      return FlickVideoPlayer(flickManager: flickManager);
    }
  }

  void _playYouTubeVideo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('YouTube Video URL'),
        content: TextField(
          controller: _urlController,
          decoration: const InputDecoration(
            hintText: 'Enter YouTube Video URL',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String? videoId = YoutubePlayer.convertUrlToId(_urlController.text);
              if (videoId != null) {
                setState(() {
                  _isYouTubeVideo = true;
                  _isCustomVideo = false;

                  // Dispose existing controllers
                  _videoPlayerController?.dispose();
                  _videoPlayerController = null;

                  // Initialize YouTube Controller
                  _youtubeController = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid YouTube URL')),
                );
              }
            },
            child: const Text('Play'),
          ),
        ],
      ),
    );
  }

  void _pickLocalVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _isYouTubeVideo = false;
        _isCustomVideo = true;

        // Dispose existing controllers
        _youtubeController?.dispose();
        _youtubeController = null;

        // Initialize Local Video Controller
        _videoPlayerController?.dispose();
        _videoPlayerController = VideoPlayerController.file(file)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController!.play();
          });
      });
    }
  }

  void _addComment() {
    final timestamp = _getTimestamp();
    if (_commentController.text.isNotEmpty) {
      setState(() {
        comments.add({
          'name': 'Director',
          'role': 'Lead Director',
          'comment': _commentController.text,
          'timestamp': timestamp,
          'replies': [],
          'avatar': 'https://ui-avatars.com/api/?name=Director'
        });
      });
      _commentController.clear();
    }
  }

  String _getTimestamp() {
    final Duration currentTime = _isCustomVideo
        ? _videoPlayerController?.value.position ?? Duration.zero
        : flickManager.flickVideoManager?.videoPlayerValue?.position ?? Duration.zero;
    return "${currentTime.inMinutes}:${currentTime.inSeconds % 60}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildVideoPlayerSection(),
            _buildCommentInput(),
            _buildAddCommentButton(),
            _buildSearchBar(),
            _buildCommentsList(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Director Review',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.video_library, color: Colors.white70),
          onPressed: _playYouTubeVideo,
        ),
        IconButton(
          icon: const Icon(Icons.upload_file, color: Colors.white70),
          onPressed: _pickLocalVideo,
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildVideoPlayerSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildVideoPlayer(),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCommentInput() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextField(
          controller: _commentController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: const Color(0xFF2C2C2C),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          maxLines: 3,
          minLines: 1,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAddCommentButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: _addComment,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Add Comment with Timestamp"),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() {}),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search comments...",
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: const Color(0xFF2C2C2C),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  SliverList _buildCommentsList() {
    final filteredComments = comments.where((comment) {
      return _searchController.text.isEmpty ||
          comment['comment'].toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final comment = filteredComments[index];
          return _buildCommentCard(comment);
        },
        childCount: filteredComments.length,
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(comment['avatar']),
            backgroundColor: Colors.white12,
          ),
          title: Text(
            comment['name'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment['role'],
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                comment['comment'],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: Text(
            comment['timestamp'],
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
