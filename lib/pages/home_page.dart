import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/colors.dart';
import '../provider/auth/auth_cubit.dart';
import '../provider/notes/notes_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var drawer = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onHorizontalDragDown: (_) {
            drawer = true;
            setState(() {});
          },
          onTapUp: (_) {
            if (drawer) drawer = false;
            setState(() {});
          },
          child: Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                AnimatedPositioned(
                  top: 0,
                  left: drawer ? 60 : 0,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  duration: const Duration(milliseconds: 200),
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: appBar(context),
                    body: FutureBuilder(
                      future: BlocProvider.of<NoteCubit>(context).getNotes(),
                      builder: (context, snap) {
                        return ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                if (index % 2 == 1)
                                  const Expanded(child: SizedBox()),
                                const NoteCard(),
                                if (index % 2 == 0)
                                  const Expanded(child: SizedBox()),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    floatingActionButtonLocation: FabLocation(context: context),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: pColor,
                      foregroundColor: white,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/edit");
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  width: 60,
                  height: MediaQuery.of(context).size.height,
                  left: drawer ? 0 : -60,
                  top: 0,
                  child: Container(
                    color: bColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        IconButton(
                          padding: const EdgeInsets.all(15),
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(white),
                          ),
                          onPressed: () {},
                          iconSize: 30,
                          icon: const Icon(
                            Icons.note_alt,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Widget?> openDialog(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email!;
    return showDialog<Widget>(
      context: context,
      useRootNavigator: true,
      builder: (context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorAuthState) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacementNamed("/auth");
          }
        },
        child: Dialog(
          backgroundColor: bColor,
          child: SizedBox(
            width: 300,
            height: 210,
            child: Column(
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  backgroundColor: pColor,
                  foregroundColor: white,
                  radius: 50,
                  child: Text(
                    email.toUpperCase().substring(0, 1),
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await BlocProvider.of<AuthCubit>(context).signOut();
                      },
                      child: const Text("Sign Out"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        width: double.minPositive,
        margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: sColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: TextField(
                style: TextStyle(fontSize: 20, color: black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30, color: pColor),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () async {
                await openDialog(context);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(pColor),
                shape: MaterialStatePropertyAll(
                  CircleBorder(side: BorderSide.none),
                ),
                padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                fixedSize: MaterialStatePropertyAll(
                  Size(50, 50),
                ),
              ),
              child: const Text(
                "A",
                style: TextStyle(
                  fontSize: 25,
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width - 150;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 200,
      width: w,
      decoration: BoxDecoration(
        color: bColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Title",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "lorem ipsum ashda  sdgtgrtgtr  ergegre ergege ergergre ergege ergeg  sdf ds fs fs f dsf sdf ds fs fsdsdsdsd sdfdsfsdf sdfdsfdsf sdfsfdsc sc dv dsc scs cs csc s cscvs csdscscscdv dvcdfvd dscdsv scsc dsvdsvs cscsvfsvfsv scsdvfsfv scsvdrfv scf ssvss  sdvdfvdfsces scscsfc sscscdscs",
          style: TextStyle(
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
        ),
      ]),
    );
  }
}

class FabLocation extends FloatingActionButtonLocation {
  final BuildContext context;
  FabLocation({required this.context});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final fabw = scaffoldGeometry.floatingActionButtonSize.width;
    return Offset(w - fabw - 25, h - fabw - 30);
  }
}
