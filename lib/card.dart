class ICard extends StatelessWidget {
  late List<User> muserlist;

  ICard({

})

  @override
  Widget build(BuildContext context) {
    return return Container(
      height: 100,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,

          backgroundImage: NetworkImage(muserlist[index].description ),
        ),
        title: Text(muserlist[index].UserName),
        trailing: Text(muserlist[index].id),
      ),
    );
  }
}
